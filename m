Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: Olivier Le Pogam <olepogam@free.fr>,
	BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <000601c84639$c8ef8640$0200a8c0@jester>
References: <359782e70712230600n7077ee15hcab67216b9e7c8b4@mail.gmail.com>
	<1198437472.8050.305.camel@aeonflux>
	<001001c84619$20f716d0$0200a8c0@jester>
	<1198493046.8050.311.camel@aeonflux>
	<000601c84639$c8ef8640$0200a8c0@jester>
Date: Tue, 25 Dec 2007 05:26:01 +0100
Message-Id: <1198556761.8050.329.camel@aeonflux>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Add 3 HCI commands / concurrent connections	setup
	question
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

> >> I'd like to add : Set_AFH_Host_Channel_Classification (OCF 0x003F),
> >> Read_AFH_Channel_Assessment_Mode (OCF 0x0048) and
> >> Write_AFH_Channel_Assessment_Mode (OCF 0x0049) to the supported HCI 
> >> commands
> > what do you wanna do with these commands? More important is, what do you
> > expect what is gonna happen if you use them?
> 
> You are perfectly right I should have started with this. I have several 
> bluetooth dongles and my idea was to split the frequency range between these 
> devices so each one have his proper range and does not overlap with others, 
> to limit interferences.
> This is in the case the host is a master and tries to connect to several 
> remote devices so there can be concurrent outgoing page scans from different 
> dongles.
> However, I realize now that maybe this HCI command is not implemented on 
> device chips, so I will maybe have a look first ... no need to implement a 
> command which is not supported by any hardware. By the way, don't hesitate 
> to tell me if my idea does not make sense at all.

all Bluetooth 1.2 dongles have to support AFH and thus these commands
have to be present.

However you should read the radio and baseband part of the Bluetooth
specification and then you will realize that AFH will not help you to
solve any page issues you see. It simply doesn't work this way and
Bluetooth is _not_ WiFi.

> I have something to ask as well ... With CSR's chips trying to open 
> concurrent connections makes the first work and others get a "Command 
> Disallowed". Then I saw with hcidump that the "Create Connection" is 
> re-issued automatically. However, it can be really later sometimes (more 
> than several seconds). My question is : how connection requests are 
> serialized by the stack ? would it be possible to make the connection 
> requests be retried more quickly ? Is there something blocking that would 
> explain why it's long ?

We try with the next connection attempt once the radio is free again.
And this is if no inquiry and no page attempt is running.

> Here is a dump of trying to connect to 7 different devices concurrently, 
> with a CSR bases dongle ("connect" are performed at the same time, then a 
> "sleep 10 seconds", and a "close"). As you can see, times are really ... 
> long !
> 
> 1st device : 1.3 seconds to come back successfully from "connect" socket
> 2nd device : 5.5 seconds
> 3rd device : 9.9 seconds
> 4th device : 10.9 seconds
> 5th device : 13 seconds
> 6th device : 18.3 seconds
> 7th device : 19.8 seconds

For every page the slave device has to sync with the master clock
(assuming that none of the remote device request a role switch). This
can take some time and at that point the clock_offset from the inquiry
result might be out of sync. So it is simply plain bad luck.

On the other hand the concurrent page support is more than a workaround
for the application to not to have to bother. If the radio/baseband is
busy, then it is busy.

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
