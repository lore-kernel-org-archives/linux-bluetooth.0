Return-Path: <cyrus@holtmann.org>
Date: Wed, 6 May 2009 12:42:22 +0300
From: Johan Hedberg <johan.hedberg@nokia.com>
To: alokbarsode@gmail.com
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        Alok Barsode <alok.barsode@azingo.com>
Subject: Re: [PATCH 2/2] Adding stop() functionality to hciops plugin.
Message-ID: <20090506094222.GA3215@localhost>
References: <1241599077-26438-1-git-send-email-alok.barsode@azingo.com> <1241599077-26438-2-git-send-email-alok.barsode@azingo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1241599077-26438-2-git-send-email-alok.barsode@azingo.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alok,

On Wed, May 06, 2009, alokbarsode@gmail.com wrote:
> From: Alok Barsode <alok.barsode@azingo.com>
> 
> ---
>  plugins/hciops.c |   24 ++++++++++++++++++++++++
>  src/adapter.c    |   23 ++++++++++-------------
>  src/adapter.h    |    1 +
>  3 files changed, 35 insertions(+), 13 deletions(-)

Both patches are now pushed upstream. There was one compilation issue
which I had to fix though:
adapter.c: In function adapter_remove:
adapter.c:2477: error: label done defined but not used

Johan
