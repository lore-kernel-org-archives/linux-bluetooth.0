Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <4885B849.7040201@wurmsdobler.org>
References: <4885B849.7040201@wurmsdobler.org>
Date: Tue, 22 Jul 2008 14:45:52 +0200
Message-Id: <1216730752.31819.28.camel@californication>
Mime-Version: 1.0
Subject: Re: [Bluez-users] #define OGF_TESTING_CMD potentially wrong?
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

Hi Peter,

> a few days ago I posted a message concerning testing, i.e. on how to put 
> a Bluetooth module into the test modes specified in the Bluetooth 
> specification Core 2.1 (27.07.2007) using:
> 
> 	hcitool cmd <OGF> <OCF> [params]
> 
> In concrete I was interested in HCI_Write_Loopback_Mode and 
> HCI_Enable_Device_Under_Test_Mode, for which OCF are defined as 0x0002 
> and 0x0003, respectively. OGF is defined as 0x06 in the specification.
> 
> hcitool delivers the command at the bluetooth module. However, hcidump, 
> which uses #defines and tables from bluez-libs, resolves this commands 
> as Unknown, as it would defined in include/hci.h
> 
> #define OGF_TESTING_CMD 0x3e
> 
> If I used OGF=0x3e in the above hcitool command, hcidump would resolve 
> the string correctly, but the bluetooth module would not do what it was 
> told to do.
> 
> To me it appears that the #define in hci.h is potentially wrong, or 
> maybe refers to an older version of the specification, when testing 
> might have been vendor specific.

that hcidump shows something as unknown, doesn't mean that it didn't
work. Actually hcidump is only a passive tool like tcpdump. So feel free
to send a patch to fix hcidump, but this doesn't mean that hcitool is
not working.

Regards

Marcel



-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
