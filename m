Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 20 May 2016 17:36:45 +0300
Message-ID: <CABBYNZ+_bjxAgk6r3xahXjfG4CuUdzipKksX5dwOARBMDZ5ykw@mail.gmail.com>
Subject: GATT service blacklist
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

In Web Bluetooth there is a list of blacklisted attributes that may
leak some important information:

https://github.com/WebBluetoothCG/registries/blob/master/gatt_blacklist.txt

Currently we don't support claiming attribute, which is what in the
end prevent a service to be exposed, so I would like to know the
opinion about having such a feature noting that this may lead to
conflicts such as plugins and application accessing the same
attributes which may or may not interfere.

One of the service that web guys would like to access is GAP service
which is something BlueZ don't actually let them do since there is a
plugin accessing it, and given its name we can probably except changes
on every new Bluetooth release making me wary about exposing its
attributes over D-Bus.


-- 
Luiz Augusto von Dentz
