Return-Path: <cyrus@holtmann.org>
Date: Thu, 24 May 2012 13:20:09 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Daniel Wagner <wagi@monom.org>
Cc: linux-bluetooth@vger.kernel.org,
	Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: Re: [PATCH v1 1/3] main: Add IngoreDUN configuration switch
Message-ID: <20120524102009.GB23856@x220>
References: <1337853618-7261-1-git-send-email-wagi@monom.org>
 <1337853618-7261-2-git-send-email-wagi@monom.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1337853618-7261-2-git-send-email-wagi@monom.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Daniel,

On Thu, May 24, 2012, Daniel Wagner wrote:
> +	main_opts.ignore_dun = TRUE;

I'd prefer if this defaulted to the old behavior, i.e. FALSE.

Johan
