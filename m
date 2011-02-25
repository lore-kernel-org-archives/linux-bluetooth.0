Return-Path: <cyrus@holtmann.org>
Date: Fri, 25 Feb 2011 12:50:20 -0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org,
	par-gunnar.p.hjalmdahl@stericsson.com,
	henrik.possung@stericsson.com
Subject: Re: [PATCH v2 3/3] Bluetooth: Validate data size before accessing
 mgmt commands
Message-ID: <20110225155020.GC19437@jh-x301>
References: <1298476240-18124-1-git-send-email-szymon.janc@tieto.com>
 <1298476240-18124-3-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1298476240-18124-3-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Wed, Feb 23, 2011, Szymon Janc wrote:
> Crafted (too small) data buffer could result in reading data outside of buffer.
> Validate buffer size and return EINVAL if size is wrong..
> 
> Signed-off-by: Szymon Janc <szymon.janc@tieto.com>

The patch looks good, except for this part:

> @@ -1170,6 +1219,10 @@ static int user_confirm_reply(struct sock *sk, u16 index, unsigned char *data,
>  
>  	BT_DBG("");
>  
> +	if (len != sizeof(*cp))
> +		return cmd_status(sk, index, MGMT_OP_USER_CONFIRM_REPLY,
> +									EINVAL);
> +
>  	if (success) {
>  		mgmt_op = MGMT_OP_USER_CONFIRM_REPLY;
>  		hci_op = HCI_OP_USER_CONFIRM_REPLY;

Note that this function is also used for the negative reply so you can't
hard-code the MGMT_OP_USER_CONFIRM_REPLY in the cmd_status. Instead move
the if (success) part earlier in the function and then use mgmt_op for
the cmd_status.

When that's fixed:
Acked-by: Johan Hedberg <johan.hedberg@nokia.com>

Johan
