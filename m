Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <420105F0.5030407@tootai.net>
From: administrator tootai <admin@tootai.net>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Re: Connection issue with headset
References: <41FA06A5.3010904@tootai.net> <ctdn6n$sqs$1@sea.gmane.org> <41FE4744.5010804@tootai.net> <ctob73$ph0$1@sea.gmane.org> <4200D3B6.1050708@tootai.net> <ctqulk$ce4$1@sea.gmane.org>
In-Reply-To: <ctqulk$ce4$1@sea.gmane.org>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
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
Date: Wed, 02 Feb 2005 17:55:12 +0100

Sebastian Roth a =E9crit :

> Hi Daniel,

Hi Sebastian

>> Did not help. I made following:
>>
>> - modprobe snd-bt-sco
>
> are the other things build into the kernel or loaded? (bluetooth,
> hci_usb, l2cap, rfcomm, sco)

all in modules

> [...]
> =20
> Maybe it's working when switching it on half the way but IMO that's no
> good idea.

As the other way it wasn't working, I tried like this ;-)

>
> - load all necessary modules
> - start hcid
> - check if all is up (hciconfig)
> - switch on your headset (normal mode)
> - make sure you have the correct address!!
> - btsco <hwaddr>
> - wait for "RFCOMM channel X connected"
> - press the headset button
> - you should see some more messages now (have a look at my output below=
)
>
> btsco <hwaddr>
> Device is 1:0
> Voice setting: 0x0060
> RFCOMM channel 1 connected    # press headset button

Till here is ok. What is below I haven't :-(

>
> recieved AT+CKPD=3D200
> opened hwdep
> connected SCO channel
> Setting sco fd
> Done setting sco fd
> recieved AT+VGS=3D01
> Sending up speaker change 1    # now you should hear a static noise
> recieved AT+CKPD=3D200        # press button to stop it
> disconnected SCO channel
> recieved AT+VGS=3D01        # canceled btsco with ^C
> Sending up speaker change 1
>
>
> When I've pressed the button to start the sound I can see a lot of SCO
> data in the output of hcidump. You too?

Nothing

>
>
> If you followed this and it does not work I have two ideas.
> 1. Is it possible that your headset does not send any AT commands
> over the connected RFCOMM channel? As far as I know btsco will never
> try to establish an SCO connection without having recived the cmd
> from your headset.

 From what I check nowhere I saw any AT command. That exactly what I'm=20
looking for!

> 2. The headset is sending "other" commands when pressing the headset
> button. Same effect as 1.
>
> Please have a look at hcidump -x to see if your headset is sending such
> a command when pressing the button!

No information shown by hcidump after pressing the button. It stays at=20
the same point that btsco command. Nothing more. So this mean that my=20
headset is "specific" (brend is HAMA BT-1000 Bluetooth 2,4 Gh v1.1) and=20
don't work with the bluez-utils?

Many thanks for your help
--=20
Daniel


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
