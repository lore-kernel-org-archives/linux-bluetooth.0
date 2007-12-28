Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: Olivier Le Pogam <olepogam@free.fr>,
	BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <003c01c84945$64d21600$0200a8c0@jester>
References: <359782e70712230600n7077ee15hcab67216b9e7c8b4@mail.gmail.com>
	<1198437472.8050.305.camel@aeonflux>
	<001001c84619$20f716d0$0200a8c0@jester>
	<1198493046.8050.311.camel@aeonflux>
	<000601c84639$c8ef8640$0200a8c0@jester>
	<1198556761.8050.329.camel@aeonflux>
	<003c01c84945$64d21600$0200a8c0@jester>
Date: Fri, 28 Dec 2007 20:21:01 +0100
Message-Id: <1198869661.4455.21.camel@aeonflux>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Add 3 HCI commands / concurrent connection
	setup	question
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

Hi Olivier,

> > However you should read the radio and baseband part of the Bluetooth
> > specification and then you will realize that AFH will not help you to
> > solve any page issues you see. It simply doesn't work this way and
> > Bluetooth is _not_ WiFi.
> 
> I have read the specs and unfortunately certainly missed the reason why it 
> won't work, since AFH makes paging restricted to the provided frequency 
> range (not inquiry, but paging). However if you think trying this out is a 
> waste of time and won't help, I will follow you.
> 
> > We try with the next connection attempt once the radio is free again.
> > And this is if no inquiry and no page attempt is running.
> 
> All of this is perfectly clear, however, there is something I don't get 
> here. Why in the case I try to setup 4 connections from 4 different devices 
> I still get delays (or page timeouts), as they all have their own radio. If 
> it's not a radio issue, I thought about interferences (so wondering about 
> AFH use). I suppose locks in the stack are anyway "per device".

the design of AFH is to help _other_ 2.4 GHz radios to survive while
Bluetooth is active in the same area. It is not meant to protect it
against its own technology. The basics behind AFH is too play nice with
WiFi networks in the same area. That's it.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
