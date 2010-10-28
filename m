Return-Path: <cyrus@holtmann.org>
Date: Thu, 28 Oct 2010 14:28:53 -0400
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/5] Fix not waiting mode change when setting powered
 property
Message-ID: <20101028182853.GA1996@jh-x301>
References: <1288252859-10337-1-git-send-email-luiz.dentz@gmail.com>
 <1288252859-10337-2-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1288252859-10337-2-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Thu, Oct 28, 2010, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>
> 
> This may cause errors if the user application immediately set another
> mode.
> ---
>  src/adapter.c |   84 +++++++++++++++++++++++++++++---------------------------
>  1 files changed, 43 insertions(+), 41 deletions(-)

This patch has been pushed upstream. Thanks.

Johan
