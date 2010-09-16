Return-Path: <cyrus@holtmann.org>
From: =?iso-8859-1?q?Jos=E9_Antonio_Santos_Cadenas?=
	<santoscadenas@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Subject: Re: CSP implementation for MCAP
Date: Thu, 16 Sep 2010 14:55:25 +0200
Cc: Elvis =?iso-8859-1?q?Pf=FCtzenreuter?= <epx@signove.com>,
	linux-bluetooth@vger.kernel.org
References: <4A11989E-5448-43B7-887F-217C54977E22@epx.com.br> <1FA1AF09-53BA-4187-81B3-78E2E5C82852@signove.com> <20100916123900.GA20869@jh-x301>
In-Reply-To: <20100916123900.GA20869@jh-x301>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201009161455.26174.santoscadenas@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

El Thursday 16 September 2010 14:39:00 Johan Hedberg escribió:
> Hi Elvis,
> 
> On Wed, Sep 15, 2010, Elvis Pfützenreuter wrote:
> > > This is the repository for the CSP implementation, rebased over the
> > > recently accepted MCAP, for your appreciation:
> > > 
> > > git://gitorious.org/bluez-epx/bluez-epx.git csp
> > > 
> > > or
> > > 
> > > http://www.gitorious.org/bluez-epx/bluez-epx/commits/csp--
> > 
> > And I am happy to announce that this CSP implementation passed on PTS
> > 
> > :) Fixes are on topmost patch of the repository.
> 
> Good to hear about the progress with the PTS :)
> 
> Unfortunately you'll need to rebase again since I pushed some cleanups
> to the MCAP code. Could you also get rid of the unnecessary
> double-pointers and type casts which aren't needed anymore now that
> mcap_send_data accepts void *.

There are also a lot of (! condition) with an extra space between the ! and 
the condition variable.

Also some use of g_malloc0 instead of g_new0. About this issue, remember that 
g_new0 initializes all the structure with 0 so the initialization don't need 
to do for some fields in mcap_sync_init function.

Regards.

> 
> Johan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
> in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
