Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Thu, 9 Sep 2010 14:58:34 -0500
Message-ID: <AANLkTikJFwwjs53_2F6NuBd-e00p1AnYahPMwYNgrveE@mail.gmail.com>
Subject: set LE advertise not working...
From: Pavan Savoy <pavan_savoy@sify.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I have an LE enabled BT controller, and I happened to send across a
simple "leadv" from the recently updated hciconfig
I got back the following data
"4 e 5 1 a 20 c 3a" and hence
"Can't set advertise mode on hci0: Success (0)"
and 0xC I guess by the BT spec means the command is disallowed (for
reasons unknown?....)

So I'm just wondering, am I supposed to run some HCI-VS commands to
enable LE? I mean I should ask my vendor I agree, but anyone who has
got it working.. do they run some VS commands before enabling LE
advertising?
