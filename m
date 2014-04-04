Return-Path: <cyrus@holtmann.org>
Date: Fri, 4 Apr 2014 10:38:39 +0300
From: Johan Hedberg <johan.hedberg@intel.com>
To: Loic Poulain <loic.poulain@intel.com>
Cc: marcel@holtmann.org, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv6] tools: add bcm43xx specific init in hciattach
Message-ID: <20140404073839.GD16753@t440s.lan>
References: <1396515889-1270-1-git-send-email-loic.poulain@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1396515889-1270-1-git-send-email-loic.poulain@intel.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Loic,

On Thu, Apr 03, 2014, Loic Poulain wrote:
> From: lpoulain <loic.poulain@intel.com>

You need to fix your git author information before this goes upstream.
The above should say "First Last <email>".

> Add a bcm43xx specific init sequence in hciattach
> in order to initialize bcm43xx controllers.
> ---
>  v6: Coding style
> 
>  Makefile.tools            |   3 +-
>  tools/hciattach.c         |  11 +-
>  tools/hciattach.h         |   2 +
>  tools/hciattach_bcm43xx.c | 374 ++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 388 insertions(+), 2 deletions(-)
>  create mode 100644 tools/hciattach_bcm43xx.c

The code looks fine now but doesn't actually compile:

  CC       tools/hciattach_bcm43xx.o
tools/hciattach_bcm43xx.c: In function ‘bcm43xx_read_local_name’:
tools/hciattach_bcm43xx.c:90:2: error: implicit declaration of function ‘free’ [-Werror=implicit-function-declaration]
  free(resp);
  ^
tools/hciattach_bcm43xx.c:90:2: error: incompatible implicit declaration of built-in function ‘free’ [-Werror]
cc1: all warnings being treated as errors
make[1]: *** [tools/hciattach_bcm43xx.o] Error 1

I believe that's because you've forgotten to #include <stdlib.h> which
is needed by free().

Always compile test with ./bootstrap-configure && make

Johan
