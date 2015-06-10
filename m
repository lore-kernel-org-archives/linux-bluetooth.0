Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <26AB874B-9CA2-4EDC-BD19-68F2E4583D96@holtmann.org>
References: <1433882287-14503-1-git-send-email-jpawlowski@google.com>
	<26AB874B-9CA2-4EDC-BD19-68F2E4583D96@holtmann.org>
Date: Wed, 10 Jun 2015 00:37:12 -0700
Message-ID: <CAD0=r8xLPViAC4J3Zhu5dX4bYORX+UBPTYM+irfmguTU=OsGUg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Fix connection to already paired device.
From: Jakub Pawlowski <jpawlowski@google.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,


On Tue, Jun 9, 2015 at 11:35 PM, Marcel Holtmann <marcel@holtmann.org> wrot=
e:
>
> Hi Jakub,
>
> > Currently, when trying to connect to already paired device that just
> > rotated its RPA MAC address, old address would be used and connection
> > would fail. In order to fix that, kernel must scan and receive
> > advertisement with fresh RPA before connecting.
> >
> > This patch changes connection procedure behaviour for devices that
> > have IRK. Instead of directly calling "connect" with last known RPA,
> > it'll add device to kernel whitelist and start scan. If advertisement
> > is received, it'll be compared against whitelist and then trigger
> > connection if it matches.
> >
> > auto_connect_for_connect field was added to hci_conn_params struct.
> > If it's set, params are marked for autoconnect because someone tried to
> > given address. When the connection is succesully estabilished, or after
> > timeout this params will be deleted, and device is removed from
> > autoconnect whitelist.
> >
> > Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
> > ---
> > include/net/bluetooth/hci_core.h | 27 +++++++++++++++++-
> > net/bluetooth/hci_conn.c         | 61 +++++++++++++++++++++++++++------=
-------
> > net/bluetooth/hci_event.c        | 16 +++++++++--
> > net/bluetooth/l2cap_core.c       |  2 +-
> > net/bluetooth/mgmt.c             | 22 +++++++++++----
> > 5 files changed, 98 insertions(+), 30 deletions(-)
> >
> > diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/h=
ci_core.h
> > index 3fbb793..bedc6be 100644
> > --- a/include/net/bluetooth/hci_core.h
> > +++ b/include/net/bluetooth/hci_core.h
> > @@ -504,6 +504,8 @@ struct hci_conn_params {
> >               HCI_AUTO_CONN_LINK_LOSS,
> >       } auto_connect;
> >
> > +     bool auto_connect_for_connect;
> > +
>
> the name is pretty unclear and we need a bit better overall structure to =
facility the L2CAP connect() request. It might be well that we are no conne=
cting to device from Add Device or L2CAP connect(). And actually the connec=
t() takes precedence since otherwise it would go through accept().
>
> >       struct hci_conn *conn;
> > };
> >
> > @@ -820,7 +822,7 @@ struct hci_chan *hci_chan_lookup_handle(struct hci_=
dev *hdev, __u16 handle);
> >
> > struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
> >                               u8 dst_type, u8 sec_level, u16 conn_timeo=
ut,
> > -                             u8 role);
> > +                             u8 role, bool fresh_dst_addr);
>
> Why do you need this? We know the address type and we can lookup if the i=
dentity address has an IRK attached to it.

It's used to distinguish between calls from check_pending_le_conn,
then fresh_dst_addr =3D=3D true, and calls from other places, then it's
false.
I need that because hci_connect_le might be called twice: first time
when someone create l2cap socket and try to connect. Address won't be
"fresh", and fresh_dst_addr would be false. Then the socket would be
left in BT_OPEN state during scan. If during scan you receive a
advertisement with 'fresh' address, it'll be called with
fresh_dst_addr set to true from check_pending_le_conn.

>
> In addition, I do not think it makes a difference if you are an RPA or no=
t. Just run through our background scanning for all connection attempts. Th=
is has the advantage that now simultaneous connection attempts via L2CAP co=
nnect() would not have to wait for each other.

So when I wrote first version of this patch in BlueZ, I was unable to
add unpaired devices to background scan. I'll try again, maybe that
would work in kernel.
>
> > struct hci_conn *hci_connect_acl(struct hci_dev *hdev, bdaddr_t *dst,
> >                                u8 sec_level, u8 auth_type);
> > struct hci_conn *hci_connect_sco(struct hci_dev *hdev, int type, bdaddr=
_t *dst,
> > @@ -875,12 +877,21 @@ static inline void hci_conn_hold(struct hci_conn =
*conn)
> >       cancel_delayed_work(&conn->disc_work);
> > }
> >
> > +
> > +struct hci_conn_params *hci_conn_params_lookup(struct hci_dev *hdev,
> > +                                            bdaddr_t *addr, u8 addr_ty=
pe);
> > +void hci_conn_params_del(struct hci_dev *hdev, bdaddr_t *addr, u8 addr=
_type);
> > +
> > +
>
> Since on one hand we are using hci_connect_le, then we should most likely=
 also introduce a special function to cancel that action. It should than in=
ternally do the right thing.
>
> > static inline void hci_conn_drop(struct hci_conn *conn)
> > {
> >       BT_DBG("hcon %p orig refcnt %d", conn, atomic_read(&conn->refcnt)=
);
> >
> >       if (atomic_dec_and_test(&conn->refcnt)) {
> >               unsigned long timeo;
> > +             struct hci_conn_params *params =3D
> > +                             hci_conn_params_lookup(conn->hdev, &conn-=
>dst,
> > +                                                             conn->dst=
_type);
> >
> >               switch (conn->type) {
> >               case ACL_LINK:
> > @@ -904,6 +915,16 @@ static inline void hci_conn_drop(struct hci_conn *=
conn)
> >                       break;
> >               }
> >
> > +             /* If the connection attempt was doing scan for new RPA, =
and is
> > +              * still stuck in scann phase, then stop the scan.
> > +              */
> > +             if (params && params->auto_connect_for_connect &&
> > +                                             conn->state =3D=3D BT_OPE=
N) {
> > +                     hci_conn_params_del(conn->hdev, &conn->dst,
> > +                                                             conn->dst=
_type);
> > +                     hci_conn_hash_del(conn->hdev, conn);
> > +             }
> > +
> >               cancel_delayed_work(&conn->disc_work);
> >               queue_delayed_work(conn->hdev->workqueue,
> >                                  &conn->disc_work, timeo);
> > @@ -976,6 +997,10 @@ struct hci_conn_params *hci_conn_params_lookup(str=
uct hci_dev *hdev,
> >                                              bdaddr_t *addr, u8 addr_ty=
pe);
> > struct hci_conn_params *hci_conn_params_add(struct hci_dev *hdev,
> >                                           bdaddr_t *addr, u8 addr_type)=
;
> > +
> > +struct hci_request;
> > +int hci_conn_params_set(struct hci_request *req, bdaddr_t *addr,
> > +                            u8 addr_type, u8 auto_connect, bool for_co=
nnect);
>
> This is not a good idea. We need to make sure we do not have to layer it =
like this. It might mean there is some code reshuffling needed to make this=
 all work.

Can you please explain what do you mean by layering?
>
> > void hci_conn_params_del(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_=
type);
> > void hci_conn_params_clear_all(struct hci_dev *hdev);
> > void hci_conn_params_clear_disabled(struct hci_dev *hdev);
> > diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> > index 2c48bf0..e670c91 100644
> > --- a/net/bluetooth/hci_conn.c
> > +++ b/net/bluetooth/hci_conn.c
> > @@ -612,21 +612,17 @@ void hci_le_conn_failed(struct hci_conn *conn, u8=
 status)
> >               hci_conn_put(params->conn);
> >               params->conn =3D NULL;
> >       }
> > -
> >       conn->state =3D BT_CLOSED;
> >
> >       mgmt_connect_failed(hdev, &conn->dst, conn->type, conn->dst_type,
> >                           status);
> >
> >       hci_connect_cfm(conn, status);
> > -
> >       hci_conn_del(conn);
> > -
> >       /* Since we may have temporarily stopped the background scanning =
in
> >        * favor of connection establishment, we should restart it.
> >        */
> >       hci_update_background_scan(hdev);
> > -
>
> These are cosmetic updates and I do not even agree with them. Nevertheles=
s they should be in a separate patch.
I'll get rid of those cosmetic things, =3D, sorry
>
> >       /* Re-enable advertising in case this was a failed connection
> >        * attempt as a peripheral.
> >        */
> > @@ -725,14 +721,13 @@ static void hci_req_directed_advertising(struct h=
ci_request *req,
> >
> > struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
> >                               u8 dst_type, u8 sec_level, u16 conn_timeo=
ut,
> > -                             u8 role)
> > +                             u8 role, bool fresh_dst_addr)
> > {
> >       struct hci_conn_params *params;
> > -     struct hci_conn *conn;
> > +     struct hci_conn *conn, *conn_unfinished;
> >       struct smp_irk *irk;
> >       struct hci_request req;
> >       int err;
> > -
>
> This one in clearly wrong and would fail checkpatch.pl. Maybe you editor =
is playing cruel tricks on you and you might want to check that.
>
> >       /* Let's make sure that le is enabled.*/
> >       if (!hci_dev_test_flag(hdev, HCI_LE_ENABLED)) {
> >               if (lmp_le_capable(hdev))
> > @@ -740,7 +735,6 @@ struct hci_conn *hci_connect_le(struct hci_dev *hde=
v, bdaddr_t *dst,
> >
> >               return ERR_PTR(-EOPNOTSUPP);
> >       }
> > -
>
> The next line is a comment and thus do not remove the empty above it.
>
> >       /* Some devices send ATT messages as soon as the physical link is
> >        * established. To be able to handle these ATT messages, the user=
-
> >        * space first establishes the connection and then starts the pai=
ring
> > @@ -751,9 +745,15 @@ struct hci_conn *hci_connect_le(struct hci_dev *hd=
ev, bdaddr_t *dst,
> >        * and return the object found.
> >        */
> >       conn =3D hci_conn_hash_lookup_ba(hdev, LE_LINK, dst);
> > +     conn_unfinished =3D NULL;
> >       if (conn) {
> >               conn->pending_sec_level =3D sec_level;
> > -             goto done;
> > +             if (conn->state =3D=3D BT_OPEN) {
> > +                     BT_DBG("will coninue unfinished conn %pMR", dst);
> > +                     conn_unfinished =3D conn;
> > +             } else {
> > +                     goto done;
> > +             }
> >       }
> >
> >       /* Since the controller supports only one LE connection attempt a=
t a
> > @@ -765,24 +765,44 @@ struct hci_conn *hci_connect_le(struct hci_dev *h=
dev, bdaddr_t *dst,
> >
> >       /* When given an identity address with existing identity
> >        * resolving key, the connection needs to be established
> > -      * to a resolvable random address.
> > +      * to a Resolvable Private Address (RPA).
>
> I have no problem changing this, but if we do, then it needs to be consis=
tent and not just in one comment. So this is a cleanup patch that should co=
me first.
>
> >        *
> > -      * This uses the cached random resolvable address from
> > -      * a previous scan. When no cached address is available,
> > -      * try connecting to the identity address instead.
> > +      * If RPA is not fresh, start scan and try to find current
> > +      * value before trying to connect. If advertisement with new
> > +      * RPA is received, this method will be called again and
> > +      * connection estabilishment will continue.
>
> You need to forget about the concept of fresh. The RPA is never fresh. As=
 soon as you disconnect, you have to consider it rotated. While the specifi=
cation gives a good value on the refresh timeout, the other side never know=
s it. So we have to always scan for devices using RPA. The freshness has no=
thing to do with it.

So "fresh" means that RPA was just received in advertisement, and is
set only when called from advertisement processing. I'll try to find
better word, "just_received" ?

>
> >        *
> > -      * Storing the resolvable random address is required here
> > -      * to handle connection failures. The address will later
> > -      * be resolved back into the original identity address
> > -      * from the connect request.
> > +      * Storing the RPA is required here to handle connection
> > +      * failures. The address will later be resolved back into
> > +      * the original identity address from the connect request.
> >        */
> >       irk =3D hci_find_irk_by_addr(hdev, dst, dst_type);
> > -     if (irk && bacmp(&irk->rpa, BDADDR_ANY)) {
> > +     if (irk && !fresh_dst_addr) {
> > +             struct hci_request req;
> > +
> > +             BT_DBG("Requesting refresh of dst_addr.");
> > +             hci_req_init(&req, hdev);
> > +
> > +             if (hci_conn_params_set(&req, dst, dst_type,
> > +                                     HCI_AUTO_CONN_ALWAYS, true) < 0) =
{
> > +                     return ERR_PTR(-EBUSY);
> > +             }
> > +
> > +             err =3D hci_req_run(&req, NULL);
> > +             if (err)
> > +                     return ERR_PTR(err);
> > +     } else if (irk && bacmp(&irk->rpa, BDADDR_ANY)) {
> >               dst =3D &irk->rpa;
> >               dst_type =3D ADDR_LE_DEV_RANDOM;
> >       }
> >
> > -     conn =3D hci_conn_add(hdev, LE_LINK, dst, role);
> > +     if (conn_unfinished) {
> > +             conn =3D conn_unfinished;
> > +             bacpy(&conn->dst, dst);
> > +     } else {
> > +             conn =3D hci_conn_add(hdev, LE_LINK, dst, role);
> > +     }
> > +
> >       if (!conn)
> >               return ERR_PTR(-ENOMEM);
> >
> > @@ -791,6 +811,9 @@ struct hci_conn *hci_connect_le(struct hci_dev *hde=
v, bdaddr_t *dst,
> >       conn->pending_sec_level =3D sec_level;
> >       conn->conn_timeout =3D conn_timeout;
> >
> > +     if (irk && !fresh_dst_addr)
> > +             goto done;
> > +
> >       hci_req_init(&req, hdev);
> >
> >       /* Disable advertising if we're active. For master role
>
> My thinking really is that we need to just start background scanning (if =
not already active) instead of calling HCI LE Create Connection. And that i=
s about it. So this is essentially doing the same thing as Add Device.
>
> The extra handling comes into play when either the device is found and we=
 now need to connect, or when a timeout happened and we might need to take =
this device back out of the whitelist.

That sounds good, but there's a socket that was open, and lots of
structures attached to it. So should the hci_conn_params become
"owner" of the socket and manage it until a device is found?
>
> > diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> > index fcbfa41..1300d4a 100644
> > --- a/net/bluetooth/hci_event.c
> > +++ b/net/bluetooth/hci_event.c
> > @@ -4674,15 +4674,25 @@ static struct hci_conn *check_pending_le_conn(s=
truct hci_dev *hdev,
> >       }
> >
> >       conn =3D hci_connect_le(hdev, addr, addr_type, BT_SECURITY_LOW,
> > -                           HCI_LE_AUTOCONN_TIMEOUT, HCI_ROLE_MASTER);
> > +                           HCI_LE_AUTOCONN_TIMEOUT, HCI_ROLE_MASTER, t=
rue);
> >       if (!IS_ERR(conn)) {
> > -             /* Store the pointer since we don't really have any
> > +             /* If auto_connect_for_connect is set, conn is already
> > +              * owned by socket that tried to connect, if no then
> > +              * store the pointer since we don't really have any
> >                * other owner of the object besides the params that
> >                * triggered it. This way we can abort the connection if
> >                * the parameters get removed and keep the reference
> >                * count consistent once the connection is established.
> >                */
> > -             params->conn =3D hci_conn_get(conn);
> > +
> > +             if (params->auto_connect_for_connect) {
> > +                     BT_DBG("removing %pMR params", addr);
> > +                     /* Params were needed only to refresh the RPA.*/
> > +                     hci_conn_params_del(hdev, addr, addr_type);
> > +             } else {
> > +                     params->conn =3D hci_conn_get(conn);
> > +             }
> > +
>
> I think this whole handling will become pretty interesting now. We would =
not need any of this since we can just add the device to our background con=
nection list and wait until it gets connected. The only difference is that =
the result is the success of connect() or accept(). There is the problem wi=
th having an underlying hci_conn struct that needs to be solved. However fu=
ndamentally the connection handling in LE is totally different from BR/EDR =
in this case. So pending LE connection are just device that we are still sc=
anning for and haven't found yet.
>
Yes, managing hci_conn is a big pain, it's owned by structures
associated with socket, or background scan, and it's my first change
in this part of code. Any hints appreciated :)

> It might also a good idea to check if we have enough l2cap-tester and mgm=
t-tester test cases to cover the interaction of L2CAP accept() and connect(=
) and Add Device. We do want to make sure that we do not regress.
>
> Regards
>
> Marcel
>


Regards,
Jakub
