Return-Path: <cyrus@holtmann.org>
Date: Fri, 20 May 2011 11:04:01 -0700
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Add conf file support
Message-ID: <20110520180401.GA23399@dell.amr.corp.intel.com>
References: <1305620264-22304-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1305620264-22304-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Tue, May 17, 2011, Luiz Augusto von Dentz wrote:
> This should reduce the amount of options which normally don't change each
> time obexd is executed.
> ---
>  Makefile.am    |    2 +-
>  plugins/ftp.c  |    8 ++-
>  src/main.c     |  176 +++++++++++++++++++++++++++++++++++++++-----------------
>  src/obexd.conf |   19 ++++++
>  4 files changed, 149 insertions(+), 56 deletions(-)
>  create mode 100644 src/obexd.conf

This doesn't compile with gcc 4.6:

src/main.c: In function ‘main’:
src/main.c:267:12: error: variable ‘config’ set but not used [-Werror=unused-but-set-variable]

Please fix and resend.

Johan
