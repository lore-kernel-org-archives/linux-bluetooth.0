Return-Path: <cyrus@holtmann.org>
Date: Tue, 21 Apr 2009 15:51:06 +0300
From: Johan Hedberg <johan.hedberg@nokia.com>
To: Forrest Zhao <forrest.zhao@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, root <root@forrest.sh.intel.com>
Subject: Re: [PATCH] re-use the sco_server initiated by audio plugin
Message-ID: <20090421125106.GA13631@localhost>
References: <1240305653-21666-1-git-send-email-forrest.zhao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
In-Reply-To: <1240305653-21666-1-git-send-email-forrest.zhao@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Forrest,

On Tue, Apr 21, 2009, Forrest Zhao wrote:
>From: root <root@forrest.sh.intel.com>
>
>---
> audio/gateway.c |   63 ++++++++++++++++++++++++++++---------------------------
> audio/gateway.h |    6 +++++
> audio/main.c    |   38 ++++++++++++++++++++++----------
> 3 files changed, 64 insertions(+), 43 deletions(-)

The patch has been pushed upstream. Thanks.

Please make sure that you don't send patches with incorrect author headers 
in the future (this one had "From: root <root@forrest.sh.intel.com>" which 
is obviously wrong). I forgot to check it before pushing and so Marcel had 
to do some extra fixing on the kernel.org side to make sure the incorrect 
info doesn't get propagated further.

Johan
