Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <434112CA.1010809@cyph.ath.cx>
From: Ho Ming Shun <cyph@cyph.ath.cx>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] [SOLVED] BCM2035 over UART on the E680I
References: <432D6F49.80304@cyph.ath.cx>  <4340F026.1040604@cyph.ath.cx> <1128339367.22437.4.camel@blade>
In-Reply-To: <1128339367.22437.4.camel@blade>
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
Date: Mon, 03 Oct 2005 19:15:22 +0800

Marcel Holtmann wrote:

>Hi,
>
>  
>
>>Thanks to all those who attempted to help me. Looking through all the 
>>code I've hacked together late last night, I spotted a stupid mistake.
>>
>>Long story short, I realised that I was basing my custom hciattach on 
>>the wrong set of ioctls. It called a custom ioctle Motorola added to the 
>>serial driver that caused the bluetooth chip to reset, therefore falling 
>>back to its "default" address.
>>
>>Nevertheless, I hope this exercise can let some of you know about the 
>>vendor-specific HCI commands that can be used to program the BCM2035, 
>>especially programming in a custom BD_ADDR.
>>    
>>
>
>what do think about writing all this stuff up and posting a patch for
>the hciattach program?
>  
>
That will be good, but will take some time. Right now I'm using a 
program totally seperate from hciattach. The only common code is the 
setting of line discipline and HCI protocol. The whole thing is also 
tied together with a shell script that calls a binary program on the 
phone firmware (to load the BCM2035 firmware, set BD_ADDR, and some 
other stuff which have not been figured out.) Meanwhile if anyone is 
interested, the binary is at:

http://cyph.ath.cx:8080/downloads/ezx-bluez-0.2.tar.bz2

Sources are at:

http://cyph.ath.cx:8080/downloads/ezx-bluez-init-0.2.tar.bz2

>I also read that Harald Welte is hacking on the A780 GSM interface. So
>maybe at some point it is possible to fully replace their binary only
>stuff.
>  
>
That will be good. For some reason, Motorola's linux phone's have not 
attracted as much hacker talent as other devices (e.g. OpenWRT, Ipaq, 
Zaurus). Hopefully it will change. Meanwhile the most active english 
forum seems to be at www.motorolafans.com.

>Regards
>
>Marcel
>
>
>
>
>-------------------------------------------------------
>This SF.Net email is sponsored by:
>Power Architecture Resource Center: Free content, downloads, discussions,
>and more. http://solutions.newsforge.com/ibmarch.tmpl
>_______________________________________________
>Bluez-devel mailing list
>Bluez-devel@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/bluez-devel
>
>  
>



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
