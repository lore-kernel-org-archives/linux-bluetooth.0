Return-Path: <cyrus@holtmann.org>
Date: Fri, 5 Nov 2010 07:06:02 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org
Subject: Re: [PATCH] Move gattrib source files to src directory
Message-ID: <20101105050602.GD25270@jh-x301>
References: <1288901266-32547-1-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1288901266-32547-1-git-send-email-claudio.takahasi@openbossa.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Thu, Nov 04, 2010, Claudio Takahasi wrote:
> gattrib related functions will be required during the device creation
> for GATT enabled devices(BR/EDR and LE). Primary service discovery is
> a pre-condition to probe the GATT device driver.
> ---
>  Makefile.am      |    7 +-
>  attrib/att.c     |  764 ------------------------------------------------------
>  attrib/att.h     |  206 ---------------
>  attrib/gatt.c    |  113 --------
>  attrib/gatt.h    |   43 ---
>  attrib/gattrib.c |  535 --------------------------------------
>  attrib/gattrib.h |   72 -----
>  src/att.c        |  764 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  src/att.h        |  206 +++++++++++++++
>  src/gatt.c       |  113 ++++++++
>  src/gatt.h       |   43 +++
>  src/gattrib.c    |  535 ++++++++++++++++++++++++++++++++++++++
>  src/gattrib.h    |   72 +++++
>  13 files changed, 1736 insertions(+), 1737 deletions(-)
>  delete mode 100644 attrib/att.c
>  delete mode 100644 attrib/att.h
>  delete mode 100644 attrib/gatt.c
>  delete mode 100644 attrib/gatt.h
>  delete mode 100644 attrib/gattrib.c
>  delete mode 100644 attrib/gattrib.h
>  create mode 100644 src/att.c
>  create mode 100644 src/att.h
>  create mode 100644 src/gatt.c
>  create mode 100644 src/gatt.h
>  create mode 100644 src/gattrib.c
>  create mode 100644 src/gattrib.h

I'll wait a little bit with this one. I agree that the gattrib
funcionality needs to be available within the core daemon, but does that
necessarily mean that the source files for need to be in src? It'd be
good to get some comment from Marcel about this too.

Johan
