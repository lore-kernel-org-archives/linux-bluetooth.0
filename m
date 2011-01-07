Return-Path: <cyrus@holtmann.org>
Date: Sat, 8 Jan 2011 01:30:42 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/2] Moving interactive code of Discover Primary to
 gatt.c
Message-ID: <20110107233042.GA10372@jh-x301>
References: <1294441204-31780-1-git-send-email-claudio.takahasi@openbossa.org>
 <1294441204-31780-2-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1294441204-31780-2-git-send-email-claudio.takahasi@openbossa.org>
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

Doesn't compile:

attrib/gatt.c: In function 'primary_by_uuid_cb':
attrib/gatt.c:93: error: 'err' may be used uninitialized in this function

Johan
