Return-Path: <cyrus@holtmann.org>
Date: Thu, 2 Dec 2010 09:12:24 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
Cc: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv2 1/5] Bluetooth: clean up sco code
Message-ID: <20101202071224.GA15525@jh-x301>
References: <1291215506-11398-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1291215506-11398-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <20101201212034.GE16125@vigoh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20101201212034.GE16125@vigoh>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Wed, Dec 01, 2010, Gustavo F. Padovan wrote:
> > -static int disable_esco = 0;
> > +static int disable_esco;
> 
> I don't think this change is right. Can we be sure that disable_esco
> will be 0 by default?

AFAIK we can since static variables are initialized to 0 by default.
However, I've understood that it's good style to have this
initialization explicit in the code so imho the code should be left as
it is.

Johan
