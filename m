Return-Path: <cyrus@holtmann.org>
Subject: Check for connections and disable bluetooth in shell
From: Jonathan Haug <jonathanhaug@wolke7.net>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 31 Aug 2010 07:58:19 +0200
Message-ID: <1283234299.1702.12.camel@josua>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


Dear bluetooth-experts,

I want to disable bluetooth on my system (via commandline), if there is
no active bluetooth connection -- without being root.

Therefor I need a way to

1.  check if there is an active bluetooth connection

2.  disable bluetooth without being root


For the second part I found

dbus-send --system --type=method_call --dest=org.bluez $(dbus-send
--system --print-reply --dest=org.bluez / org.bluez.Manager.ListAdapters
| awk -F'"' '/at/ {print $2}') org.bluez.Adapter.SetProperty
string:Powered variant:boolean:false

but this doesn't really disable bluetooth: I'm still able to deactivate
bluetooth in the panel.

For the first part I could not find a solution so far.

I'm running Ubuntu 10.04.

Thanks for your help!

Jonathan Haug


