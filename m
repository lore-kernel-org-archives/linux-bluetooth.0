Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Subject: Re: [PATCH] avctp: Move avctp.c|h from profiles/audio to protocol/
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1387365861-23356-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Date: Wed, 18 Dec 2013 12:39:05 +0100
Cc: "linux-bluetooth@vger.kernel.org development"
	<linux-bluetooth@vger.kernel.org>
Message-Id: <13E32B04-DDEA-4BE1-BCAB-40C0395D638F@holtmann.org>
References: <1387365861-23356-1-git-send-email-ravikumar.veeramally@linux.intel.com>
To: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ravi,

> This is an initial patch for decoupling avctp.c|h from profiles/audio.
> Goal is to remove external dependency (glib is enough) and reusable
> to android/* sources.
> ---
> Makefile.plugins                     | 2 +-
> {profiles/audio => protocol}/avctp.c | 7 +------
> {profiles/audio => protocol}/avctp.h | 0
> 3 files changed, 2 insertions(+), 7 deletions(-)
> rename {profiles/audio => protocol}/avctp.c (99%)
> rename {profiles/audio => protocol}/avctp.h (100%)

actually, no.

The breaks my nicely tab-tab-completion handling when going through the source code. Pro{file,tocol} have a way to close prefix.

Regards

Marcel

