Return-Path: <cyrus@holtmann.org>
Message-ID: <5a4e8eadcfd668fabdcd350e63a65308.squirrel@iwavesystems.com>
In-Reply-To: <237bbd312054ce6433af002f5e1213c7.squirrel@iwavesystems.com>
References: <237bbd312054ce6433af002f5e1213c7.squirrel@iwavesystems.com>
Date: Wed, 2 Sep 2015 08:24:41 -0400
Subject: Re: StartLescan rerturns false
From: krishnaks@iwavesystems.com
To: linux-bluetooth@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I have ported bluez to Android Kitkat 4.4.3 and I am testing Bluetooth Low
energy from android application.
BluetoothAdapter's method startLeScan returns false during scanning BLE
devices.
register-client method is getting called in hal-gatt.c. But looks like
"scanStarted" function is returning false.

Have anyone faced this issue.

Thanks in advance
KP

