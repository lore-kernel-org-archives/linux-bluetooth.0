Return-Path: <cyrus@holtmann.org>
Date: Thu, 13 Oct 2011 13:12:27 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 12/12] Improve test/simple-player to allow user
 interaction
Message-ID: <20111013101227.GA17879@fusion.localdomain>
References: <1318432282-25002-1-git-send-email-lucas.demarchi@profusion.mobi>
 <1318432282-25002-12-git-send-email-lucas.demarchi@profusion.mobi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1318432282-25002-12-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

On Wed, Oct 12, 2011, Lucas De Marchi wrote:
> Allow user to trigger TrackChanged and PropertyChanged. Calls made by
> remote side (coming from D-Bus) are printed to stderr while the ones to
> interact with user go to stdout.
> ---
>  test/simple-player |   71 +++++++++++++++++++++++++++++++++++++++++++++++++---
>  1 files changed, 67 insertions(+), 4 deletions(-)

Patches 5-12 have been applied also. Thanks.

Johan
