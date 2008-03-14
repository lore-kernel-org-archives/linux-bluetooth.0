Return-Path: <cyrus@holtmann.org>
Message-Id: <42CCF85F-A627-496E-AEB3-5FD249D7FCC9@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1205519413.30595.228.camel@cookie.hadess.net>
Mime-Version: 1.0 (Apple Message framework v919.2)
Date: Fri, 14 Mar 2008 19:59:59 +0100
References: <20080313150643.GI8969@cathedrallabs.org>
	<1205519413.30595.228.camel@cookie.hadess.net>
Subject: Re: [Bluez-devel] [PATCH 1/2 v011] add support to fake HID devices
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Bastien,

>> This patch adds support to fake HID devices. Instead of registering  
>> with
>> kernel, the fake HID will be handled in user level and an uinput  
>> device
>> will be created in order to get the events into input layer.
> <snip>
>> +		fake = g_try_new0(struct fake_input, 1)
>
> Missing a semi-colon.
>
>
>> +	if (fake)
>> +		gfree(fake);
>
> g_free, not gfree.
>
> Works fine after those changes.

fixed everything, but I had to do some manual fixups for coding style  
and so on. This patch is in. The other one isn't. I need an updated one.

Regards

Marcel


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
