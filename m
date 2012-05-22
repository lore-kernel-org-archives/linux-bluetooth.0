Return-Path: <cyrus@holtmann.org>
Date: Tue, 22 May 2012 13:50:27 -0700 (PDT)
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org, gustavo@padovan.org, marcel@holtmann.org
cc: pkrystad@codeaurora.org
Subject: Re: [PATCH] Bluetooth: Send a configuration request after security
 confirmation
In-Reply-To: <1337719690-986-1-git-send-email-mathewm@codeaurora.org>
Message-ID: <alpine.DEB.2.02.1205221348570.2239@mathewm-linux>
References: <1337719690-986-1-git-send-email-mathewm@codeaurora.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>


Gustavo & Marcel -

On Tue, 22 May 2012, Mat Martineau wrote:

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
> net/bluetooth/l2cap_core.c |   11 +++++++++++
> 1 file changed, 11 insertions(+)
>
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index b644f40..f6c3b0c 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -5519,6 +5519,17 @@ int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
> 			rsp.status = cpu_to_le16(stat);
> 			l2cap_send_cmd(conn, chan->ident, L2CAP_CONN_RSP,
> 							sizeof(rsp), &rsp);
> +
> +			if (!test_bit(L2CAP_CONF_REQ_SENT, &chan->conf_state) &&

Sorry, L2CAP_CONF_REQ_SENT has been renamed.  I'll sent a v2 patch 
shortly.

> +			    result == L2CAP_CR_SUCCESS) {
> +				char buf[128];
> +				set_bit(L2CAP_CONF_REQ_SENT, &chan->conf_state);
> +				l2cap_send_cmd(conn, l2cap_get_ident(conn),
> +					       L2CAP_CONF_REQ,
> +					       l2cap_build_conf_req(chan, buf),
> +					       buf);
> +				chan->num_conf_req++;
> +			}
> 		}
>
> 		l2cap_chan_unlock(chan);
> -- 
> 1.7.10



--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
