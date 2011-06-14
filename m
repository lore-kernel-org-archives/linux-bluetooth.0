Return-Path: <cyrus@holtmann.org>
Date: Tue, 14 Jun 2011 12:08:38 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Rafal Michalski <michalski.raf@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 1/4] Fix invalid write to memory issue in a2dp module
Message-ID: <20110614090838.GA31529@dell.ger.corp.intel.com>
References: <1307962189-15460-1-git-send-email-michalski.raf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1307962189-15460-1-git-send-email-michalski.raf@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Rafal,

On Mon, Jun 13, 2011, Rafal Michalski wrote:
> Under some circumstances (such as terminating bluetoothd during music is
> streamed) sep object may be destroyed (memory for sep object is internally
> freed, directly by "a2dp_unregister_sep") after invoking
> "media_endpoint_clear_configuration" (in "stream_state_changed").
> It leads to invalid write issue (reported by valgrind) after assignment
> "sep->stream = NULL", since "sep" is "alias" pointer to sep object which
> is already out of date (memory for sep object has been already freed)
> 
> This patch prevents from this issue by ensuring that assignment
> "sep->stream = NULL" would be executed when sep object certainly exists.
> ---
>  audio/a2dp.c |    5 ++---
>  1 files changed, 2 insertions(+), 3 deletions(-)

All four patches have been pushed upstream. Thanks.

Johan
