Return-Path: <cyrus@holtmann.org>
Date: Sun, 23 Mar 2014 17:08:42 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: =?iso-8859-1?Q?=C0lex?= Fiestas <afiestas@kde.org>
Cc: BlueZ <linux-bluetooth@vger.kernel.org>
Subject: Re: Adapters power management
Message-ID: <20140323150842.GB20404@t440s.P-661HNU-F1>
References: <2963801.adpd6n3SPJ@minibad>
 <1458063.fJ1RYS5iKm@minibad>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1458063.fJ1RYS5iKm@minibad>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alex,

On Sun, Mar 23, 2014, Àlex Fiestas wrote:
> On Sunday 23 March 2014 01:42:49 you wrote:
> > I'm finishing the port of KDE's bluez interface to BlueZ5 and I am wondering
> > a few things about power management.
> > 
> > First thing is, why is Adapter::powered not hook into rfkill? Is there any
> > difference power consumption-wise whether the power state is true or false?
> > I look  into the source code and only saw code to monitor the rfkill state
> > but not for modifying it.
> > 
> > In the case that Adapter::powered has an impact on power consumption, then
> > the ideal state is to have it to false as much as possible. Are there any
> > plans to make that easy for frontend developers? In a sense this is very
> > similar to Inhibitions in systemd[1] so I was thinking
> That bluez could implement something similar so when the application that 
> changed Adapter::powered to true exists the state is set back to false.

How would you suggest to make this work together with Bluetooth mice and
keyboards that need to be connected or at least able to initiate
connections on demand (when you press a button or move the mouse).

Johan
