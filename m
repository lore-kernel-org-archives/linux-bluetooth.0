Return-Path: <cyrus@holtmann.org>
Message-ID: <1360136648.15783.3.camel@aeonflux>
Subject: Re: [PATCH 1/2] hostname: Fallback to static hostname if pretty
 hostname is not set
From: Marcel Holtmann <marcel@holtmann.org>
To: Szymon Janc <szymon@janc.net.pl>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 06 Feb 2013 09:44:08 +0200
In-Reply-To: <1360098656-12488-1-git-send-email-szymon@janc.net.pl>
References: <1360098656-12488-1-git-send-email-szymon@janc.net.pl>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

> If pretty hostname is not set fallback to static hostname (if it is
> set). If static or pretty hostname is not set appropriate properties
> are empty strings not NULLs. This behaviour is recomended by hostnamed.
> 
> Also fix setting adapter name to empty string if pretty hostname was
> not set.

please do not squeeze to patches into one.

I am also not convinced that we should bother with the static hostname
at all. I left this out on purpose. My thinking here was that if we do
not have a pretty hostname, then why bother with trying to make
something useful out of the hostname, it would be ugly or wrong anyway.

Regards

Marcel


