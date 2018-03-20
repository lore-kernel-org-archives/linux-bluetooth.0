Return-Path: <tony@atomide.com>
Date: Tue, 20 Mar 2018 16:29:43 -0700
From: Tony Lindgren <tony@atomide.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Sebastian Reichel <sre@kernel.org>, linux-bluetooth@vger.kernel.org,
	Ulf Hansson <ulf.hansson@linaro.org>, robh@kernel.org
Subject: Re: [RFC] Bluetooth: hci_ll: Convert to use h4_recv_buf helper
Message-ID: <20180320232943.GX5796@atomide.com>
References: <20180320083704.11705-1-marcel@holtmann.org>
 <4DBD77C5-BBFD-4952-A296-30187D85A07F@holtmann.org>
 <20180320172827.ohla5v4a23v3u3qq@earth.universe>
 <20180320201449.GV5796@atomide.com>
 <E7257152-583E-4BCC-B366-2627E62F1FE1@holtmann.org>
 <20180320211151.GW5796@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180320211151.GW5796@atomide.com>
List-ID: <linux-bluetooth.vger.kernel.org>

* Tony Lindgren <tony@atomide.com> [180320 14:11]:
> * Marcel Holtmann <marcel@holtmann.org> [180320 21:01]:
> > that might be a git am issue and it being rather strict.
> 
> Or the patch not being correct copied from the archive.
> Do you have a patchwork url for it or care to bounce the
> patch to me?

Thanks got it applied now, works the same way as without it
where hcitool scan finds some devices. Sorry don't have
anything really configured beyond that right now, but:

Tested-by: Tony Lindgren <tony@atomide.com>
