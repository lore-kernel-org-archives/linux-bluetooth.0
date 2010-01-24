Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Sun, 24 Jan 2010 17:18:36 +0200
Message-ID: <549992e51001240718l19528937j7e2cb166a3b2bd2c@mail.gmail.com>
Subject: bridge: mac addresses question (for bluetooth pan-nap)
From: Metuki Sabhe <sabhe.metuki@gmail.com>
To: netdev@vger.kernel.org
Cc: bridge@lists.linux-foundation.org, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I have a single bridge with up to 7 virtual TAP ports,
which are being added and removed dynamically.

Can I use the same MAC address for all ports and for the bridge ?
(I don't use STP as the topology is very very simple).

This is needed to allow macaddress header compression of BNEP...
(i plan to use the radio BDADDR as the MAC address for all TAP ports
and for the bridge)

thank you,
sabhe
