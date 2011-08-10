Return-Path: <cyrus@holtmann.org>
Date: Wed, 10 Aug 2011 12:34:10 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd] Fix memory leak on opp plugin
Message-ID: <20110810093410.GB21443@dell>
References: <1312964270-8806-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1312964270-8806-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Wed, Aug 10, 2011, Luiz Augusto von Dentz wrote:
> Folder and name can point to allocated memory so they need to be freed
> before returning.
> 
> Thanks for Daniele Forsi <dforsi@gmail.com> for reporting it.
> ---
>  plugins/opp.c |    8 ++++++--
>  1 files changed, 6 insertions(+), 2 deletions(-)

Applied. Thanks.

Johan
