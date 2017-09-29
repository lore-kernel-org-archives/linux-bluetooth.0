Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: Luca Capra <luca.capra@gmail.com>
Date: Fri, 29 Sep 2017 07:15:22 +0200
Message-ID: <CAAB86tDPUqKrJT9j6XyeAfjWKX50zCun9GJiLda1m2qwUJ6sJQ@mail.gmail.com>
Subject: Exposing a device for GATT services
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi
I am maintaining a golang library that interface to bluetooth Dbus API [1].
The client part is ok and I just finished a GATT API
application/server implementation based on the python example in test
folder.

I would like to be able to expose a device at that point to use those
GATT services, but cannot find a way.

Is it possible  o supposed to work that way?

Thanks

Regards
Luca


[1] https://github.com/muka/go-bluetooth
