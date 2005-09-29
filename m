Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <433C0F0D.2080605@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] snd-bt-sco on an UART bluetooth device
References: <e555255705092908451b2be938@mail.gmail.com>
In-Reply-To: <e555255705092908451b2be938@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 29 Sep 2005 09:58:05 -0600

Anderson

> for using a bluetooth headset). When I used a usb bluetooth dongle,
> everything was ok. But, when I use the bluetooh on-board (UART type),
> the sound on bluetooth headset is very bad and I can't hear anything,
> just noise.

I remember seeing someone else talk about this problem. It should work 
as long as the bluetooth adapter is still made by CSR. If it is a CSR 
chip then maybe there's a problem in the kernel driver.

Brad


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
