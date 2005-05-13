Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Jack Jia <jjia@cs.ubc.ca>
To: BlueZ mailing list <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Re: help with bluetooth on linux
In-Reply-To: <20050512225626.GE4319@bougret.hpl.hp.com>
Message-ID: <Pine.GSO.4.60.0505122232080.20512@columbia.cs.ubc.ca>
References: <4283A85A.3040609@certi.org.br> <20050512225626.GE4319@bougret.hpl.hp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
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
Date: Thu, 12 May 2005 22:37:35 -0700 (PDT)

You can do anything with Java. In Java, everything is pointer and all the 
functions are virtual, and from language point of view it is cooler than 
C/C++. Finally, everything will go to 0s and 1s, but it is NOT cool to use 
them directly. People who don't like Java are usually not good C/C++ 
programmers.

Jack

On Thu, 12 May 2005, Jean Tourrilhes wrote:

> On Thu, May 12, 2005 at 04:02:50PM -0300, Gabriel Marques wrote:
>> Hi, I've found your e-mail in a "how to" about "Brainboxes BlueTooth +
>> Linux Howto".
>> The tutorial is helping a lot but I still got some problems, and I was
>> hoping you could help me out with any information.
>> In my work (with JavaTV) I need to set up a communication channel over a
>> BT device, using an open-source Java BT stack.
>
> 	That's typical of the Java people, they want to rewrite the
> whole OS in Java. This only lead to lot of duplicated code,
> interoperability problem and madness. Please use the OS existing BT
> stack, don't rewrite your own.
> 	Let suppose your Java programe use a Java BT stack, and you
> want both your Java program and a regular C/C++ program (BT
> mouse/audio driver) to use BT, how do you make that work. You can't.
>
>> JavaBluetooth relies on a serial/tty abstraction of the HCI layer (H4),
>> and works fine with serial (RS232) BT dongles.
>> But those are hard and expensive to find, and all I have is two USB
>> dongles. One is a 3com and the other came from china.
>> Well, my problem is: *How to make JavaBluetooth work with an USB dongle*
>
> 	Don't. It's a waste of time.
> 	The proper question is : how do I access in Java the existing
> BT stack of Linux that is fully debugged and fully functional.
>
>> I've installed Fedora Linux (kernel 2.6.11-1.14_FC3), and the USB dongle
>> was recognized automatically, its running fine trough BlueZ.
>> can you help me with some steps on putting the usb_bt>serial_bt driver
>> to work?
>
> 	No, what you need to do is to create a JNI enabling your Java
> program to access the BlueZ APIs. The BlueZ APIs are all sockets of
> various types, and most likely you only need one or two types, so this
> is not as bad as it looks like. Yeah, it's a shame that writting JNI
> is so messy, SUN should improve that.
> 	If you want an example of such JNI, you can look at the
> Java-IrDA API done be a collegue of mine. That's the right way to do
> it.
> 	Actually, somebody might have already done that, so ask around...
>
> 	Regards,
>
> 	Jean
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by Oracle Space Sweepstakes
> Want to be the first software developer in space?
> Enter now for the Oracle Space Sweepstakes!
> http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
