Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Alex Blasche <alexander.blasche@qt.io>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Runtime retrieval of bluetoothd version
Date: Wed, 1 Nov 2017 11:07:33 +0000
Message-ID: <AM4PR0201MB2196BB85B60661BDEA615EFEE75F0@AM4PR0201MB2196.eurprd02.prod.outlook.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Is there a way to retrieve the version of bluetoothd runtime?

Why is this necessary? Most bluetoothd versions add new or experimental DBu=
s API's (in particular in the LE domain). However most of those interfaces/=
APIs do not turn up until later because they are dynamically added when dev=
ices appear. Since it is possible to work around missing BTLE DBus APIs usi=
ng hci et al it would be nice to retrieve the bluetoothd version at runtime=
 to match against a map of available non-experimental API per bluetoothd ve=
rsion. After all it is kind of hard to wait for never appearing BTLE interf=
aces due to using old Bluez/bluetoothd versions.

The only reliable way I have seen so far is bluetoothd --version which assu=
mes that one knows where bluetoothd is located. At least in source I could =
not find any other way.

Thank you.

--
Alex=
