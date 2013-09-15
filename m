Return-Path: <cyrus@holtmann.org>
Date: Sun, 15 Sep 2013 09:30:17 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3 5/8] Bluetooth: Fix error code for invalid CID in
 l2cap_config_req
Message-ID: <20130915063017.GA22996@x220.p-661hnu-f1>
References: <1379179711-16436-1-git-send-email-johan.hedberg@gmail.com>
 <1379179711-16436-6-git-send-email-johan.hedberg@gmail.com>
 <DDB6D220-2DB5-49B3-9200-4AD8FBAAADDE@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <DDB6D220-2DB5-49B3-9200-4AD8FBAAADDE@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sat, Sep 14, 2013, Marcel Holtmann wrote:
> > The convention of the L2CAP code is to return EFAULT when a CID in the
> > request packet is invalid. This patch fixes the l2cap_config_req to use
> > that error code instead of ENOENT.
> > 
> > Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> > ---
> > net/bluetooth/l2cap_core.c | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> > index 9ec1561f..d134501 100644
> > --- a/net/bluetooth/l2cap_core.c
> > +++ b/net/bluetooth/l2cap_core.c
> > @@ -3978,7 +3978,7 @@ static inline int l2cap_config_req(struct l2cap_conn *conn,
> > 
> > 	chan = l2cap_get_chan_by_scid(conn, dcid);
> > 	if (!chan)
> > -		return -ENOENT;
> > +		return -EFAULT;
> 
> do we really want to use EFAULT. That is normally only used if a
> memory copy from userspace to kernel or vice versa fails.

EFAULT seemed to be the most common error code in this case, but now
that I did some research it seems it's mostly from newish AMP related
code. Would you be ok if I just switch all places to use ENOENT then?

Johan
