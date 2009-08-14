Return-Path: <cyrus@holtmann.org>
Date: Fri, 14 Aug 2009 16:19:39 +0200
From: Stefan Seyfried <stefan.seyfried@googlemail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: access point networking without X
Message-ID: <20090814161939.43f64dea@stoetzler>
In-Reply-To: <d89ddf300908140007h767dd390r639955e1d004e2be@mail.gmail.com>
References: <d89ddf300908140007h767dd390r639955e1d004e2be@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, 14 Aug 2009 01:07:44 -0600
Brad Midgley <bmidgley@gmail.com> wrote:

> Hey
> 
> I've got some python scripts for driving access point services
> (dun/pan) under bluez4. The idea is to cover machines like gumstix or
> beagleboard that run without a ui and can't do the gnome/kde bluetooth
> controllers.
> 
> Is anyone interested in me pulling these things together and housing
> them in a standalone project? I was thinking we could move toward a C
> implementation once things have settled down in the python prototype.
> (Python is not always a great requirement to put on embedded hosts).
> If anyone else has built similar helpers, we should collect those
> together.

I am definitely interested in BlueZ console tools (not only) for
embedded systems. It can also be beneficial for debugging (even though
most of that can be done with the bluez-supplied test scripts).

> I'd like to be able to extend this beyond simple access point and be
> able to do audio and voip sort of services as well. These little
> machines are quite capable these days and wouldn't have much trouble
> keeping up.

Would be cool, and I would be willing to help (where possible with my
rather limited knowledge ;-)
-- 
R&D Preload Department             |              "Any ideas, John?"
SUSE LINUX Products GmbH, Nürnberg | "Well, surrounding them's out."

This footer brought to you by insane German lawmakers:
SUSE Linux Products GmbH, GF: Markus Rex, HRB 16746 (AG Nürnberg)
