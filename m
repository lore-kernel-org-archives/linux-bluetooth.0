Return-Path: <cyrus@holtmann.org>
Date: Mon, 4 Nov 2013 21:15:14 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/client: Fix annoying delay in command line
Message-ID: <20131104191514.GC13837@x220.p-661hnu-f1>
References: <1383564824-32337-1-git-send-email-jerzy.kasenberg@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1383564824-32337-1-git-send-email-jerzy.kasenberg@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jerzy,

On Mon, Nov 04, 2013, Jerzy Kasenberg wrote:
> Move fflush(stdout) to after prints and user input.
> This removes delay of showing prompt.
> ---
> Same effect could be achieved by calling setbuf(stdout, NULL)
> in terminal_setup() then all fflush calls could be removed.
> 
> If you think this should be better approach, I will change it.
> 
>  android/client/pollhandler.c |    5 -----
>  android/client/terminal.c    |    6 ++++++
>  2 files changed, 6 insertions(+), 5 deletions(-)

Applied. Thanks.

Johan
