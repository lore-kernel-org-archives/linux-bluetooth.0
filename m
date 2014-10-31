Return-Path: <cyrus@holtmann.org>
Date: Fri, 31 Oct 2014 19:58:06 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Loic Poulain <loic.poulain@intel.com>,
	"Gustavo F. Padovan" <gustavo@padovan.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: HCI H5 peer reset detection
Message-ID: <20141031175806.GA371@t440s.P-661HNU-F1>
References: <1412780068-19449-1-git-send-email-loic.poulain@intel.com>
 <20141031083908.GB18888@t440s.P-661HNU-F1>
 <5453A5D5.3060801@intel.com>
 <E6505B84-8BD2-4FC2-BDE6-9ACEB363D045@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <E6505B84-8BD2-4FC2-BDE6-9ACEB363D045@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Fri, Oct 31, 2014, Marcel Holtmann wrote:
> > So, hardware error seems the best way to warn host stack about the H5 controller
> > reset.
> 
> I am actually fine with doing it this way.
> 
> > Regarding the "upper stack", I know that Bluedroid restarts on hardware error, but
> > I ignore the Bluez behavior.
> 
> This is something we need to fix then. First and foremost this has to
> work with the Bluetooth subsystem in the kernel as well and not just a
> stack on top of HCI User Channel.

Agreed. I've now applied this patch to bluetooth-next so we can continue
towards making the higher layers do the right thing as well.

Johan
