Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Sun, 7 Jun 2009 12:53:24 +0900
Message-ID: <434c4b6e0906062053na041ddj6ae690c5f08f750@mail.gmail.com>
Subject: How could bluez start A2DP stream directly without other commands
	while PTS.
From: =?EUC-KR?B?udrC+b+t?= <chanyeol.park@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello.

If possible, could you explain how to start a2dp stream directly
without other commands such as Get_capability, Set_configuration..
because it is necessary when a2dp stream connection was already made
by peer(sink).

In case of PTS test(TP/SET/BV-06-I), I couldn't pass the test case.
There is no action after bluez receive DISCOVER cmd from PTS....

I uses PTS 3.2.16

If you need futher information, please let me know it.

Regards
Chanyeol
