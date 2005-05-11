Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] rfcomm - multiple connections to 1 pocketPC from
	2 seperate bluetooth-dongles
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <003c01c555b5$31b193d0$8300a8c0@priveiqvfluhp9>
References: <003c01c555b5$31b193d0$8300a8c0@priveiqvfluhp9>
Content-Type: text/plain
Message-Id: <1115805412.11503.22.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 11 May 2005 11:56:52 +0200

Hi Pieter,

> I'm using rfcomm 2.15 to make a connection from Linux to a 
> PocketPc(00:04:3E:68:3C:6B). I can do this for one connection. But when I 
> plug in a second bluetooth-dongle in my linuxPC, I can't establish a second 
> rfcomm connection with the same PocketPc.
> 
> Scenario 1:
> BT1 ------- PocketPC  : ok
> channel0
> 
> Scenario 2:
> BT2 ------- PocketPC   : ok
> channel1
> 
> Scenario 3: not ok
> 
> channel0
> BT1 ----------|
>                        |
>                     PocketPC
>                        |
> BT2 ----------|
> channel1
> 
> Someone tried this?

first you need to separate the two rfcomm calls and tell them what
dongle should they use.

	rfcomm -i hci0 connect rfcomm0 <bdaddr> <channel>
	rfcomm -i hci1 connect rfcomm1 <bdaddr> <channel>

Now you may have the problem that the pocket PC is not capable of
dealing with scatternets (as Brad said) or you can't connect to the same
RFCOMM channel twice.

For the scatternet part you should check with "hcitool info" as root
what kind of chip is in that PocketPC. For the double channel problem,
there might be no choice if it does not offer two serial profiles. Of
course you can try to use the dialup profile instead or write your own
application that runs on the PocketPC and provides you with two RFCOMM
channels for your special use.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
