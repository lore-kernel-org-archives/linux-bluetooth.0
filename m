Return-Path: <cyrus@holtmann.org>
Date: Fri, 18 Oct 2013 10:06:43 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Fix ATT socket backwards compatibility with
 user space
Message-ID: <20131018070643.GA22824@x220.p-661hnu-f1>
References: <1382037386-17396-1-git-send-email-johan.hedberg@gmail.com>
 <699FBB88-B7E3-4F64-92C8-54A70F1DE751@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <699FBB88-B7E3-4F64-92C8-54A70F1DE751@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Fri, Oct 18, 2013, Marcel Holtmann wrote:
> > Old user space versions bind the Attribute Protocol socket to
> > BDADDR_BREDR when they should be using BDADDR_LE_PUBLIC or
> > BDADDR_LE_RANDOM. The kernel recently introduced stricter checks on the
> > socket parameters but we need to punch this hole to them to ensure that
> > old user space versions keep working.
> > 
> > Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> > ---
> > net/bluetooth/l2cap_sock.c | 19 +++++++++++++++++--
> > 1 file changed, 17 insertions(+), 2 deletions(-)
> > 
> > diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
> > index 34e5a58..a43aead 100644
> > --- a/net/bluetooth/l2cap_sock.c
> > +++ b/net/bluetooth/l2cap_sock.c
> > @@ -159,8 +159,23 @@ static int l2cap_sock_connect(struct socket *sock, struct sockaddr *addr,
> > 	if (!bdaddr_type_is_valid(la.l2_bdaddr_type))
> > 		return -EINVAL;
> > 
> > -	if (chan->src_type == BDADDR_BREDR && la.l2_bdaddr_type != BDADDR_BREDR)
> > -		return -EINVAL;
> > +	if (chan->src_type == BDADDR_BREDR &&
> > +	    la.l2_bdaddr_type != BDADDR_BREDR) {
> > +		if (!bdaddr_type_is_le(la.l2_bdaddr_type))
> > +			return -EINVAL;
> 
> I do not understand this. The check for that la.l2_bdaddr_type is LE
> is done twice here.

The idea was simply to try to be forward compatible in case a fourth
address type is added, i.e. I made the assumption that
"a != BDADDR_BREDR" might not always be the same as "bdaddr_type_is_le(a)".

If you're ok with this assumption we should not just remove this extra
if-statement but also change the higher-level one to use
bdaddr_type_is_le() instead of making explicit comparisons with
BDADDR_BREDR.


> > +
> > +		/* Old user space versions will try to bind the ATT
> > +		 * socket using BDADDR_BREDR, so we have to allow this
> > +		 * to pass and fix chan->src_type to the correct value.
> > +		 */
> > +		if (la.l2_cid != __constant_cpu_to_le16(L2CAP_CID_ATT))
> > +			return -EINVAL;
> 
> I think we should also check that the src address is BDADDR_ANY. If it
> is not BDADDR_ANY, we should reject it as well. That is enough to make
> old userspace work. I do not want us to be any more flexible. Or are
> we actually bind to the right source adapter when calling connect().

The user space code is correct in this regard, so I'll add the extra
check for BDADDR_ANY.

> > +		if (chan->scid != L2CAP_CID_ATT)
> > +			return -EINVAL;
> > +
> > +		chan->src_type = BDADDR_LE_PUBLIC;
> > +	}
> 
> I do not like the fact that we are just defaulting to BDADDR_LE_PUBLIC
> here. It might be fine since the old userspace only ever understood
> public addresses anyway. However I do not like it that much. And if we
> keep it this way, then a comment needs to explain that this is good
> enough.

I'll add a comment. We could in theory extend the code to also check for
information inside the hdev struct, but that would require too much
complexity for the benefit since we do not have the hdev available at
this point in the socket operations. That, considered together with the
fact that even now user space will have a hard-coded BDADDR_LE_PUBLIC is
imo reason enough to just keep this simple in the kernel.

Johan
