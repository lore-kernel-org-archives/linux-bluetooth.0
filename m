Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 1/3] Add BT3 AMP device support, by Atheros Linux BT3
 team.
From: Marcel Holtmann <marcel@holtmann.org>
To: "Gustavo F. Padovan" <gustavo@padovan.org>
Cc: "Luis R. Rodriguez" <lrodriguez@atheros.com>,
	Dan Tian <Dan.Tian@Atheros.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Haijun Liu <Haijun.Liu@Atheros.com>,
	Luis Rodriguez <Luis.Rodriguez@Atheros.com>
In-Reply-To: <20100715194256.GA4307@vigoh>
References: <CDAFEDABF718A54BABD0DA5476695307CE881EC1@SHEXMB-01.global.atheros.com>
	 <20100715150921.GA3188@vigoh> <20100715184308.GF1166@tux>
	 <20100715194256.GA4307@vigoh>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 16 Jul 2010 09:08:36 -0700
Message-ID: <1279296516.6282.76.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dan,

> > > Could you split all your patches in little chunks? +1882 is very hard to
> > > review. And please be more verbose on the commit message, it can help us
> > > figure out what's happening.
> > 
> > This used to be 1 large patch, it was recently split up to 3, I havent't
> > had a chance yet to review further but my understanding is this this was
> > split up as much as possible in the last try. If you can provide suggestions
> > how to split it up more that might be useful, but agreed, if possible more
> > splitup would help.
> 
> But it is still too big. I looked to patch 3/3, it does a lot different
> things in the same patch that make the patch impossible to be tracked.
> We need atomic patches for at least each change in the ERTM code, each
> new state added in the L2CAP state machine, each new HS feature, etc,
> i.e., we need proper patches with proper commit messages explaining
> what's happening. The same should apply to 1/3 and 2/3, I didn't looked
> to them.

please split these in smaller chunks. You can provide the full blown
patch on kernel.org as Luis did, but we need small chunks to get this
merged. It touches too many areas and I won't be able to do the full
review otherwise.

Patch 1/3 can be split properly. It doesn't have to be this big in the
first place.

 include/net/bluetooth/hci.h      |  342 +++++++++++++++++++-
 include/net/bluetooth/hci_core.h |  264 ++++++++++++++-
 net/bluetooth/cmtp/core.c        |    1 +
 net/bluetooth/hci_conn.c         |  201 +++++++++++-
 net/bluetooth/hci_core.c         |  349 ++++++++++++++++++--
 net/bluetooth/hci_event.c        |  698 +++++++++++++++++++++++++++++++++++++-
 6 files changed, 1822 insertions(+), 33 deletions(-)

Why are you touching CMTP. If that is needed, then send a patch up-front
that prepares this change. This just clutters it.

I see also thinks like this:

-#define HCI_OP_WRITE_SCAN_ENABLE       0x0c1a
+#define HCI_OP_WRITE_SCAN_ENABLE       0x0c1a

If you wanna do cleanups of already existing code, then please send
these cleanup patches first. Otherwise they just clutter the rest and I
will refuse to review them.

Same here:

-void hci_send_acl(struct hci_conn *conn, struct sk_buff *skb, __u16 flags);
-void hci_send_sco(struct hci_conn *conn, struct sk_buff *skb);
+int hci_send_acl(struct hci_conn *conn, struct sk_buff *skb, __u16 flags);
+int hci_send_sco(struct hci_conn *conn, struct sk_buff *skb);

Separate patch with proper commit message explaining why this is needed
etc. And then ensuring that it doesn't affect current code.

And for this you better have a good explanation:

 LIST_HEAD(hci_dev_list);
+EXPORT_SYMBOL(hci_dev_list);
+
 DEFINE_RWLOCK(hci_dev_list_lock);
+EXPORT_SYMBOL(hci_dev_list_lock);

 /* HCI callback list */
 LIST_HEAD(hci_cb_list);
+EXPORT_SYMBOL(hci_cb_list);
+
 DEFINE_RWLOCK(hci_cb_list_lock);
+EXPORT_SYMBOL(hci_cb_list_lock);

For every single symbol that you wanna export I expect at least a proper
paragraph in the commit message explaining why that is needed.

And then please one patch that just adds the new HCI definitions. And
form there on single steps with changing init behavior for BR/EDR and
AMP, adding the new flow control, adding physical link establishment.
All in single patches with proper commit messages please.

And this is only for patch 1/3.

After that I can have a look at the AMP Manager and the L2CAP changes.

> > Dan, can you also please drop the "by Atheros Linux BT3 team." on the subject
> > of the patches. This is already implied by the From and the Signed-off-by.
> 
> Dan, your patches don't apply cleanly upstream, please rebase them
> against Marcel's bluetooth-next tree and do the proper split of the
> patches.

I can update bluetooth-testing, but right it would be way better to base
them against the bluetooth-next tree. That will be the one, I ask John
to pull into his wireless-next tree in a bit.

Regards

Marcel


