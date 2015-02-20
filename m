Return-Path: <cyrus@holtmann.org>
Date: Fri, 20 Feb 2015 12:55:25 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC BlueZ 3/3] tools/btgatt-client: Add signed write support
Message-ID: <20150220105525.GA25329@t440s.lan>
References: <1424428710-8907-1-git-send-email-luiz.dentz@gmail.com>
 <1424428710-8907-3-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1424428710-8907-3-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Fri, Feb 20, 2015, Luiz Augusto von Dentz wrote:
> +static bool convert_csrk_key(char *optarg, uint8_t csrk[16])
> +{
> +	int i;
> +	char value[2];
> +
> +	if (strlen(optarg) != 32) {
> +		printf("csrk length is invalid\n");
> +		return false;
> +	}
> +
> +	for (i = 0; i < 16; i++) {
> +		strncpy(value, optarg + (i * 2), 2);
> +		csrk[i] = strtol(value, NULL, 16);

It doesn't look like you've got enough space in 'value' for this. You'd
need 2 + 1 to have it nul-terminater. However, I think you can
completely get away with the need of this temporary variable by using
sscanf(), i.e. something like:

	sscanf(optarg + (i * 2), "%2hhx", &csrk[i]);

Johan
