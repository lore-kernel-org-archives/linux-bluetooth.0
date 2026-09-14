Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B0847533E
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Sep 2026 13:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789393047; cv=pass; b=d5Sf0gC9rZNfYc8myRpKcAovY/H1xsHGZwaTT3ehM0YT83qC/17sNFI2mVTpBYKaeYaBdy76MnDLLilOjTrr5xBLlDN6O8OAZ7kicz4cUYC3lsOM0J8e9auk+gWtlOyjI9ruUF67tOhaFHqcZn0IOsFRDnjOcLZGxKGmme+mr2U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789393047; c=relaxed/simple;
	bh=9/RyajETRS7JaIokh+AzptLF8frp93De9Ajxq9Srfmc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aSiRoYflzaeQTR5R2zW8vn3j/zcHXMb+7Tb1P70u7WICGU2Dw3SDpazs60ikLGAIvBqnmXYSDnFspEUnBlSxG+q5g73l5vn1ggXd7d4S14tT29AgeNJppRBaFdyD4/fJ7tEW9d3mU2CznHoswm4sHpfZOVOIH/D43udr+2WsmfE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YAVs4Cvk; arc=pass smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YAVs4Cvk"
Received: by mail-yx2-f13.google.com with SMTP id 956f58d0204a3-6713d20d375so1407682d50.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Sep 2026 06:37:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789393045; cv=none;
        d=google.com; s=arc-20260327;
        b=Blh+0gaOpDVVJl+QevDqTzuIj/CwZ70fHY+o3+l4gWTfuBzhvn9ZXWxemxO41FiMDW
         aWc3ypeEp5x5WIjW8E/Zcv0JJk+xGgB4o/UGMJMdkQsKFpeceY1/4+XAFtDnlubFNFOo
         dql2nP7vTBR0Ejxc2BBkXdIy8+KPNCUBKDElrG4Uv8zz2g6RhYJWd42cB7aGJsLCJw+O
         /yAdkJfePhKNGL47jJOheZkaQnzF+7fP4KvD44femsWUhXyIQj8hEl9gQ0x1pQGH09zD
         HSyuLSoPY8AJb3BO8dIJ+un9KXwaEUqBcu+w0wZjQCwdtywl2RMHjlB9bITCe/JdFQOI
         zR8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1jKg9u/X8a1eZ5R4WLZi6NMAIRDHGHmgAVoEAnSweEA=;
        fh=h6lGVIwnN+ST3u+/UtyvxpLbhqUiyXcgSw6hWMWIrgk=;
        b=WpxGwpfOI5wwodalgs6XQLGyuhWiAAEWUqgJ0WCdrZ0/9No58644re5pDuUmzlcvj0
         i5s4+pM9p2DQ1VPzONmTFOsbmCcFCX82HsqlFDFP0Coev9iDO3VDY5N2R1b43Ls2Xafy
         eTGEJ2UF6D90LA6yFOYZ0znCPsDwWo3v4JwF+3CsDp1khvkLhXBsnLXYZdMUEnmIjK2h
         BSbShIlB5ARa0MK2lf9hineRQBfsBMOEpy/VjlCEwHyWnt3srjrkIdbnzwZENKaiaOdK
         5quZ9DtCZAKtC3iVoiXVquOtE9OnEzPF4Cy32IVmTfoYaD3hXABusKnsDc01jqWKU4DP
         R2aA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789393045; x=1789997845; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1jKg9u/X8a1eZ5R4WLZi6NMAIRDHGHmgAVoEAnSweEA=;
        b=YAVs4CvkkoxvPGgJDkbaC8x61FXudaCdeZUXDeFhbMqxCpbFIVfIr8PQxfFASK3RM5
         YNwnNUYy/w02k+vBOmvkppeLuI5CdJ21IUafD0olzAUqqXUFP4XQaFyf6fVgXCTg1wXj
         J0klLs/oQnJFGoftKEBIPYvATiY3KT33UGWMTwsKEV7Bqt+b+aygBDgkr6DbED1t49Lp
         BbdUAAOxBU4vzbTw7ESyYt7ZPv/APx6kofbfuGfCw7YTlus0DpMi/NX81v2jY4JXtsUv
         bDURLurrM6Y3h1Ujubdla8lb/c3lhk9baj9PtwL3jg8LZfT8Vc8flPE5jTCPm2GAmsqi
         FKdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789393045; x=1789997845;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1jKg9u/X8a1eZ5R4WLZi6NMAIRDHGHmgAVoEAnSweEA=;
        b=BzvCxG2SJre+5Nv4ibFYPeahLE+ajpZcd2j1df9m/PBrbIPBJ2pgs97sCJMISiG5Og
         gHudfCe6C8Ppn6lMw0/ylvB9XfQazCElZT5aSPf/3FL8cbAFEsQWdzL8HOi/DGRuVA8y
         2C0lFsEzJY6dEess9TGtlpnf7W8KV/l1Oa4DiRnmvqolbST+uqdQefc9RI0H4mxRTVfO
         CIq9hQzXuF3SxKcjN712mHbKsdqKg2RMdp8eEqcDUDX6iHcDfJaKgcXmKrYOfhIth6+k
         TRAGygHo2UTHhU8KBVwSoMTJD1Fk8MMzHIZP6wYivVjEVYuC9YD/l5z1OHDl2GZzlmh7
         qYuA==
X-Forwarded-Encrypted: i=1; AKwUvBy+lExIdIU4N68iKNvd6VvifJ00AyiQNOeSXoN8TjFSJ7RT1qmQ4ADPwgI1wUudpWPcK4aN05e4RzRC00YipBs=@vger.kernel.org
X-Gm-Message-State: AFuF++meC3C64qdR938bszYpgSD33iExvpVIGmfRQowrF8l+rdEAyTxl
	0hma2E+I3mNOo/3VkJI9cC0IeUE51ygpxQskXrA6F8FBKP6fdvOXZYAcGZWYAgOsubD6Y/YYkTN
	gn4NLfC0MmlwftfskbQ2S1ZL7EfVVQKU=
X-Gm-Gg: AYBFou3IPaaX0QwWg4qMTFbOQkN8JkXFZXKHyXKGB0ptgcyieL4cnk8+2pLCpLHUoPJ
	b4nixg49Qaz3UUoYRCU9bU1+KixfkAIVqU92hRo2k2UoTRsyfkGGiisQQ979JNpXTsFH4+/i+GH
	d6CQX7YhHYqmZEsCLGJvAujxlhVR2WLd8I66Puuof+frOEWvYK54BLyF9C7wpSphQsZVe4hLMwh
	UJ2ntkSl8TBVH/JAarEWqaKXWksKdUPLTD5Uc1TWk+9OiyKT+VGpEaAkpIUNSHcDNTcfyoMKa+R
	8RNyYk6/OrAh+6IOEK1psgmZ0/TZZUmtJOnZtpRGeAyeO5IuQ/rfm0MyWXuearSPwhdptv6B8Fu
	P6Dd2GGYHbfeRE4p26CBHaib0YmUXqkHqkE9lAnjTOrgsNVALGvDH
X-Received: by 2002:a05:690e:4893:10b0:66f:c1be:84f0 with SMTP id
 956f58d0204a3-6714e1fb9fcmr404204d50.94.1789393044525; Mon, 14 Sep 2026
 06:37:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260912100315.151674-1-mikhail.v.gavrilov@gmail.com>
In-Reply-To: <20260912100315.151674-1-mikhail.v.gavrilov@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 14 Sep 2026 09:37:12 -0400
X-Gm-Features: AcwNN1UZQNJo5_PHQh3UyFpsR9W1n3tpSvAYjG4sJDlJDfsze1asvS35xP-8Pv4
Message-ID: <CABBYNZKDMriYfGN_8hNmpDdhxdJXL8hzOzP+7LhsV_kwXcYTBw@mail.gmail.com>
Subject: Re: [PATCH v3] Bluetooth: RFCOMM: connect the session socket without rfcomm_mutex
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: marcel@holtmann.org, nicoyip.dev@gmail.com, pav@iki.fi, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+74071deb72339c215b2e@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mikhail,

On Sat, Sep 12, 2026 at 6:03=E2=80=AFAM Mikhail Gavrilov
<mikhail.v.gavrilov@gmail.com> wrote:
>
> An RFCOMM connect() issued while a BR/EDR link is being authenticated
> makes lockdep report a circular dependency, and the reported cycle is a
> real AB/BA between rfcomm_mutex and hdev->lock.
>
> rfcomm_security_cfm() is called from the HCI event path, which already
> holds hdev->lock:
>
>   hci_rx_work()
>     hci_event_packet()
>       hci_cc_read_enc_key_size()   [hdev->lock]
>         hci_encrypt_cfm()          [hci_cb_list_lock]
>           rfcomm_security_cfm()    [rfcomm_mutex]
>
> while an RFCOMM connect() from userspace takes the same two locks the
> other way round:
>
>   rfcomm_sock_connect()
>     rfcomm_dlc_open()              [rfcomm_mutex]
>       __rfcomm_dlc_open()
>         rfcomm_session_create()
>           kernel_connect()
>             l2cap_sock_connect()
>               l2cap_chan_connect() [hdev->lock]
>
>   WARNING: possible circular locking dependency detected
>   kworker/u131:1/1128 is trying to acquire lock:
>   rfcomm_mutex, at: rfcomm_security_cfm+0x31/0x3e0 [rfcomm]
>   but task is already holding lock:
>   hci_cb_list_lock, at: hci_cc_read_enc_key_size+0x1d2/0xcc0
>   Chain exists of:
>     rfcomm_mutex --> &hdev->lock --> hci_cb_list_lock
>
> hci_auth_complete_evt() and hci_encrypt_change_evt() reach the callback
> the same way.
>
> Both orders have to be seen in the same boot, which is why a BR/EDR
> connection alone is not enough to show it: a session set up by the
> remote side is created by rfcomm_accept_connection() in krfcommd, which
> calls kernel_accept() and never takes hdev->lock under rfcomm_mutex.
> Connecting a device that authenticates and encrypts the link and then
> calling connect() on an RFCOMM socket towards any address - the connect
> does not have to succeed, the order is recorded before the page timeout
> - reports it every time.
>
> Only the session socket has to be connected with the lock held, and it
> does not: nothing else can see the socket before it is put on the
> session list.  So connect it first and take rfcomm_mutex afterwards,
> which removes the rfcomm_mutex -> hdev->lock order for good, rather
> than keeping the HCI event path out of rfcomm_mutex.
>
> rfcomm_session_create() becomes rfcomm_session_connect(), which returns
> the connected socket without touching the session list, and
> rfcomm_dlc_open() adds the session once it holds the lock again.  If
> another opener added a session for the same pair while this socket was
> connecting, that session is used and this socket is dropped.
> __rfcomm_dlc_open() now takes the session it should use, and its state
> check runs after the lock is re-acquired, so a DLC that was opened or
> closed in the meantime is still handled.
>
> Over an existing ACL link the connection can complete before the
> session reaches the list, and the wakeup from the socket callback is
> then lost, so krfcommd is woken once the session is visible.
>
> Fixes: 759c185d0bbd ("Bluetooth: RFCOMM: serialize security confirmation =
handling")
> Suggested-by: Pauli Virtanen <pav@iki.fi>
> Reported-by: Pauli Virtanen <pav@iki.fi>
> Closes: https://lore.kernel.org/linux-bluetooth/5e76a95e934e451e7006db288=
27c2d64af5a88be.camel@iki.fi/
> Reported-by: syzbot+74071deb72339c215b2e@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/linux-bluetooth/6a92fadc.08e933ee.dbf97.0=
08f.GAE@google.com/
> Cc: stable@vger.kernel.org
> Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
> ---
>
> The commit this fixes is in v7.3-rc1 and is marked for stable, so this
> probably wants the bluetooth fixes tree rather than -next.
>
> v1: https://lore.kernel.org/linux-bluetooth/20260902235132.453044-1-mikha=
il.v.gavrilov@gmail.com/
> v2: https://lore.kernel.org/linux-bluetooth/20260904012028.77590-1-mikhai=
l.v.gavrilov@gmail.com/
>
> v3:
>  - fix the lock order on the connect side instead of deferring the
>    security confirmation, as asked for on v2; rfcomm_security_cfm()
>    and krfcommd are left alone, so none of the questions about delayed
>    confirmations apply any more
>  - the queue, its annotations and the flush from v2 are gone
>
> Tested on 7.3.0-rc2 with an MT7922 controller (btusb).  Without the
> patch the reproducer below reports the inversion on every run; with it
> applied it stays quiet and the validator is still armed afterwards
> (debug_locks: 1).  A 10 hour session with BR/EDR headset connects,
> AVRCP and SCO traffic produced no lockdep report either.
>
> An outgoing connect towards a connected headset is answered in 29 ms
> with ECONNREFUSED - the session is established over the existing ACL
> link and the peer rejects the channel - which is the case where the
> L2CAP connect can complete before the session reaches the list.
> Towards an idle device the same connect fails with EHOSTDOWN after the
> page timeout.
>
> The connect() side used for the reproducer, so that it does not depend
> on which end sets up the HFP session:
>
>   #include <stdint.h>
>   #include <string.h>
>   #include <unistd.h>
>   #include <sys/socket.h>
>
>   #define BTPROTO_RFCOMM 3
>
>   struct sockaddr_rc {
>       unsigned short  rc_family;
>       uint8_t         rc_bdaddr[6];   /* little endian */
>       uint8_t         rc_channel;
>   };
>
>   int main(void)
>   {
>       struct sockaddr_rc addr =3D { .rc_family =3D AF_BLUETOOTH,
>                                   .rc_channel =3D 1 };
>       int fd =3D socket(AF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM);
>
>       memcpy(addr.rc_bdaddr, "\x55\x44\x33\x22\x11\x00", 6);
>       connect(fd, (struct sockaddr *)&addr, sizeof(addr));
>       close(fd);
>       return 0;
>   }
>
>  net/bluetooth/rfcomm/core.c | 114 ++++++++++++++++++++++++------------
>  1 file changed, 76 insertions(+), 38 deletions(-)
>
> diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
> index f7463f092283..227ccc7da848 100644
> --- a/net/bluetooth/rfcomm/core.c
> +++ b/net/bluetooth/rfcomm/core.c
> @@ -62,10 +62,9 @@ static void rfcomm_make_uih(struct sk_buff *skb, u8 ad=
dr);
>
>  static void rfcomm_process_connect(struct rfcomm_session *s);
>
> -static struct rfcomm_session *rfcomm_session_create(bdaddr_t *src,
> -                                                       bdaddr_t *dst,
> -                                                       u8 sec_level,
> -                                                       int *err);
> +static struct socket *rfcomm_session_connect(bdaddr_t *src, bdaddr_t *ds=
t,
> +                                            u8 sec_level, int *err);
> +static struct rfcomm_session *rfcomm_session_add(struct socket *sock, in=
t state);
>  static struct rfcomm_session *rfcomm_session_get(bdaddr_t *src, bdaddr_t=
 *dst);
>  static struct rfcomm_session *rfcomm_session_del(struct rfcomm_session *=
s);
>
> @@ -365,28 +364,17 @@ static int rfcomm_check_channel(u8 channel)
>         return channel < 1 || channel > 30;
>  }
>
> -static int __rfcomm_dlc_open(struct rfcomm_dlc *d, bdaddr_t *src, bdaddr=
_t *dst, u8 channel)
> +static int __rfcomm_dlc_open(struct rfcomm_dlc *d, struct rfcomm_session=
 *s,
> +                            u8 channel)
>  {
> -       struct rfcomm_session *s;
> -       int err =3D 0;
>         u8 dlci;
>
> -       BT_DBG("dlc %p state %ld %pMR -> %pMR channel %d",
> -              d, d->state, src, dst, channel);
> -
> -       if (rfcomm_check_channel(channel))
> -               return -EINVAL;
> +       BT_DBG("dlc %p state %ld session %p channel %d",
> +              d, d->state, s, channel);
>
>         if (d->state !=3D BT_OPEN && d->state !=3D BT_CLOSED)
>                 return 0;
>
> -       s =3D rfcomm_session_get(src, dst);
> -       if (!s) {
> -               s =3D rfcomm_session_create(src, dst, d->sec_level, &err)=
;
> -               if (!s)
> -                       return err;
> -       }
> -
>         dlci =3D __dlci(__session_dir(s), channel);
>
>         /* Check if DLCI already exists */
> @@ -421,14 +409,72 @@ static int __rfcomm_dlc_open(struct rfcomm_dlc *d, =
bdaddr_t *src, bdaddr_t *dst,
>
>  int rfcomm_dlc_open(struct rfcomm_dlc *d, bdaddr_t *src, bdaddr_t *dst, =
u8 channel)
>  {
> -       int r;
> +       struct rfcomm_session *s;
> +       struct socket *sock;
> +       int err;
> +
> +       BT_DBG("dlc %p state %ld %pMR -> %pMR channel %d",
> +              d, d->state, src, dst, channel);
> +
> +       if (rfcomm_check_channel(channel))
> +               return -EINVAL;
>
>         rfcomm_lock();
>
> -       r =3D __rfcomm_dlc_open(d, src, dst, channel);
> +       /* Do not page the remote device for a DLC that cannot be opened
> +        * anyway.  __rfcomm_dlc_open() looks at the state again once the
> +        * lock has been re-acquired below.
> +        */
> +       if (d->state !=3D BT_OPEN && d->state !=3D BT_CLOSED) {
> +               rfcomm_unlock();
> +               return 0;
> +       }
>
> +       s =3D rfcomm_session_get(src, dst);
> +       if (s) {
> +               err =3D __rfcomm_dlc_open(d, s, channel);
> +               rfcomm_unlock();
> +               return err;
> +       }
>         rfcomm_unlock();
> -       return r;
> +
> +       /* There is no session for this pair yet.  kernel_connect() ends =
up in
> +        * l2cap_chan_connect(), which takes hdev->lock, and the HCI even=
t
> +        * path takes rfcomm_mutex while holding hdev->lock, so the socke=
t has
> +        * to be connected with rfcomm_mutex released.
> +        */
> +       sock =3D rfcomm_session_connect(src, dst, d->sec_level, &err);
> +       if (!sock)
> +               return err;

We might need to check if the sock hasn't been closed in the process:

https://sashiko.dev/#/patchset/20260912100315.151674-1-mikhail.v.gavrilov%4=
0gmail.com

> +       rfcomm_lock();
> +
> +       /* Another opener may have added a session for the same pair in t=
he
> +        * meantime; that one is used and this socket is dropped.
> +        */
> +       s =3D rfcomm_session_get(src, dst);
> +       if (!s) {
> +               s =3D rfcomm_session_add(sock, BT_BOUND);
> +               if (s) {
> +                       s->initiator =3D 1;
> +                       sock =3D NULL;
> +               }
> +       }
> +
> +       err =3D s ? __rfcomm_dlc_open(d, s, channel) : -ENOMEM;
> +
> +       rfcomm_unlock();
> +
> +       if (sock)
> +               sock_release(sock);
> +
> +       /* Over an existing ACL link the connection can complete before t=
he
> +        * session reaches the list, and that wakeup is then lost, so let
> +        * krfcommd look at the socket state now.
> +        */
> +       rfcomm_schedule();
> +
> +       return err;
>  }
>
>  static void __rfcomm_dlc_disconn(struct rfcomm_dlc *d)
> @@ -757,12 +803,12 @@ static struct rfcomm_session *rfcomm_session_close(=
struct rfcomm_session *s,
>         return rfcomm_session_del(s);
>  }
>
> -static struct rfcomm_session *rfcomm_session_create(bdaddr_t *src,
> -                                                       bdaddr_t *dst,
> -                                                       u8 sec_level,
> -                                                       int *err)
> +/* Creates the L2CAP socket a new session will run on and starts connect=
ing
> + * it.  Must be called with rfcomm_mutex released.
> + */
> +static struct socket *rfcomm_session_connect(bdaddr_t *src, bdaddr_t *ds=
t,
> +                                            u8 sec_level, int *err)
>  {
> -       struct rfcomm_session *s =3D NULL;
>         struct sockaddr_l2 addr;
>         struct socket *sock;
>         struct sock *sk;
> @@ -792,24 +838,16 @@ static struct rfcomm_session *rfcomm_session_create=
(bdaddr_t *src,
>                 l2cap_pi(sk)->chan->mode =3D L2CAP_MODE_ERTM;
>         release_sock(sk);
>
> -       s =3D rfcomm_session_add(sock, BT_BOUND);
> -       if (!s) {
> -               *err =3D -ENOMEM;
> -               goto failed;
> -       }
> -
> -       s->initiator =3D 1;
> -
>         bacpy(&addr.l2_bdaddr, dst);
>         addr.l2_family =3D AF_BLUETOOTH;
>         addr.l2_psm    =3D cpu_to_le16(L2CAP_PSM_RFCOMM);
>         addr.l2_cid    =3D 0;
>         addr.l2_bdaddr_type =3D BDADDR_BREDR;
>         *err =3D kernel_connect(sock, (struct sockaddr_unsized *)&addr, s=
izeof(addr), O_NONBLOCK);
> -       if (*err =3D=3D 0 || *err =3D=3D -EINPROGRESS)
> -               return s;
> +       if (*err && *err !=3D -EINPROGRESS)
> +               goto failed;
>
> -       return rfcomm_session_del(s);
> +       return sock;
>
>  failed:
>         sock_release(sock);
> --
> 2.55.0
>


--=20
Luiz Augusto von Dentz
