Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Thu, 3 May 2012 14:40:25 -0400
Message-ID: <CACEkAT65YcQ9ggbJfzMOrh7c=E8F1qSKKEx1EUUrMVvc4Z+pHw@mail.gmail.com>
Subject: determining link quality for poor connections
From: Andy Pyles <ajpyles@cs.wm.edu>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In reading the spec, I noticed that implementation of link quality is
up to the implementation of the bluetooth chip manufacturer.
After testing this (hci_read_link_quality())  on two separate
bluetooth chipsets, I got some inconsistent results.

The test scenario involes sending a simple l2cap message every second
to a mobile device with bluetooth.
The mobile device displays the received message to the console.
I gradually walk away from the sender until the messages are no longer
displayed (meaning outside of the range.)
I have bluez 4.98.

After each packet is sent I retrieve the link quality (hci_read_link_quality()).
I tested this scenario on two different bluetooth chipsets:

Broadcom device id: 0a5c:217f:  I receive link quality of 255 ( the
entire duration)
Atheros-Qualcom devide id:  04ca:3004 (ath3k device) I receive link
quality of 172 ( the entire duration)
(I also confirmed these results with hcitool)

It seems that link_quality is not a useful parameter. As the link
quality is obviously impaired, this function always returns the same
value.  I'm also retrieving RSSI which seems to be more indicative of
the poor connection quality.

Is there a better way to determine link quality? Is there a way to
count packets which need to be re-transmitted?
