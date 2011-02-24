Return-Path: <cyrus@holtmann.org>
Date: Thu, 24 Feb 2011 17:40:07 -0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: Andre Guedes <andre.guedes@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] hcitool: add discovery procedure to lescan command
Message-ID: <20110224204007.GA30774@jh-x301>
References: <1298495788-22273-1-git-send-email-andre.guedes@openbossa.org>
 <20110224025437.GA6189@jh-x301>
 <AANLkTi=ZGNaLi7VUBzEWoDffcJaP9HPmxf_AmAcPw_g-@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <AANLkTi=ZGNaLi7VUBzEWoDffcJaP9HPmxf_AmAcPw_g-@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Feb 24, 2011, Anderson Lizardo wrote:
> On Wed, Feb 23, 2011 at 11:54 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> > Hi André,
> >
> > On Wed, Feb 23, 2011, Andre Guedes wrote:
> >> +     "\tlescan [--discovery=g|l] enable general or limited discovery"
> >
> > To make this consistent with the other options please default to general
> > and have a --limited switch to enable limited discovery.
> 
> Note that there are actually three modes:
> 
> 1) the default one, when no parameters are given: do not filter
> anything, useful for debugging (this is what is currently done)
> 2) limited discovery
> 3) general discovery
> 
> limited/general are done according to the procedure description on the spec.

Ok, then the patch makes sense. It has now been pushed upstream.

Johan
