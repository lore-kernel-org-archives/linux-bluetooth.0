Return-Path: <cyrus@holtmann.org>
Date: Wed, 28 Aug 2013 14:54:21 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Richard Neill <rn214@richardneill.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: How to test/debug bluetooth advertising [with hciconfig]?
Message-ID: <20130828115343.GE15469@aemeltch-MOBL1>
References: <521DCF49.5020807@richardneill.org>
 <20130828103920.GD15469@aemeltch-MOBL1>
 <521DDAB3.2050407@richardneill.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <521DDAB3.2050407@richardneill.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Richard,

On Wed, Aug 28, 2013 at 12:10:43PM +0100, Richard Neill wrote:
> 
> >On Wed, Aug 28, 2013 at 11:22:01AM +0100, Richard Neill wrote:
> >>Dear All,
> >>
> >>I'm trying to get "hello world" working from the shell between 2
> >>Bluetooth 4 dongles, in LE advertising mode. I wonder whether I
> >>could ask for some pointers?
> >
> >Check ogf and ocf from the Bluetooth Specification.
> 
> Dear Andrei,
> 
> Thanks for your reply. That was actually very helpful: by searching
> specifically for "ogf ocf Bluetooth specification", I was able to
> locate the right part of the relevant document (a 600 page PDF of
> Bluetooth 4.0 core).
> 
> However, before I delve into this in great detail, I wonder whether
> I am about to "re-invent the wheel".  For example, if I wanted to
> use "ping" in a shell-script, I wouldn't normally begin by poking
> registers in the ethernet card.

Then you should not use "hcitool cmd". Better use high level API.

Best regards 
Andrei Emeltchenko 

