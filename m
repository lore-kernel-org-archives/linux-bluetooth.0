Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.0 \(1990.1\))
Subject: Re: BlueZ 5: SDP Record & D-Bus APIs
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAE7yNv_mZU-yyLszs5BmhUc7MLSwK=TZZ4ArJfeS9Cnn4VgkeQ@mail.gmail.com>
Date: Tue, 28 Oct 2014 10:31:37 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <508E57A5-CE70-43BE-9FC3-6F883E6397CB@holtmann.org>
References: <CAE7yNv_mZU-yyLszs5BmhUc7MLSwK=TZZ4ArJfeS9Cnn4VgkeQ@mail.gmail.com>
To: Sujay Sarkhel <ssarkhe@ncsu.edu>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sujay,

> I'm still getting used to BlueZ 5 D-Bus APIs and I was wondering if
> someone can help me with a few queries that I've:
> 
> 1. BlueZ 4 D-Bus Device API provided a method called
> DiscoverServices(string pattern) that could be used to retrieve
> service information from the remote device in XML format. I used to
> use this XML information to retrieve several meta-data relevant to my
> use-case.
> 
> For example: for Device ID profile, I would want to retrieve vendor
> information (id/vendoridsource, etc), for HDP, the optional text
> associated with an MDEP, etc.

the Device ID information are represented in form of the Modalias property.

For anything HDP related that should be part of the Health API actually. If it is missing there, then that sounds to me like a bug in that API that should be fixed.

> From what I understand, this method does not exist anymore in the
> exposed APIs. I was wondering whether there's a workaround? How can I
> still look at the meta-data?
> 
> 2. I was investigating how to work with the BlueZ D-Bus GATT APIs when
> it comes to talking to GATT services on remote devices. Is that
> possible? If yes, then how do I retrieve the list of object path
> corresponding to the available remote services?

We are developing a new D-Bus based generic GATT API. It is brand new and you can follow the progress on the mailing list.

Regards

Marcel

