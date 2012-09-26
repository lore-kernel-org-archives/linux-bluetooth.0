Return-Path: <cyrus@holtmann.org>
Date: Wed, 26 Sep 2012 21:36:53 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] build: Fix make distcheck for src/profile.c
Message-ID: <20120926183653.GA22623@x220.P-661HNU-F1>
References: <1348683762-28057-1-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1348683762-28057-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Wed, Sep 26, 2012, Anderson Lizardo wrote:
> Fix this "make distcheck" error:
> 
> ../src/profile.c:39:18: fatal error: uuid.h: No such file or directory
> ---
>  src/profile.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Good catch, thanks! The patch is now upstream.

Johan
