Return-Path: <cyrus@holtmann.org>
Message-Id: <261228FD-F5FF-4D64-9D65-FC873DF95F9F@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <d89ddf300802241225l1a352768x94afccdc2b120be6@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v919.2)
Date: Mon, 25 Feb 2008 02:29:13 +0100
References: <1203815399.8021.10.camel@pc.ilinx>
	<d89ddf300802241225l1a352768x94afccdc2b120be6@mail.gmail.com>
Subject: Re: [Bluez-users] hci_scodata_packet: hci0 SCO packet for unknown
	connection handle 1
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

Hi Brad,

>> I follow the steps in http://wiki.bluez.org/wiki/HOWTO/AudioDevices
>> Feb 23 20:06:37 pc kernel: [20254.788127] hci_scodata_packet: hci0  
>> SCO packet for unknown connection handle 1
>
> I've added the kernel patch that is supposed to handle this problem to
> the end of the wiki page. Please let us know if it helps. It's
> ostensibly going to be an issue if you have a bluetooth adapter
> capable of esco but your headset is not.

the patch you sent me is fully broken. First of all the coding style  
is wrong. Does nobody have learned this by now? I always look for that  
first before even reading the patch. Second the case where an  
ESCO_LINK returns NULL is broken and will fall over and crash.

Regards

Marcel


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
