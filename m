Return-Path: <bluez-devel-admin@lists.sourceforge.net>
To: Gabriel Marques <wp9-t6@certi.org.br>
Cc: BlueZ mailing list <bluez-devel@lists.sourceforge.net>
Message-ID: <20050512225626.GE4319@bougret.hpl.hp.com>
References: <4283A85A.3040609@certi.org.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4283A85A.3040609@certi.org.br>
From: Jean Tourrilhes <jt@hpl.hp.com>
Subject: [Bluez-devel] Re: help with bluetooth on linux
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
Date: Thu, 12 May 2005 15:56:26 -0700

On Thu, May 12, 2005 at 04:02:50PM -0300, Gabriel Marques wrote:
> Hi, I've found your e-mail in a "how to" about "Brainboxes BlueTooth + 
> Linux Howto".
> The tutorial is helping a lot but I still got some problems, and I was 
> hoping you could help me out with any information.
> In my work (with JavaTV) I need to set up a communication channel over a 
> BT device, using an open-source Java BT stack.

	That's typical of the Java people, they want to rewrite the
whole OS in Java. This only lead to lot of duplicated code,
interoperability problem and madness. Please use the OS existing BT
stack, don't rewrite your own.
	Let suppose your Java programe use a Java BT stack, and you
want both your Java program and a regular C/C++ program (BT
mouse/audio driver) to use BT, how do you make that work. You can't.

> JavaBluetooth relies on a serial/tty abstraction of the HCI layer (H4), 
> and works fine with serial (RS232) BT dongles.
> But those are hard and expensive to find, and all I have is two USB 
> dongles. One is a 3com and the other came from china.
> Well, my problem is: *How to make JavaBluetooth work with an USB dongle*

	Don't. It's a waste of time.
	The proper question is : how do I access in Java the existing
BT stack of Linux that is fully debugged and fully functional.

> I've installed Fedora Linux (kernel 2.6.11-1.14_FC3), and the USB dongle 
> was recognized automatically, its running fine trough BlueZ.
> can you help me with some steps on putting the usb_bt>serial_bt driver 
> to work?

	No, what you need to do is to create a JNI enabling your Java
program to access the BlueZ APIs. The BlueZ APIs are all sockets of
various types, and most likely you only need one or two types, so this
is not as bad as it looks like. Yeah, it's a shame that writting JNI
is so messy, SUN should improve that.
	If you want an example of such JNI, you can look at the
Java-IrDA API done be a collegue of mine. That's the right way to do
it.
	Actually, somebody might have already done that, so ask around...

	Regards,

	Jean


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
