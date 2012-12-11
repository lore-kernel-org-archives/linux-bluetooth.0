Return-Path: <cyrus@holtmann.org>
Date: Tue, 11 Dec 2012 07:43:56 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/4] sap-u8500: Fix build errors due to unaligned memory
 access
Message-ID: <20121211054356.GA19828@x220.P-661HNU-F1>
References: <1353665354-32178-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1353665354-32178-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Fri, Nov 23, 2012, Szymon Janc wrote:
> This fix following compilation error on ARM.
> 
>   CC     profiles/sap/sap-u8500.o
> profiles/sap/sap-u8500.c: In function recv_card_status:
> profiles/sap/sap-u8500.c:323:16: error: cast increases required
> 	alignment of target type [-Werror=cast-align]
> profiles/sap/sap-u8500.c: In function recv_response:
> profiles/sap/sap-u8500.c:423:12: error: cast increases required
> 	alignment of target type [-Werror=cast-align]
> cc1: all warnings being treated as errors
> ---
>  profiles/sap/sap-u8500.c |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Sorry about the delay with these. All four are now upstream.

Johan
