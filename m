Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: Passive scanning of iBeacons results in a "Data Buffer Overflow"
From: Adam Warski <adam@warski.org>
In-Reply-To: <407CD6A9-AFA8-4A8A-BA2C-882D7A64EF40@warski.org>
Date: Mon, 3 Mar 2014 16:27:27 +0100
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Message-Id: <018DA7AF-5E7C-4E18-949C-E7EED9F9EB52@warski.org>
References: <6E6C1573-4744-486B-B2E6-2D3DC45D024B@warski.org> <CAJdJm_PMAVyiY-=13puBHAucCzObUWOSOXZ+maOL2z11YwOh-g@mail.gmail.com> <A4DDF6F3-8DD4-4CF7-A5C0-205F5B4EE489@warski.org> <CAJdJm_PN3xGjdNOtr3o-J0SJ8N6MJXBChUCwOWOZBrdFKDBfGA@mail.gmail.com> <407CD6A9-AFA8-4A8A-BA2C-882D7A64EF40@warski.org>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


> I messed up the model number, looked at the wrong dongle, TP-Link is the WiFi one ;)
> The bluetooth one is an IOGear GBU521 (http://www.iogear.com/product/GBU521/).
> 
> I don’t have another dongle right now (I tried a different IOGear, but same thing), but I’ll try setting a VM on my laptop/getting a different USB dongle.

I’ve setup an Ubuntu 13.10 VM (kernel 3.11.0-17), same dongle (IOGear), bluez 5.15, and it works without problems - at least for the past 15 minutes ;) (usually it work at most 2 minutes).

I’m wondering what this might mean exactly :) I guess it could point to the specific USB/bluetooth drivers present in the raspbian 3.10 and ubuntu 3.11 kernels, right? 

Adam

-- 
Adam Warski

http://twitter.com/#!/adamwarski
http://www.softwaremill.com
http://www.warski.org

