Return-Path: <cyrus@holtmann.org>
Date: Fri, 22 Mar 2013 12:55:16 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: Re: [RFC v0 02/11] device: Use btd_service to represent profiles
Message-ID: <20130322105516.GB10769@x220.ger.corp.intel.com>
References: <1363678855-12765-1-git-send-email-mikel.astiz.oss@gmail.com>
 <1363678855-12765-3-git-send-email-mikel.astiz.oss@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1363678855-12765-3-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Tue, Mar 19, 2013, Mikel Astiz wrote:
> +static gint service_profile_cmp(gconstpointer a, gconstpointer b)
> +{
> +	struct btd_service *service = (gpointer) a;
> +	struct btd_profile *profile = (gpointer) b;

Instead of this explicit casting why not declare the local variables
const too?

Johan
