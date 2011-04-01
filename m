Return-Path: <cyrus@holtmann.org>
Date: Fri, 1 Apr 2011 16:43:24 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Bruna Moreira <bruna.moreira@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Remove deprecated attrib plugin
Message-ID: <20110401134324.GA24588@jh-x301>
References: <1301587151-18975-1-git-send-email-bruna.moreira@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1301587151-18975-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bruna,

On Thu, Mar 31, 2011, Bruna Moreira wrote:
> The attrib plugin is deprecated and it is not used anymore. Remove it
> and all related configuration. Note that GATT utility (gatttool)
> configuration item was moved to Makefile.tools and it is compiled when
> --enable-tools is used in configure.
> ---
>  Makefile.am         |   18 ------------------
>  Makefile.tools      |   11 +++++++++++
>  acinclude.m4        |    6 ------
>  attrib/main.c       |   48 ------------------------------------------------
>  attrib/manager.c    |   43 -------------------------------------------
>  attrib/manager.h    |   26 --------------------------
>  bootstrap-configure |    1 -
>  7 files changed, 11 insertions(+), 142 deletions(-)
>  delete mode 100644 attrib/main.c
>  delete mode 100644 attrib/manager.c
>  delete mode 100644 attrib/manager.h

Both patches have been pushed upstream. Thanks.

Johan
