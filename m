Return-Path: <cyrus@holtmann.org>
Date: Fri, 11 Feb 2011 13:10:10 -0800
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: hcitool: add option for LE_Scan_Type
 parameter
Message-ID: <20110211211010.GC26894@jh-x301>
References: <1297373795-14909-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <20110211210607.GB26894@jh-x301>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110211210607.GB26894@jh-x301>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Feb 11, 2011, Johan Hedberg wrote:
> Hi Andrei,
> 
> On Thu, Feb 10, 2011, Emeltchenko Andrei wrote:
> > +	"\tlescan [--scantype] set scan type 0 - passive, 1 - active (default)\n";
> 
> Maybe this should be a boolean flag like the address type? I.e.
> --passive and/or --active command line switches?

Nevermind. I see that you already sent an updated patch which does this.

Johan
