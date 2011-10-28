Return-Path: <cyrus@holtmann.org>
Date: Fri, 28 Oct 2011 14:01:22 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix check for PDU size
Message-ID: <20111028110122.GB15672@fusion.localdomain>
References: <1319634146-1643-1-git-send-email-lucas.demarchi@profusion.mobi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1319634146-1643-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

On Wed, Oct 26, 2011, Lucas De Marchi wrote:
> Company ID became part of the avrcp header so its size is already
> accounted in the AVRCP_HEADER_LENGTH define.
> ---
>  audio/avrcp.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Applied. Thanks.

Johan
