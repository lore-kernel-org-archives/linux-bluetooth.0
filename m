Return-Path: <cyrus@holtmann.org>
Date: Thu, 16 Sep 2010 18:03:17 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Elvis =?iso-8859-1?Q?Pf=FCtzenreuter?= <epx@signove.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: CSP implementation for MCAP
Message-ID: <20100916150317.GA23529@jh-x301>
References: <4A11989E-5448-43B7-887F-217C54977E22@epx.com.br>
 <1FA1AF09-53BA-4187-81B3-78E2E5C82852@signove.com>
 <20100916123900.GA20869@jh-x301>
 <F9784FEC-442D-4448-9BA1-234AA9963ECE@signove.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <F9784FEC-442D-4448-9BA1-234AA9963ECE@signove.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Elvis,

On Thu, Sep 16, 2010, Elvis Pfützenreuter wrote:
> > On Wed, Sep 15, 2010, Elvis Pfützenreuter wrote:
> >>> This is the repository for the CSP implementation, rebased over the
> >>> recently accepted MCAP, for your appreciation:
> >>> 
> >>> git://gitorious.org/bluez-epx/bluez-epx.git csp
> >>> 
> >>> or
> >>> 
> >>> http://www.gitorious.org/bluez-epx/bluez-epx/commits/csp--
> >> 
> >> And I am happy to announce that this CSP implementation passed on PTS
> >> :) Fixes are on topmost patch of the repository.
> > 
> > Good to hear about the progress with the PTS :)
> > 
> > Unfortunately you'll need to rebase again since I pushed some cleanups
> > to the MCAP code. Could you also get rid of the unnecessary
> > double-pointers and type casts which aren't needed anymore now that
> > mcap_send_data accepts void *.
> 
> It's done, and tested.

Thanks. I still had to do quite a lot of coding style fixes as well as
plug a memory leak, but the patches are now pushed upstream.

Next steps:

- Get rid of the forward declarations of static functions
  wherever possible. It looked like you could accomplish that
  with a simple reordering of the functions.

- Get rid of raw HCI access (hci_open_dev). bluetoothd shouldn't use
  this type of sockets in the future at all. You'll need to add a proper
  callback to the adapter_opts and a function to plugins/hciopts.c and
  use that instead. Then export a function like btd_adapter_read_clock
  for the plugin to use.

Johan
