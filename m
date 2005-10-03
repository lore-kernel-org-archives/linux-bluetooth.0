Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <4340F026.1040604@cyph.ath.cx>
From: Ho Ming Shun <cyph@cyph.ath.cx>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] [SOLVED] BCM2035 over UART on the E680I
References: <432D6F49.80304@cyph.ath.cx>
In-Reply-To: <432D6F49.80304@cyph.ath.cx>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
Date: Mon, 03 Oct 2005 16:47:34 +0800

Hi,

Thanks to all those who attempted to help me. Looking through all the 
code I've hacked together late last night, I spotted a stupid mistake.

Long story short, I realised that I was basing my custom hciattach on 
the wrong set of ioctls. It called a custom ioctle Motorola added to the 
serial driver that caused the bluetooth chip to reset, therefore falling 
back to its "default" address.

Nevertheless, I hope this exercise can let some of you know about the 
vendor-specific HCI commands that can be used to program the BCM2035, 
especially programming in a custom BD_ADDR.

Thanks again!


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
