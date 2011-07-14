Return-Path: <cyrus@holtmann.org>
Date: Thu, 14 Jul 2011 16:59:11 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Bartosz Szatkowski <bulislaw@linux.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd 1/2] Add tracker backend stump for MAP
Message-ID: <20110714135911.GG2770@dell.ger.corp.intel.com>
References: <1310651174-11945-1-git-send-email-bulislaw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1310651174-11945-1-git-send-email-bulislaw@linux.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bartosz,

On Thu, Jul 14, 2011, Bartosz Szatkowski wrote:
> ---
>  plugins/messages-tracker.c |   98 ++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 98 insertions(+), 0 deletions(-)
>  create mode 100644 plugins/messages-tracker.c

This patch should also add the new file to Makefile.am (EXTRA_DIST I
suppose). Otherwise the file will be left out of the tarball when doing
"make dist".

Johan
