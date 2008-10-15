Return-Path: <cyrus@holtmann.org>
Message-ID: <48F6301E.30607@powercraft.nl>
Date: Wed, 15 Oct 2008 20:02:06 +0200
From: Jelle de Jong <jelledejong@powercraft.nl>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <48F1F7C0.4040705@powercraft.nl>	<1223819361.31961.1763.camel@cookie.hadess.net>	<48F5E741.7020907@powercraft.nl>	<1224078893.5268.2962.camel@cookie.hadess.net>	<1224083365.5268.3130.camel@cookie.hadess.net>
	<1224083803.4764.8.camel@californication>
In-Reply-To: <1224083803.4764.8.camel@californication>
Subject: Re: [Bluez-devel] [PATCH] Re:  Sony Bluetooth BD Remote Control
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

Marcel Holtmann wrote:
> Hi Bastien,
> 
>>>> I have been working hard to get the bluetooth remote working, but
>>>> without success. I build new non official debian packages of the latest
>>>> git. I installed them with success. Loaded the new daemon tried to
>>>> connect with the bluetooth-wizard but it will not pair/connect. With the
>>>> hidd system is does connect but the situation is exactly the same as
>>>> with the ordinal report.
>>>>
>>>> What commands are needed to get the device working? I would like to be
>>>> able to use xbindings --key to attach commands/keybindings to the keys.
>>>>
>>>> See the attachment for all the steps I did, the new trials are on the
>>>> end of the documents.
>>> I mentioned it in the past, I'll mention it again: DO NOT USE HIDD.
>>>
>>> It doesn't have support for the PS3 BD remote. Make sure you have the
>>> latest git, I fixed the input event generation for the remote yesterday.
>> As it's just the pairing that doesn't work, the bug was in the wizard.
>> The code to restrict the PS3 detection to a particular OUI was causing
>> problems.
> 
> I added the extra OUI. Thanks.
> 
> Regards
> 
> Marcel
> 

Thank you all for the patches and the support, after rebuilding
everything and trying things out. The bluetooth-applet wizzard system
tolled me it connected successfully. See the log below.

However how can I know actually use the device? I tried xbindings --key
to catch a key and bind it to something useful. I feel like I am back to
point one with the old hidd system...

bluetoothd[10832]: Discovery session 0xb9409040 with :1.8 activated
bluetoothd[10832]: session_ref(0xb9409040): ref=1
bluetoothd[10832]: session_unref(0xb9409040): ref=0
bluetoothd[10832]: Discovery session 0xb9409040 with :1.8 deactivated
bluetoothd[10832]: Stopping discovery
bluetoothd[10832]: create_device(00:1E:3D:15:0A:4F)
bluetoothd[10832]: Creating device /org/bluez/hci0/dev_00_1E_3D_15_0A_4F
bluetoothd[10832]: adapter_get_device(00:1E:3D:15:0A:4F)
bluetoothd[10832]: Probe drivers for /org/bluez/hci0/dev_00_1E_3D_15_0A_4F
bluetoothd[10832]: hid_device_probe: path
/org/bluez/hci0/dev_00_1E_3D_15_0A_4F
bluetoothd[10832]: Registered interface org.bluez.Input on path
/org/bluez/hci0/dev_00_1E_3D_15_0A_4F

Best regards,

Jelle

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
