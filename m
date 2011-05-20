Return-Path: <cyrus@holtmann.org>
Date: Fri, 20 May 2011 10:54:48 -0700
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Slawomir Bochenski <lkslawek@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v4] Add partial mas.c - messages-*.c API.
Message-ID: <20110520175448.GA23267@dell.amr.corp.intel.com>
References: <1304671695-6153-1-git-send-email-lkslawek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1304671695-6153-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Slawek,

On Fri, May 06, 2011, Slawomir Bochenski wrote:
> This adds stubs of functions needed for message browsing and retrieval.
> ---
> Changes according to the discussion on the IRC. Changed the way the
> parameters are returned. Some documentation changes. Packed boolean
> arguments to messages_get_message into a single bit mask.
> 
>  plugins/messages-dummy.c |   69 +++++++++++++
>  plugins/messages.h       |  245 ++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 314 insertions(+), 0 deletions(-)

Pushed upstream. Thanks.

Johan
