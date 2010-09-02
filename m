Return-Path: <cyrus@holtmann.org>
Subject: Re: CSP implementation for MCAP
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=iso-8859-1
From: =?iso-8859-1?Q?Elvis_Pf=FCtzenreuter?= <epx@signove.com>
In-Reply-To: <20100902204022.GA18957@jh-x301>
Date: Thu, 2 Sep 2010 18:49:27 -0300
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <7120005A-6C60-4A79-990D-DF4937855EF7@signove.com>
References: <4A11989E-5448-43B7-887F-217C54977E22@epx.com.br> <20100902202806.GA8391@jh-x301> <FC6865EA-F6F4-459A-9962-7215F8B0509C@signove.com> <20100902204022.GA18957@jh-x301>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


On Sep 2, 2010, at 5:40 PM, Johan Hedberg wrote:

> Hi Elvis,
> 
> On Thu, Sep 02, 2010, Elvis Pfützenreuter wrote:
>>> - I'm not so happy about all the ifdefs in the code and the way that
>>> they are used. So this may need some rethinking. Probably we could
>>> have the code always compiled in and have a runtime variable to
>>> disable its use.
>> 
>> Such variable already exists, and starts turned off. So could I remove
>> the --enable-mcap-csp flag altogether?
> 
> Yes, I think a single --enable-mcap that covers also csp should be
> enough.

Ok, those first changes have been made and tested. Waiting for the next round.