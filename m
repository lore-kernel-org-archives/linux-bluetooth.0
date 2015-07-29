Return-Path: <cyrus@holtmann.org>
Date: Wed, 29 Jul 2015 20:52:27 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Alexis Ballier <aballier@gentoo.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix build with experimental enabled but no readline.
Message-ID: <20150729175227.GC3234@t440s.P-661HNU-F1>
References: <1435668000-26875-1-git-send-email-aballier@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1435668000-26875-1-git-send-email-aballier@gentoo.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alexis,

On Tue, Jun 30, 2015, Alexis Ballier wrote:
> btmgmt requires readline. Protect it under if READLINE.
> ---
>  Makefile.tools | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Applied, however I moved this to the common section for other READLINE
binaries in Makefile.tools.

Johan
