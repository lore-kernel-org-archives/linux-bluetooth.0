Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <46D8DBF3.2050902@gmail.com>
Date: Sat, 01 Sep 2007 00:26:43 -0300
From: Manuel Naranjo <naranjo.manuel@gmail.com>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <cc1649d10708301947o7fbb805dsfb2a7df83d39ec@mail.gmail.com>	<1188569227.13373.94.camel@violet>	<cc1649d10708310723h5eff2001sd95a186888e8dc03@mail.gmail.com>	<1188582998.13373.102.camel@violet>	<cc1649d10708311345w6cc50a72w41bc43d43db9e683@mail.gmail.com>	<1188594085.10148.8.camel@violet>
	<cc1649d10708312014s4ff62bd3o603905ab4d8dd221@mail.gmail.com>
In-Reply-To: <cc1649d10708312014s4ff62bd3o603905ab4d8dd221@mail.gmail.com>
Subject: Re: [Bluez-users] JSR-82 using D-Bus
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Vlad
> My goal is to make open source JSR-82 and certify it with Motorola.
> I can't do this with windows corporates. They will not make a minimal
> modifications in the core to make it possible to make JSR-82 complaint
> (100%) implementation on top...
>   
Great, I would like to help. And I think the company I work for will 
fully support me on this.
>   Does this mean you will help me with advise while I'm doing JSR-82
> on top of BlueZ?
>
>   I'm big fun of java :) and I can write in C/C++.  As it is right now
> I managed to create nearly compliant implementation on windows. There
> are some missing parts that I can't fix in WIDCOMM to certify
> implementation with Motorola.  Also I'm hoping to make a version for
> Toshiba stack. The API they have looks very promising. But this after
> BlueZ.
>
>   I just started with BlueZ and managed to create device discovery
> using D-Bus java binding. As I see there are many places where the are
> missing documentation in BlueZ or unimplemented functionality e.g
> Service framework does not give me ability to register L2CAP service.
> Also if I want to register RFCOMM service but don't want map it to com
> port and just handle it using sockets (not via D-Bus).....
>
>   So now I'm going for one week to the cottage. When back I will start
> making noise in this group again
I'm a big fun of java too. And I like C, right now I'm writing an app 
that opens an spp server, interacts with the spp clients, and then sends 
data to web server. The code is 100% GPL and written in C. But I think 
that doing it in Java could make my life much easier.

Have you see the d-bus api for Java, maybe you can use it to avoid JNI 
as much as possible.

There's also Avetana BT, I had patched it a bit to get it compile and 
used it. But it's too old, and a bit buggy, it's still using loads of 
hci calls, and I agree with Marcel idea of not using hci calls outside 
from hcid.

Cheers,
Manuel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
