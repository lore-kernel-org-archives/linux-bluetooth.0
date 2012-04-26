Return-Path: <cyrus@holtmann.org>
Date: Thu, 26 Apr 2012 12:13:03 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] gatttool: Fix handle parsing in cmd_char_write()
Message-ID: <20120426091303.GA18380@x220>
References: <1335367519-16361-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1335367519-16361-1-git-send-email-andrzej.kaczmarek@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej,

On Wed, Apr 25, 2012, Andrzej Kaczmarek wrote:
> errno is not set to 0 before call to strtoll() so cmd_char_write() can fail
> even with proper data. Use strtohandle() helper function instead.
> ---
>  attrib/interactive.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied. Thanks.

Johan
