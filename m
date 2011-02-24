Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20110224025437.GA6189@jh-x301>
References: <1298495788-22273-1-git-send-email-andre.guedes@openbossa.org>
	<20110224025437.GA6189@jh-x301>
Date: Thu, 24 Feb 2011 08:32:35 -0300
Message-ID: <AANLkTi=ZGNaLi7VUBzEWoDffcJaP9HPmxf_AmAcPw_g-@mail.gmail.com>
Subject: Re: [PATCH] hcitool: add discovery procedure to lescan command
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Andre Guedes <andre.guedes@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Cc: Johan Hedberg <johan.hedberg@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Wed, Feb 23, 2011 at 11:54 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi André,
>
> On Wed, Feb 23, 2011, Andre Guedes wrote:
>> +     "\tlescan [--discovery=g|l] enable general or limited discovery"
>
> To make this consistent with the other options please default to general
> and have a --limited switch to enable limited discovery.

Note that there are actually three modes:

1) the default one, when no parameters are given: do not filter
anything, useful for debugging (this is what is currently done)
2) limited discovery
3) general discovery

limited/general are done according to the procedure description on the spec.

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
