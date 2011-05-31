Return-Path: <cyrus@holtmann.org>
Date: Tue, 31 May 2011 09:04:57 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 1/3] Clean SAP server error printouts
Message-ID: <20110531060457.GA15916@dell.ger.corp.intel.com>
References: <1306749575-21119-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1306749575-21119-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Waldek,

On Mon, May 30, 2011, Waldemar Rymarkiewicz wrote:
> @@ -387,8 +385,10 @@ static int disconnect_req(struct sap_connection *conn, uint8_t disc_type)
>  
>  	case SAP_DISCONNECTION_TYPE_CLIENT:
>  		if (conn->state != SAP_STATE_CONNECTED &&
> -				conn->state != SAP_STATE_GRACEFUL_DISCONNECT)
> -			goto error_rsp;
> +				conn->state != SAP_STATE_GRACEFUL_DISCONNECT) {
> +			sap_error_rsp(conn);
> +			goto error_req;
> +		}

Since all of the case statements return from the function in the
non-error case, and all the error_req label is doing is a single return
statment, I think it'd be cleaner (easier to follow the code flow) by
removing the label and do "return -EPERM;" directly instead of a goto.

Johan
