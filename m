Return-Path: <cyrus@holtmann.org>
Subject: Re: Supporting more than 7 Connections
From: Marcel Holtmann <marcel@holtmann.org>
To: Klaus Teller <klaus.teller@gmx.net>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <20090327174505.23080@gmx.net>
References: <20090327174505.23080@gmx.net>
Content-Type: text/plain
Date: Thu, 26 Mar 2009 08:05:21 +0100
Message-Id: <1238051121.8206.6.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Klaus,

> I was wondering how BlueZ handles parked connections. I came across this comment http://osdir.com/ml/linux.bluez.devel/2003-07/msg00110.html that looks like something that would allow me to transparently manage parked connections.
> 
> Essentially, the article talks about supervisory unpark-parks where BlueZ will could deal with parking and unparkingdevices when it has data for them.
> 
> Can somebody tell me if this has been implemented since then?

we could, but it will not help you. Almost all Bluetooth chips don't
support more than 7 connections overall. Parked or not parked makes no
difference. It is a memory constraint on the chip.

Regards

Marcel


