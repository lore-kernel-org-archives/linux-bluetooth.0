Return-Path: <cyrus@holtmann.org>
Message-ID: <479346D7.1080500@gmx.net>
Date: Sun, 20 Jan 2008 14:04:23 +0100
From: Gunnar Thielebein <gunnar_thielebein@gmx.net>
MIME-Version: 1.0
To: Bluez-users@lists.sourceforge.net
References: <47928635.2030400@gmx.net>
	<d89ddf300801192041o12e98ee7ybeeb28efb2fdfa1d@mail.gmail.com>
In-Reply-To: <d89ddf300801192041o12e98ee7ybeeb28efb2fdfa1d@mail.gmail.com>
Subject: Re: [Bluez-users] audio bluetooth connectivity in gutsy
Reply-To: gunnar_thielebein@gmx.net,
	BlueZ users <bluez-users@lists.sourceforge.net>
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

Heres my hcid.conf (comments stripped):

options {
        autoinit yes;
        security auto;
        pairing multi;
        passkey "0000"; # pw for headset pairing
}

device {
        name "%h-%d";
        class 0x000100;
        iscan enable; pscan enable;
        lm master;
        lp rswitch,hold,sniff,park;
}

.asoundrc:

pcm.bluetooth {
   type bluetooth
   device 00:12:EE:18:95:CA
}

I had my other soundcard in use could that cause problems in some cases?
I want to use the sco part of bt-audio so the test with mplayer was only 
for checking if it works in general.
later on I would like to use linphone with it.

This is output of hciconfig:

hci0:   Type: USB
        BD Address: 00:0B:0D:20:FE:15 ACL MTU: 339:4 SCO MTU: 0:0
        UP RUNNING PSCAN
        RX bytes:996 acl:0 sco:0 events:25 errors:0
        TX bytes:596 acl:0 sco:0 commands:24 errors:0
        Features: 0xff 0xff 0x3d 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: MASTER
        Name: 'knallbuntu-0knallbuntu-0'
        Class: 0x080104
        Service Classes: Capturing
        Device Class: Computer, Desktop workstation
        HCI Ver: 1.1 (0x1) HCI Rev: 0x93 LMP Ver: 1.1 (0x1) LMP Subver: 0x93
        Manufacturer: Transilica, Inc. (24)

hci0:   Type: USB
        BD Address: 00:0B:0D:20:FE:15 ACL MTU: 339:4 SCO MTU: 0:0
        Unsupported manufacturer

Brad Midgley schrieb:
> Gunnar
>
> I'd be most suspect of the microtune dongle. It would tell us more if you ran:
>
> hciconfig -a;sudo hciconfig hci0 revision
>
> Brad
>
> On Jan 19, 2008 4:22 PM, Gunnar Thielebein <gunnar_thielebein@gmx.net> wrote:
>   
>> Hi group,
>>
>> I am trying to connect my headset in gutsy with default kernel
>> 2.6.22-14-generic. I tried all four(?) possible solutions: old sco way,
>> plugz, bluetooth-alsa (at least the package in gutsy) and bluez-audio
>> which all ends finally with a hardlock of my system when the connection
>> was established with headset.
>>
>> Authentication and sdp browsing works fine at least in kde.
>>
>> I tested sound play with smplayer,mplayer,aplay,play.
>>
>> I also tested with the unstable packages from sid libbluez, bluez-
>> bluez-audio, gstreamer-plugins
>>
>> Could you tell if I need a more current kernel version than 22?
>> Or is it something with my hardware?
>>
>> my hardware spec:
>>
>> Headset: HBH-PV700
>> ---
>> Dongle: Bus 001 Device 003: ID 0f4d:1000 Microtune, Inc. Bluetooth Dongle
>> ---
>> arch: amd64 - 2.6.22-14-generic #1 SMP Tue Dec 18 05:28:27 UTC 2007
>> x86_64 GNU/Linux
>>
>> -------------------------------------------------------------------------
>> This SF.net email is sponsored by: Microsoft
>> Defy all challenges. Microsoft(R) Visual Studio 2008.
>> http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
>> _______________________________________________
>> Bluez-users mailing list
>> Bluez-users@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/bluez-users
>>
>>     
>
>
>
>   


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
