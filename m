Return-Path: <cyrus@holtmann.org>
Date: Fri, 13 Apr 2012 13:08:44 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Syam Sidhardhan <s.syam@samsung.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd 0/4] Fix memory leak, remove unused struct etc
Message-ID: <20120413100844.GB17640@x220.ger.corp.intel.com>
References: <1334243001-17016-1-git-send-email-s.syam@samsung.com>
 <1334243001-17016-21-git-send-email-s.syam@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1334243001-17016-21-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Syam,

On Thu, Apr 12, 2012, Syam Sidhardhan wrote:
> This series of patches fixes the following issues in obexd.
> 
> Syam Sidhardhan (4):
>   client: Fix memory leak during session connect
>   src: Use goto for avoiding code duplication
>   src: Remove headers declared but not defined
>   client: Remove unused struct session_callback
> 
>  client/session.c |   10 ++++------
>  src/manager.c    |    4 ++--
>  src/obex.h       |    4 ----
>  3 files changed, 6 insertions(+), 12 deletions(-)

All patches in this set have been applied. Thanks.

Johan
