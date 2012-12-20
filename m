Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20121220093742.GA6548@x220>
References: <CAFOXTdcaRvGHesU_J7rW93Yp_5d438+x5xryCzAhY9QQL_-Y4Q@mail.gmail.com>
	<20121220080447.GA561@x220>
	<CAFOXTde8iSouGKEVZKG-egvPUr4LAyLnFigVa6avhpqTjXNq8A@mail.gmail.com>
	<20121220091943.GA5862@x220>
	<CAFOXTdf9qrtXD0GPDBFLhLX66QGQCgF_VzyS8WWz5xTAH8+0zQ@mail.gmail.com>
	<20121220093742.GA6548@x220>
Date: Thu, 20 Dec 2012 11:22:28 +0100
Message-ID: <CAFOXTden8JeVHe+SXKt7GeG+QXHP01Nku2ubQ_m88LxJ1ATUmg@mail.gmail.com>
Subject: Re: Authentication Rejected when pairing stereo headset
From: Andrey Voropaev <voropaev.andrey@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Dec 20, 2012 at 10:37 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> An quicker way for you to overcome the issue is to change the user space
> side pairing call to pass "DisplayYesNo" instead of "KeyboardDisplay" to
> BlueZ. I.e. edit the simple-agent script, find the (two) occurrences of
> "KeyboardDisplay" and change them to "DisplayYesNo" and try to pair
> again.

Thanks. This trick worked (though there was only 1 KeyboardDisplay).
I've paired the device and now hcitool con reports

Connections:
    < ACL 00:1A:7D:25:2C:A4 handle 43 state 1 lm MASTER AUTH ENCRYPT


And I get

hcitool info 00:1A:7D:25:2C:A4
Requesting information ...
    BD Address:  00:1A:7D:25:2C:A4
    OUI Company: cyber-blue(HK)Ltd (00-1A-7D)
    Device Name: BTH220
    LMP Version: 2.1 (0x4) LMP Subversion: 0x14fa
    Manufacturer: Cambridge Silicon Radio (10)
    Features page 0: 0xff 0xfe 0x0f 0xc6 0x8b 0xef 0x59 0x83
        <3-slot packets> <5-slot packets> <encryption> <slot offset>
        <timing accuracy> <role switch> <hold mode> <sniff mode>
        <RSSI> <channel quality> <SCO link> <HV2 packets>
        <HV3 packets> <u-law log> <A-law log> <CVSD> <paging scheme>
        <power control> <transparent SCO> <EDR ACL 2 Mbps>
        <EDR ACL 3 Mbps> <inquiry with RSSI> <extended SCO>
        <EV4 packets> <EV5 packets> <AFH cap. slave> <3-slot EDR ACL>
        <5-slot EDR ACL> <sniff subrating> <pause encryption>
        <AFH cap. master> <EDR eSCO 2 Mbps> <EDR eSCO 3 Mbps>
        <3-slot EDR eSCO> <extended inquiry> <simple pairing>
        <encapsulated PDU> <non-flush flag> <LSTO> <inquiry TX power>
        <extended features>
    Features page 1: 0x01 0x00 0x00 0x00 0x00 0x00 0x00 0x00

But seems like Alsa still does not see it. I've added

 pcm.bluetooth {
  type bluetooth
  device 00:1A:7D:25:2C:A4
  profile "auto"
 }


to /etc/asound.conf, restarted alsasound, but bluetooth does not show
up among available outputs. Well, I'm almost there. The Skype has
"bluetooth" in the list of devices and it works. Just mplayer does not
want to work with option

 -ao alsa:device=bluetooth


Probably there's some capabilities problem. Any advice here? :) Sorry ...
