Return-Path: <cyrus@holtmann.org>
Date: Tue, 12 Jun 2012 03:04:47 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: vishal agarwal <vishal.bluez@gmail.com>
Cc: Vishal Agarwal <vishal.agarwal@stericsson.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Fix sending HCI_Disconnect only after
 connection
Message-ID: <20120612060447.GG24440@joana>
References: <1339395584-3223-1-git-send-email-vishal.agarwal@stericsson.com>
 <20120612030522.GD24440@joana>
 <CA+_sZW8S9ZKtT6itUSXENovADEYoR8GUydpVg044CAEWEx2MTw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CA+_sZW8S9ZKtT6itUSXENovADEYoR8GUydpVg044CAEWEx2MTw@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vishal,

* vishal agarwal <vishal.bluez@gmail.com> [2012-06-12 11:20:44 +0530]:

> Hi Gustavo,
> 
> On 6/12/12, Gustavo Padovan <gustavo@padovan.org> wrote:
> > Hi Vishal,
> >
> > * Vishal Agarwal <vishal.agarwal@stericsson.com> [2012-06-11 11:49:44
> > +0530]:
> >
> >> HCI_Disconnet should only be sent after connection is established.
> >
> > minor: it's HCI_Disconnect here.
> Thanks for mentioning. I will correct it in the next patch.
> >
> >> If connection is not yet established and hci_disconnect is called
> >> then disconnection complete will be received with a handle which
> >> does not exist and hence this event will be ignored.
> >> But as mgmt.c will not receive this event, its variable for pending
> >> command is not cleared.This will result in future Disconnect commands
> >> for that BD Address to be blocked with error busy.
> >>
> >> Signed-off-by: Vishal Agarwal <vishal.agarwal@stericsson.com>
> >> ---
> >>  net/bluetooth/mgmt.c |    2 +-
> >>  1 files changed, 1 insertions(+), 1 deletions(-)
> >>
> >> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> >> index 958f764..3a857bf 100644
> >> --- a/net/bluetooth/mgmt.c
> >> +++ b/net/bluetooth/mgmt.c
> >> @@ -1598,7 +1598,7 @@ static int disconnect(struct sock *sk, struct
> >> hci_dev *hdev, void *data,
> >>  	else
> >>  		conn = hci_conn_hash_lookup_ba(hdev, LE_LINK, &cp->addr.bdaddr);
> >>
> >> -	if (!conn) {
> >> +	if (!conn || conn->state == BT_OPEN || conn->state == BT_CLOSED) {
> >
> > You might also want to check for BT_BOUND here, as this is also a pre
> > connect() state.
> >
> I did not see any place where BT_BOUND is used for conn->state. Should I still
> check for BT_BOUND state?

You are totally right, I just get confused. Check for BT_OPEN and BT_CLOSED is
enough.

	Gustavo
