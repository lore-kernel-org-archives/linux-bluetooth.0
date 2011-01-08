Return-Path: <cyrus@holtmann.org>
Date: Sat, 8 Jan 2011 11:08:06 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 2/2] Moving interactive code of Discover Primary to
 gatt.c
Message-ID: <20110108090806.GA14070@jh-x301>
References: <20110107233042.GA10372@jh-x301>
 <1294453679-28068-1-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1294453679-28068-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Fri, Jan 07, 2011, Claudio Takahasi wrote:
> Initial patch to move the shared code related to Discover All Primary
> Services and Discover Primary Services by UUID to gatt.c.
> ---
>  attrib/gatt.c     |  165 +++++++++++++++++++++++++++++++++++++--
>  attrib/gatt.h     |    6 +-
>  attrib/gatttool.c |   82 +++----------------
>  src/device.c      |   59 ++++++++++++--
>  src/glib-helper.c |  224 +++-------------------------------------------------
>  src/glib-helper.h |    6 --
>  6 files changed, 238 insertions(+), 304 deletions(-)

Thanks for the updated patch. It has now been pushed upstream. One minor
nitpick: please use the form "Move" instead of "Moving" in the summary
line to keep things consistent in the commit history.

Johan
