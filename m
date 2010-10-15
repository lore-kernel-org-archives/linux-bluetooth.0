Return-Path: <cyrus@holtmann.org>
Date: Fri, 15 Oct 2010 12:58:50 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix not responding Not Found for filtered vcard-listing
Message-ID: <20101015095850.GA9788@jh-x301>
References: <1287135959-6605-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1287135959-6605-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Fri, Oct 15, 2010, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>
> 
> In this case entries may be found but it still may not match the filter
> criteria.
> ---
>  plugins/pbap.c |   12 ++++++------
>  1 files changed, 6 insertions(+), 6 deletions(-)

Thanks. Pushed upstream.

Johan
