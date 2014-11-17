Return-Path: <cyrus@holtmann.org>
Date: Mon, 17 Nov 2014 20:51:01 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Fix BR/EDR-only address checks for remote OOB
 data
Message-ID: <20141117185101.GA21584@t440s.P-661HNU-F1>
References: <1416242965-29207-1-git-send-email-johan.hedberg@gmail.com>
 <4362075.XVFnp0kduk@leonov>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4362075.XVFnp0kduk@leonov>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hy Szymon,

On Mon, Nov 17, 2014, Szymon Janc wrote:
> On Monday 17 of November 2014 18:49:25 Johan Hedberg wrote:
> > From: Johan Hedberg <johan.hedberg@intel.com>
> > 
> > For now the mgmt commands dealing with remote OOB data are strictly
> > BR/EDR-only. This patch fixes missing checks for the passed address type
> > so that any non-BR/EDR value triggers the appropriate error response.
> > 
> > Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> > ---
> >  net/bluetooth/mgmt.c | 19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> > 
> > diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> > index b84c0923ec62..aaaa605f48b0 100644
> > --- a/net/bluetooth/mgmt.c
> > +++ b/net/bluetooth/mgmt.c
> > @@ -3589,6 +3589,13 @@ static int add_remote_oob_data(struct sock *sk,
> > struct hci_dev *hdev, struct mgmt_cp_add_remote_oob_data *cp = data;
> >  		u8 status;
> > 
> > +		if (cp->addr.type != BDADDR_BREDR) {
> > +			err = cmd_status(sk, hdev->id,
> > +					 MGMT_OP_ADD_REMOTE_OOB_DATA,
> > +					 MGMT_STATUS_INVALID_PARAMS);
> > +			goto unlock;
> > +		}
> 
> This should generate command complete event.
> (it looks like there is also similar bug in 'else' case in the code)

Good point! v2 coming in a minute (also resending my other patch to
avoid conflicts).

Johan
