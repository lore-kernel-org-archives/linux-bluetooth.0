Return-Path: <cyrus@holtmann.org>
Date: Thu, 14 Jul 2011 16:40:09 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Slawomir Bochenski <lkslawek@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd 5/5 v2] Remove *hi from mime driver read()
Message-ID: <20110714134009.GD2770@dell.ger.corp.intel.com>
References: <1310558478-16968-1-git-send-email-lkslawek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1310558478-16968-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Slawek,

On Wed, Jul 13, 2011, Slawomir Bochenski wrote:
> This removes possibility of setting header type in mime driver read()
> function as the functionality of adding different header types is now
> supported by get_next_header().
> ---
> v2: Rebase
> 
>  plugins/filesystem.c    |   13 +++----------
>  plugins/irmc.c          |    3 +--
>  plugins/mas.c           |    4 +---
>  plugins/pbap.c          |   14 +++-----------
>  plugins/pcsuite.c       |    4 +---
>  plugins/syncevolution.c |    6 ++----
>  src/mimetype.h          |    2 +-
>  src/obex.c              |   27 ++++++++-------------------
>  8 files changed, 20 insertions(+), 53 deletions(-)

Applied. Thanks.

Johan
