Return-Path: <cyrus@holtmann.org>
Date: Fri, 2 Dec 2011 16:38:03 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Bartosz Szatkowski <bulislaw@linux.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv2 obexd 4/4] Add simple helper for MAP client
Message-ID: <20111202143803.GB24812@x220>
References: <1322829142-7855-1-git-send-email-bulislaw@linux.com>
 <1322829142-7855-4-git-send-email-bulislaw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1322829142-7855-4-git-send-email-bulislaw@linux.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bartosz,

On Fri, Dec 02, 2011, Bartosz Szatkowski wrote:
> ---
>  test/map-client |   52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 52 insertions(+), 0 deletions(-)
>  create mode 100755 test/map-client

This patch is missing an addition to Makefile.am (test_files).

Johan
