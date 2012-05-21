Return-Path: <cyrus@holtmann.org>
Date: Mon, 21 May 2012 15:25:56 +0300
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Bluetooth: Use defined link key size
Message-ID: <20120521122554.GB30424@aemeltch-MOBL1>
References: <1337350806-20326-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <20120518144044.GA5494@x220.P-661HNU-F1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120518144044.GA5494@x220.P-661HNU-F1>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Fri, May 18, 2012 at 05:40:44PM +0300, Johan Hedberg wrote:
> Hi Andrei,
> 
> On Fri, May 18, 2012, Andrei Emeltchenko wrote:
> > Remove magic number with defined link key size. This is especially
> > useful for calculation other keys which are 2 * key_size, etc that
> > makes usage of magic numbers too much.
> > 
> > Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> > ---
> >  include/net/bluetooth/bluetooth.h |    2 ++
> >  include/net/bluetooth/hci.h       |    4 ++--
> >  include/net/bluetooth/hci_core.h  |    2 +-
> >  net/bluetooth/hci_core.c          |    2 +-
> >  net/bluetooth/hci_event.c         |    2 +-
> >  net/bluetooth/mgmt.c              |    2 +-
> >  6 files changed, 8 insertions(+), 6 deletions(-)
> > 
> > diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
> > index 961669b..4abedfe 100644
> > --- a/include/net/bluetooth/bluetooth.h
> > +++ b/include/net/bluetooth/bluetooth.h
> > @@ -68,6 +68,8 @@ struct bt_security {
> >  #define BT_SECURITY_MEDIUM	2
> >  #define BT_SECURITY_HIGH	3
> >  
> > +#define BT_SEC_LINK_KEY_SIZE		16
> 
> The patch seems ok'ish to me but I'd remove the _SEC part from the
> define name since it doesn't really buy you anything. 

Sent new version with a name proposed by Marcel.

> Also, I'm a bit
> confused by the commit message. What other keys are "2 * key_size"?

This is AMP key size which is calculated from link keys.

> There are no such occurrences in the patch itself so you should at least
> give some examples in the commit message.

I deleted this from the patch description.

Best regards 
Andrei Emeltchenko 
