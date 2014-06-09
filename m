Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: Question about HCI_QUIRK_RESET_ON_CLOSE
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20140609083124.1ea9e852@han1-desk-dev>
Date: Mon, 9 Jun 2014 17:45:01 +0200
Cc: Linux Bluetooth mailing list <linux-bluetooth@vger.kernel.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	"Gustavo F. Padovan" <gustavo@padovan.org>
Message-Id: <8BACFBA7-C6B6-4BE7-9107-2E4665B3A278@holtmann.org>
References: <20140609083124.1ea9e852@han1-desk-dev>
To: Tedd Ho-Jeong An <tedd.an@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tedd,

> I noticed that HCI_QUIRK_RESET_ON_CLOSE bit is used during stack initialization or device close exclusively.
> If the bit is set, HCI_RESET is sent to the device during device close but not during stack initialization and vice versa when it is not set. I just wonder if there is any reason for doing it?

Bluetooth 1.0b and some Bluetooth 1.1 devices have not a clear defined behavior on HCI_Reset when it comes to the host transport. Only Bluetooth 1.1 cleared that HCI_Reset is not suppose to reset the transport. For example with USB. So you ended up seeing HCI_Reset, USB Reset, USB Disconnect, USB Connect endless cycles.

A certain set of drivers are required to set this quirk. However eventually they have to do the HCI_Reset since otherwise we end up in funky states. Check drivers/bluetooth/ for devices that require not to send the HCI_Reset on init.

> What do you recommend if HCI_RESET needs to be sent for both stack initialization case and device close?

I have been thinking about this a while ago. Instead of using HCI_Reset we actually started to modify the kernel to clear out all its states when we are powering down the controller. A recent bluetooth-next kernel should just make sure we are no longer connectable and discoverable and also no longer advertising.

We needed this for UART based devices where the transport has no clear indication that it is down. With USB devices this problem normally never happens since we are bringing down USB as well.

Do you need something else?

Regards

Marcel

