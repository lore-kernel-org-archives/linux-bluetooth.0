Return-Path: <cyrus@holtmann.org>
Date: Mon, 12 May 2014 22:41:26 +0800
From: Adam Lee <adam.lee@canonical.com>
To: Ben Hutchings <ben@decadent.org.uk>
Cc: Paritosh Debnath <paritosh.debnath@intel.com>,
	linux-bluetooth@vger.kernel.org, johannes@sipsolutions.net
Subject: Re: [PATCH v3] firmware: update Intel Bluetooth device firmware
 patch files
Message-ID: <20140512144126.GA4972@adam-laptop>
References: <1396949427-6929-1-git-send-email-paritosh.debnath@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1396949427-6929-1-git-send-email-paritosh.debnath@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Apr 08, 2014 at 03:00:27PM +0530, Paritosh Debnath wrote:
> This patch updates firmware patch files for following Intel Bluetooth devices:
> - Intel Wireless Bluetooth 7260
> - Intel Wireless Bluetooth 3160
> 
> This patch fixes
> - Issue with LED blinking
> - Issue with USB
> - No SCO data over EHCI
> 
> Signed-off-by: Paritosh Debnath <paritosh.debnath@intel.com>
> ---
> This patch contains fixes given on 0x36 submitted by Tedd
> http://www.spinics.net/lists/linux-bluetooth/msg45790.html
> ---
>  WHENCE                                  |    4 ++--
>  intel/ibt-hw-37.7.10-fw-1.0.2.3.d.bseq  |  Bin 18145 -> 21198 bytes
>  intel/ibt-hw-37.7.10-fw-1.80.2.3.d.bseq |  Bin 17917 -> 20989 bytes
>  3 files changed, 2 insertions(+), 2 deletions(-)

Hi, please maintainer apply this patch? Lots of laptops are affected.

-- 
Adam Lee
