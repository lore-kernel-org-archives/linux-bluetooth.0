Return-Path: <cyrus@holtmann.org>
Subject: Re: CSP implementation for MCAP
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=iso-8859-1
From: =?iso-8859-1?Q?Elvis_Pf=FCtzenreuter?= <epx@signove.com>
In-Reply-To: <20100902202806.GA8391@jh-x301>
Date: Thu, 2 Sep 2010 17:36:47 -0300
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <FC6865EA-F6F4-459A-9962-7215F8B0509C@signove.com>
References: <4A11989E-5448-43B7-887F-217C54977E22@epx.com.br> <20100902202806.GA8391@jh-x301>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


On Sep 2, 2010, at 5:28 PM, Johan Hedberg wrote:

> Hi Elvis,
> 
> On Thu, Sep 02, 2010, Elvis Pfützenreuter wrote:
>> This is the repository for the CSP implementation, rebased over the
>> recently accepted MCAP, for your appreciation:
>> 
>> git://gitorious.org/bluez-epx/bluez-epx.git csp
> 
> A couple of quick comments:
> 
> - Several of the commits in the tree have the author as
>  "epx <epx@xenicall.(none)>". That needs fixing.

Ouch :(

> - I'm not so happy about all the ifdefs in the code and the way that
>  they are used. So this may need some rethinking. Probably we could
>  have the code always compiled in and have a runtime variable to
>  disable its use.

Such variable already exists, and starts turned off. So could I remove the --enable-mcap-csp flag altogether?

> Johan

