Return-Path: <cyrus@holtmann.org>
Date: Tue, 18 Oct 2011 10:40:03 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 0/5] Request/Abort Continuing and some minor things
Message-ID: <20111018074003.GA24105@fusion.localdomain>
References: <1318883671-10932-1-git-send-email-lucas.demarchi@profusion.mobi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1318883671-10932-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

On Mon, Oct 17, 2011, Lucas De Marchi wrote:
> Changes from previous version:
> 
>  - 2/5: fix minor coding style issue
>  - 3/5: allow 0 to be a valid duration value
>  - 5/5: fill attribute header in player_fill_media_attribute() in order to
>    simplify implementation
> 
> 
> Lucas De Marchi (5):
>   AVRCP: Use track's UID in event notification
>   AVRCP: implement TRACK-REACHED-START event
>   AVRCP: respond with UINT32_MAX if duration is not available
>   AVRCP: Implement AbortContinuingResponse PDU
>   AVRCP: Implement RequestContinuingResponse PDU
> 
>  audio/avrcp.c |  307 +++++++++++++++++++++++++++++++++++++++++----------------
>  audio/avrcp.h |    3 +
>  audio/media.c |   22 ++++-
>  3 files changed, 246 insertions(+), 86 deletions(-)

All five patches applied. Thanks.

Johan
