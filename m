Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: How can i configure bluez to transmit Voice over PCM
Date: Tue, 3 Feb 2009 09:40:13 +0800
Message-ID: <9F2B2656C8747B498D56A7B30FF5EB9FEC3FC2@CNMAIL13.cn.utstarcom.com>
In-Reply-To: <49ED01FC03EE524BB7BB258E8F93BFF32F3E28@bfl-exchange-1.BFL.local>
From: "Yao Ye" <yeyao@utstar.com>
To: "Matuschka, Sebastian" <Sebastian.Matuschka@gcd-solutions.de>
Cc: <linux-bluetooth@vger.kernel.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


> Python is not really an option for our embedded system.
> I got bluez 4.27 running and all I have tested worked.
> But I have a problem with the pairing:
> Since there is no passkey-agent any longer and I don't want to run
python scripts I tried agent but it starts with an error message:
 
test/agent.c seems to be outdated, just as you can see in function
"static DBusHandlerResult agent_message(...)".
It is impossible for us to porting python to embedded system, because
python is too big, and dbus of python needed.

import sys
import dbus
import dbus.service
import dbus.mainloop.glib

Marcel has said: 
Currently we only have Python scripts test/simple-agent.
in the future we gonna have a full blown command line client for BlueZ.

so now bluez 4.28 can run well on embeded system,  but cann't run
pairing.
let us looking  forward to the update of test/agent.c.
