Return-Path: <cyrus@holtmann.org>
Date: Wed, 14 Nov 2012 13:11:40 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Frederic Danis <frederic.danis@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/4] adapter: Convert storage aliases
Message-ID: <20121114111140.GA8393@x220>
References: <1352888166-7391-1-git-send-email-frederic.danis@linux.intel.com>
 <20121114104553.GA6519@x220>
 <50A37AC7.1090009@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <50A37AC7.1090009@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Frederic,

On Wed, Nov 14, 2012, Frederic Danis wrote:
> On 14/11/2012 11:45, Johan Hedberg wrote:
> >Hi Frederic,
> >
> >On Wed, Nov 14, 2012, Frédéric Danis wrote:
> >>  #define SETTINGS_PATH STORAGEDIR "/%s/settings"
> >>  #define CACHE_PATH STORAGEDIR "/%s/cache/%s"
> >>+#define DEVICE_INFO_PATH STORAGEDIR "/%s/%s/info"
> >
> >Why do you have these separate defines? Do you need them in multiple
> >places? The define names are longer than the actual values and you're
> >just obfuscating the actual call that uses them (since you need to look
> >in two places to figure out of the format parameters are actually
> >matching the format string). So please don't use these.
> >
> 
> CACHE_PATH and DEVICE_INFO_PATH are only used in one place, so they
> can be removed.
> 
> SETTINGS_PATH is used in both store_adapter_info() and
> load_config(), so I think it is better to keep it.

I'd still just duplicate it in both places for readability. These
locations will be static at least for the entire 5.x series and maybe
longer.

Johan
