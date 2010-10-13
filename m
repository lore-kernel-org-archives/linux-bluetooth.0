Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Fix problem with operator name length
From: Dmitriy Paliy <dmitriy.paliy@nokia.com>
To: ext Johan Hedberg <johan.hedberg@gmail.com>,
	Lukasz Pawlik <lucas.pawlik@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
In-Reply-To: <20101013141921.GB4828@jh-x301>
References: <1286974170-12282-1-git-send-email-lucas.pawlik@gmail.com>
	 <20101013141921.GB4828@jh-x301>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 13 Oct 2010 17:52:51 +0300
Message-ID: <1286981571.2142.5.camel@dp-x301>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

At the moment it is received in ascii from csd since not all car kits
can handle utf8.

Br,
Dmitriy

On Wed, 2010-10-13 at 16:19 +0200, ext Johan Hedberg wrote:
> Hi Lukasz,
> 
> On Wed, Oct 13, 2010, Lukasz Pawlik wrote:
> > -	net.operator_name = g_strdup(name);
> > -
> > +	net.operator_name = g_strndup(name, 16);
> 
> Is it possible that the the format of the name would be such that byte
> boundaries are not always the same as character boundaries (e.g. UTF-8)?
> If so, using g_strndup sounds dangerous since it assumes one byte per
> character.
> 
> Johan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


