Return-Path: <cyrus@holtmann.org>
Date: Mon, 10 Mar 2014 10:30:25 +0200
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] unit/avrcp: Add /TP/NFY/BV-03-C test
Message-ID: <20140310083023.GA9620@aemeltch-MOBL1>
References: <1394206711-5508-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1394206711-5508-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Mar 07, 2014 at 05:38:30PM +0200, Andrei Emeltchenko wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Test verifies that Target responds Register notification command with
> parameter AVRCP_EVENT_SETTINGS_CHANGED.

ping

> ---
>  unit/test-avrcp.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
> index 0e3bb51..c442001 100644
> --- a/unit/test-avrcp.c
> +++ b/unit/test-avrcp.c
> @@ -521,6 +521,12 @@ static ssize_t avrcp_handle_register_notification(struct avrcp *session,
>  		memset(&pdu[1], 0xff, 8);
>  		pdu_len += 8;
>  		break;
> +	case AVRCP_EVENT_SETTINGS_CHANGED:
> +		pdu[1] = 0x01;
> +		pdu[2] = 0x01;
> +		pdu[3] = 0x02;
> +		pdu_len = 4;
> +		break;
>  	default:
>  		return -EINVAL;
>  	}
> @@ -938,5 +944,23 @@ int main(int argc, char *argv[])
>  				0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
>  				0xff, 0xff));
>  
> +	/* Register notification - TG */
> +	define_test("/TP/NFY/BV-03-C", test_server,
> +			raw_pdu(0x00, 0x11, 0x0e, 0x03, 0x48, 0x00,
> +				0x00, 0x19, 0x58, AVRCP_REGISTER_NOTIFICATION,
> +				0x00, 0x00, 0x05,
> +				AVRCP_EVENT_SETTINGS_CHANGED,
> +				0x00, 0x00, 0x00, 0x00),
> +			raw_pdu(0x02, 0x11, 0x0e, AVC_CTYPE_INTERIM, 0x48, 0x00,
> +				0x00, 0x19, 0x58, AVRCP_REGISTER_NOTIFICATION,
> +				0x00, 0x00, 0x04,
> +				AVRCP_EVENT_SETTINGS_CHANGED,
> +				0x01, 0x01, 0x02),
> +			raw_pdu(0x02, 0x11, 0x0e, AVC_CTYPE_CHANGED, 0x48, 0x00,
> +				0x00, 0x19, 0x58, AVRCP_REGISTER_NOTIFICATION,
> +				0x00, 0x00, 0x04,
> +				AVRCP_EVENT_SETTINGS_CHANGED,
> +				0x01, 0x01, 0x02));
> +
>  	return g_test_run();
>  }
> -- 
> 1.8.3.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
