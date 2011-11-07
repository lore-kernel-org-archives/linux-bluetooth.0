Return-Path: <cyrus@holtmann.org>
Date: Mon, 7 Nov 2011 21:36:48 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] btmgmt: fix used without initialization
Message-ID: <20111107193648.GA2597@fusion.localdomain>
References: <1320685115-20542-1-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1320685115-20542-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Mon, Nov 07, 2011, Claudio Takahasi wrote:
> This patch fixes the following warning being treated as error:
> mgmt/main.c: In function 'mgmt_process_data':
> mgmt/main.c:508:3: error: 'len' may be used uninitialized in this
> function [-Werror=uninitialized]
> ---
>  mgmt/main.c |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)

Thanks for the heads-up. Seems like my gcc is buggy since it doesn't
catch this even when I use bootstrap-configure. The original intent of
the code was to have return ret which is what I pushed as a fix (-errno
would be more sophisticated but then it'd make sense to fix several
other places in the code too). Btw, please keep "int err" variables
negative so that we have consistency in the code-base and avoid stupid
bugs.

Johan
