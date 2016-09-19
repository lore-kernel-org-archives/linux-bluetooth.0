Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1474216531-11518-2-git-send-email-b0661n0e17e@gmail.com>
References: <1474216531-11518-1-git-send-email-b0661n0e17e@gmail.com> <1474216531-11518-2-git-send-email-b0661n0e17e@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 19 Sep 2016 15:16:06 +0300
Message-ID: <CABBYNZK6zeHyyX6GFAFdkq3mJOOBOz8kxLr0Bakxq5qTsmJofA@mail.gmail.com>
Subject: Re: [Patch BlueZ 1/1] Make network server interface handling more robust
To: Bobby Noelte <b0661n0e17e@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "b0661n0e71e@gmail.com" <b0661.n0e17e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bobby,

On Sun, Sep 18, 2016 at 7:35 PM, Bobby Noelte <b0661n0e17e@gmail.com> wrote:
> From: "b0661n0e71e@gmail.com" <b0661.n0e17e@gmail.com>
>
> Interface names may be renamed by udev (systemd-udev) after creation
> before the interface is up. Interfaces may also be renamed when
> the interface is down due to a bluetoothd restart.

I guess there should probably be a way to prevent systemd-udev to
change to rename the interface or then we need kernel changes to make
sure the interface index is sent.

> Use the interface index, that does not change on renaming, where possible.
> Also do some retries when the creation of an interface fails.
> ---
>  profiles/network/bnep.c | 311 ++++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 260 insertions(+), 51 deletions(-)
>
> diff --git a/profiles/network/bnep.c b/profiles/network/bnep.c
> index 9bf0b18..cba0f63 100644
> --- a/profiles/network/bnep.c
> +++ b/profiles/network/bnep.c
> @@ -65,6 +65,7 @@ struct bnep {
>         uint16_t        dst;
>         bdaddr_t        dst_addr;
>         char    iface[16];
> +       unsigned int    ifindex;
>         guint   attempts;
>         guint   setup_to;
>         guint   watch;
> @@ -98,25 +99,109 @@ int bnep_cleanup(void)
>         return 0;
>  }
>
> +/**
> + * private: for local use only.
> + *
> + * bnep_indextoname() - Return interface name corresponding to interface index.
> + * @ifindex interface index.
> + * @iface interface name, output only, will be filled with '<unknown>' in case of error.
> + *
> + * The name is placed in the buffer pointed to by ifname.
> + * The buffer must allow for the storage of at least IF_NAMESIZE bytes.
> + *
> + * On success 0 is returned. On error errno as a negative value is returned.
> + */
> +static int bnep_indextoname(unsigned int ifindex, char *iface)
> +{
> +       int err;
> +
> +       err = 0;
> +       if (if_indextoname(ifindex, iface) == 0) {
> +               err = -errno;
> +               strncpy(iface, "<unknown>", 10);
> +       }
> +       return err;
> +}
> +
> +/**
> + * private: for local use only.
> + *
> + * bnep_nametoindext() - Return interface index corresponding to interface name.
> + * @iface interface name
> + * @ifindex interface index, output only, will be filled with 0 in case of error.
> + *
> + * The interface index is placed in the variable pointed to by ifindex.
> + *
> + * In case the interface is temporarily unavailable do a retry.
> + *
> + * On success 0 is returned. On error errno as a negative value is returned.
> + */
> +static int bnep_nametoindex(const char *iface, unsigned int *ifindex)
> +{
> +       int retry;
> +       int err;
> +
> +       retry = 0;
> +       while (retry < 2) {
> +               DBG("get interface index for device %s retry %d", iface, retry);
> +               *ifindex = if_nametoindex(iface);
> +               if (*ifindex != 0) {
> +                       DBG("got interface index %d for added device %s retry %d",
> +                               *ifindex, iface, retry);
> +                       err = 0;
> +               } else {
> +                       err = -errno;
> +               }
> +               if (err != -EAGAIN)
> +                       break;
> +               /* EAGAIN - Resource temporarily unavailable */
> +               retry++;
> +               sleep(1);

sleep is no acceptable in the daemon code, it should never block in
any circumstances.

> +       }
> +       return err;
> +}
> +
>  static int bnep_conndel(const bdaddr_t *dst)
>  {
> +       int err;
>         struct bnep_conndel_req req;
> +       char addr[20];
>
> +       ba2str(dst, &addr[0]);
>         memset(&req, 0, sizeof(req));
>         baswap((bdaddr_t *)&req.dst, dst);
>         req.flags = 0;
> -       if (ioctl(ctl, BNEPCONNDEL, &req) < 0) {
> -               int err = -errno;
> -               error("bnep: Failed to kill connection: %s (%d)",
> -                                                       strerror(-err), -err);
> +       err = ioctl(ctl, BNEPCONNDEL, &req);
> +       if (err < 0) {
> +               err = -errno;
> +               error("bnep: Failed to kill connection %s: %s (%d)",
> +                       addr, strerror(-err), -err);
>                 return err;
>         }
> +       DBG("deleted device %s, %d", addr, err);
> +
>         return 0;
>  }
>
> -static int bnep_connadd(int sk, uint16_t role, char *dev)
> +/**
> + * private: for local use only.
> + *
> + * bnep_connadd() - Add bluetooth ethernet connection.
> + * @sk bluez control socket.
> + * @role
> + * @dev device name, template for new interface name (e.g. "bnep%d") or name.
> + * @dst bluetooth address, only needed for retries.
> + * @ifindex interface index, ouput only - new interface index
> + *
> + * In case the interface can not be accessed by the device name (e.g. due to udev rename) do a retry.
> + *
> + * On success 0 is returned. On error errno as a negative value is returned.
> + */
> +static int bnep_connadd(int sk, uint16_t role, char *dev, const bdaddr_t *dst, unsigned int *ifindex)
>  {
>         struct bnep_connadd_req req;
> +       int err;
> +       int retry;
>
>         memset(&req, 0, sizeof(req));
>         strncpy(req.device, dev, 16);
> @@ -125,15 +210,40 @@ static int bnep_connadd(int sk, uint16_t role, char *dev)
>         req.sock = sk;
>         req.role = role;
>         req.flags = (1 << BNEP_SETUP_RESPONSE);
> -       if (ioctl(ctl, BNEPCONNADD, &req) < 0) {
> -               int err = -errno;
> -               error("bnep: Failed to add device %s: %s(%d)",
> -                                               dev, strerror(-err), -err);
> -               return err;
> +
> +       retry = 0;
> +
> +       while (retry < 2) {
> +               DBG("add device %s retry %d", req.device, retry);
> +
> +               err = ioctl(ctl, BNEPCONNADD, &req);
> +               if (err < 0) {
> +                       err = -errno;
> +                       break;
> +               }
> +               DBG("added device %s retry %d", req.device, retry);
> +               /*
> +               * There is a potential race condition between udev renaming the interface
> +               * after being created by BNEPCONNADD and bnep_nametoindex providing
> +               * the interface index.
> +               */
> +               err = bnep_nametoindex(&req.device[0], ifindex);
> +               if (!err)
> +                       break;
> +
> +               /* Prepare retry */
> +               retry++;
> +               bnep_conndel(dst);
> +               /* Give BT some time to really delete. */
> +               sleep(1);

We aint gonna fix any race condition with sleep.

>         }
>
> -       strncpy(dev, req.device, 16);
> -       return 0;
> +       if (err) {
> +               error("bnep: Failed to add device %s with interface index %d: %s(%d)",
> +                       req.device, *ifindex, strerror(-err), -err);
> +       }
> +
> +       return err;
>  }
>
>  static uint32_t bnep_getsuppfeat(void)
> @@ -148,51 +258,108 @@ static uint32_t bnep_getsuppfeat(void)
>         return feat;
>  }
>
> -static int bnep_if_up(const char *devname)
> +/**
> + * private: for local use only.
> + *
> + * bnep_if_up() - Bring interface up.
> + * @ifindex interface index
> + *
> + * In case the interface can not be accessed (e.g. due to udev rename) do a retry.
> + *
> + * On success 0 is returned. On error errno as a negative value is returned.
> + */
> +static int bnep_if_up(unsigned int ifindex)
>  {
>         struct ifreq ifr;
> -       int sk, err = 0;
> +       int sk, err;
> +       int retry;
>
>         sk = socket(AF_INET, SOCK_DGRAM, 0);
>
>         memset(&ifr, 0, sizeof(ifr));
> -       strncpy(ifr.ifr_name, devname, IF_NAMESIZE - 1);
> -
>         ifr.ifr_flags |= IFF_UP;
>         ifr.ifr_flags |= IFF_MULTICAST;
>
> -       if (ioctl(sk, SIOCSIFFLAGS, (void *) &ifr) < 0) {
> +       retry = 0;
> +       while (retry < 2) {
> +               err = bnep_indextoname(ifindex, ifr.ifr_name);
> +               if (err)
> +                       break;
> +               /*
> +               * There is a potential race condition between udev renaming the interface
> +               * after the name is retrieved by bnep_nametoindex and the usage of the
> +               * interface name by ioctl.
> +               */
> +               if (ioctl(sk, SIOCSIFFLAGS, (void *) &ifr) == 0)
> +                       break;
>                 err = -errno;
> -               error("bnep: Could not bring up %s: %s(%d)",
> -                                               devname, strerror(-err), -err);
> +               DBG("could not bring up interface %s with index %d: %s(%d) retry %d",
> +                       ifr.ifr_name, ifindex, strerror(-err), -err, retry);
> +
> +               /* Prepare retry */
> +               retry++;
> +               sleep(1);

Ditto.

>         }
>
>         close(sk);
>
> +       if (err) {
> +               error("bnep: Could not bring up interface %s with index %d: %s(%d)",
> +                       ifr.ifr_name, ifindex, strerror(-err), -err);
> +       }
> +
>         return err;
>  }
>
> -static int bnep_if_down(const char *devname)
> +/**
> + * private: for local use only.
> + *
> + * bnep_if_down() - Bring interface down.
> + * @ifindex interface index
> + *
> + * In case the interface can not be accessed (e.g. due to udev rename) do a retry.
> + *
> + * On success 0 is returned. On error errno as a negative value is returned.
> + */
> +static int bnep_if_down(unsigned int ifindex)
>  {
>         struct ifreq ifr;
> -       int sk, err = 0;
> +       int sk, err;
> +       int retry;
>
>         sk = socket(AF_INET, SOCK_DGRAM, 0);
>
>         memset(&ifr, 0, sizeof(ifr));
> -       strncpy(ifr.ifr_name, devname, IF_NAMESIZE - 1);
> -
>         ifr.ifr_flags &= ~IFF_UP;
>
> -       /* Bring down the interface */
> -       if (ioctl(sk, SIOCSIFFLAGS, (void *) &ifr) < 0) {
> +       retry = 0;
> +       while (retry < 2) {
> +               err = bnep_indextoname(ifindex, ifr.ifr_name);
> +               if (err)
> +                       break;
> +               /*
> +               * There is a potential race condition between udev renaming the interface
> +               * after the name is retrieved by bnep_nametoindex and the usage of the
> +               * interface name by ioctl.
> +               */
> +               if (ioctl(sk, SIOCSIFFLAGS, (void *) &ifr) == 0)
> +                       break;
>                 err = -errno;
> -               error("bnep: Could not bring down %s: %s(%d)",
> -                                               devname, strerror(-err), -err);
> +               DBG("could not bring down interface %s with index %d: %s(%d) retry %d",
> +                       ifr.ifr_name, ifindex, strerror(-err), -err, retry);
> +
> +               /* Prepare retry */
> +               retry++;
> +               sleep(1);

Ditto.

>         }
>
>         close(sk);
>
> +       if (err) {
> +               error("bnep: Could not bring down interface %s with index %d: %s(%d)",
> +                       ifr.ifr_name, ifindex, strerror(-err), -err);
> +       }
> +
>         return err;
>  }
>
> @@ -270,14 +437,19 @@ static gboolean bnep_setup_cb(GIOChannel *chan, GIOCondition cond,
>         setsockopt(sk, SOL_SOCKET, SO_RCVTIMEO, &timeo, sizeof(timeo));
>
>         sk = g_io_channel_unix_get_fd(session->io);
> -       if (bnep_connadd(sk, session->src, session->iface) < 0)
> +       if (bnep_connadd(sk, session->src, session->iface, &session->dst_addr, &session->ifindex) < 0)
>                 goto failed;
>
> -       if (bnep_if_up(session->iface) < 0) {
> +       if (bnep_if_up(session->ifindex) < 0) {
>                 bnep_conndel(&session->dst_addr);
>                 goto failed;
>         }
>
> +       /* Update interface name to current one only after interface is up.
> +        * Only at that time the name should be stable (no udev rename).
> +        */
> +       bnep_indextoname(session->ifindex, session->iface);
> +
>         session->watch = g_io_add_watch(session->io,
>                                         G_IO_ERR | G_IO_HUP | G_IO_NVAL,
>                                         (GIOFunc) bnep_watchdog_cb, session);
> @@ -305,7 +477,7 @@ static int bnep_setup_conn_req(struct bnep *session)
>         req = (void *) pkt;
>         req->type = BNEP_CONTROL;
>         req->ctrl = BNEP_SETUP_CONN_REQ;
> -       req->uuid_size = 2;     /* 16bit UUID */
> +       req->uuid_size = 2;     /* 16bit UUID */
>         s = (void *) req->service;
>         s->src = htons(session->src);
>         s->dst = htons(session->dst);
> @@ -354,6 +526,7 @@ struct bnep *bnep_new(int sk, uint16_t local_role, uint16_t remote_role,
>         session->dst = remote_role;
>         strncpy(session->iface, iface, 16);
>         session->iface[15] = '\0';
> +       session->ifindex = 0;
>
>         g_io_channel_set_close_on_unref(session->io, TRUE);
>         session->watch = g_io_add_watch(session->io,
> @@ -430,20 +603,26 @@ void bnep_disconnect(struct bnep *session)
>                 session->io = NULL;
>         }
>
> -       bnep_if_down(session->iface);
> +       bnep_if_down(session->ifindex);
>         bnep_conndel(&session->dst_addr);
>  }
>
> -static int bnep_add_to_bridge(const char *devname, const char *bridge)
> +static int bnep_add_to_bridge(unsigned int ifindex, const char *bridge)
>  {
> -       int ifindex;
>         struct ifreq ifr;
>         int sk, err = 0;
> +       char devname[IF_NAMESIZE];
>
> -       if (!devname || !bridge)
> +       DBG("add interface index %d to bridge %s", ifindex, bridge);
> +       if (!ifindex || !bridge)
>                 return -EINVAL;
>
> -       ifindex = if_nametoindex(devname);
> +       err = bnep_indextoname(ifindex, &devname[0]);
> +       if (err) {
> +               error("bnep: Can't add interface %s with index %d to the bridge %s: %s(%d)",
> +                                       devname, ifindex, bridge, strerror(-err), -err);
> +               return -EINVAL;
> +       }
>
>         sk = socket(AF_INET, SOCK_STREAM, 0);
>         if (sk < 0)
> @@ -451,7 +630,8 @@ static int bnep_add_to_bridge(const char *devname, const char *bridge)
>
>         memset(&ifr, 0, sizeof(ifr));
>         strncpy(ifr.ifr_name, bridge, IFNAMSIZ - 1);
> -       ifr.ifr_ifindex = ifindex;
> +       ifr.ifr_ifindex = (int)ifindex;
> +
>
>         if (ioctl(sk, SIOCBRADDIF, &ifr) < 0) {
>                 err = -errno;
> @@ -466,16 +646,21 @@ static int bnep_add_to_bridge(const char *devname, const char *bridge)
>         return err;
>  }
>
> -static int bnep_del_from_bridge(const char *devname, const char *bridge)
> +static int bnep_del_from_bridge(unsigned int ifindex, const char *bridge)
>  {
> -       int ifindex;
>         struct ifreq ifr;
>         int sk, err = 0;
> +       char devname[IF_NAMESIZE];
>
> -       if (!devname || !bridge)
> +       if (!ifindex || !bridge)
>                 return -EINVAL;
>
> -       ifindex = if_nametoindex(devname);
> +       err = bnep_indextoname(ifindex, &devname[0]);
> +       if (err) {
> +               error("bnep: Can't delete interface %s with index %d from the bridge %s: %s(%d)",
> +                                       devname, ifindex, bridge, strerror(-err), -err);
> +               return -EINVAL;
> +       }
>
>         sk = socket(AF_INET, SOCK_STREAM, 0);
>         if (sk < 0)
> @@ -483,7 +668,7 @@ static int bnep_del_from_bridge(const char *devname, const char *bridge)
>
>         memset(&ifr, 0, sizeof(ifr));
>         strncpy(ifr.ifr_name, bridge, IFNAMSIZ - 1);
> -       ifr.ifr_ifindex = ifindex;
> +       ifr.ifr_ifindex = (int)ifindex;
>
>         if (ioctl(sk, SIOCBRDELIF, &ifr) < 0) {
>                 err = -errno;
> @@ -606,6 +791,7 @@ static int bnep_server_add_legacy(int sk, uint16_t dst, char *bridge,
>                                         char *iface, const bdaddr_t *addr,
>                                         uint8_t *setup_data, int len)
>  {
> +       unsigned int ifindex;
>         int err, n;
>         uint16_t rsp;
>
> @@ -616,27 +802,32 @@ static int bnep_server_add_legacy(int sk, uint16_t dst, char *bridge,
>                 goto reply;
>         }
>
> -       err = bnep_connadd(sk, dst, iface);
> +       err = bnep_connadd(sk, dst, iface, addr, &ifindex);
>         if (err < 0) {
>                 rsp = BNEP_CONN_NOT_ALLOWED;
>                 goto reply;
>         }
>
> -       err = bnep_add_to_bridge(iface, bridge);
> +       err = bnep_add_to_bridge(ifindex, bridge);
>         if (err < 0) {
>                 bnep_conndel(addr);
>                 rsp = BNEP_CONN_NOT_ALLOWED;
>                 goto reply;
>         }
>
> -       err = bnep_if_up(iface);
> +       err = bnep_if_up(ifindex);
>         if (err < 0) {
> -               bnep_del_from_bridge(iface, bridge);
> +               bnep_del_from_bridge(ifindex, bridge);
>                 bnep_conndel(addr);
>                 rsp = BNEP_CONN_NOT_ALLOWED;
>                 goto reply;
>         }
>
> +       /* Update interface name to current one only after interface is up.
> +        * Only at that time the name should be stable (no udev rename).
> +        */
> +       bnep_indextoname(ifindex, iface);
> +
>         rsp = BNEP_SUCCESS;
>
>  reply:
> @@ -652,6 +843,7 @@ reply:
>  int bnep_server_add(int sk, char *bridge, char *iface, const bdaddr_t *addr,
>                                                 uint8_t *setup_data, int len)
>  {
> +       unsigned int ifindex;
>         int err;
>         uint32_t feat;
>         uint16_t rsp, dst;
> @@ -691,24 +883,29 @@ int bnep_server_add(int sk, char *bridge, char *iface, const bdaddr_t *addr,
>                 return bnep_server_add_legacy(sk, dst, bridge, iface, addr,
>                                                         setup_data, len);
>
> -       err = bnep_connadd(sk, dst, iface);
> +       err = bnep_connadd(sk, dst, iface, addr, &ifindex);
>         if (err < 0) {
>                 rsp = BNEP_CONN_NOT_ALLOWED;
>                 goto failed;
>         }
>
> -       err = bnep_add_to_bridge(iface, bridge);
> +       err = bnep_add_to_bridge(ifindex, bridge);
>         if (err < 0)
>                 goto failed_conn;
>
> -       err = bnep_if_up(iface);
> +       err = bnep_if_up(ifindex);
>         if (err < 0)
>                 goto failed_bridge;
>
> +       /* Update interface name to current one only after interface is up.
> +        * Only at that time the name should be stable (no udev rename).
> +        */
> +       bnep_indextoname(ifindex, iface);
> +
>         return 0;
>
>  failed_bridge:
> -       bnep_del_from_bridge(iface, bridge);
> +       bnep_del_from_bridge(ifindex, bridge);
>
>  failed_conn:
>         bnep_conndel(addr);
> @@ -727,10 +924,22 @@ failed:
>
>  void bnep_server_delete(char *bridge, char *iface, const bdaddr_t *addr)
>  {
> +       int err;
> +       unsigned int ifindex;
> +
>         if (!bridge || !iface || !addr)
>                 return;
>
> -       bnep_del_from_bridge(iface, bridge);
> -       bnep_if_down(iface);
> +       err = bnep_nametoindex(iface, &ifindex);
> +       if (err) {
> +               error("bnep: Failed to delete device %s - interface not available/ renamed: %s(%d)",
> +                                               iface, strerror(-err), -err);
> +               goto failed;
> +       }
> +
> +       bnep_del_from_bridge(ifindex, bridge);
> +       bnep_if_down(ifindex);
> +failed:
>         bnep_conndel(addr);
>  }
> +
> --
> 2.7.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
