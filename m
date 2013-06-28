Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <4639059.6A5mfqIqsg@uw000953>
References: <1356097469-24073-1-git-send-email-s.syam@samsung.com>
	<CAFBvHie-XXKTh0ggsP522YkQ5y1s6wHcoLrxa2SnEL0FxDdyoQ@mail.gmail.com>
	<CAFBvHieOqd9rT9=Ku=CZ5FCtrH3baBTpCGWnFLaFFE+4bW0J7Q@mail.gmail.com>
	<4639059.6A5mfqIqsg@uw000953>
Date: Fri, 28 Jun 2013 15:47:46 +0530
Message-ID: <CAFBvHidA6JdOu_FH2D4_NB24VoOWDeX_LEMX89U1p_O_ezCoJA@mail.gmail.com>
Subject: Re: [PATCH 2/2] Bluetooth: Fix ACL alive for long in case of non
 pariable devices
From: Syam Sidhardhan <syamsidhardh@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: Syam Sidhardhan <s.syam@samsung.com>,
	User Name <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi


On Wed, Jun 26, 2013 at 6:18 PM, Szymon Janc <szymon.janc@tieto.com> wrote:
>
> Hi,
>
> On Wednesday 26 of June 2013 17:03:23 Syam Sidhardhan wrote:
> > Hi,
> >
> > On Tue, Jan 8, 2013 at 2:19 AM, Syam Sidhardhan <syamsidhardh@gmail.com> wrote:
> > >
> > > Hi,
> > >
> > > On Fri, Dec 21, 2012 at 7:14 PM, Syam Sidhardhan <s.syam@samsung.com> wrote:
> > > > For certain devices (ex: HID mouse), support for authentication,
> > > > pairing and bonding is optional. For such devices, the ACL alive
> > > > for too long after the l2cap disconnection.
> > > >
> > > > To avoid keep ACL alive for too long, set the ACL timeout back to
> > > > HCI_DISCONN_TIMEOUT when l2cap is connected.
> > > >
> > > > commit id:a9ea3ed9b71cc3271dd59e76f65748adcaa76422 might have introduce
> > > > this issue.
> > > >
> > > > Signed-off-by: Sang-Ki Park <sangki79.park@samsung.com>
> > > > Signed-off-by: Syam Sidhardhan <s.syam@samsung.com>
> > > > ---
> > > > I'm not sure whether we need hci_conn_hold() and hci_conn_put() across
> > > > while updating the disc_timeout. In certain other places in the code
> > > > it's done. Ex: hci_auth_complete_evt(), hci_link_key_notify_evt() etc.
> > > > Here I took that as the reference.
> > > >
> > > >  net/bluetooth/l2cap_core.c |    5 ++++-
> > > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> > > > index 82a3bdc..7a544c2 100644
> > > > --- a/net/bluetooth/l2cap_core.c
> > > > +++ b/net/bluetooth/l2cap_core.c
> > > > @@ -1360,7 +1360,6 @@ static void l2cap_le_conn_ready(struct l2cap_conn *conn)
> > > >         sk = chan->sk;
> > > >
> > > >         hci_conn_hold(conn->hcon);
> > > > -       conn->hcon->disc_timeout = HCI_DISCONN_TIMEOUT;

The above change has been recently applied to the  bluetooth-next by Johan.
https://git.kernel.org/cgit/linux/kernel/git/bluetooth/bluetooth-next.git/commit/net/bluetooth/l2cap_core.c?id=0cc59a72c723979cf8973aff4df874a5f7a697c7
>
> > > >
> > > >         bacpy(&bt_sk(sk)->src, conn->src);
> > > >         bacpy(&bt_sk(sk)->dst, conn->dst);
> > > > @@ -1380,6 +1379,10 @@ static void l2cap_conn_ready(struct l2cap_conn *conn)
> > > >
> > > >         BT_DBG("conn %p", conn);
> > > >
> > > > +       hci_conn_hold(conn->hcon);
> > > > +       conn->hcon->disc_timeout = HCI_DISCONN_TIMEOUT;
> > > > +       hci_conn_put(conn->hcon);
> > > > +
> > > >         if (!hcon->out && hcon->type == LE_LINK)
> > > >                 l2cap_le_conn_ready(conn);
> > > >
> > > > --
> > > > 1.7.9.5
> > > >
> > >
> > > ping.
> > >
> >
> > Is there any comment on this patch?
> > If this patch looks valid I can rebase it with the latest code and
> > send it once again.
> >
>
> The funny thing is that original patch send to ML has this timer set back to
> HCI_DISCONN_TIMEOUT in l2cap_connect_req(), not in l2cap_le_conn_ready().
> See [1]. There were some big changes in l2cap code in bluetooth-next.git
> while this was committed to bluetooth.git so maybe some merge conflict was
> incorrectly resolved or sth...
>
> This patch looks ok to me. Just please make sure it works correctly
> in scenario described in original commit.
>

Unfortunately I'm unable to find such an Android device to check the correctness
describing in original commit.
>
>
> ps
> hold/put was to restart timer with new value, I think now it is hold/drop and
> timer is replaced with workqueue and is needed if you want new timeout to be
> used.
>
> [1] http://comments.gmane.org/gmane.linux.bluez.kernel/27532


Thanks Szymon for the clarification.
I'll send another version based on the latest bluetooth-next.git.
