Return-Path: <cyrus@holtmann.org>
Subject: RE: How can i configure bluez to transmit Voice over PCM
From: Marcel Holtmann <marcel@holtmann.org>
To: "Matuschka, Sebastian" <Sebastian.Matuschka@gcd-solutions.de>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <49ED01FC03EE524BB7BB258E8F93BFF32F3DD5@bfl-exchange-1.BFL.local>
References: <49ED01FC03EE524BB7BB258E8F93BFF32F3DB5@bfl-exchange-1.BFL.local>
	 <1233507125.4809.2.camel@californication>
	 <49ED01FC03EE524BB7BB258E8F93BFF32F3DD5@bfl-exchange-1.BFL.local>
Content-Type: text/plain
Date: Mon, 02 Feb 2009 09:58:09 +0100
Message-Id: <1233565089.4668.15.camel@californication>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

let me repeat this; _NO_ top-posting. I really mean it.

> is it possible to use Version 4.27 for embedded systems without any
> Desktop Environment only with commandline?
> I will try to switch to 4.27.

it is possible. Currently we only have Python scripts that use the D-Bus
interfaces, but in the future we gonna have a full blown command line
client for BlueZ.

Regards

Marcel


