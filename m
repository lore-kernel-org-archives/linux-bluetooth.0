Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=US-ASCII
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1816\))
Subject: Re: [PATCH] btusb: add realtek 8723 in the blacklist
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <52774AB7.1010609@canonical.com>
Date: Mon, 4 Nov 2013 08:49:47 +0100
Cc: "linux-bluetooth@vger.kernel.org development"
	<linux-bluetooth@vger.kernel.org>
Message-Id: <D53A2E83-5B2C-4FA2-A2AB-EF48240BBDCF@holtmann.org>
References: <52774AB7.1010609@canonical.com>
To: "Bruce.Ma" <bruce.ma@canonical.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bruce,

> From: Bruce Ma <bruce.ma@canonical.com>
> Date: Tue, 04 Nov 2013 11:21:20 +0800
> Subject: [PATCH] btusb: add Realtek 8723 in the blacklist
> 
> The btusb doesn't work with Realtek 8723 bluetooth device,
> so we want to add it to the blacklist.

this is the same answer as last time. I do not randomly blacklist devices for out of tree drivers. Changing the commit message to make this look more innocent is not going to help.

Someone has to do the real work and get the Realtek support integrated into btusb.ko driver.

Regards

Marcel

