Return-Path: <cyrus@holtmann.org>
Date: Fri, 28 Sep 2012 13:59:37 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: chen.ganir@ti.com
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v4 01/10] battery: Add generic device battery
 documentation
Message-ID: <20120928105937.GA14450@x220>
References: <1348470919-25567-1-git-send-email-chen.ganir@ti.com>
 <1348470919-25567-2-git-send-email-chen.ganir@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1348470919-25567-2-git-send-email-chen.ganir@ti.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chen,

On Mon, Sep 24, 2012, chen.ganir@ti.com wrote:
> +BlueZ D-Bus Battery API description
> +****************************************

Please keep the "underline" consistent with the length of the text above
it.

> +	Texas Instruments, Inc. <chen.ganir@ti.com>

What's this supposed to be? If you want a copyright statement here then
make it of the proper format. Author info is not needed as we have the
AUTHORS file and the commit history.

> +Device Battery hierarchy
> +=====================================

Same thing with the consistency of the "underline"

> +Service		org.bluez
> +Interface	org.bluez.Battery
> +Object path	[variable prefix]/{hci0,..}/dev_XX_XX_XX_XX_XX_XX/BATTYYYY
> +YYYY is numeric value between 0 and 9999.

I don't think you need a separate comment for the "YYY". We don't have
that for the "XX" stuff either.

> +		array{object} Batteries [readonly]

I guess you should mark this with [experimental] since it'll be removed
with the advent of ObjectManager.

Johan
