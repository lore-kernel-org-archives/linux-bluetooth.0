Return-Path: <cyrus@holtmann.org>
Date: Sat, 14 Feb 2015 16:43:50 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 4/4] core: Add support for Multi Profile Specification
Message-ID: <20150214144350.GA9782@t440s.P-661HNU-F1>
References: <1423918946-14332-1-git-send-email-szymon.janc@tieto.com>
 <1423918946-14332-4-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1423918946-14332-4-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Sat, Feb 14, 2015, Szymon Janc wrote:
> +	str = g_key_file_get_string(config, "General", "MultiProfile", &err);
> +	if (err) {
> +		g_clear_error(&err);
> +	} else {
> +		DBG("MultiProfile=%s", str);
> +
> +		if (strcmp(str, "mpsd")) {
> +			mps_mpsd = true;
> +		} else if (strcmp(str, "mpmd")) {
> +			mps_mpsd = true;
> +			mps_mpmd = true;
> +		}

Shouldn't these be '!strcmp'?

Johan
