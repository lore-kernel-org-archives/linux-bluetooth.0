Return-Path: <cyrus@holtmann.org>
Date: Mon, 14 Oct 2013 14:51:33 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv3 14/15] android: Add makefile for hciconfig
Message-ID: <20131014115131.GG2861@aemeltch-MOBL1>
References: <1381131496-9417-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1381243883-2745-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1381243883-2745-15-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <60443344-0A54-4EF4-ABBB-1EAAE168E541@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <60443344-0A54-4EF4-ABBB-1EAAE168E541@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Oct 09, 2013 at 09:59:42PM +0200, Marcel Holtmann wrote:
> Hi Andrei,
> 
> > 
> > ---
> > android/Android.mk |   34 ++++++++++++++++++++++++++++++++++
> > 1 file changed, 34 insertions(+)
> > 
> > diff --git a/android/Android.mk b/android/Android.mk
> > index e7a70d0..09c4579 100644
> > --- a/android/Android.mk
> > +++ b/android/Android.mk
> > @@ -123,3 +123,37 @@ $(foreach file,$(lib_headers), $(shell ln -sf ../$(file) $(LOCAL_PATH)/../lib/bl
> > LOCAL_MODULE := libbluetooth
> > 
> > include $(BUILD_SHARED_LIBRARY)
> > +
> > +#
> > +# hciconfig
> > +#
> 
> why are we building this one. Only btmgmt should be needed for testing. If at all.
> 

Can btmon now save packet dump in a format understandable for wireshark?

Best regards 
Andrei Emeltchenko 

