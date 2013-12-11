Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Wed, 11 Dec 2013 15:36:48 -0500
Message-ID: <CAGGtaNZeTa5f360_a_dnML0dTY7HkE1zMu1xpokiA2Ltjvcc8w@mail.gmail.com>
Subject: Doc for Qualcomm AR3001 HCI
From: Frank Zhao <frank.zhao.main@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I am doing some hacking on a PlayStation 4's DualShock 4 controller,
inside is a Qualcomm Atheros AR3002 connected to a microcontroller
using UART HCI. I have a logic analyzer connected to the UART signals
and I have captured a lot of data. But a lot of the HCI commands have
OGF of 0xFC which means that the commands are "vendor defined", and
thus they are not in the HCI functional specifications documentation.

I can't find any helpful technical documentation at all from
Qualcomm's website and they probably won't help some hobbyist anyways.
I've searched Google and found your website. You guys have written a
driver for this chip already, so you must have some documentation on
Qualcomm's own HCI commands. Can you please share this documentation
with me?

Thank you

Frank Zhao

PS: I originally wrote this email to linux-wireless but they told me
to try linux-bluetooth instead
