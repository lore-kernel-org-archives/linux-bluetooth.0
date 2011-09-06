Return-Path: <cyrus@holtmann.org>
Date: Tue, 6 Sep 2011 17:46:44 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: Peter Hurley <peter@hurleysoftware.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH v2 10/13] Bluetooth: Fix setting the connection sec_level
 when encryption fails
Message-ID: <20110906204644.GA22348@samus.indt.org>
References: <1314313359-12652-1-git-send-email-vcgomes@gmail.com>
 <1314313359-12652-11-git-send-email-vcgomes@gmail.com>
 <1315337959.11425.23.camel@THOR>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1315337959.11425.23.camel@THOR>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Peter,

On 15:39 Tue 06 Sep, Peter Hurley wrote:
> Hi Vinicius,
> 
> On Thu, 2011-08-25 at 19:02 -0400, Vinicius Costa Gomes wrote:
> > From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
> > 
> > If the encryption changed event indicates that happened an error we
> > should not set the security level of the connection.
> > 
> > Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
> > ---
> >  include/net/bluetooth/hci_core.h |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> > 
> > diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> > index 7aa02e2..b6f1865 100644
> > --- a/include/net/bluetooth/hci_core.h
> > +++ b/include/net/bluetooth/hci_core.h
> > @@ -797,7 +797,7 @@ static inline void hci_encrypt_cfm(struct hci_conn *conn, __u8 status,
> >  	if (conn->sec_level == BT_SECURITY_SDP)
> >  		conn->sec_level = BT_SECURITY_LOW;
> >  
> > -	if (conn->pending_sec_level > conn->sec_level)
> > +	if (!status && conn->pending_sec_level > conn->sec_level)
> >  		conn->sec_level = conn->pending_sec_level;
> 
> I think this should be moved out of hci_encrypt_cfm and directly into
> hci_encrypt_change_evt. Currently, the only place this assignment is
> valid is on receipt of a successful Encryption Change Event (Although,
> where is the Encryption Key Refresh Complete Event handling? Or does the
> current SMP implementation not allow sec_level elevation?)

Security elevation in SMP isn't supported right now, as the only supported
security level is MEDIUM, because we don't support anything that would
offer MITM protection, that we are using as a condition for the HIGH
security level.

But your point, that this isn't the best place for this assignment is
good. See below.

> 
> Also, I believe that this assignment should only occur on LE links
> (which should be specifically tested for). For example, what if an ACL
> link authenticates at BT_SECURITY_MEDIUM level successfully but then
> later a specific service attempts to authenticates at BT_SECURITY_HIGH
> level but fails. The pending_sec_level will still be set to
> BT_SECURITY_HIGH so SET_CONN_ENCRYPT just needs to be resent and the ACL
> link will be promoted to BT_SECURITY_HIGH.

Again, good point. But that's an problem that already existed before my
patch. What my patch tries to solve is a much simpler issue: in case of
failure of a single security procedure, the security level of the link
shouldn't be promoted.

> 
> Maybe instead of testing for an LE link, a new pend bit should be
> introduced to indicate that this link is specifically expecting to set
> the link sec_level as a result of sending the LE_START_ENCRYPTION cmd?

I like it.

> 
> Regards,
> Peter Hurley

Cheers,
-- 
Vinicius
