Return-Path: <cyrus@holtmann.org>
Date: Tue, 17 Aug 2010 17:18:41 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Fix aborting capability scripts making them
 zombies processes
Message-ID: <20100817141841.GA16071@jh-x301>
References: <1282053510-18102-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1282053510-18102-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Tue, Aug 17, 2010, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>
> 
> When using G_SPAWN_DO_NOT_REAP_CHILD the watch cannot be removed since it
> basically replaces the use of waitpid which does prevent the child
> process to became 'zombie' when terminated, a more detailed explanation
> can be found in waitpid manpage.
> ---
>  plugins/filesystem.c |   28 ++++++++++++++++++----------
>  1 files changed, 18 insertions(+), 10 deletions(-)

Thanks. The patch is now upstream.

Johan
