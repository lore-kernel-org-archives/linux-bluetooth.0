Return-Path: <cyrus@holtmann.org>
Subject: RE: [patch] obexd: if path == NULL, don't call
 dbus_connection_get_object_path_data
From: Marcel Holtmann <marcel@holtmann.org>
To: "Liu, Raymond" <raymond.liu@intel.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
In-Reply-To: <0463F45F3606F4428ED35AC8C709F92E046C04CB@pdsmsx502.ccr.corp.intel.com>
References: <ac8af0be0812221733j262e8077re27476f18772079e@mail.gmail.com>
	 <3D8E1963-54E4-4974-98B3-6E9095046D30@gmail.com>
	 <0463F45F3606F4428ED35AC8C709F92E046C0469@pdsmsx502.ccr.corp.intel.com>
	 <1230090097.4954.27.camel@californication>
	 <0463F45F3606F4428ED35AC8C709F92E046C04CB@pdsmsx502.ccr.corp.intel.com>
Content-Type: text/plain
Date: Wed, 24 Dec 2008 07:17:37 +0100
Message-Id: <1230099457.16960.0.camel@californication>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Raymond,

> >You should really start thinking for the error => return paradigm all
> >the time. This makes the code a lot simpler to read.
>
> OK, Got it. Resent

applied to the bluez.git and obexd.git trees. Thanks.

Regards

Marcel


