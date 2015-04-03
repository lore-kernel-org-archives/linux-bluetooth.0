Return-Path: <cyrus@holtmann.org>
Message-ID: <551E7E40.5030904@hurleysoftware.com>
Date: Fri, 03 Apr 2015 07:49:20 -0400
From: Peter Hurley <peter@hurleysoftware.com>
MIME-Version: 1.0
To: Frederic Danis <frederic.danis@linux.intel.com>
CC: linux-serial@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	Greg KH <gregkh@linuxfoundation.org>,
	Jiri Slaby <jslaby@suse.cz>
Subject: Re: [Patch] tty: Re-add external interface for tty_set_termios()
References: <1428055395-10648-1-git-send-email-frederic.danis@linux.intel.com> <551E6BCA.7000807@hurleysoftware.com>
In-Reply-To: <551E6BCA.7000807@hurleysoftware.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

[ +cc GregKH, JiriS ]

On 04/03/2015 06:30 AM, Peter Hurley wrote:
> Hi Frederic,
> 
> On 04/03/2015 06:03 AM, Frederic Danis wrote:
>> This is a partial revert of patch "tty: Remove external interface for
>> tty_set_termios()" from Peter Hurley (2015-01-25 SHA1 632f32e2107) to
>> set tty_set_termios() publicly available.
>>
>> This will be needed by Bluetooth hci_uart module to be able to change
>> Bluetooth controller and local UART speed during vendor specific
>> initialization.
> 
> NAK.
> 
> 1. Where is this _proposed_ usage?

Found it. RFC series in linux-bluetooth.

