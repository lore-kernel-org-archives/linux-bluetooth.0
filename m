Return-Path: <cyrus@holtmann.org>
Date: Tue, 4 Nov 2008 14:33:42 +0200
From: Johan Hedberg <johan.hedberg@nokia.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: compiling error
Message-ID: <20081104123342.GA20202@localhost>
References: <49104706.2010200@kleiderschrank51.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <49104706.2010200@kleiderschrank51.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Nov 04, 2008, mike wrote:
> device.c:(.text+0x1847): undefined reference to `g_timeout_add_seconds'

> its an multilib environment and its the same for 64 bit. anyone a idea?

Yes. You've got a too old GLib version. If you check the GLib
documentation you'll see that g_timeout_add_seconds was added in version
2.14.

Johan
