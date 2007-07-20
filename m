Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Mats Erik Andersson <mats.andersson64@comhem.se>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <cfd8c35a0707190551j1972892co4a2e2f2961f0623b@mail.gmail.com>
References: <cfd8c35a0707190551j1972892co4a2e2f2961f0623b@mail.gmail.com>
Date: Fri, 20 Jul 2007 10:53:52 +0200
Message-Id: <1184921632.3755.2.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Computer not visible to other devices.
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

Hello there.

Probably same solution as last week: Add an entry

	discoverto 0;

to the device section of your hcid.conf and reread the
configuration by issuing "sudo killall -HUP hcid".

Good luck	Mats E A


tor 2007-07-19 klockan 14:51 +0200 skrev Adrian van Dongen:
> Hi
> 
> I installed a new clean debian system and the problem I had before is
> gone now ( I can connect to my mobile now). This is a other hardware
> set so I don't know if it due to the install or the hardware. I will
> see what i can find out. 
> 
> I do have a small other problem now, my new computer is not visible to
> other bluetooth devices... what could be  wrong ? 
> 
> I read something about iscan en pscan both being enable but this not
> the case in the new install: 
> 
> hci0:   Type: USB
>         BD Address: 00:10:60:A9:10:28 ACL MTU: 192:8 SCO MTU: 64:8
>         UP RUNNING PSCAN
>         RX bytes:820 acl:0 sco:0 events:34 errors:0 
>         TX bytes:614 acl:0 sco:0 commands:28 errors:0
> 
> can I force iscan to? I do have it enabled in the configuration.
> 
> Regards,
> 
> Adrian.
> 
> 
> -------------------------------------------------------------------------
> This SF.net email is sponsored by DB2 Express
> Download DB2 Express C - the FREE version of DB2 express and take
> control of your XML. No limits. Just data. Click to get it now.
> http://sourceforge.net/powerbar/db2/
> _______________________________________________ Bluez-users mailing list Bluez-users@lists.sourceforge.net https://lists.sourceforge.net/lists/listinfo/bluez-users

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
