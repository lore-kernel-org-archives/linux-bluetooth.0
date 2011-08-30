Return-Path: <cyrus@holtmann.org>
Date: Tue, 30 Aug 2011 13:07:43 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Bruno Dilly <bdilly@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 3/3] Add test for serial proxy and serial proxy manager
Message-ID: <20110830100743.GB20356@dell>
References: <1313791842-32558-1-git-send-email-bdilly@profusion.mobi>
 <1313791842-32558-3-git-send-email-bdilly@profusion.mobi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1313791842-32558-3-git-send-email-bdilly@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bruno,

On Fri, Aug 19, 2011, Bruno Dilly wrote:
> ---
>  test/test-serial-proxy |   64 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 64 insertions(+), 0 deletions(-)
>  create mode 100755 test/test-serial-proxy

This one is missing the corresponding update to EXTRA_DIST in
Makefile.tools. Without it the new script will not go to the "make dist"
tarball.

Johan
