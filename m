Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
To: Amitkumar Karwar <akarwar@marvell.com>
Cc: linux-bluetooth@vger.kernel.org,
	Nishant Sarmukadam <nishants@marvell.com>,
	wnhuang@chromium.com, devicetree@vger.kernel.org,
	Cathy Luo <cluo@marvell.com>, linux-kernel@vger.kernel.org,
	Xinming Hu <huxm@marvell.com>
Subject: Re: [PATCH v4 1/3] mwifiex: register platform specific driver
Date: Tue, 16 Feb 2016 12:28:44 +0100
Message-ID: <4893138.FlpGGi4f54@wuerfel>
In-Reply-To: <1455614079-4263-1-git-send-email-akarwar@marvell.com>
References: <1455614079-4263-1-git-send-email-akarwar@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tuesday 16 February 2016 01:14:37 Amitkumar Karwar wrote:
> +  - compatible : must be "marvell,sd8xxx"
> 

I think we mentioned it before, but a compatible string must not contain
wildcards of any kind, as it is very possible that there are some future
sd8xxx devices that are slightly incompatible with the first one.

Please use a specfic model name here, or a list of multiple models
if they are actually different.

	Arnd
