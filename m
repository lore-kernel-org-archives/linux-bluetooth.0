Return-Path: <cyrus@holtmann.org>
Date: Wed, 1 Dec 2010 19:21:23 -0200
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv2 3/5] Bluetooth: clean up l2cap code
Message-ID: <20101201212123.GF16125@vigoh>
References: <1291215506-11398-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1291215506-11398-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1291215506-11398-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

* Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com> [2010-12-01 16:58:24 +0200]:

> From: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
> 
> Do not initialize static vars to zero, macros with complex values
> shall be enclosed with (), remove unneeded braces.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
> ---
>  include/net/bluetooth/l2cap.h |   10 +++++-----
>  net/bluetooth/l2cap.c         |    7 +++----
>  2 files changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
> index c819c8b..217bb91 100644
> --- a/include/net/bluetooth/l2cap.h
> +++ b/include/net/bluetooth/l2cap.h
> @@ -417,11 +417,11 @@ static inline int l2cap_tx_window_full(struct sock *sk)
>  	return sub == pi->remote_tx_win;
>  }
>  
> -#define __get_txseq(ctrl) ((ctrl) & L2CAP_CTRL_TXSEQ) >> 1
> -#define __get_reqseq(ctrl) ((ctrl) & L2CAP_CTRL_REQSEQ) >> 8
> -#define __is_iframe(ctrl) !((ctrl) & L2CAP_CTRL_FRAME_TYPE)
> -#define __is_sframe(ctrl) (ctrl) & L2CAP_CTRL_FRAME_TYPE
> -#define __is_sar_start(ctrl) ((ctrl) & L2CAP_CTRL_SAR) == L2CAP_SDU_START
> +#define __get_txseq(ctrl)	(((ctrl) & L2CAP_CTRL_TXSEQ) >> 1)
> +#define __get_reqseq(ctrl)	(((ctrl) & L2CAP_CTRL_REQSEQ) >> 8)
> +#define __is_iframe(ctrl)	(!((ctrl) & L2CAP_CTRL_FRAME_TYPE))
> +#define __is_sframe(ctrl)	((ctrl) & L2CAP_CTRL_FRAME_TYPE)
> +#define __is_sar_start(ctrl)	(((ctrl) & L2CAP_CTRL_SAR) == L2CAP_SDU_START)
>  
>  void l2cap_load(void);
>  
> diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
> index 12b4aa2..d4b4fbd 100644
> --- a/net/bluetooth/l2cap.c
> +++ b/net/bluetooth/l2cap.c
> @@ -57,7 +57,7 @@
>  
>  #define VERSION "2.15"
>  
> -static int disable_ertm = 0;
> +static int disable_ertm;

Same issue here.

-- 
Gustavo F. Padovan
http://profusion.mobi
