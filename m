Return-Path: <cyrus@holtmann.org>
Date: Thu, 13 Oct 2011 10:42:38 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 03/12] Don't overwrite metadata when changing track
Message-ID: <20111013074238.GB8289@fusion.localdomain>
References: <1318432282-25002-1-git-send-email-lucas.demarchi@profusion.mobi>
 <1318432282-25002-3-git-send-email-lucas.demarchi@profusion.mobi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1318432282-25002-3-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

On Wed, Oct 12, 2011, Lucas De Marchi wrote:
> If we use the same hash table to set the new metadata, we have 2
> undesired behaviors:
> 
> 1) New track may contain fields from previous track if it didn't set all
> the fields
> 2) If we fail on parsing the signal, we will still change some of the
> fields
> ---
>  audio/media.c     |   41 ++++++++++++++++++++++++++---------------
>  doc/media-api.txt |    6 ++++++
>  2 files changed, 32 insertions(+), 15 deletions(-)

The first two patches have been applied but this one doesn't compile:

audio/media.c: In function ‘parse_player_metadata’:
audio/media.c:1358:11: error: variable ‘title’ set but not used [-Werror=unused-but-set-variable]

Johan
