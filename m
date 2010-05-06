Return-Path: <cyrus@holtmann.org>
Date: Fri, 7 May 2010 01:56:33 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org
Subject: Re: [PATCH 6/6] Change end of line from DOS to UNIX
Message-ID: <20100506225633.GA15821@jh-x301>
References: <1273184832-8265-1-git-send-email-santoscadenas@gmail.com>
 <1273184832-8265-6-git-send-email-santoscadenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1273184832-8265-6-git-send-email-santoscadenas@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, May 07, 2010, Jose Antonio Santos Cadenas wrote:
> Files tools/ubcsp.c and tools/ubcsp.h had DOS end of line now they
> are changed to UNIX end of line
> ---
>  tools/ubcsp.c | 2360 ++++++++++++++++++++++++++++----------------------------
>  tools/ubcsp.h |  414 +++++-----
>  2 files changed, 1387 insertions(+), 1387 deletions(-)

Thanks for these cleanup patches. I've pushed the first five upstream
but am a little bit hesitant about this sixth one since it essentially
replaces every line in the existing file and I'm not sure if it's worth
having that obfuscating the commit history (e.g. git blame wouldn't be
useful anymore). Marcel, do you have any opinion about having a patch
like that in the tree?

Johan
