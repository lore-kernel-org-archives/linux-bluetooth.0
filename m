Return-Path: <cyrus@holtmann.org>
Message-ID: <4A36E764.5070406@kepler2004.de>
Date: Tue, 16 Jun 2009 02:29:24 +0200
From: Hannes Rapp <webmaster@kepler2004.de>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: hciattach timeout - blocks at read() call
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,
I am currently trying to get bluetooth working, but hciattach always
gives me initialization timeout.
I have a W2CBW003 module which has a marvel wlan module and a CSR BC04
bt module.
I call hciattach like this:
hciattach ttyS1 csr

The LED is flashing a few times but nothing else happens.

I added some debug printf's to the csr() initialize function and the
read_hci_event() in hciattach.c and it turned out that read_hci_event
blocks on the read() call on line 164.

My question: is this a known issue? or someone knows what the problem
could be ?

thanks & greetings
hannes
