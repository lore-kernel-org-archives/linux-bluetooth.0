Return-Path: <cyrus@holtmann.org>
Message-id: <A6A3803775F34AD79A13985D295506ED@sisodomain.com>
From: Syam Sidhardhan <s.syam@samsung.com>
To: linux-bluetooth@vger.kernel.org
References: <1345651858-23031-1-git-send-email-s.syam@samsung.com>
 <1345651858-23031-3-git-send-email-s.syam@samsung.com>
Subject: Re: [PATCH obexd 3/4] plugins: Remove redundant incude sys/stat.h
Date: Wed, 22 Aug 2012 21:47:19 +0530
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=iso-8859-1; reply-type=original
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

----- Original Message ----- 
From: "Syam Sidhardhan" <s.syam@samsung.com>
To: <linux-bluetooth@vger.kernel.org>
Sent: Wednesday, August 22, 2012 9:40 PM
Subject: [PATCH obexd 3/4] plugins: Remove redundant incude sys/stat.h


> ---
> plugins/filesystem.c |    1 -
> 1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/plugins/filesystem.c b/plugins/filesystem.c
> index e664fc5..1132a34 100644
> --- a/plugins/filesystem.c
> +++ b/plugins/filesystem.c
> @@ -32,7 +32,6 @@
> #include <string.h>
> #include <unistd.h>
> #include <dirent.h>
> -#include <sys/stat.h>
> #include <sys/types.h>
> #include <sys/stat.h>
> #include <sys/statvfs.h>
> -- 


%s/incude/include/g     in commit message of 3/4 & 4/4.
Will send another version.

Regards,
Syam
