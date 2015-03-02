Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 06/12] profiles/network: Fix sending command responses
Date: Mon, 02 Mar 2015 11:12:59 +0100
Message-ID: <2614031.O79LzPuJtE@uw000953>
In-Reply-To: <1424951614-8527-6-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1424951614-8527-1-git-send-email-grzegorz.kolodziejczyk@tieto.com> <1424951614-8527-6-git-send-email-grzegorz.kolodziejczyk@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Grzegorz,

On Thursday 26 of February 2015 12:53:28 Grzegorz Kolodziejczyk wrote:
> Command response can be three bytes long (in case if command is not
> understood) 1 byte(packet type) + 1 byte(control type) + 1 byte(unknown
> control type). Command response can be also four bytes long if it's
> response for setup connection, filter net type and filter multi addr,
> 1 byte(packet type) + 1 byte(control type) + 2 byte(response message).
> ---
>  lib/bnep.h              |  6 +++++
>  profiles/network/bnep.c | 59 +++++++++++++++++++++++++++++++++++--------------
>  2 files changed, 48 insertions(+), 17 deletions(-)
> 
> diff --git a/lib/bnep.h b/lib/bnep.h
> index 2bbfb17..aa46852 100644
> --- a/lib/bnep.h
> +++ b/lib/bnep.h
> @@ -103,6 +103,12 @@ struct bnep_set_filter_req {
>  	uint8_t  list[0];
>  } __attribute__((packed));
>  
> +struct bnep_ctrl_cmd_not_understood_cmd {
> +	uint8_t type;
> +	uint8_t ctrl;
> +	uint8_t unkn_ctrl;
> +} __attribute__((packed));
> +
>  struct bnep_control_rsp {
>  	uint8_t  type;
>  	uint8_t  ctrl;
> diff --git a/profiles/network/bnep.c b/profiles/network/bnep.c
> index bef9b60..132dbab 100644
> --- a/profiles/network/bnep.c
> +++ b/profiles/network/bnep.c
> @@ -549,16 +549,40 @@ static int bnep_del_from_bridge(const char *devname, const char *bridge)
>  	return err;
>  }
>  
> -static ssize_t bnep_send_ctrl_rsp(int sk, uint8_t type, uint8_t ctrl,
> -								uint16_t resp)
> +static ssize_t bnep_send_ctrl_rsp(int sk, uint8_t ctrl, uint16_t resp)
>  {
> -	struct bnep_control_rsp rsp;
> +	ssize_t sent;
>  
> -	rsp.type = type;
> -	rsp.ctrl = ctrl;
> -	rsp.resp = htons(resp);
> +	switch (ctrl) {
> +	case BNEP_CMD_NOT_UNDERSTOOD: {
> +		struct bnep_ctrl_cmd_not_understood_cmd rsp;
>  
> -	return send(sk, &rsp, sizeof(rsp), 0);
> +		rsp.type = BNEP_CONTROL;
> +		rsp.ctrl = ctrl;
> +		rsp.unkn_ctrl = (uint8_t) resp;
> +
> +		sent = send(sk, &rsp, sizeof(rsp), 0);
> +		break;
> +	}
> +	case BNEP_FILTER_MULT_ADDR_RSP:
> +	case BNEP_FILTER_NET_TYPE_RSP:
> +	case BNEP_SETUP_CONN_RSP: {
> +		struct bnep_control_rsp rsp;
> +
> +		rsp.type = BNEP_CONTROL;
> +		rsp.ctrl = ctrl;
> +		rsp.resp = htons(resp);
> +
> +		sent = send(sk, &rsp, sizeof(rsp), 0);
> +		break;
> +	}
> +	default:
> +		error("wrong bnep response type");
> +		sent = -1;
> +		break;
> +	}
> +
> +	return sent;
>  }
>  
>  static uint16_t bnep_setup_decode(int sk, struct bnep_setup_conn_req *req,
> @@ -637,16 +661,15 @@ int bnep_server_add(int sk, char *bridge, char *iface, const bdaddr_t *addr,
>  	/* Highest known Control command ID
>  	 * is BNEP_FILTER_MULT_ADDR_RSP = 0x06 */
>  	if (req->type == BNEP_CONTROL &&
> -				req->ctrl > BNEP_FILTER_MULT_ADDR_RSP) {
> -		uint8_t pkt[3];
> -
> -		pkt[0] = BNEP_CONTROL;
> -		pkt[1] = BNEP_CMD_NOT_UNDERSTOOD;
> -		pkt[2] = req->ctrl;
> +					req->ctrl > BNEP_FILTER_MULT_ADDR_RSP) {
> +		error("cmd not understood");

Please prefix error/info with "bnep: "

> +		err = bnep_send_ctrl_rsp(sk, BNEP_CMD_NOT_UNDERSTOOD,
> +								req->ctrl);
> +		if (err < 0)
> +			error("send not understood ctrl rsp error: %s (%d)",
> +							strerror(errno), errno);
>  
> -		send(sk, pkt, sizeof(pkt), 0);
> -
> -		return -EINVAL;
> +		return err;
>  	}
>  
>  	/* Processing BNEP_SETUP_CONNECTION_REQUEST_MSG */
> @@ -681,7 +704,9 @@ int bnep_server_add(int sk, char *bridge, char *iface, const bdaddr_t *addr,
>  		rsp = BNEP_CONN_NOT_ALLOWED;
>  
>  reply:
> -	bnep_send_ctrl_rsp(sk, BNEP_CONTROL, BNEP_SETUP_CONN_RSP, rsp);
> +	err = bnep_send_ctrl_rsp(sk, BNEP_SETUP_CONN_RSP, rsp);
> +	if (err < 0)
> +		error("send ctrl rsp error: %s (%d)", strerror(errno), errno);
>  
>  	return err;
>  }
> 

-- 
Best regards, 
Szymon Janc
