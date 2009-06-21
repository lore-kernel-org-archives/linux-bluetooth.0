Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Add udev rules to start bluetooth on-demand
From: Marcel Holtmann <marcel@holtmann.org>
To: Bastien Nocera <hadess@hadess.net>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
In-Reply-To: <1245591547.26486.7101.camel@localhost.localdomain>
References: <1245591547.26486.7101.camel@localhost.localdomain>
Content-Type: text/plain
Date: Sun, 21 Jun 2009 15:50:51 +0200
Message-Id: <1245592251.15367.64.camel@violet>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

> As discussed in previous mails.

please name it bluetooth.rules. The daemon is also called bluetoothd and
not bluezd.

Also you need to have the EXTRA_DIST part in it since _DATA doesn't get
added to the distribution automatically. For all this changes, you have
to check with make distcheck.

Regards

Marcel


