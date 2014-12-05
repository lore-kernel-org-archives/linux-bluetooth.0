Return-Path: <cyrus@holtmann.org>
Message-ID: <1417786926.32209.9.camel@jrissane-mobl.ger.corp.intel.com>
Subject: Re: 6lowpan next header compression framwork: module handling or
 not?
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
	linux-wpan@vger.kernel.org, martin.townsend@xsilon.com
Date: Fri, 05 Dec 2014 15:42:06 +0200
In-Reply-To: <20141205124602.GB478@omega>
References: <20141205124602.GB478@omega>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alex,

On pe, 2014-12-05 at 13:46 +0100, Alexander Aring wrote:
> Hi,
> 
> last patch series Jukka, told me to make default "loading" of some next
> header compression formats. I agree with that, so users don't need to
> extra loading some next header compression modules.
> 
> Per default we support some compression formats, that sounds good.
> 
> 
> Before that Marcel told (I think if I understand it right) that he wants
> to have each nhc compression as separate module and users can do some
> modalias magic for autoloading.
> 
> Currently I see no option to add support for both of them.
> 
> If I do Jukka's default "loading" (not loading of module) I add nhc
> and all compression layers into the 6lowpan.ko module. While module_init
> of 6lowpan.ko we add all default nhc's. On module_exit we remove _all_
> registered nhc.
> 
> Marcel idea with modules we have in each nhc compression format a module_init
> and a module_exit function. In these functions the nhc compression format will
> be added to the nhc framework and removed. With this solution I can't
> implement some "load all defaults nhc modules, while loading 6lowpan.ko
> module. Users need to do some configuration to make this default
> available at startup.

If there would be a "default" module that gets automatically loaded if
no other module is used / configured, then both of these wished would be
full filled.

So my point was that the current way of compressing things i.e., the
"default" would be used if no other compression method is
found/configured (I probably expressed myself poorly in my previous
mail ;)
I am fine if the "default" being a module, as long as it is
automatically loaded. From the end user point of view, he/she should not
configure or do any magic in order to use 6lowpan.

> 
> 
> What should I do now?
> 
> - Alex


Cheers,
Jukka
