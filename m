Return-Path: <cyrus@holtmann.org>
Date: Tue, 18 Dec 2012 13:45:50 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] hcidump: Fix compilation errors due to unaligned
 memory access
Message-ID: <20121218114550.GA19406@x220>
References: <1355829058-10033-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1355829058-10033-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Tue, Dec 18, 2012, Szymon Janc wrote:
> Use bt_get_le* helper functions to access unaligned memory. This fix
> number of compilation errors on ARM similar to:
> 
> CC     tools/parser/hci.o
> tools/parser/hci.c: In function ‘ext_inquiry_data_dump’:
> tools/parser/hci.c:797:10 error: cast increases required alignment of
> 	target type [-Werror=cast-align]
> tools/parser/hci.c:797:10: error: cast increases required alignment of
> 	target type [-Werror=cast-align]
> cc1: all warnings being treated as errors
> make[1]: *** [tools/parser/hci.o] Error 1
> ---
>  tools/parser/hci.c   |  7 ++-----
>  tools/parser/l2cap.c | 22 +++++++++++-----------
>  2 files changed, 13 insertions(+), 16 deletions(-)

Both patches have been applied. Thanks.

Johan
