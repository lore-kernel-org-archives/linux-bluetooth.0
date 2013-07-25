Return-Path: <cyrus@holtmann.org>
Date: Thu, 25 Jul 2013 11:51:50 -0700
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] build: Fix make distcheck
Message-ID: <20130725185150.GA27285@x220.p-661hnu-f1>
References: <1374776746-14457-1-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1374776746-14457-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Thu, Jul 25, 2013, Anderson Lizardo wrote:
> Fix this error:
> 
> make[1]: *** No rule to make target `profiles/audio/audio.conf', needed
> by `distdir'.  Stop.
> make: *** [test_build] Error 2
> ---
>  Makefile.am |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Applied. Thanks.

Johan
