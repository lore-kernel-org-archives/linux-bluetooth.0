Return-Path: <cyrus@holtmann.org>
Date: Tue, 15 Mar 2011 19:39:40 +0200
From: Johan Hedberg <johan.hedberg@nokia.com>
To: Elvis@jh-x301, Pf@jh-x301
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v4 1/2] Use new UUID functions in GATT
Message-ID: <20110315173940.GB16335@jh-x301>
References: <20110315085205.GB16296@jh-x301>
 <1300194304-29449-1-git-send-email-epx@signove.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1300194304-29449-1-git-send-email-epx@signove.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Elvis,

On Tue, Mar 15, 2011, Elvis Pf??tzenreuter wrote:
> This patch puts the new UUID functions into use for GATT-related
> code, and adds some convenience functions to ATT API (att.h).
> Example GATT server is also changed.
> ---
>  attrib/att.c         |   47 +++++++++++--------------
>  attrib/att.h         |   69 +++++++++++++++++++++++++++++++++----
>  attrib/client.c      |   26 ++++++--------
>  attrib/example.c     |   92 ++++++++++++++++++++++++++-----------------------
>  attrib/gatt.c        |   68 +++++++++++++++++++------------------
>  attrib/gatt.h        |    4 +-
>  attrib/gattrib.c     |    3 +-
>  attrib/gatttool.c    |   18 ++++-----
>  attrib/interactive.c |   22 +++++------
>  attrib/utils.c       |    1 +
>  src/adapter.c        |    1 +
>  src/attrib-server.c  |   93 +++++++++++++++++++++++++------------------------
>  src/attrib-server.h  |    4 +-
>  src/device.c         |    1 +
>  src/main.c           |    1 +
>  15 files changed, 250 insertions(+), 200 deletions(-)

Both patches have been pushed upstream. Thanks.

Johan
