Return-Path: <cyrus@holtmann.org>
From: =?utf-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?= <jprvita@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com
Subject: A2DP Sink implementation
Date: Mon, 13 Jul 2009 12:28:49 -0300
Message-Id: <1247498933-30609-1-git-send-email-jprvita@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


The following serie of patches implements the necessary code for the A2DP Sink
in bluetoothd. It needs kernel version 2.6.30+ to work. The sink is disabled by
default, since there is no client to handle the incoming stream yet. To enable
it, just add an "Enable=Source" line to /etc/bluetooth/audio.conf.
