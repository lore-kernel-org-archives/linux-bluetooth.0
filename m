Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <4479225C.9090809@trn.iki.fi>
References: <4479225C.9090809@trn.iki.fi>
Date: Mon, 29 May 2006 15:05:28 +0200
Message-Id: <1148907928.31689.15.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] rfcomm disconnects + hcid dying
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Lasse,

> Who is responsible for these parts? Why am I getting no replies to this
> mail? Are any developers reading this list? Where should I send this, to
> developers' private addresses or something?

don't try the developers private addresses. They might ignore you or if
you send it to me, I am going to tell you to send it to the mailing
list. You need to have patience, because some of us might be busy with
other stuff that has higher priority.

> PROBLEM 1:
> 
> Whenever /dev/rfcomm0 (or rfcomm1) is closed, the corresponding Bluetooth
> device gets disconnected and I have to run hcitool cc xx:xx:xx:xx:xx:xx to
> get it working again. How can I have the devices automatically connected
> at all times whenever they are within reach and the USB BT dongle is
> plugged in?
> 
> My current workaround is an endless while loop that runs hcitool cc all
> the time, but this is obviously quite ugly. It works, but I'd really want
> to have something more elegant.

You can of course keep /dev/rfcommX open with cat for example, but it
won't reconnect if the device get out of range.

There is nothing elegant for device that come out of range and then come
back and they should automatically reconnect. The device most initiate
this at the moment, because the host behaves passiv and if nobody tells
it to connect, it simply doesn't.

> PROBLEM 2:
> 
> My hcid keeps dying occassionally. I don't know why, but it just does
> that. My current workaround is to have the init system restart it whenever
> it dies, but this, too, is somewhat ugly. Haven't found any messages about
> that in the logs yet, but that is partly because my log was flooded with
> other stuff.

We fixed a lot of stuff in the upcoming bluez-utils-2.26 version, but
without any log messages or reports I can't tell you anything. However
you can run "hcid -n" and it will log everything in the terminal instead
of the log files.

Regards

Marcel




_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
