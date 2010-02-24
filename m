Return-Path: <cyrus@holtmann.org>
Message-ID: <4B851AAE.10401@nokia.com>
Date: Wed, 24 Feb 2010 14:25:18 +0200
From: Ville Tervo <ville.tervo@nokia.com>
MIME-Version: 1.0
To: ext Tomas Winkler <tomas.winkler@intel.com>
CC: "marcel@holtmann.org" <marcel@holtmann.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "guy.cohen@intel.com" <guy.cohen@intel.com>,
        "ron.rindjunsky@intel.com" <ron.rindjunsky@intel.com>,
        Gregory Paskar <greogry.paskar@intel.com>
Subject: Re: [bluetooth-next 1/1] bluetooth: handle device reset event
References: <1266486007-25015-1-git-send-email-tomas.winkler@intel.com>
In-Reply-To: <1266486007-25015-1-git-send-email-tomas.winkler@intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tomas,

ext Tomas Winkler wrote:
> From: Gregory Paskar <greogry.paskar@intel.com>
> 
> A bluetooth device experiencing hardware failure may issue
> a HARDWARE_ERROR hci event. The reaction to this event is device
> reset flow implemented in following sequence.
> 
> 1. Notify: HCI_DEV_DOWN
> 2. Reinitialize internal structures.
> 3. Call driver flush function
> 4. Send HCI reset request to the device.
> 5. Send HCI init sequence reset to the device.
> 6. Notify HCI_DEV_UP.

Drivers on some embedded platforms can disable whole bt chip with gpio 
line. Actually hw reset is sometimes needed for the reset. I'm wondering 
if it would be feasible to add hdev->close() and hdev->open requense to 
reset code? It would force driver to do hw reset for the chip.

-- 
Ville
