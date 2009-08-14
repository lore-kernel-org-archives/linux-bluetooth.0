Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Fri, 14 Aug 2009 01:07:44 -0600
Message-ID: <d89ddf300908140007h767dd390r639955e1d004e2be@mail.gmail.com>
Subject: access point networking without X
From: Brad Midgley <bmidgley@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hey

I've got some python scripts for driving access point services
(dun/pan) under bluez4. The idea is to cover machines like gumstix or
beagleboard that run without a ui and can't do the gnome/kde bluetooth
controllers.

Is anyone interested in me pulling these things together and housing
them in a standalone project? I was thinking we could move toward a C
implementation once things have settled down in the python prototype.
(Python is not always a great requirement to put on embedded hosts).
If anyone else has built similar helpers, we should collect those
together.

I'd like to be able to extend this beyond simple access point and be
able to do audio and voip sort of services as well. These little
machines are quite capable these days and wouldn't have much trouble
keeping up.

-- 
Brad Midgley
