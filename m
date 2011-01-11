Return-Path: <cyrus@holtmann.org>
Date: Tue, 11 Jan 2011 22:13:52 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2 v2] Fix memory leak when calling endpoint method
Message-ID: <20110111201352.GA20820@jh-x301>
References: <1294748511-8393-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1294748511-8393-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Tue, Jan 11, 2011, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>
> 
> The pending call must be unrefed in those cases
> ---
>  audio/media.c |   21 +++++++++++++++------
>  1 files changed, 15 insertions(+), 6 deletions(-)

Both patches have been pushed upstream. Thanks.

Johan
