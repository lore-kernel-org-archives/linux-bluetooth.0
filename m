Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Sujay Sarkhel <ssarkhe@ncsu.edu>
Date: Mon, 20 Oct 2014 19:43:51 -0700
Message-ID: <CAE7yNv_mZU-yyLszs5BmhUc7MLSwK=TZZ4ArJfeS9Cnn4VgkeQ@mail.gmail.com>
Subject: BlueZ 5: SDP Record & D-Bus APIs
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I'm still getting used to BlueZ 5 D-Bus APIs and I was wondering if
someone can help me with a few queries that I've:

1. BlueZ 4 D-Bus Device API provided a method called
DiscoverServices(string pattern) that could be used to retrieve
service information from the remote device in XML format. I used to
use this XML information to retrieve several meta-data relevant to my
use-case.

For example: for Device ID profile, I would want to retrieve vendor
information (id/vendoridsource, etc), for HDP, the optional text
associated with an MDEP, etc.

>From what I understand, this method does not exist anymore in the
exposed APIs. I was wondering whether there's a workaround? How can I
still look at the meta-data?

2. I was investigating how to work with the BlueZ D-Bus GATT APIs when
it comes to talking to GATT services on remote devices. Is that
possible? If yes, then how do I retrieve the list of object path
corresponding to the available remote services?

I've a Bluetooth LE heart rate watch, to which I can connect and use
gatttool to talk to. I was wondering how to do the same using the
experimental APIs.

I apologize in advance for my ignorance. Still learning about BlueZ,
D-Bus and Bluetooth LE.

Would really appreciate any pointers in this regard. Thanks!

- Sujay
