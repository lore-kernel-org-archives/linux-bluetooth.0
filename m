Return-Path: <cyrus@holtmann.org>
Date: Tue, 27 Sep 2011 12:39:05 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd] Remove test/main.c
Message-ID: <20110927093905.GH3952@dell>
References: <1314879277-4792-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1314879277-4792-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Thu, Sep 01, 2011, Luiz Augusto von Dentz wrote:
> It is not useful anymore since gwobex will be removed and we
> have already tools/test-client and tools/test-server for gobex.
> ---
>  Makefile.am |    6 -
>  test/main.c |  316 -----------------------------------------------------------
>  2 files changed, 0 insertions(+), 322 deletions(-)
>  delete mode 100644 test/main.c

Applied. Thanks.

Johan
