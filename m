Return-Path: <cyrus@holtmann.org>
Message-ID: <f86d2a880811040903i3ee0a5e7tdf9b52775108dab0@mail.gmail.com>
Date: Tue, 4 Nov 2008 12:03:52 -0500
From: "David Merrill" <dmerrill@media.mit.edu>
To: linux-bluetooth@vger.kernel.org
Subject: how to: Inquiry with RSSI?
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello all -
First, thanks to the developers for creating Bluez - it's so nice to
have such a useful, open-source Bluetooth option.

I am writing with a question: how can I do an inquiry scan with RSSI,
and read out the RSSI values? (without making a connection to devices)
When I run "hciconfig hci0 inqmode" I get the following:

Inquiry mode: Inquiry with RSSI

..so I think the adapter supports this, and is in the correct
configuration - but when I run "hcitool scan", I only get the HW
address and name of local adapters - no RSSI. Is there some flag, or
option that I need to pass to hcitool in order to get RSSI as well?

thanks very much,
David Merrill
--
MIT Media Lab
dmerrill@media.mit.edu
http://web.media.mit.edu/~dmerrill/
