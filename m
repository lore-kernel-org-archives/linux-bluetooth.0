Return-Path: <cyrus@holtmann.org>
Date: Thu, 2 Feb 2012 09:36:26 -0800
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jaganath Kanakkassery <jaganath.k@samsung.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd 4/4] obex: Fix file not getting deleted when a push
 is aborted
Message-ID: <20120202173626.GA24733@x220.globalsuite.net>
References: <1328182457-14924-1-git-send-email-jaganath.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1328182457-14924-1-git-send-email-jaganath.k@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jaganath,

On Thu, Feb 02, 2012, Jaganath Kanakkassery wrote:
> Problem: Even if transfer is aborted file will be saved with partial
> content.
> 
> Fix: In os_reset_session() os->cmd is checked for PUT before calling
> driver->remove(), but os->cmd is never assigned.This fix sets os->cmd
> wit respective opcode
> ---
>  src/obex.c |   12 ++++++++++++
>  1 files changed, 12 insertions(+), 0 deletions(-)

Patches 1 2 and 4 have been applied. Waiting for comments on Luiz's
feedback on patch 3.

Johan
