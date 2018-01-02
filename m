Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <27274c2e-4558-3a27-5fc8-e09b9eae9ad4@gmx.net>
References: <79b36674-39ec-8d96-8515-4c0ef79e45ee@gmx.net> <CAHU4CU+PBowrTEqahB_BJWi=E0PuhFGscpD+e68ZUBakOFzCcQ@mail.gmail.com>
 <27274c2e-4558-3a27-5fc8-e09b9eae9ad4@gmx.net>
From: Ahmed Alsharif <ahmeds2000x@gmail.com>
Date: Tue, 2 Jan 2018 04:10:06 +0100
Message-ID: <CAHU4CUJVSpdSqct4Cpc7Ko9PnMs9RH=K0ZkM7Y4EQzqToJELSw@mail.gmail.com>
Subject: Re: A2DP: simple-agent vs bluetoothctl
To: mortadelo@gmx-topmail.de
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

> This setup used to work more or less flawlessly with Raspbian Jessie.
> With Stretch, however, I'm seeing a variety of behaviors from "pairing
> rejected" over "paired, but not trusted" to "working OK" (rare). This
> inconsistent behavior lets me believe that the BT device is missing
> initialization into a predictable state (pairable, discoverable, any
> other?) before the script is called. I'm currently playing with explicit
> initialization sequences using 'bluetoothctl', but I'm also wondering
> how this used to work with Raspbian Jessie before.

>From what I can tell raspbian jessie had bluez-5.23, try downgrading
to it from your current version, either by installing the exact
version from your package manager, or by cloning the bluez repository,
checking out the commit from that release ,building, and then running
it. That way you can tell whether it's the newer versions of bluez
that are causing the issue.

>
> The most common behavior is "paired, but not trusted", which yields the
> following errors in syslog:
> Jan  1 12:40:53 Raspi-2 bluetoothd[615]: Authentication attempt without
> agent

Are you using the exact simple-agent script you attached or a
variation of it? the one you attached seems to be registering an
agent, whereas this is saying it isn't.
