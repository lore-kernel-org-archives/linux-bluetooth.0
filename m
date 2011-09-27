Return-Path: <cyrus@holtmann.org>
Date: Tue, 27 Sep 2011 12:57:53 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH hcidump] avrcp: fix name of metadata field
Message-ID: <20110927095753.GB6190@dell>
References: <1315524770-12000-1-git-send-email-lucas.demarchi@profusion.mobi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1315524770-12000-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

On Thu, Sep 08, 2011, Lucas De Marchi wrote:
> Metadata field number 0x7 should be the track duration and not the
> progress of the track playback. Thus rename it to a better description.
> ---
>  parser/avrcp.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)

Applied. Thanks.

Johan
