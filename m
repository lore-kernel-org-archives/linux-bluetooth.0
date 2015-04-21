Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCH] tty: Re-add external interface for tty_set_termios()
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20150421090640.GB1569@kroah.com>
Date: Tue, 21 Apr 2015 09:04:18 -0700
Cc: Peter Hurley <peter@hurleysoftware.com>,
	Frederic Danis <frederic.danis@linux.intel.com>,
	linux-serial@vger.kernel.org,
	"bluez mailin list (linux-bluetooth@vger.kernel.org)"
	<linux-bluetooth@vger.kernel.org>, jslaby@suse.cz
Message-Id: <5F75AEFB-A885-465E-9A5E-032B9380D226@holtmann.org>
References: <1428671585-13310-1-git-send-email-frederic.danis@linux.intel.com> <5527CEFB.5070406@hurleysoftware.com> <20150421090640.GB1569@kroah.com>
To: Greg KH <gregkh@linuxfoundation.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Greg,

>>> This is needed by Bluetooth hci_uart module to be able to change speed
>>> of Bluetooth controller and local UART.
>> 
>> Because this is the lesser evil right now,
>> 
>> Reviewed-by: Peter Hurley <peter@hurleysoftware.com>
> 
> Does this need to be in 4.1-rc1?  Or is this a 4.2 thing?

if you can queue this up for 4.1-rc1, that would be great. We are using it. It is just the driver using it did not make it to 4.0-rc1 yet.

Regards

Marcel

