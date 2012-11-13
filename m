Return-Path: <cyrus@holtmann.org>
Date: Tue, 13 Nov 2012 10:05:44 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] build: Fix make distcheck for input plugin
Message-ID: <20121113080544.GA2206@x220>
References: <1352754221-29672-1-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1352754221-29672-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Mon, Nov 12, 2012, Anderson Lizardo wrote:
> suspend.c is a symlink generated at build time, therefore it should be
> created on build directory. Additionally, it is necessary to add
> -I$(srcdir)/profiles/input to CPPFLAGS so suspend.h can be found (the
> compiler does not follow symlinks prior to resolving #include
> directives).
> ---
>  Makefile.am |    6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Applied. Thanks.

Johan
