Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Tue, 13 May 2014 16:00:42 +0200
Message-ID: <CAOb4fKcq6R4PTo_m0j+e09hgkKj2nSizWd8_8j340pV-CrXAJg@mail.gmail.com>
Subject: External Bluez plugin and GATT profile
From: =?UTF-8?B?SsOhbiBMYWxpxaE=?= <lalis.jan@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I want to create external plugin for Bluez where I create custom GATT
profile. I created plugin without problems, but problem is with
creating custom profile using function gatt_service_add (I dont find
any other working solution in code for creating custom profile),
because this function is not exported as external function.

I know that there are some exported functions (with btd_ prefix) but
there is no example or documentation for how to use them and playing
with this functions give me no working result. Very simple example
will be good starting point for everyone, who want to start write
custom profile for BLE usign Bluez API.

Thanks for help,


Jan
