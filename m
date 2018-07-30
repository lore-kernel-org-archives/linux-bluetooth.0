Return-Path: <johan.hedberg@gmail.com>
Date: Mon, 30 Jul 2018 15:03:57 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jaganath Kanakkassery <jaganath.k.os@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
	Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Subject: Re: [PATCH BlueZ v2 0/7] Add BREDR PHYs in PHY configuration commands
Message-ID: <20180730120357.GA31474@x1c.home>
References: <1532514086-14790-1-git-send-email-jaganathx.kanakkassery@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1532514086-14790-1-git-send-email-jaganathx.kanakkassery@intel.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jaganath,

On Wed, Jul 25, 2018, Jaganath Kanakkassery wrote:
> This also has mgmt-tester patches for 5.0 implementation
> 
> v2-> Fixed -Werror=unused-const-variable build error
> 
> Jaganath Kanakkassery (7):
>   monitor: Add BREDR PHYs in PHY configuration commands
>   emulator: Add BREDR 2M & 3M, 3 & 5 Slot packet type support
>   mgmt-tester: Add extended advertising test cases
>   mgmt-tester: Add PHY Configuration test cases
>   mgmt-tester: Add tests for extended scanning and device found
>   mgmt-tester: Add support ext create connection and enh conn complete
>   mgmt-tester: Update Supported_settings to reflect PHY_CONFIGURATION
> 
>  emulator/btdev.c    |   10 +
>  monitor/packet.c    |   39 +-
>  tools/mgmt-tester.c | 2085 ++++++++++++++++++++++++++++++++++++++++++++++++---
>  3 files changed, 2015 insertions(+), 119 deletions(-)

All patches in this set have been applied. Thanks.

Johan
