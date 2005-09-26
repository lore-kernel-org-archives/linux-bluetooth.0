Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <4337B838.9080701@ubuntu.com>
From: Charles Majola <charles@ubuntu.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] hid2hci segementation fault at boot time
References: <27820.1125566922@www47.gmx.net> <1125921697.11955.8.camel@pegasus>
In-Reply-To: <1125921697.11955.8.camel@pegasus>
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
Date: Mon, 26 Sep 2005 10:58:32 +0200

Marcel Holtmann wrote:

>Hi Stefan,
>
>  
>
>>I own a Logitech Bluetooth Desktop keyboard and mouse. I wanted to use the
>>Logitech dongle to additionally connect my Bluetooth headset to the PC for
>>Skype voice calls. 
>>So far no problems, modules and demons load fine, switched the Logitech
>>dongle to bluetooth mode via hid2hci.
>>To automate this process during boot time I enabled the bluetooth.init
>>script. The demons and modules still load fine, but hid2hci crashes with a
>>segmentation fault. When I run the init script after bootup as superuser
>>everything goes fine.
>>Any idea where is the difference or what I am doing wrong?
>>Running Suse 9.1 with a vanilla kernel 2.6.12.4. Tried the last three
>>releases of Bluez.
>>    
>>
>
>check with dmesg if you see a kernel oops. Otherwise use gdb to debug
>  
>
>the problem.
>  
>
I think I have the same problem. I'm using a powerpc, the keyboard work 
before bluez-utils is loaded.

>Regards
>
>Marcel
>
>
>
>
>-------------------------------------------------------
>SF.Net email is Sponsored by the Better Software Conference & EXPO
>September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
>Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
>Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
>_______________________________________________
>Bluez-devel mailing list
>Bluez-devel@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/bluez-devel
>
>  
>



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
