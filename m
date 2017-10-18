Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <1508291480.5910.76.camel@hadess.net>
Subject: Re: [PATCH 8/9] plugins/sixaxis: Add support for DualShock 4/PS4
 cable pairing
From: Bastien Nocera <hadess@hadess.net>
To: Szymon Janc <szymon.janc@codecoup.pl>
Cc: linux-bluetooth@vger.kernel.org,
        Juha Kuikka <juha.kuikka@gmail.com>
Date: Wed, 18 Oct 2017 03:51:20 +0200
In-Reply-To: <8659915.mKjsMy947m@ix>
References: <20170904181212.5639-1-hadess@hadess.net>
         <20170904181212.5639-8-hadess@hadess.net> <8659915.mKjsMy947m@ix>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, 2017-09-27 at 11:12 +0200, Szymon Janc wrote:
> Hi Bastien,
> 
> On Monday, 4 September 2017 20:12:11 CEST Bastien Nocera wrote:
> > <snip>
> 
> Lets prefix all sixaxis error/info logs with "sixaxis:"

Sure. I've reformulated the error messages so we know which type of
device we're printing an error about.
