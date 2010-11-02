Return-Path: <cyrus@holtmann.org>
Date: Tue, 2 Nov 2010 19:25:49 -0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Cleanup set_mode code
Message-ID: <20101102222549.GA19832@jh-x301>
References: <1288709056-7551-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1288709056-7551-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Tue, Nov 02, 2010, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>
> 
> Now that MODE_LIMITED was removed there is no need to compare string mode
> to determine if scan mode will change or not.
> ---
>  src/adapter.c |   21 +++++----------------
>  1 files changed, 5 insertions(+), 16 deletions(-)

Pushed upstream. Thanks.

Johan
