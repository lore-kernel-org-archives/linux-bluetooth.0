Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1345545955-13144-1-git-send-email-tomasz.bursztyka@linux.intel.com>
References: <1345545955-13144-1-git-send-email-tomasz.bursztyka@linux.intel.com>
Date: Fri, 24 Aug 2012 10:54:23 +0300
Message-ID: <CABBYNZK=ND4egOi6x3ftZxcddpGF6eGAqqw5A-ya6R=88U6_3A@mail.gmail.com>
Subject: Re: [PATCH 0/5] PAN server fixes
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Tomasz Bursztyka <tomasz.bursztyka@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tomasz,

On Tue, Aug 21, 2012 at 1:45 PM, Tomasz Bursztyka
<tomasz.bursztyka@linux.intel.com> wrote:
> Hi,
>
> After looking at connman's bug https://bugs.meego.com/show_bug.cgi?id=25125 I figured out that PAN server code was missbehaving.
> Basically, when DBus Unregister call is made: all bnep ifs and there corresponding connections are not touched at all, so on the
> client side: it still thinks it's connected (it is, but it lost the tethering stuff and so on).
>
> So here is a patch set that fixes the issue.
>
> 1 - it tracks the bnep interface per session, it will be necessary afterwards
> 2 - An helper to remove properly an interface from a bridge, it will be necessary afterwards also
> 3 - Here we are: it deletes the interface from the bridge, and puts it down when the server is freed. It's on its own function since it will be
> necessary aft
> erwards.
> 4 - It kills the underlying connection properly so the client is notified as it should
> 5 - Finally, when Unregister method call is made: it cleans up all sessions so clients are disconnected accordingly etc...
>
> Note: I tested this patch against 4.101 and it worken properly.
>
> Please review,
>
>
> Tomasz Bursztyka (5):
>   network: Keep track of session's interface name in server
>   network: Add helper function to remove an interface from a bridge
>   network: Release session's interface from bridge when unregistering
>   network: Kill underlying session's connection before freeing it
>   network: Remove sessions from server on DBus call Unregister
>
>  profiles/network/common.c |   29 +++++++++++++++++++++++++++++
>  profiles/network/common.h |    1 +
>  profiles/network/server.c |   31 ++++++++++++++++++++++++++++---
>  3 files changed, 58 insertions(+), 3 deletions(-)
>
> --
> 1.7.8.6

All 5 patches are now upstream, thanks.

-- 
Luiz Augusto von Dentz
