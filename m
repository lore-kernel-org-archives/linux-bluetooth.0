Return-Path: <cyrus@holtmann.org>
Date: Wed, 15 Oct 2014 15:56:57 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3 1/2] Bluetooth: Fix RFCOMM NSC response
Message-ID: <20141015135657.GA24545@t440s.fdxtended.com>
References: <1413193434-16779-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1413193434-16779-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Mon, Oct 13, 2014, Szymon Janc wrote:
> rfcomm_send_nsc expects CR to be either 0 or 1 since it is later
> passed to __mcc_type macro and shitfed. Unfortunatelly CR extracted
> from received frame type was not sanitized and shifted value was passed
> resulting in bogus response.
> 
> Note: shifted value was also passed to other functions but was used
> only in if satements so this bug appears only for NSC case.
> 
> The CR bit in the value octet shall be set to the same value
> as the CR bit in the type field octet of the not supported command
> frame but the CR bit for NCS response should be set to 0 since it is
> always a response.
> 
> This was affecting TC_RFC_BV_25_C PTS qualification test.
> 
> Signed-off-by: Szymon Janc <szymon.janc@tieto.com>
> ---
> 
> V3: fixed invalid CR
> V2: moved sanitization to macro ifself
>     added second patch that also fix __test_pf 
> 
>  net/bluetooth/rfcomm/core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Both of these patches have been applied to bluetooth-next. Thanks.

Johan
