Return-Path: <cyrus@holtmann.org>
Date: Mon, 16 Jun 2014 16:11:43 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Vikrampal Yadav <vikram.pal@samsung.com>
Cc: linux-bluetooth@vger.kernel.org, d.kasatkin@samsung.com,
	p.sinha@samsung.com, sanjay.nm@samsung.com,
	bharat.panda@samsung.com
Subject: Re: [PATCH ] sdp: Fix memory issues to avoid potential crash
Message-ID: <20140616131143.GA20334@t440s.lan>
References: <1402915607-3952-1-git-send-email-vikram.pal@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1402915607-3952-1-git-send-email-vikram.pal@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vikram,

On Mon, Jun 16, 2014, Vikrampal Yadav wrote:
> NULL pointer check added to handle memory allocation
> failure scenarios.
> ---
>  src/sdp-xml.c       | 16 +++++++++++++++-
>  src/sdpd-database.c |  4 ++++
>  2 files changed, 19 insertions(+), 1 deletion(-)

Thanks. The patch has now been applied (after one more tiny coding-style
improvement).

One thing that I'm surprised you didn't send another patch for is that
this patch exposes two missing NULL checks for the calls to the
sdp_xml_parse_string_decode() function. You should have seen those if
you were compiling the source tree with ./bootstrap-configure, or at
least with --enable-maintainer-mode. Please do that for all future patch
submissions. For this time I went ahead and applied an extra patch to
fix these missing checks.

Johan
