Return-Path: <cyrus@holtmann.org>
Date: Thu, 17 Mar 2011 14:44:23 +0200
From: Johan Hedberg <johan.hedberg@nokia.com>
To: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Add 'Protocol not supported' error in a2dp_add_sep
Message-ID: <20110317124423.GB12238@jh-x301>
References: <1300276872-20149-1-git-send-email-dmitriy.paliy@nokia.com>
 <1300347949.2509.11.camel@dp-x301>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1300347949.2509.11.camel@dp-x301>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dmitriy,

On Thu, Mar 17, 2011, Dmitriy Paliy wrote:
> On Wed, 2011-03-16 at 14:01 +0200, ext Dmitriy Paliy wrote:
> > 'Protocol not supported' error code is added to registeration of A2DP
> > end-points. Error response org.bluez.Error.NotSupported instead of
> > org.bluez.Error.InvalidArguments is used when SEP registration fails
> > due to disabled corresponding interface in audio.conf.
> 
> Seems like there were some comment about this patch that I missed. Could
> anybody post a reply with them to this email?

The main concern raised on IRC was about the convention of returning an
integer error through a pointer parameter instead of the return value of
the function. Usually it's better to have integer errors in the return
value, but as the main purpose of this function is to create and return
and object and checking for the exact error is a secondary concern
(which isn't always needed). So I think it's kind of ok in this case and
I've therefore pushed the patch upstream. It'd be nice if we had similar
macros as the kernel has for encoding POSIX errno's into a pointer
value. Then this kind of issue wouldn't exist.

Johan
