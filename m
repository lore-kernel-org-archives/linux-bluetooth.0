Return-Path: <cyrus@holtmann.org>
Subject: Re: Supporting more than 7 Connections
From: Marcel Holtmann <marcel@holtmann.org>
To: Klaus Teller <klaus.teller@gmx.net>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <20090327204841.234650@gmx.net>
References: <20090327174505.23080@gmx.net>
	 <1238051121.8206.6.camel@localhost.localdomain>
	 <20090327204841.234650@gmx.net>
Content-Type: text/plain
Date: Fri, 27 Mar 2009 21:00:49 -0700
Message-Id: <1238212849.8206.20.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Klaus,

> I've inquired with Aircable and it appears their Bluetooth Chip can handle 7 active connections and 128 parked connections. The comment at  http://osdir.com/ml/linux.bluez.devel/2003-07/msg00110.html also suggests that the CSR chip is capable of handling more than 7 connections overall.
> 
> So, what effort would be involved in making supervisory unpark-parks in BlueZ possible?

Aircable is not building their own chips. So I highly doubt that any
chip manufacturer bothered to test park with 128 slaves. I think these
guys mixing specification values with real life values. However be my
guest to prove me wrong, but keep in mind that park state will be
eventually be deprecated since nobody is using it.

Regards

Marcel


