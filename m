Return-Path: <cyrus@holtmann.org>
Date: Fri, 16 Jul 2010 13:54:39 -0300
From: Johan Hedberg <johan.hedberg@nokia.com>
To: Ville Tervo <ville.tervo@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Use default adapter for LE commands
Message-ID: <20100716165439.GB21721@jh-x301>
References: <1279274585-17730-1-git-send-email-ville.tervo@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1279274585-17730-1-git-send-email-ville.tervo@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ville,

On Fri, Jul 16, 2010, Ville Tervo wrote:
> Choose default adapter if device was not specified on command line.
> ---
>  tools/hcitool.c |    9 +++++++++
>  1 files changed, 9 insertions(+), 0 deletions(-)

Thanks for the patch. It's now upstream.

Johan
