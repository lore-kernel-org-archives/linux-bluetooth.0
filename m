Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Alexander Holler <holler@ahsoftware.de>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Success: switching the Logitech-Hub
Message-ID: <134020000.1073270547@[192.168.207.2]>
In-Reply-To: <1073267036.3804.4.camel@pegasus>
References: <9810000.1073197538@[192.168.207.2]>
 <1073267036.3804.4.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 05 Jan 2004 03:42:27 +0100

Hello,

--On Montag, Januar 05, 2004 02:43:56 +0100 Marcel Holtmann 
<marcel@holtmann.org> wrote:

>> lsusb:
>>
>> Bus 001 Device 004: ID 046d:c707 Logitech, Inc.
>> Bus 001 Device 003: ID 046d:c704 Logitech, Inc.

> A little bit weird is that the HID device 046d:c704 is still present
> after switching.

This is something I doesn't understand too. Either the Linux-USB stack is 
missing the disconnect, or a 'magic' report in the switch-sequence for 
finally disabling the usb-hid-device is missing.
Using Windows it seems the usb-hid-dev is removed after starting the 
bluetooth-stack. I will check my win-logs if I could find another report 
which could do this.

Regards,

Alexander




-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
