Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=US-ASCII
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: Patch for bccmd
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <5396BCBC.2050009@remote-exploit.org>
Date: Tue, 10 Jun 2014 11:26:20 +0200
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <E880AF5C-0FA3-4103-81C9-F932A0C5C0C1@holtmann.org>
References: <5396BCBC.2050009@remote-exploit.org>
To: mmo@remote-exploit.org
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Max,

> i recently had the issue that i was required to interact with a bluecore
> based device with a non-default vendorid and productid via usb. Plesae
> find a small patch to introduce two new parameters. If the parameters
> are omitted, the default value of 0x0a12 0x0001 will be used.

please use git-format-patch and git-send-email for the patch. That way it is easier for us to review it inline and also apply it.

Regards

Marcel

