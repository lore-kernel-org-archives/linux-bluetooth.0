Return-Path: <cyrus@holtmann.org>
Date: Sun, 15 Sep 2013 23:00:21 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3 5/8] Bluetooth: Fix error code for invalid CID in
 l2cap_config_req
Message-ID: <20130915200021.GA8409@x220.p-661hnu-f1>
References: <1379179711-16436-1-git-send-email-johan.hedberg@gmail.com>
 <1379179711-16436-6-git-send-email-johan.hedberg@gmail.com>
 <DDB6D220-2DB5-49B3-9200-4AD8FBAAADDE@holtmann.org>
 <20130915063017.GA22996@x220.p-661hnu-f1>
 <D242F6F2-162B-4904-8637-78BA01BF5737@holtmann.org>
 <20130915181552.GA6383@x220.p-661hnu-f1>
 <5A99E897-60EC-486C-94D9-775B3C01FB16@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5A99E897-60EC-486C-94D9-775B3C01FB16@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sun, Sep 15, 2013, Marcel Holtmann wrote:
> >>>>> The convention of the L2CAP code is to return EFAULT when a CID in the
> >>>>> request packet is invalid. This patch fixes the l2cap_config_req to use
> >>>>> that error code instead of ENOENT.
> >>>>> 
> >>>>> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> >>>>> ---
> >>>>> net/bluetooth/l2cap_core.c | 2 +-
> >>>>> 1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>> 
> >>>>> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> >>>>> index 9ec1561f..d134501 100644
> >>>>> --- a/net/bluetooth/l2cap_core.c
> >>>>> +++ b/net/bluetooth/l2cap_core.c
> >>>>> @@ -3978,7 +3978,7 @@ static inline int l2cap_config_req(struct l2cap_conn *conn,
> >>>>> 
> >>>>> 	chan = l2cap_get_chan_by_scid(conn, dcid);
> >>>>> 	if (!chan)
> >>>>> -		return -ENOENT;
> >>>>> +		return -EFAULT;
> >>>> 
> >>>> do we really want to use EFAULT. That is normally only used if a
> >>>> memory copy from userspace to kernel or vice versa fails.
> >>> 
> >>> EFAULT seemed to be the most common error code in this case, but now
> >>> that I did some research it seems it's mostly from newish AMP related
> >>> code. Would you be ok if I just switch all places to use ENOENT then?
> >> 
> >> EFAULT is really for memory address errors. It is a pretty bad idea to use CID errors.
> >> 
> >> I am fine with keep using ENOENT if we used that before. If that is
> >> what the original code used, then lets keep using it. Otherwise we
> >> better find a more descriptive error.
> > 
> > If we ignore new AMP code there's only one "legacy" reference for this
> > kind of situation which is l2cap_config_req. Since it has always used
> > ENOENT for a failed CID lookup I'll follow that lead and use the same
> > error for all places that need it.
> 
> have a look at EBADRQC, EBADSLT, EBADR or EBADE. They might be a
> better choice.

I'd rather have a consensus here first before resending the entire patch
set yet another time because of this issue (which, let's face it, is not
about any public API but consistency inside a single c-file).

As quite often with trying to map POSIX error codes to our own domain
we've ended up here with trying to find the "least bad" option in the
absence of a single obviously correct one.

EBADRQC sounds like it's not related to PDU parameters but the request
code of the PDU. EBADSLT is "invalid slot", so if we consider the CID to
be a "slot" this might be an option. EBADR talks about a "request
descriptor" which I don't quite understand how it's different from a
"request code". EBADE means "invalid exchange" whereas this isn't really
about an exchange but just an incorrect CID in a PDU.

I agree that ENOENT isn't perfect either since, even though internally
this is about a failed lookup, externally this is just the peer sending
us an invalid parameter value. Therefore, we could even consider EINVAL
if it wasn't for the fact that it's already used e.g. when we receive an
unknown opcode.

In the end I'm willing to accept pretty much any of the proposed options
since there really isn't a single right answer to this and since this is
not about public API that we really need to stick to once we decide
which value to use. The important thing is that the code is kept
consistent regarding the use of this error.

Johan
