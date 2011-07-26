Return-Path: <cyrus@holtmann.org>
Date: Tue, 26 Jul 2011 11:16:19 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 0/3] Initial Proximity Monitor implementation
Message-ID: <20110726081619.GE9775@dell>
References: <1310560677-2773-1-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1310560677-2773-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Wed, Jul 13, 2011, Claudio Takahasi wrote:
> The following patches don't require the previously submitted patches.
> 
> Adds the plugin and device driver for Proximity Monitor. Service is not
> functional yet.
> 
> Claudio Takahasi (3):
>   Add Proximity Profile plugin skeleton
>   Add Proximity Monitor skeleton
>   Add Link Loss device driver skeleton
> 
>  Makefile.am         |    7 ++++
>  acinclude.m4        |    6 ++++
>  bootstrap-configure |    1 +
>  proximity/main.c    |   60 ++++++++++++++++++++++++++++++++++++
>  proximity/manager.c |   84 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  proximity/manager.h |   26 ++++++++++++++++
>  proximity/monitor.c |   84 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  proximity/monitor.h |   26 ++++++++++++++++
>  8 files changed, 294 insertions(+), 0 deletions(-)
>  create mode 100644 proximity/main.c
>  create mode 100644 proximity/manager.c
>  create mode 100644 proximity/manager.h
>  create mode 100644 proximity/monitor.c
>  create mode 100644 proximity/monitor.h

All three patches have been applied. Thanks.

Johan
