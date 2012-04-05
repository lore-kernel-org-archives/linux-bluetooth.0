Return-Path: <cyrus@holtmann.org>
Date: Thu, 5 Apr 2012 09:35:15 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org,
	Andre Guedes <andre.guedes@openbossa.org>
Subject: Re: [RFC BlueZ 4/4] l2test: Add option to inform the address type
Message-ID: <20120405063513.GA804@aemeltch-MOBL1>
References: <1333570571-29650-1-git-send-email-claudio.takahasi@openbossa.org>
 <1333570571-29650-4-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1333570571-29650-4-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Wed, Apr 04, 2012 at 05:16:11PM -0300, Claudio Takahasi wrote:
...

> +	addr.l2_bdaddr_type = bdaddr_type;
>  	if (cid)

...

> @@ -1020,6 +1022,7 @@ static void info_request(char *svr)
> +	addr.l2_bdaddr_type = bdaddr_type;

...

> @@ -1167,6 +1170,7 @@ static void do_pairing(char *svr)
> +	addr.l2_bdaddr_type = bdaddr_type;

...

> +		case 'V':
> +			bdaddr_type = atoi(optarg);

Apparently there is no check that value is correct. I think that you can
use here lookup_table (see l2cap_modes and chan_policies).

Best regards 
Andrei Emeltchenko 

