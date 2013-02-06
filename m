Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon@janc.net.pl>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] hostname: Fallback to static hostname if pretty hostname is not set
Date: Wed, 06 Feb 2013 21:29:43 +0100
Message-ID: <3769291.6MmiuAcpF2@athlon>
In-Reply-To: <1360136648.15783.3.camel@aeonflux>
References: <1360098656-12488-1-git-send-email-szymon@janc.net.pl> <1360136648.15783.3.camel@aeonflux>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-bluetooth.vger.kernel.org>

On Wednesday 06 February 2013 09:44:08 Marcel Holtmann wrote:

Hi Marcel,
 
> > If pretty hostname is not set fallback to static hostname (if it is
> > set). If static or pretty hostname is not set appropriate properties
> > are empty strings not NULLs. This behaviour is recomended by hostnamed.
> > 
> > Also fix setting adapter name to empty string if pretty hostname was
> > not set.
> 
> please do not squeeze to patches into one.

Will split that in v2.

> 
> I am also not convinced that we should bother with the static hostname
> at all. I left this out on purpose. My thinking here was that if we do
> not have a pretty hostname, then why bother with trying to make
> something useful out of the hostname, it would be ugly or wrong anyway.

Maybe not that fancy as pretty hostname but at least know to user(e.g for
some reason my Fedora doesn't have pretty hostname set and falling back to 
static hostname makes adapter name somewhat reasonable).
Also falling back to static hostname will allow hostname plugin to number
adapters' names. Yet, maybe main.conf parsing should be fixed instead to 
properly substitute %h/%d as stated in comment. Currently name is simply set 
to string '%h-%d' in such case...

-- 
Szymon K. Janc
szymon@janc.net.pl
