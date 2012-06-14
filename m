Return-Path: <cyrus@holtmann.org>
Date: Thu, 14 Jun 2012 17:22:16 +0300
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Use AUTO_OFF constant in jiffies
Message-ID: <20120614142214.GA2585@aemeltch-MOBL1>
References: <1339659945-28094-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <CAJdJm_MtZYC9=nFzchcCR+yZiyGVNCMpXnmPf7D-dKut1UT8BA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CAJdJm_MtZYC9=nFzchcCR+yZiyGVNCMpXnmPf7D-dKut1UT8BA@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

On Thu, Jun 14, 2012 at 08:07:40AM -0400, Anderson Lizardo wrote:
> > Move AUTO_OFF_TIMEOUT to other constants changing name to
> > HCI_AUTO_OFF_TIMEOUT and convert to jiffies.
> >
> > Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> > ---
> >  include/net/bluetooth/hci.h |    3 ++-
> >  net/bluetooth/hci_core.c    |    5 +----
> >  2 files changed, 3 insertions(+), 5 deletions(-)
> >
> > diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> > index 3d1ad2c..a7b334e 100644
> > --- a/include/net/bluetooth/hci.h
> > +++ b/include/net/bluetooth/hci.h
> > @@ -153,8 +153,9 @@ enum {
> >  #define HCI_DISCONN_TIMEOUT    msecs_to_jiffies(4000)  /* 2 seconds */
> 
> There is a typo in the comment above. It should be "4 seconds". Maybe
> you can fix it in a separate patch together with the "seconds" ->
> "second" fix you did below?

Sorry, the patch applied against my tree where I use this hack for
"slow" device. I will rebase the patch against bluetooth-next.

Best regards 
Andrei Emeltchenko 

