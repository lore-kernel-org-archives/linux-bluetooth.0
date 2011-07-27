Return-Path: <cyrus@holtmann.org>
Date: Thu, 28 Jul 2011 00:48:31 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Tom Rini <tom_rini@mentor.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Makefile.am: Mark local_headers as BUILT_SOURCES
Message-ID: <20110727214831.GA6175@dell.Elisa>
References: <1310224253-4557-1-git-send-email-tom_rini@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1310224253-4557-1-git-send-email-tom_rini@mentor.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tom,

On Sat, Jul 09, 2011, Tom Rini wrote:
> As these files are auto-generated they need to be marked as BUILT_SOURCES
> so that we don't run into a build race later on.  lib/bluetooth is removed
> by clean-local so this doesn't need to be in CLEAN_FILES
> ---
>  Makefile.am |    5 ++---
>  1 files changed, 2 insertions(+), 3 deletions(-)

The patch has now (finally) been pushed upstream. Thanks.

Johan
