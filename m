Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
Date: Tue, 1 Nov 2011 14:15:49 -0200
From: Gustavo Padovan <padovan@profusion.mobi>
To: "Cho, Yu-Chen" <acho@suse.com>
Cc: marcel@holtmann.org, linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org, acho@novell.com, jlee@novell.com,
	oneukum@suse.com, jlee@suse.com
Subject: Re: [PATCH 1/3] add device entry for Broadcom Valentine combo card
Message-ID: <20111101161549.GG2580@joana>
References: <944af9667334f5677be87e89fe8f38486823cc95.1320139612.git.acho@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <944af9667334f5677be87e89fe8f38486823cc95.1320139612.git.acho@suse.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Yu-Chen,

* Cho, Yu-Chen <acho@suse.com> [2011-11-01 17:33:05 +0800]:

> This device declares itself to be vendor specific
> It therefore needs to be added to the device table
> to make btusb bind.
> 
> Signed-off-by: Cho, Yu-Chen <acho@suse.com>
> ---
>  drivers/bluetooth/btusb.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)

Ok, but where is the output of usb-devices that I asked. Thanks.

	 Gustavo
