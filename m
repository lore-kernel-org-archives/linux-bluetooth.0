Return-Path: <cyrus@holtmann.org>
Date: Wed, 23 May 2012 11:20:15 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, gustavo@padovan.org,
	marcel@holtmann.org, pkrystad@codeaurora.org
Subject: Re: [PATCHv2] Bluetooth: Send a configuration request after security
 confirmation
Message-ID: <20120523082013.GB32022@aemeltch-MOBL1>
References: <1337720145-8019-1-git-send-email-mathewm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1337720145-8019-1-git-send-email-mathewm@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

On Tue, May 22, 2012 at 01:55:45PM -0700, Mat Martineau wrote:
> Sometimes an ACL link must be raised to a higher security level after
> an L2CAP connection is requested, but before a connection response is
> sent.  In this case, a connection response sent by L2CAP was not
> immediately followed by a configuration request.  Other code paths do
> send this configuration request right away.  It was possible for the
> connection to time out while L2CAP waited for the remote device (like
> PTS) to trigger the configuration process.
> 
> This change immediately sends a configuration request after a connect
> response rather than waiting for a configuration request from the
> remote device.  It fixes connection stalls in a variety of PTS test
> cases.
> 
> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> ---
>  net/bluetooth/l2cap_core.c |   11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index b644f40..14c27f4 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -5519,6 +5519,17 @@ int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
>  			rsp.status = cpu_to_le16(stat);
>  			l2cap_send_cmd(conn, chan->ident, L2CAP_CONN_RSP,
>  							sizeof(rsp), &rsp);
> +
> +			if (!test_bit(CONF_REQ_SENT, &chan->conf_state) &&
> +			    res == L2CAP_CR_SUCCESS) {

This looks more readable but I think we used to have constructions like
!status so this would translate to !res

Best regards 
Andrei Emeltchenko 
