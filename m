Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <79b36674-39ec-8d96-8515-4c0ef79e45ee@gmx.net>
References: <79b36674-39ec-8d96-8515-4c0ef79e45ee@gmx.net>
From: Ahmed Alsharif <ahmeds2000x@gmail.com>
Date: Mon, 1 Jan 2018 02:41:19 +0100
Message-ID: <CAHU4CU+PBowrTEqahB_BJWi=E0PuhFGscpD+e68ZUBakOFzCcQ@mail.gmail.com>
Subject: Re: A2DP: simple-agent vs bluetoothctl
To: mortadelo@gmx-topmail.de
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Dec 31, 2017 11:44, <mortadelo@gmx-topmail.de> wrote:
>
> Hi,
>
> I'm currently playing with A2DP in Raspbian Stretch (i.e. Bluez
> 5.43-2+rpt2+deb9u2). I understand that there has been an architectural
> rework in BT pairing, connetion acceptance etc. handling. Whereas in
> earlier versions of BlueZ, the script 'simple-agent' was provided for a
> scripted (possibly unattended) pairing and connection handling, this
> script is no more available. 'bluetoothctl' is the actual replacement.
>
> ....
>
> What is the current philosophy behind pairing and connection management?
> Is 'simple-agent' still supposed to work, and I'm using it wrong, or is
> 'bluetoothctl' the way to go? If the latter, will it ever be scriptable?
>
>
> Thanks and kind regards, Michael

Hi,

You can use bluetoothctl non-interactively in the following way:

#  $ bluetoothctl << __EOL__
#  > connect xx:xx:xx:xx:xx:xx
#  > __EOL__

connect and trust seem to work fine this way, but pair doesn't. If
you're okay with using python, checkout this library:
https://github.com/nullp0tr/bluew. I'm also planning to add a
non-interactive bluetoothctl alternative to it, but you can easily
write a 3 liner with it that does what you need (disclaimer: I wrote
it).

> My problem with 'bluetoothctl' is that, due to its interactive
> character, it is hard to impossible to use in scripts. 'simple-agent'
> (the previous version), however, seems to have become somewhat
> unpredictable in current Bluez. I haven't managed to implement a
> consistent and predictable flow of pairing -set trust - connect anymore
> with 'simple-agent'. Typically (but not consistently), the pairing would
> not be set to 'Trusted=true'.

Overall simple-agent should still work. Examples/code snippets of your
current 'flow', and the errors returned would help in finding the
problem.


Cheers,
Ahmed Alsharif.
