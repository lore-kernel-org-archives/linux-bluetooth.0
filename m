Return-Path: <cyrus@holtmann.org>
Date: Wed, 21 Dec 2011 12:28:43 +0200
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Brian Gix <bgix@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH-v7 1/2] Bluetooth: Add MITM mechanism to LE-SMP
Message-ID: <20111221102841.GB21295@aemeltch-MOBL1>
References: <1324429482-2755-1-git-send-email-bgix@codeaurora.org>
 <1324429482-2755-2-git-send-email-bgix@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1324429482-2755-2-git-send-email-bgix@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Brian,

On Tue, Dec 20, 2011 at 05:04:41PM -0800, Brian Gix wrote:
> To achive Man-In-The-Middle (MITM) level security with Low Energy,
> we have to enable User Passkey Comparison.  This commit modifies the
> hard-coded JUST-WORKS pairing mechanism to support query via the MGMT
> interface of Passkey comparison and User Confirmation.
> 
> Signed-off-by: Brian Gix <bgix@codeaurora.org>
> ---
>  include/net/bluetooth/hci_core.h |    1 +
>  include/net/bluetooth/smp.h      |    5 +
>  net/bluetooth/smp.c              |  227 ++++++++++++++++++++++++++++++++++----
>  3 files changed, 211 insertions(+), 22 deletions(-)

...

> +static int tk_request(struct l2cap_conn *conn, u8 remote_oob, u8 auth,
> +						u8 local_io, u8 remote_io)
> +{
> +	struct hci_conn *hcon = conn->hcon;
> +	struct smp_chan *smp = conn->smp_chan;
> +	u8 method;
> +	u32 passkey = 0;
> +	int ret = 0;
> +
> +	/* Initialize key to JUST WORKS */
> +	memset(smp->tk, 0, sizeof(smp->tk));
> +	clear_bit(SMP_FLAG_TK_VALID, &smp->smp_flags);
> +
> +	BT_DBG("tk_request: auth:%d lcl:%d rem:%d", auth, local_io, remote_io);
> +
> +	/* If neither side wants MITM, use JUST WORKS */
> +	/* If either side has unknown io_caps, use JUST_WORKS */
> +	if (!(auth & SMP_AUTH_MITM) ||
> +			local_io > SMP_IO_KEYBOARD_DISPLAY ||
> +			remote_io > SMP_IO_KEYBOARD_DISPLAY) {
> +		auth &= ~SMP_AUTH_MITM;
> +		set_bit(SMP_FLAG_TK_VALID, &smp->smp_flags);
> +		return 0;
> +	}
> +
> +	/* MITM is now officially requested, but not required */
> +	/* Determine what we need (if anything) from the agent */
> +	method = gen_method[local_io][remote_io];
> +
> +	if (method == JUST_WORKS || method == JUST_CFM)
> +		auth &= ~SMP_AUTH_MITM;
> +
> +	/* Don't bother confirming unbonded JUST_WORKS */
> +	if (!(auth & SMP_AUTH_BONDING) && method == JUST_CFM) {
> +		set_bit(SMP_FLAG_TK_VALID, &smp->smp_flags);
> +		return 0;
> +	} else if (method == JUST_WORKS) {
> +		set_bit(SMP_FLAG_TK_VALID, &smp->smp_flags);
> +		return 0;
> +	} else if (method == OVERLAP) {
> +		if (hcon->link_mode & HCI_LM_MASTER)
> +			method = CFM_PASSKEY;
> +		else
> +			method = REQ_PASSKEY;
> +	}
> +
> +	if (method == CFM_PASSKEY) {
> +		u8 key[16];
> +		/* Generate a passkey for display. It is not valid until
> +		 * confirmed.
> +		 */
> +		memset(key, 0, sizeof(key));
> +		get_random_bytes(&passkey, sizeof(passkey));
> +		passkey %= 1000000;
> +		put_unaligned_le32(passkey, key);
> +		swap128(key, smp->tk);
> +		BT_DBG("PassKey: %d", passkey);
> +	}

Would it make sense to use switch(method) instead of [if/else/else if] ?

Best regards 
Andrei Emeltchenko 

