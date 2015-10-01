Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: [PATCH] Revert "serial: 8250_dma: don't bother DMA with small transfers"
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1443689736.8361.322.camel@linux.intel.com>
Date: Thu, 1 Oct 2015 12:44:55 +0200
Cc: Peter Hurley <peter@hurleysoftware.com>,
	Frederic Danis <frederic.danis@linux.intel.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	linux-serial@vger.kernel.org, linux-bluetooth@vger.kernel.org
Message-Id: <15E8D395-71C7-44D2-82BB-5B6658872F55@holtmann.org>
References: <1443617191-21013-1-git-send-email-frederic.danis@linux.intel.com> <560BE919.9020803@hurleysoftware.com> <1443622344.8361.304.camel@linux.intel.com> <560C420B.4030007@hurleysoftware.com> <1443689736.8361.322.camel@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andy,

>>>> It's customary to mail the commit author in patches which revert
>>>> their work.
>>>> 
>>>>> This commit prevents from sending "big" file using Bluetooth.
>>>>> When sending a lot of data quickly through the Bluetooth 
>>>>> interface, 
>>>>> and
>>>>> after a variable amount of data sent, transfer fails with 
>>>>> error:
>>>>>    kernel: [  415.247453] Bluetooth: hci0 hardware error 0x00
> 
> Frederic, I forgot to ask how exactly the hw setup looks like?
> 
> The message above is not present in the kernel (the closest what I
> found is 
> 
> drivers/bluetooth/btintel.c:98: BT_ERR("%s: Hardware error 0x%2.2x",
> hdev->name, code);
> 
> which makes me think you have USB BT adapter attached to the same
> machine. Am I wrong?

the Bluetooth core will generate that error in case the driver does not provide hdev->hw_error callback. We have not hocked that up for the UART driver yet. Look at net/bluetooth/hci_core.c to find the common error message.

Regards

Marcel

