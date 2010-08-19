Return-Path: <cyrus@holtmann.org>
Date: Thu, 19 Aug 2010 09:34:20 +0300
From: Johan Hedberg <johan.hedberg@nokia.com>
To: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix problem with multiple emails in vcard
Message-ID: <20100819063420.GA3661@jh-x301>
References: <1282198407-4025-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1282198407-4025-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Radek,

On Thu, Aug 19, 2010, Radoslaw Jablonski wrote:
> +	char *birthday;
> +	char *nickname;
> +	char *website;
> +	char *photo;
> +	char *company;
> +	char *department;
> +	char *title;

How is this part related to your patch (about email support in vCards)?
Seems like it belongs to some other patch. The rest of the patch seems
fine to me.

Johan
