Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: =?ISO-8859-1?Q?Nicol=F2_Chieffo?= <nicolo.chieffo@gmail.com>
Date: Mon, 24 Aug 2009 13:13:05 +0200
Message-ID: <98391a7b0908240413u371c4392r2c9f92ee85a97081@mail.gmail.com>
Subject: can't pair cellphone
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello, I've just subscribed to this mailing list because I have a
problem with my bluetooth phone in ubuntu 9.10

I'm trying to pair my phone, but I'm not able to do it.
First of all I tried using the gnome-bluetooth applet, but I failed,
so I started to use the hcitool command in this way

sudo hcitool cc xx:xx:xx:xx:xx:xx
sudo hcitool auth xx:xx:xx:xx:xx:xx

the first command passes, while the second returns this message:
HCI authentication request failed: Input/output error

This is the system log:
Aug 24 13:05:40 yelo3-laptop bluetoothd[4458]: link_key_request
(sba=xx:xx:xx:xx:xx:xx, dba=xx:xx:xx:xx:xx:xx)
Aug 24 13:05:40 yelo3-laptop bluetoothd[4458]: pin_code_request
(sba=xx:xx:xx:xx:xx:xx, dba=xx:xx:xx:xx:xx:xx)
Aug 24 13:05:49 yelo3-laptop NetworkManager:
bluez_manager_bdaddr_removed_cb: BT device xx:xx:xx:xx:xx:xx removed
