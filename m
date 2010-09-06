Return-Path: <cyrus@holtmann.org>
Date: Mon, 6 Sep 2010 14:30:31 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Bastien Nocera <hadess@hadess.net>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: Add new plugin to set adapter class
Message-ID: <20100906113031.GA23586@jh-x301>
References: <1283770089.7529.9.camel@localhost.localdomain>
 <20100906111516.GA23167@jh-x301>
 <1283771863.7529.10.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1283771863.7529.10.camel@localhost.localdomain>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

On Mon, Sep 06, 2010, Bastien Nocera wrote:
> > Previously it was possible to --disable-hal and be sure that whatever is
> > defined in main.conf gets used (this is e.g. something that has been
> > important for us in Maemo/MeeGo). Your patch seems to make one of the
> > two automated adapter class sources always be used and so potentially
> > overriding what main.conf says. So I'd prefer to keep the possibility of
> > disably any such plugins completely.
> 
> Take a look at the code, there's no ways to disable the HAL plugin right
> now. If you want a separate patch for that, I can certainly cook one up.

Yep, my memory was playing tricks on me here. We're actually using
DisablePlugins=hal in main.conf to avoid interference from this code.
The same would also work for your new plugin so build-time disabling
isn't strictly necessary then (but might be nice to have for some
platforms).

Johan
