Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=US-ASCII
Mime-Version: 1.0 (Mac OS X Mail 8.0 \(1990.1\))
Subject: Re: [PATCH] Bluetooth: HCI H5 peer reset detection
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <5453A5D5.3060801@intel.com>
Date: Fri, 31 Oct 2014 09:50:58 -0700
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
	linux-bluetooth@vger.kernel.org
Message-Id: <E6505B84-8BD2-4FC2-BDE6-9ACEB363D045@holtmann.org>
References: <1412780068-19449-1-git-send-email-loic.poulain@intel.com> <20141031083908.GB18888@t440s.P-661HNU-F1> <5453A5D5.3060801@intel.com>
To: Loic Poulain <loic.poulain@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Loic,

please do not top-post on this mailing list. It breaks the flow of things since everybody is doing inline quoting.

> This is just the expected behavior as described int the specification:
> 
> UART Spec says:
> If the UART synchronization is lost in the communication from Host to Host
> Controller, then the Host Controller shall send a Hardware Error Event to tell
> the Host about the synchronization error. The Host Controller will then expect to
> receive an HCI_Reset command from the Host in order to perform a reset. The
> Host Controller will also use the HCI_Reset command in the byte stream from
> Host to Host Controller to re-synchronize.
> 
> H5 part says:
> If a SYNC message is received while in the Active State, it is assumed that the
> peer device has reset. The local device should therefore perform a full reset of
> the upper stack, and start Link Establishment again at the Uninitialized State.
> 
> So, hardware error seems the best way to warn host stack about the H5 controller
> reset.

I am actually fine with doing it this way.

> Regarding the "upper stack", I know that Bluedroid restarts on hardware error, but
> I ignore the Bluez behavior.

This is something we need to fix then. First and foremost this has to work with the Bluetooth subsystem in the kernel as well and not just a stack on top of HCI User Channel.

Regards

Marcel

