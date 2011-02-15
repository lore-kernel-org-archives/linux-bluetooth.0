Return-Path: <cyrus@holtmann.org>
Date: Tue, 15 Feb 2011 18:14:51 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC 1/3] Bluetooth: Add LE signaling commands handling
Message-ID: <20110215211451.GD7219@joana>
References: <1297459736-24514-1-git-send-email-claudio.takahasi@openbossa.org>
 <1297459736-24514-2-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1297459736-24514-2-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

* Claudio Takahasi <claudio.takahasi@openbossa.org> [2011-02-11 19:28:54 -0200]:

> This patch splits the L2CAP command handling function in order to
> have a clear separation between the commands related to BR/EDR and
> LE. Commands and responses in the LE signaling channel are not being
> handled yet, command reject is sent to all received requests. Bluetooth
> Core Specification, Volume 3, Part A, section 4 defines the signaling
> packets formats and allowed commands/responses over the LE signaling
> channel.
> 
> Signed-off-by: Claudio Takahasi <claudio.takahasi@openbossa.org>
> ---
>  include/net/bluetooth/l2cap.h |    2 +
>  net/bluetooth/l2cap_core.c    |  150 +++++++++++++++++++++++++++--------------
>  2 files changed, 100 insertions(+), 52 deletions(-)
> 
> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
> index 420981c..6aa70e9 100644
> --- a/include/net/bluetooth/l2cap.h
> +++ b/include/net/bluetooth/l2cap.h
> @@ -89,6 +89,8 @@ struct l2cap_conninfo {
>  #define L2CAP_ECHO_RSP		0x09
>  #define L2CAP_INFO_REQ		0x0a
>  #define L2CAP_INFO_RSP		0x0b
> +#define L2CAP_CONN_PARAM_UPDATE_REQ	0x12
> +#define L2CAP_CONN_PARAM_UPDATE_RSP	0x13
>  
>  /* L2CAP feature mask */
>  #define L2CAP_FEAT_FLOWCTL	0x00000001
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 0ca54d8..122fc1c 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -1435,7 +1435,11 @@ static struct sk_buff *l2cap_build_cmd(struct l2cap_conn *conn,
>  
>  	lh = (struct l2cap_hdr *) skb_put(skb, L2CAP_HDR_SIZE);
>  	lh->len = cpu_to_le16(L2CAP_CMD_HDR_SIZE + dlen);
> -	lh->cid = cpu_to_le16(L2CAP_CID_SIGNALING);
> +
> +	if (conn->hcon->type == LE_LINK)
> +		lh->cid = cpu_to_le16(L2CAP_CID_LE_SIGNALING);
> +	else
> +		lh->cid = cpu_to_le16(L2CAP_CID_SIGNALING);
>  
>  	cmd = (struct l2cap_cmd_hdr *) skb_put(skb, L2CAP_CMD_HDR_SIZE);
>  	cmd->code  = code;
> @@ -2504,12 +2508,98 @@ static inline int l2cap_information_rsp(struct l2cap_conn *conn, struct l2cap_cm
>  	return 0;
>  }
>  
> -static inline void l2cap_sig_channel(struct l2cap_conn *conn, struct sk_buff *skb)
> +static inline int bredr_sig_cmd(struct l2cap_conn *conn,
> +			struct l2cap_cmd_hdr *cmd, u16 cmd_len, u8 *data)
> +{
> +	int err = 0;
> +
> +	switch (cmd->code) {
> +	case L2CAP_COMMAND_REJ:
> +		l2cap_command_rej(conn, cmd, data);
> +		break;
> +
> +	case L2CAP_CONN_REQ:
> +		err = l2cap_connect_req(conn, cmd, data);
> +		break;
> +
> +	case L2CAP_CONN_RSP:
> +		err = l2cap_connect_rsp(conn, cmd, data);
> +		break;
> +
> +	case L2CAP_CONF_REQ:
> +		err = l2cap_config_req(conn, cmd, cmd_len, data);
> +		break;
> +
> +	case L2CAP_CONF_RSP:
> +		err = l2cap_config_rsp(conn, cmd, data);
> +		break;
> +
> +	case L2CAP_DISCONN_REQ:
> +		err = l2cap_disconnect_req(conn, cmd, data);
> +		break;
> +
> +	case L2CAP_DISCONN_RSP:
> +		err = l2cap_disconnect_rsp(conn, cmd, data);
> +		break;
> +
> +	case L2CAP_ECHO_REQ:
> +		l2cap_send_cmd(conn, cmd->ident, L2CAP_ECHO_RSP, cmd_len, data);
> +		break;
> +
> +	case L2CAP_ECHO_RSP:
> +		break;
> +
> +	case L2CAP_INFO_REQ:
> +		err = l2cap_information_req(conn, cmd, data);
> +		break;
> +
> +	case L2CAP_INFO_RSP:
> +		err = l2cap_information_rsp(conn, cmd, data);
> +		break;
> +
> +	default:
> +		BT_ERR("Unknown BR/EDR signaling command 0x%2.2x", cmd->code);
> +		err = -EINVAL;
> +		break;
> +	}
> +
> +	return err;
> +}
> +
> +static inline int le_sig_cmd(struct l2cap_conn *conn,
> +					struct l2cap_cmd_hdr *cmd, u8 *data)
> +{
> +	int err;

This var can be removed, I went ahead and removed it for you. Patch is now
applied. I also added a l2cap_ prefix to the new functions you added.

-- 
Gustavo F. Padovan
http://profusion.mobi
