Return-Path: <cyrus@holtmann.org>
Date: Fri, 13 Jun 2014 15:44:15 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] HDP: Set error message on error condition
Message-ID: <20140613124415.GB13193@t440s.lan>
References: <1402398695-10975-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1402398695-10975-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Tue, Jun 10, 2014, Andrei Emeltchenko wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Fixes clang warning:
> ...
>   CC       profiles/health/bluetoothd-hdp.o
> profiles/health/hdp.c:1778:13: warning: Access to field 'message'
> results in a dereference of a null pointer (loaded from variable 'gerr')
>                                                 "%s", gerr->message);
>                                                       ^~~~~~~~~~~~~
> ...
> ---
>  profiles/health/hdp.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Applied. Thanks.

Johan
