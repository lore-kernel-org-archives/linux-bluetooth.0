Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: <wadex@km.ru>
To: bluez-devel@lists.sourceforge.net
Date: Mon, 12 Nov 2007 04:36:23 +0300
Message-Id: <4737AE17.019961.01480@e-post07.km.ru>
MIME-Version: 1.0
Subject: Re: [Bluez-devel] j2me hid profile
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

Excuse me for off topic, but the answer can be found here: http://www.wiili.org/forum/wiimote-via-java-t983-s21.html

Quote:
"You raise many valid issues with JSR-82. The PSM issue has been raised by others. At the time where JSR-82 was defined, the expectation was that new profiles would define PSM values outside of the reserved range. Profiles defined within the reserved range would have special requirements on L2CAP. With that said, the Bluetooth specification did not evolve this way. This has lead to the shortcoming that you mentioned. 

JSR-82 is currently in maintenance mode, which means errors may be fixed, but no new features may be added to the specification. To actually solve this problem, a new JSR needs to be submitted for Bluetooth. This has been discussed, but has not been announced yet. 

As for the PSM value being odd, this is a requirement of the Bluetooth v1.2 and v2.1 specifications. The 0x1001 value is also defined in the Bluetooth v1.2 and v2.1 specifications. 

I know that this is the not the answer you are probably looking for, but it is a reality of the JCP process. The issues that you raised will be helpful in the development of a future Java + Bluetooth JSR."

Best regards, wadex.


>Hi everyone.
>
>I'm interesping how to plugin a bluetooth keyboard to cell phone with j2me + jsr-82. It's need implement a HID profile. But the problem is happened. It described here: http://developer.sonyericsson.com/thread.jspa?&threadID=37949&start=0
> 
>But I can't understand: if HID based on L2CAP layer and it works correct on j2se, why it can't work properly on j2me's L2CAR layer? What's matter? What's need else for HID implementation on j2me? Or is it possible plugin the keyboard some another way (keyboard's bios or some think else)? Can you advise some solutions?
>
>Best regards, wadex.


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
