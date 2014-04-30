Return-Path: <cyrus@holtmann.org>
Date: Wed, 30 Apr 2014 11:37:34 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: Gustavo Padovan <gustavo@padovan.org>,
	linux-wireless@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: pull request: bluetooth 2014-04-25
Message-ID: <20140430153733.GD3635@tuxdriver.com>
References: <20140425124602.GF7832@joana>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140425124602.GF7832@joana>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Apr 25, 2014 at 09:46:02AM -0300, Gustavo Padovan wrote:
> Hi John,
> 
> Some fixes for 3.15. There is a revert for the intel driver, a new device id,
> and two important SSP fixes from Johan. This one is rebased on wireless/master.
> 
> Please pull or let me know of any concerns you have. Thanks!
> 	
> 	Gustavo
> 
> ---
> The following changes since commit ffa216bb5eecfce0f01b0b2a95d5c320dde90005:
> 
>   brcmfmac: Fix brcmf_chip_ai_coredisable not applying reset bits to BCMA_IOCTL (2014-04-24 21:46:22 -0400)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git for-upstream
> 
> for you to fetch changes up to 1fb4e09a7e780b915dbd172592ae7e2a4c071065:
> 
>   Bluetooth: Add support for Lite-on [04ca:3007] (2014-04-25 09:47:16 +0300)

I pulled this on Friday, but forgot to send an email -- FYI! :-)

-- 
John W. Linville		Someday the world will need a hero, and you
linville@tuxdriver.com			might be all we have.  Be ready.
