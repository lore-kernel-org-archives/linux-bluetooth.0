Return-Path: <cyrus@holtmann.org>
Date: Tue, 27 Oct 2015 09:56:07 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@codecoup.pl>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] unit: Fix gobex unit tests
Message-ID: <20151027075607.GA23267@t440s.ger.corp.intel.com>
References: <1445896083-15680-1-git-send-email-szymon.janc@codecoup.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1445896083-15680-1-git-send-email-szymon.janc@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Mon, Oct 26, 2015, Szymon Janc wrote:
> /gobex/test_header_encode_connid test name was duplicated.
> This results in Glib assert:
> (unit/test-gobex-header:15356): GLib-ERROR **: duplicate test
>     case path: /gobex/test_header_encode_connid
> ---
>  unit/test-gobex-header.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied. Thanks.

Johan
