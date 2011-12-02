Return-Path: <cyrus@holtmann.org>
Date: Fri, 2 Dec 2011 13:15:10 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Syam Sidhardhan <s.syam@samsung.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/3] Fix dbus reply memory leak
Message-ID: <20111202111510.GA15891@x220.ger.corp.intel.com>
References: <1322144076-1913-1-git-send-email-s.syam@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1322144076-1913-1-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Syam,

On Thu, Nov 24, 2011, Syam Sidhardhan wrote:
> ---
>  audio/telephony-maemo5.c |    8 ++++----
>  cups/main.c              |   30 +++++++++++++++++++++++++-----
>  test/agent.c             |    2 ++
>  test/mpris-player.c      |    6 +++++-
>  4 files changed, 36 insertions(+), 10 deletions(-)

Your commit message uses the word leak in singular form but there are
multiple fixes in this patch, i.e. the commit message is misleading. In
this case I'd split the patch into four separate ones:

telephony-maemo5: Fix D-Bus reply memory leaks
cups: Fix D-Bus reply memory leaks
agent: Fix D-Bus reply memory leaks
mpris-player: Fix D-Bus reply memory leaks

Johan
