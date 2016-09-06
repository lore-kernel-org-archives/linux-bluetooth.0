Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <04AC5786-517A-4834-AFD7-B0C6AC29B869@gmail.com>
References: <04AC5786-517A-4834-AFD7-B0C6AC29B869@gmail.com>
From: Tobias Svehagen <tobias.svehagen@gmail.com>
Date: Tue, 6 Sep 2016 22:53:37 +0200
Message-ID: <CADwkJjLm5RF54MHANHYUX3cmh52V4EgHB57hrMu4oXeOA6bR3Q@mail.gmail.com>
Subject: Re: Query BLE connected status?
To: Travis Griggs <travisgriggs@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Travis,

There is a Connected property on the org.bluez.Device1 interface (see
http://git.kernel.org/cgit/bluetooth/bluez.git/tree/doc/device-api.txt).
This will tell you if that specific device is connected or not. Would
this solve your problem?

Regards,
Tobias
