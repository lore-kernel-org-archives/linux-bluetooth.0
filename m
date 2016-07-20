Return-Path: <linux-bluetooth-owner@vger.kernel.org>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
From: Marco Trapanese <marcotrapanese@gmail.com>
Subject: AVRCP: player object path
Message-ID: <6b556d8b-b0ee-543f-2ca1-0ef9a48172ee@gmail.com>
Date: Wed, 20 Jul 2016 14:26:22 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello, I'm trying to implement some function of AVRCP protocol. From here:

http://git.kernel.org/cgit/bluetooth/bluez.git/tree/doc/media-api.txt

I don't understand how to retreive the |object path| of my player:

    Object path [variable
    prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX/playerX

I'm not sure if it is returned from some DBus methods or I have to 
manually build it using the bluetooth address and the local device.

Thanks!
Marco


