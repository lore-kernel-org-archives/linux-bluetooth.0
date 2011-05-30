Return-Path: <cyrus@holtmann.org>
Date: Mon, 30 May 2011 15:40:16 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Slawomir Bochenski <lkslawek@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3 1/2] Add messages backend initialization and
 finalization
Message-ID: <20110530124016.GA21194@dell.amr.corp.intel.com>
References: <20110529192630.GI32088@dell.ger.corp.intel.com>
 <1306736852-5201-1-git-send-email-lkslawek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1306736852-5201-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Slawek,

On Mon, May 30, 2011, Slawomir Bochenski wrote:
> This adds functions for initializing and freeing resources used by
> message storage access backend and example implementation in the dummy
> (or rather - filesystem) backend.
> 
> Dummy backend uses $MAP_ROOT (if set) and falls back to
> $HOME/map-messages for its message storage. This directory should at
> least contain basic folders required by the MAP specification. It
> represents the root as seen from the perspective of MAP client. You can
> prepare it as follows:
> 
> $ mkdir -p "$MAP_ROOT/telecom/msg/inbox"
> $ mkdir "$MAP_ROOT/telecom/msg/sent"
> $ mkdir "$MAP_ROOT/telecom/msg/deleted"
> $ mkdir "$MAP_ROOT/telecom/msg/outbox"
> ---
>  plugins/mas.c            |    7 +++++++
>  plugins/messages-dummy.c |   22 ++++++++++++++++++++++
>  2 files changed, 29 insertions(+), 0 deletions(-)

Thanks. Both patches have been pushed upstream.

Johan
