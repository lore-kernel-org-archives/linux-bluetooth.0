Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Fri, 20 Apr 2018 16:03:53 +0200
From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] build: Make bt_shell conditional to readline
Message-ID: <20180420160353.5cb58146@windsurf.numericable.fr>
In-Reply-To: <20180420130254.20063-1-luiz.dentz@gmail.com>
References: <20180420130254.20063-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

On Fri, 20 Apr 2018 16:02:54 +0300, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> bt_shell APIs shall only be build if readline is present on the system
> since it currently depend on it.

Tested-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>

I've tested with a few different BlueZ configurations (not all
combinations though), and all of them built fine. The specific
configuration that was failing to build due to the dependency on
readline no longer fails to build.

Thanks a lot Luiz for having looked so quickly at this bug report!

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
