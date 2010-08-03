Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Tue, 3 Aug 2010 17:38:35 +0300
Message-ID: <AANLkTikei7_OFG6CNWK17i8P5Yz1So6+pQcYy+xssxh+@mail.gmail.com>
Subject: btd_adapter_driver
From: =?ISO-8859-1?Q?Daniel_=D6rstadius?= <daniel.orstadius@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

I have a question about the btd_adapter_driver struct.

The Maemo6 MCE plugin (which uses that struct) needs to be notified
when the adapter is powered on or off. One idea is to add a callback
to btd_adapter_driver to be called in adapter.c, but from discussion
with Johan the struct was intended to stay very simple, so that this
might not be an acceptable solution.

What would be a good way to handle it? Could listening to a raw hci
socket inside the driver be an option?

Thanks in advance,
Daniel
