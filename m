Return-Path: <cyrus@holtmann.org>
Message-Id: <F0024931-2A53-4DD6-B8FF-0314A26BD1D6@gmail.com>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <89b6ba3a0810191006y1687b30ap6adb8354389dd7d@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v929.2)
Date: Sun, 19 Oct 2008 20:16:46 +0300
References: <mailman.81198.1224358186.3608.bluez-users@lists.sourceforge.net>
	<89b6ba3a0810181248u29129a09v50c7befde6741e5b@mail.gmail.com>
	<48FA49A4.9040908@powercraft.nl>
	<89b6ba3a0810190855g2aa8bd00v9fe2c782fe5efb3e@mail.gmail.com>
	<89b6ba3a0810190909l69688cb9n13c8000ca272767@mail.gmail.com>
	<4AA04BF6-26EE-488D-A22C-37855410E2F7@gmail.com>
	<89b6ba3a0810190954q3826a2a8i4c8087e3d43cf45d@mail.gmail.com>
	<89b6ba3a0810191006y1687b30ap6adb8354389dd7d@mail.gmail.com>
Subject: Re: [Bluez-devel] [Bluez-users] Motorola S9 and BlueZ 4.14
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
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi,

On Oct 19, 2008, at 20:06, Patryk Zawadzki wrote:
> bluetoothd[24705]: Audio API: sending BT_STREAMSTART_RSP
> bluetoothd[24705]: Audio API: sending BT_STREAMFD_IND
> bluetoothd[24705]: setup_unref(0xb9c67a70): ref=1
> bluetoothd[24705]: setup_unref(0xb9c67a70): ref=0
> bluetoothd[24705]: setup_free(0xb9c67a70)
> bluetoothd[24705]: avdtp_unref(0xb9c5d468): ref=3
> DEBUG: trying to change stream state from 3 to 3
> bluetoothd[24705]: stream state change failed: Input/output error

Could you give some more info of what events triggered this than just  
these few lines? Also, if possible come to #bluez on freenode.net so  
we can discuss this in more detail there.

Johan

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
