Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Re: A2DP: simple-agent vs bluetoothctl
To: Ahmed Alsharif <ahmeds2000x@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
References: <79b36674-39ec-8d96-8515-4c0ef79e45ee@gmx.net>
 <CAHU4CU+PBowrTEqahB_BJWi=E0PuhFGscpD+e68ZUBakOFzCcQ@mail.gmail.com>
 <27274c2e-4558-3a27-5fc8-e09b9eae9ad4@gmx.net>
 <CAHU4CUJVSpdSqct4Cpc7Ko9PnMs9RH=K0ZkM7Y4EQzqToJELSw@mail.gmail.com>
From: mortadelo@gmx-topmail.de
Message-ID: <f3a7f5a0-1b0c-21b6-a6be-4d552c713151@gmx.net>
Date: Tue, 2 Jan 2018 12:02:00 +0100
MIME-Version: 1.0
In-Reply-To: <CAHU4CUJVSpdSqct4Cpc7Ko9PnMs9RH=K0ZkM7Y4EQzqToJELSw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ahmed,

Please se my answers inline.

Thanks, Michael

Am 02.01.2018 um 04:10 schrieb Ahmed Alsharif:
>> This setup used to work more or less flawlessly with Raspbian Jessie.
>> With Stretch, however, I'm seeing a variety of behaviors from "pairing
>> rejected" over "paired, but not trusted" to "working OK" (rare). This
>> inconsistent behavior lets me believe that the BT device is missing
>> initialization into a predictable state (pairable, discoverable, any
>> other?) before the script is called. I'm currently playing with explicit
>> initialization sequences using 'bluetoothctl', but I'm also wondering
>> how this used to work with Raspbian Jessie before.
> From what I can tell raspbian jessie had bluez-5.23, try downgrading
> to it from your current version, either by installing the exact
> version from your package manager, or by cloning the bluez repository,
> checking out the commit from that release ,building, and then running
> it. That way you can tell whether it's the newer versions of bluez
> that are causing the issue.

I was finally able to isolate and address the problem(s). It was
actually a coincidence of several factors:
- Missing initialization of the BT device (as I already suspected):
It ws a matter of luck whether the device was in pairing mode or not.
I'm still wondering how this worked in the former Raspbian Jessie setup
(which isn't available anymore to me).

- Timing/synchronization issue:
'simple-agent' was/is started from within '.profile'of the 'pi' user
which - in turn - is automatically logged in / started at boot by the
system. I realize that 'bluetoothd' takes some 30 secs after boot to
become operational (on my Raspberry Pi 1). If I try to pair before, it
fails. This also explains why (this part of) the problem didn't show up
when I manually started the script from within the booted system.

- Missing status output of 'simple-agent' in autostart mode:
When 'simple-agent'is started from '.profile', whose console - in turn -
is auto-started when the system boots, its status oupt put (e.g. 'Agent
registered') is not visible. This makes debugging more challenging...


I have fixed the problem by initializing the BT device via a bash script
which calls 'bluetoothctl - power on - discoverable on - pairable on' in
the way how you told me (here document). This bash script is called in
'.profile' before 'simple-agent'is called, which has the pleasant
side-effect that the bash script (i.e. 'bluetoothctl') waits for
'bluetoothd' to become operational. So I'm getting an implicit
synchronization.
>> The most common behavior is "paired, but not trusted", which yields the
>> following errors in syslog:
>> Jan  1 12:40:53 Raspi-2 bluetoothd[615]: Authentication attempt without
>> agent
> Are you using the exact simple-agent script you attached or a
> variation of it? the one you attached seems to be registering an
> agent, whereas this is saying it isn't.
Now obsolete.
