Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Fri, 6 Jan 2012 15:43:02 -0800
Message-ID: <CAHZ1yC=3Ecj-4-SAHnD93S7_YVF+f_o__Hb2PYFcaoCs_NDoPw@mail.gmail.com>
Subject: Bluetooth 2.1 keyboard not sending keypress notifications
From: Scott James Remnant <keybuk@google.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Have been testing a Bluetooth 2.1 keyboard, but we don't get any
keypress notifications from it as the pincode is typed and the Agent's
DisplayPasskey D-Bus method is never called (with two or three
arguments).

Any ideas where to begin debugging this?

Scott
--
Scott James Remnant | Chrome OS Systems | keybuk@google.com | Google
