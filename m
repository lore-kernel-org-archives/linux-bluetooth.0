Return-Path: <cyrus@holtmann.org>
Subject: Re: [RESEND #2] [PATCH] Bluetooth: implement raw output for hidp
From: Marcel Holtmann <marcel@holtmann.org>
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	Brian Gunn <bgunn@solekai.com>,
	Andrew Morton <akpm@linux-foundation.org>
In-Reply-To: <alpine.LNX.2.00.0912071853230.3755@pobox.suse.cz>
References: <alpine.LNX.2.00.0912031450400.3755@pobox.suse.cz>
	 <alpine.LNX.2.00.0912071853230.3755@pobox.suse.cz>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 07 Dec 2009 19:27:12 +0100
Message-ID: <1260210432.2987.59.camel@violet>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jiri,

> Implment raw output callback which is used by hidraw to send raw data to 
> the underlying device.
> 
> Without this patch, the userspace hidraw-based applications can't send 
> output reports to HID bluetooth devices.

that is in the bluetooth-next and net-next tree already. Linus should be
pulling it any time soon.

Regards

Marcel


