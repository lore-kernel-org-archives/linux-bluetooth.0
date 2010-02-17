Return-Path: <cyrus@holtmann.org>
Message-ID: <4B7BB746.1040806@nokia.com>
Date: Wed, 17 Feb 2010 11:30:46 +0200
From: Ville Tervo <ville.tervo@nokia.com>
MIME-Version: 1.0
To: ext Nick Pelly <npelly@google.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] Bluetooth: Allow SCO/eSCO packet type selection for
 outgoing SCO connections.
References: <1265918068-14721-1-git-send-email-npelly@google.com> 	<35c90d961002111159h6727bc2cw28b55ce6e919fb4f@mail.gmail.com> <35c90d961002151315i5fc0f5b9y36aaba4415987a2f@mail.gmail.com>
In-Reply-To: <35c90d961002151315i5fc0f5b9y36aaba4415987a2f@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

ext Nick Pelly wrote:
> On Thu, Feb 11, 2010 at 11:59 AM, Nick Pelly <npelly@google.com> wrote:
>> On Thu, Feb 11, 2010 at 11:54 AM, Nick Pelly <npelly@google.com> wrote:
>>> __u16 sco_pkt_type is introduced to struct sockaddr_sco. It allows bitwise
>>> selection of SCO/eSCO packet types as per the Packet_Type parameter in
>>> HCI Setup Synchrnous Connection Command.
>>>
>>> 0x0001 HV1 may be used.
>>> 0x0002 HV2 may be used.
>>> 0x0004 HV3 may be used.
>>> 0x0008 EV3 may be used.
>>> 0x0010 EV4 may be used.
>>> 0x0020 EV5 may be used.
>>> 0x0040 2-EV3 may not be used.
>>> 0x0080 3-EV3 may not be used.
>>> 0x0100 2-EV5 may not be used.
>>> 0x0200 3-EV5 may not be used.
>>>
>>> We've followed the Bluetooth SIG convention of reversing the logic on the
>>> EDR bits.
>>>
>>> Packet type selection is just a request made to the Bluetooth chipset, and
>>> it is up to the link manager on the chipset to negiotiate and decide on the
>>> actual packet types used. Furthermore, when a SCO/eSCO connection is eventually
>>> made there is no way for the host stack to determine which packet type was used
>>> (however it is possible to get the link type of SCO or eSCO).
>>>
>>> sco_pkt_type is ignored for incoming SCO connections. It is possible
>>> to add this in the future as a parameter to the Accept Synchronous Connection
>>> Command, however its a little trickier because the kernel does not
>>> currently preserve sockaddr_sco data between userspace calls to accept().
>>>
>>> Typically userspace just wants to select eSCO or SCO packet types, which can be
>>> done with the new constants ALL_SCO_PKTS or ALL_ESCO_PKTS. If sco_pkt_type is
>>> zero, or userspace uses the old sockaddr_sco structure size, then ALL_ESCO_PKTS
>>> will be selected as default.
>>>
>>> This patch is motivated by broken Bluetooth carkits such as the Motorolo
>>> HF850 (it claims to support eSCO, but will actually reject eSCO connections
>>> after 5 seconds) and the 2007/2008 Infiniti G35/37 (fails to route audio
>>> if a 2-EV5 packet type is negiotiated). With this patch userspace can maintain
>>> a blacklist of packet types to workaround broken remote devices such as these.
>>>
>>> Signed-off-by: Nick Pelly <npelly@google.com>
>>> ---
>>>  include/net/bluetooth/hci.h      |    7 +++-
>>>  include/net/bluetooth/hci_core.h |    7 +++-
>>>  include/net/bluetooth/sco.h      |    4 ++-
>>>  net/bluetooth/hci_conn.c         |   25 +++++++++------
>>>  net/bluetooth/hci_event.c        |    6 ++-
>>>  net/bluetooth/l2cap.c            |    2 +-
>>>  net/bluetooth/sco.c              |   61 +++++++++++++++++++++++++------------
>>>  7 files changed, 74 insertions(+), 38 deletions(-)
>>>
>>> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
>>> index 4f7795f..72efc94 100644
>>> --- a/include/net/bluetooth/hci.h
>>> +++ b/include/net/bluetooth/hci.h
>>> @@ -139,8 +139,11 @@ enum {
>>>  #define ESCO_2EV5      0x0100
>>>  #define ESCO_3EV5      0x0200
>>>
>>> -#define SCO_ESCO_MASK  (ESCO_HV1 | ESCO_HV2 | ESCO_HV3)
>>> -#define EDR_ESCO_MASK  (ESCO_2EV3 | ESCO_3EV3 | ESCO_2EV5 | ESCO_3EV5)
>>> +#define SCO_ESCO_MASK  (ESCO_HV1 | ESCO_HV2 | ESCO_HV3)
>>> +#define EDR_ESCO_MASK  (ESCO_2EV3 | ESCO_3EV3 | ESCO_2EV5 | ESCO_3EV5)
>>> +
>>> +#define ALL_SCO_PKTS   (SCO_ESCO_MASK | EDR_ESCO_MASK)
>>> +#define ALL_ESCO_PKTS  (SCO_ESCO_MASK | ESCO_EV3 | ESCO_EV4 | ESCO_EV5)
>>>
>>>  /* ACL flags */
>>>  #define ACL_START              0x00
>>> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
>>> index b6d36cb..cbcc5b1 100644
>>> --- a/include/net/bluetooth/hci_core.h
>>> +++ b/include/net/bluetooth/hci_core.h
>>> @@ -326,12 +326,15 @@ void hci_acl_disconn(struct hci_conn *conn, __u8 reason);
>>>  void hci_add_sco(struct hci_conn *conn, __u16 handle);
>>>  void hci_setup_sync(struct hci_conn *conn, __u16 handle);
>>>
>>> -struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst);
>>> +struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type,
>>> +                                       __u16 pkt_type, bdaddr_t *dst);
>>>  int hci_conn_del(struct hci_conn *conn);
>>>  void hci_conn_hash_flush(struct hci_dev *hdev);
>>>  void hci_conn_check_pending(struct hci_dev *hdev);
>>>
>>> -struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst, __u8 sec_level, __u8 auth_type);
>>> +struct hci_conn *hci_connect(struct hci_dev *hdev, int type,
>>> +                                       __u16 pkt_type, bdaddr_t *dst,
>>> +                                       __u8 sec_level, __u8 auth_type);
>>>  int hci_conn_check_link_mode(struct hci_conn *conn);
>>>  int hci_conn_security(struct hci_conn *conn, __u8 sec_level, __u8 auth_type);
>>>  int hci_conn_change_link_key(struct hci_conn *conn);
>>> diff --git a/include/net/bluetooth/sco.h b/include/net/bluetooth/sco.h
>>> index e28a2a7..924338a 100644
>>> --- a/include/net/bluetooth/sco.h
>>> +++ b/include/net/bluetooth/sco.h
>>> @@ -37,6 +37,7 @@
>>>  struct sockaddr_sco {
>>>        sa_family_t     sco_family;
>>>        bdaddr_t        sco_bdaddr;
>>> +       __u16           sco_pkt_type;
>>>  };
>>>
>>>  /* SCO socket options */
>>> @@ -72,7 +73,8 @@ struct sco_conn {
>>>
>>>  struct sco_pinfo {
>>>        struct bt_sock  bt;
>>> -       __u32           flags;
>>> +       __u16           pkt_type;
>>> +
>>>        struct sco_conn *conn;
>>>  };
>>>
>>> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
>>> index fa8b412..8ced057 100644
>>> --- a/net/bluetooth/hci_conn.c
>>> +++ b/net/bluetooth/hci_conn.c
>>> @@ -196,7 +196,8 @@ static void hci_conn_idle(unsigned long arg)
>>>        hci_conn_enter_sniff_mode(conn);
>>>  }
>>>
>>> -struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst)
>>> +struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type,
>>> +                                       __u16 pkt_type, bdaddr_t *dst)
>>>  {
>>>        struct hci_conn *conn;
>>>
>>> @@ -221,14 +222,16 @@ struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst)
>>>                conn->pkt_type = hdev->pkt_type & ACL_PTYPE_MASK;
>>>                break;
>>>        case SCO_LINK:
>>> +               if (!pkt_type)
>>> +                       pkt_type = ALL_SCO_PKTS;
>>> +       case ESCO_LINK:
>>> +               if (!pkt_type)
>>> +                       pkt_type = ALL_ESCO_PKTS;
>>>                if (lmp_esco_capable(hdev))
>>> -                       conn->pkt_type = (hdev->esco_type & SCO_ESCO_MASK) |
>>> -                                       (hdev->esco_type & EDR_ESCO_MASK);
>>> +                       conn->pkt_type = pkt_type & hdev->esco_type;
>>>                else
>>> -                       conn->pkt_type = hdev->pkt_type & SCO_PTYPE_MASK;
>>> -               break;
>>> -       case ESCO_LINK:
>>> -               conn->pkt_type = hdev->esco_type & ~EDR_ESCO_MASK;
>>> +                       conn->pkt_type = (pkt_type << 5) & hdev->pkt_type &
>>> +                                       SCO_PTYPE_MASK;
>>>                break;
>>>        }
>>>
>>> @@ -340,7 +343,9 @@ EXPORT_SYMBOL(hci_get_route);
>>>
>>>  /* Create SCO or ACL connection.
>>>  * Device _must_ be locked */
>>> -struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst, __u8 sec_level, __u8 auth_type)
>>> +struct hci_conn *hci_connect(struct hci_dev *hdev, int type,
>>> +                                       __u16 pkt_type, bdaddr_t *dst,
>>> +                                       __u8 sec_level, __u8 auth_type)
>>>  {
>>>        struct hci_conn *acl;
>>>        struct hci_conn *sco;
>>> @@ -348,7 +353,7 @@ struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst, __u8
>>>        BT_DBG("%s dst %s", hdev->name, batostr(dst));
>>>
>>>        if (!(acl = hci_conn_hash_lookup_ba(hdev, ACL_LINK, dst))) {
>>> -               if (!(acl = hci_conn_add(hdev, ACL_LINK, dst)))
>>> +               if (!(acl = hci_conn_add(hdev, ACL_LINK, 0, dst)))
>>>                        return NULL;
>>>        }
>>>
>>> @@ -364,7 +369,7 @@ struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst, __u8
>>>                return acl;
>>>
>>>        if (!(sco = hci_conn_hash_lookup_ba(hdev, type, dst))) {
>>> -               if (!(sco = hci_conn_add(hdev, type, dst))) {
>>> +               if (!(sco = hci_conn_add(hdev, type, pkt_type, dst))) {
>>>                        hci_conn_put(acl);
>>>                        return NULL;
>>>                }
>>> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
>>> index 10edd1a..5343e0f 100644
>>> --- a/net/bluetooth/hci_event.c
>>> +++ b/net/bluetooth/hci_event.c
>>> @@ -579,7 +579,7 @@ static inline void hci_cs_create_conn(struct hci_dev *hdev, __u8 status)
>>>                }
>>>        } else {
>>>                if (!conn) {
>>> -                       conn = hci_conn_add(hdev, ACL_LINK, &cp->bdaddr);
>>> +                       conn = hci_conn_add(hdev, ACL_LINK, 0, &cp->bdaddr);
>>>                        if (conn) {
>>>                                conn->out = 1;
>>>                                conn->link_mode |= HCI_LM_MASTER;
>>> @@ -964,7 +964,9 @@ static inline void hci_conn_request_evt(struct hci_dev *hdev, struct sk_buff *sk
>>>
>>>                conn = hci_conn_hash_lookup_ba(hdev, ev->link_type, &ev->bdaddr);
>>>                if (!conn) {
>>> -                       if (!(conn = hci_conn_add(hdev, ev->link_type, &ev->bdaddr))) {
>>> +                       /* pkt_type not yet used for incoming connections */
>>> +                       if (!(conn = hci_conn_add(hdev, ev->link_type, 0,
>>> +                                                       &ev->bdaddr))) {
>>>                                BT_ERR("No memmory for new connection");
>>>                                hci_dev_unlock(hdev);
>>>                                return;
>>> diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
>>> index d056886..b342f06 100644
>>> --- a/net/bluetooth/l2cap.c
>>> +++ b/net/bluetooth/l2cap.c
>>> @@ -955,7 +955,7 @@ static int l2cap_do_connect(struct sock *sk)
>>>                }
>>>        }
>>>
>>> -       hcon = hci_connect(hdev, ACL_LINK, dst,
>>> +       hcon = hci_connect(hdev, ACL_LINK, 0, dst,
>>>                                        l2cap_pi(sk)->sec_level, auth_type);
>>>        if (!hcon)
>>>                goto done;
>>> diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
>>> index 77f4153..4976ad5 100644
>>> --- a/net/bluetooth/sco.c
>>> +++ b/net/bluetooth/sco.c
>>> @@ -176,6 +176,7 @@ static int sco_connect(struct sock *sk)
>>>  {
>>>        bdaddr_t *src = &bt_sk(sk)->src;
>>>        bdaddr_t *dst = &bt_sk(sk)->dst;
>>> +       __u16 pkt_type = sco_pi(sk)->pkt_type;
>>>        struct sco_conn *conn;
>>>        struct hci_conn *hcon;
>>>        struct hci_dev  *hdev;
>>> @@ -192,10 +193,14 @@ static int sco_connect(struct sock *sk)
>>>
>>>        if (lmp_esco_capable(hdev) && !disable_esco)
>>>                type = ESCO_LINK;
>>> -       else
>>> +       else {
>>>                type = SCO_LINK;
>>> +               pkt_type &= SCO_ESCO_MASK;
>>> +               pkt_type |= EDR_ESCO_MASK;
>>> +       }
>>>
>>> -       hcon = hci_connect(hdev, type, dst, BT_SECURITY_LOW, HCI_AT_NO_BONDING);
>>> +       hcon = hci_connect(hdev, type, pkt_type, dst,
>>> +                                       BT_SECURITY_LOW, HCI_AT_NO_BONDING);
>>>        if (!hcon)
>>>                goto done;
>>>
>>> @@ -451,18 +456,22 @@ static int sco_sock_create(struct net *net, struct socket *sock, int protocol)
>>>        return 0;
>>>  }
>>>
>>> -static int sco_sock_bind(struct socket *sock, struct sockaddr *addr, int addr_len)
>>> +static int sco_sock_bind(struct socket *sock, struct sockaddr *addr, int alen)
>>>  {
>>> -       struct sockaddr_sco *sa = (struct sockaddr_sco *) addr;
>>> +       struct sockaddr_sco sa;
>>>        struct sock *sk = sock->sk;
>>> -       bdaddr_t *src = &sa->sco_bdaddr;
>>> -       int err = 0;
>>> +       bdaddr_t *src = &sa.sco_bdaddr;
>>> +       int len, err = 0;
>>>
>>> -       BT_DBG("sk %p %s", sk, batostr(&sa->sco_bdaddr));
>>> +       BT_DBG("sk %p %s", sk, batostr(&sa.sco_bdaddr));
>>>
>>>        if (!addr || addr->sa_family != AF_BLUETOOTH)
>>>                return -EINVAL;
>>>
>>> +       memset(&sa, 0, sizeof(sa));
>>> +       len = min_t(unsigned int, sizeof(sa), alen);
>>> +       memcpy(&sa, addr, len);
>>> +
>>>        lock_sock(sk);
>>>
>>>        if (sk->sk_state != BT_OPEN) {
>>> @@ -476,7 +485,8 @@ static int sco_sock_bind(struct socket *sock, struct sockaddr *addr, int addr_le
>>>                err = -EADDRINUSE;
>>>        } else {
>>>                /* Save source address */
>>> -               bacpy(&bt_sk(sk)->src, &sa->sco_bdaddr);
>>> +               bacpy(&bt_sk(sk)->src, &sa.sco_bdaddr);
>>> +               sco_pi(sk)->pkt_type = sa.sco_pkt_type;
>>>                sk->sk_state = BT_BOUND;
>>>        }
>>>
>>> @@ -489,26 +499,34 @@ done:
>>>
>>>  static int sco_sock_connect(struct socket *sock, struct sockaddr *addr, int alen, int flags)
>>>  {
>>> -       struct sockaddr_sco *sa = (struct sockaddr_sco *) addr;
>>>        struct sock *sk = sock->sk;
>>> -       int err = 0;
>>> -
>>> +       struct sockaddr_sco sa;
>>> +       int len, err = 0;
>>>
>>>        BT_DBG("sk %p", sk);
>>>
>>> -       if (addr->sa_family != AF_BLUETOOTH || alen < sizeof(struct sockaddr_sco))
>>> +       if (!addr || addr->sa_family != AF_BLUETOOTH)
>>>                return -EINVAL;
>>>
>>> -       if (sk->sk_state != BT_OPEN && sk->sk_state != BT_BOUND)
>>> -               return -EBADFD;
>>> -
>>> -       if (sk->sk_type != SOCK_SEQPACKET)
>>> -               return -EINVAL;
>>> +       memset(&sa, 0, sizeof(sa));
>>> +       len = min_t(unsigned int, sizeof(sa), alen);
>>> +       memcpy(&sa, addr, len);
>>>
>>>        lock_sock(sk);
>>>
>>> +       if (sk->sk_type != SOCK_SEQPACKET) {
>>> +               err = -EINVAL;
>>> +               goto done;
>>> +       }
>>> +
>>> +       if (sk->sk_state != BT_OPEN && sk->sk_state != BT_BOUND) {
>>> +               err = -EBADFD;
>>> +               goto done;
>>> +       }
>>> +
>>>        /* Set destination address and psm */
>>> -       bacpy(&bt_sk(sk)->dst, &sa->sco_bdaddr);
>>> +       bacpy(&bt_sk(sk)->dst, &sa.sco_bdaddr);
>>> +       sco_pi(sk)->pkt_type = sa.sco_pkt_type;
>>>
>>>        if ((err = sco_connect(sk)))
>>>                goto done;
>>> @@ -610,10 +628,13 @@ static int sco_sock_getname(struct socket *sock, struct sockaddr *addr, int *len
>>>        addr->sa_family = AF_BLUETOOTH;
>>>        *len = sizeof(struct sockaddr_sco);
>>>
>>> -       if (peer)
>>> +       if (peer) {
>>>                bacpy(&sa->sco_bdaddr, &bt_sk(sk)->dst);
>>> -       else
>>> +               sa->sco_pkt_type = sco_pi(sk)->pkt_type;
>>> +       } else {
>>>                bacpy(&sa->sco_bdaddr, &bt_sk(sk)->src);
>>> +               sa->sco_pkt_type = sco_pi(sk)->pkt_type;
>>> +       }
>>>
>>>        return 0;
>>>  }
>>> --
>>> 1.6.5.3
>>>
>>>
>> BTW i'm happy to switch the logic on the EDR bits, such that 1 is
>> always 'allow this packet type'. I stuck with the Bluetooth SIG
>> convention in this patch because the logic actually came out cleanly.
>>
>> Either way, its confusing for userspace, and we should document it
>> carefully in the patch to userspace headers.
> 
> Ping.
> 
> As a first step, can we get consensus on the userspace API:
> 
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -139,8 +139,11 @@ enum {
> +#define ALL_SCO_PKTS   (SCO_ESCO_MASK | EDR_ESCO_MASK)
> +#define ALL_ESCO_PKTS  (SCO_ESCO_MASK | ESCO_EV3 | ESCO_EV4 | ESCO_EV5)
> 
> --- a/include/net/bluetooth/sco.h
> +++ b/include/net/bluetooth/sco.h
> @@ -37,6 +37,7 @@
> struct sockaddr_sco {
>        sa_family_t     sco_family;
>        bdaddr_t        sco_bdaddr;
> +       __u16           sco_pkt_type;
> };
> 
> This will at least unblock my work.

Would it be better to add new sockopt for sco socket?

-- 
Ville


