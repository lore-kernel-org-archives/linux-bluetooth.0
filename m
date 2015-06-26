Return-Path: <cyrus@holtmann.org>
Date: Fri, 26 Jun 2015 09:53:13 +0200
From: Alexander Aring <alex.aring@gmail.com>
To: paras kumar <paras.kumar@samsung.com>
Cc: jukka.rissanen@linux.intel.com, marcel@holtmann.org,
	johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org
Subject: Re: Re: Query regarding IPv6 address configuration for BT 6lowpan
 device/interface
Message-ID: <20150626075309.GA959@omega>
References: <037401d0a9a4$b5f9c4c0$21ed4e40$@samsung.com>
 <20150618090842.GA4544@omega>
 <022a01d0afcc$b9936c20$2cba4460$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <022a01d0afcc$b9936c20$2cba4460$@samsung.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Jun 26, 2015 at 10:28:10AM +0530, paras kumar wrote:
> Hello All,
> 
> Please help me to understand below queries.
> 

sorry, I don't help you to making backports. I am currently busy with
other things which are related to mainline work. I can't help you.

The missing ARPHRF_6LOWPAN in addrconf was just a shoot into the dark,
because you don't have the stateless autoconfiguration and this needed to
be there for that. I really have no idea about the following panic and
why it occurs, maybe providing the stacktrace would be nice that I have
more information. But I think it's more work than just copying the files
to kernel version 3.10.

I also don't know if somebody did a backport to earlier kernel versions.
Otherwise I would mentioned that here, but you are the first one.

- Alex
