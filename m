Return-Path: <cyrus@holtmann.org>
Date: Fri, 22 Mar 2013 12:59:04 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: Re: [RFC v0 05/11] device: Replace pending profile list with services
Message-ID: <20130322105904.GD10769@x220.ger.corp.intel.com>
References: <1363678855-12765-1-git-send-email-mikel.astiz.oss@gmail.com>
 <1363678855-12765-6-git-send-email-mikel.astiz.oss@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1363678855-12765-6-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Tue, Mar 19, 2013, Mikel Astiz wrote:
> +static gint service_prio_cmp(gconstpointer a, gconstpointer b)
>  {
> -	const struct btd_profile *p1 = a, *p2 = b;
> +	struct btd_service *s1 = (gpointer) a;
> +	struct btd_service *s2 = (gpointer) b;

Again, adding const specifiers here would help avoid the explicit
casting.

Johan
