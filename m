Return-Path: <cyrus@holtmann.org>
Date: Wed, 25 Jun 2014 22:47:16 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC 2/5] tools/mcaptest: Add skeleton for mcap test tool
Message-ID: <20140625194716.GA16227@t440s.P-661HNU-F1>
References: <1403711401-11247-1-git-send-email-jakub.tyszkowski@tieto.com>
 <1403711401-11247-2-git-send-email-jakub.tyszkowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1403711401-11247-2-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Wed, Jun 25, 2014, Jakub Tyszkowski wrote:
> +tools_mcaptest_SOURCES = tools/mcaptest.c \
> +				src/log.c btio/btio.c \
> +				android/mcap-lib.h android/mcap-lib.c

I don't think we want to have tools/* depending on anything in
android/*. Ideally the tool should depend on a nice library in
src/shared (which we don't have) or in the worst case on
profiles/health or then it should be moved to android/ from tools/.

Johan
