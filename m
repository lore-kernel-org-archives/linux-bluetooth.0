Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: =?koi8-r?B?8tXTzMHOIOvV2tjNyc4=?= <kuzminruslan@icloud.com>
Content-type: text/plain; charset=us-ascii
MIME-version: 1.0 (1.0)
Date: Mon, 13 Nov 2017 11:44:27 +0300
Subject: How connect two headphones two Bluez5
Message-id: <26467B30-3820-4CBF-98DB-DC7CAF669A73@icloud.com>
To: linux-bluetooth@vger.kernel.org
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Excuse me for my English.I am developer.My task connect two Bluetooth headph=
ones to one Bluetooth adapter.I know in Windows and in bluez4 this feature w=
orked.In bluez5 in connection with pulseaudio created only one virtual A2DP s=
peaker.
Long time I am searched reason in pulseaudio (more precisely in pulseaudio s=
ources) but how I knowed what dbus send from bluez to pulseaudio command Cle=
arConfiguration when I am trying connect second headphone. I want to know wh=
ere in sources of bluez5 limited count of working A2DP profiles.May I am wri=
te self hook for pulseaudio for two Bluetooth A2DP headphones?
Best regards,Ruslan=
