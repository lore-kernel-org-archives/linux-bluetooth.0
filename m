Return-Path: <linux-bluetooth-owner@vger.kernel.org>
To: linux-bluetooth@vger.kernel.org
From: mortadelo@gmx-topmail.de
Subject: A2DP: simple-agent vs bluetoothctl
Message-ID: <79b36674-39ec-8d96-8515-4c0ef79e45ee@gmx.net>
Date: Sun, 31 Dec 2017 11:44:40 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I'm currently playing with A2DP in Raspbian Stretch (i.e. Bluez
5.43-2+rpt2+deb9u2). I understand that there has been an architectural
rework in BT pairing, connetion acceptance etc. handling. Whereas in
earlier versions of BlueZ, the script 'simple-agent' was provided for a
scripted (possibly unattended) pairing and connection handling, this
script is no more available. 'bluetoothctl' is the actual replacement.

My problem with 'bluetoothctl' is that, due to its interactive
character, it is hard to impossible to use in scripts. 'simple-agent'
(the previous version), however, seems to have become somewhat
unpredictable in current Bluez. I haven't managed to implement a
consistent and predictable flow of pairing -set trust - connect anymore
with 'simple-agent'. Typically (but not consistently), the pairing would
not be set to 'Trusted=true'.

What is the current philosophy behind pairing and connection management?
Is 'simple-agent' still supposed to work, and I'm using it wrong, or is
'bluetoothctl' the way to go? If the latter, will it ever be scriptable?


Thanks and kind regards, Michael




