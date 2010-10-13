Return-Path: <cyrus@holtmann.org>
Date: Wed, 13 Oct 2010 17:19:21 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Lukasz Pawlik <lucas.pawlik@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix problem with operator name length
Message-ID: <20101013141921.GB4828@jh-x301>
References: <1286974170-12282-1-git-send-email-lucas.pawlik@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1286974170-12282-1-git-send-email-lucas.pawlik@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

On Wed, Oct 13, 2010, Lukasz Pawlik wrote:
> -	net.operator_name = g_strdup(name);
> -
> +	net.operator_name = g_strndup(name, 16);

Is it possible that the the format of the name would be such that byte
boundaries are not always the same as character boundaries (e.g. UTF-8)?
If so, using g_strndup sounds dangerous since it assumes one byte per
character.

Johan
