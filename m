Return-Path: <cyrus@holtmann.org>
Date: Wed, 1 Dec 2010 13:21:38 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Waldemar.Rymarkiewicz@tieto.com
Cc: marcel@holtmann.org, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Sim Access Profile API
Message-ID: <20101201112138.GA1855@jh-x301>
References: <1291113364-6401-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
 <1291113364-6401-2-git-send-email-waldemar.rymarkiewicz@tieto.com>
 <1291200591.4795.95.camel@aeonflux>
 <99B09243E1A5DA4898CDD8B7001114480BDADF1B1B@EXMB04.eu.tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <99B09243E1A5DA4898CDD8B7001114480BDADF1B1B@EXMB04.eu.tieto.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Waldek,

On Wed, Dec 01, 2010, Waldemar.Rymarkiewicz@tieto.com wrote:
> >do we want this really as property? Wouldn't be configuration 
> >option be better to enable this. None of the other profiles 
> >has this anymore. 
> 
> Well, that is actually a proposal and I don't see any problems if we
> go for conf options in here. Even more, that would be if fact more
> usef-ull.  Is the main.conf a right place for say EnableSAP=true
> option ?

If the SAP support is all contained within a single plugin you probably
don't need a new option at all but can simply use the DisablePlugins
option for it.

Johan
