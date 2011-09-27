Return-Path: <cyrus@holtmann.org>
Date: Tue, 27 Sep 2011 12:26:53 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Yegor Yefremov <yegor_sub1@visionsystems.de>
Cc: linux-bluetooth@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] hciattach: fix serial speed setting for wl1271
Message-ID: <20110927092653.GX3952@dell>
References: <4E64D1B4.9020300@visionsystems.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4E64D1B4.9020300@visionsystems.de>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Yegor,

On Mon, Sep 05, 2011, Yegor Yefremov wrote:
> override speed setting if firmware script issues serial settings command,
> otherwise the value given in the firmware script will be overridden.
> 
> Example:
> 
> hciattach /dev/ttyO1 texas 115200
> 
> will fail, because /dev/ttyO1 will be opened with 115200 b/s, then
> the firmware script will set the buadrate to 3000000 b/s, after UART init
> hciattach.c will set the baudrate to 115200, so communication is broken.
> 
> The only correct way is to set both speeds:
> 
> hciattach -s 115200 /dev/ttyO1 texas 3000000
> 
> With this patch only initial speed must be specified. The former semantic
> will be preserved in case the firmware script doesn't provide serial
> settings action.
> 
> Tested with wl1271 and firmware TIInit_7.2.31.bts
> 
> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
> ---
>  tools/hciattach.c    |    2 +-
>  tools/hciattach.h    |    2 +-
>  tools/hciattach_ti.c |   19 +++++++++++--------
>  3 files changed, 13 insertions(+), 10 deletions(-)

Applied after fixing the commit message (we don't use Signed-off-by).
Thanks.

Johan
