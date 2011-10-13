Return-Path: <cyrus@holtmann.org>
Date: Thu, 13 Oct 2011 16:10:28 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Don't overwrite metadata when changing track
Message-ID: <20111013131028.GA22730@fusion.localdomain>
References: <1318510623-7484-1-git-send-email-lucas.demarchi@profusion.mobi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1318510623-7484-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

On Thu, Oct 13, 2011, Lucas De Marchi wrote:
> If we use the same hash table to set the new metadata, we have 2
> undesired behaviors:
> 
> 1) New track may contain fields from previous track if it didn't set all
> the fields
> 2) If we fail on parsing the signal, we will still change some of the
> fields
> ---
>  audio/media.c     |   42 ++++++++++++++++++++++++++++--------------
>  doc/media-api.txt |    6 ++++++
>  2 files changed, 34 insertions(+), 14 deletions(-)

Both patches applied. Thanks.

Johan
