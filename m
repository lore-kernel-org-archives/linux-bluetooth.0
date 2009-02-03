Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: How can i configure bluez to transmit Voice over PCM
Date: Tue, 3 Feb 2009 08:34:40 +0100
Message-ID: <49ED01FC03EE524BB7BB258E8F93BFF32F3E3A@bfl-exchange-1.BFL.local>
In-Reply-To: <9F2B2656C8747B498D56A7B30FF5EB9FEC3FC2@CNMAIL13.cn.utstarcom.com>
References: <49ED01FC03EE524BB7BB258E8F93BFF32F3E28@bfl-exchange-1.BFL.local> <9F2B2656C8747B498D56A7B30FF5EB9FEC3FC2@CNMAIL13.cn.utstarcom.com>
From: "Matuschka, Sebastian" <Sebastian.Matuschka@gcd-solutions.de>
Cc: <linux-bluetooth@vger.kernel.org>
To: unlisted-recipients:; (no To-header on input)
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

> test/agent.c seems to be outdated, just as you can see in function 
> "static DBusHandlerResult agent_message(...)".
> It is impossible for us to porting python to embedded system, because 
> python is too big, and dbus of python needed.
> 
> import sys
> import dbus
> import dbus.service
> import dbus.mainloop.glib

Same here

> 
> Marcel has said:
> Currently we only have Python scripts test/simple-agent.
> in the future we gonna have a full blown command line client for
BlueZ.
> 
> so now bluez 4.28 can run well on embeded system,  but cann't run 
> pairing.
> let us looking  forward to the update of test/agent.c.

Hmm, then i think it would be the best for me to switch back to 3.36 for
the moment until the agent works, or writing my own agent.
Do you think it is possible to write an agent with shell scripts?
That would be an option, but since it is not object oriented it would be
hard I guess.
Regards
Sebastian 

