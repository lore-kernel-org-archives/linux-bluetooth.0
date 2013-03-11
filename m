Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Subject: Re: [PATCH v3 4/8] obexd: Add Message Notification Server (MNS)
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1363014350-16114-5-git-send-email-christian.fetzer@oss.bmw-carit.de>
Date: Mon, 11 Mar 2013 09:15:27 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <5A90B70B-487C-4D82-9D63-7D458BCD1AD2@holtmann.org>
References: <1363014350-16114-1-git-send-email-christian.fetzer@oss.bmw-carit.de> <1363014350-16114-5-git-send-email-christian.fetzer@oss.bmw-carit.de>
To: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Christian,

> This implements the MAP Message Notification Server (MNS)
> which is part of the MCE.
> ---
> Makefile.obexd            |   3 +
> obexd/client/map-event.h  |  42 ++++++
> obexd/client/mns.c        | 348 ++++++++++++++++++++++++++++++++++++++++++++++
> obexd/plugins/bluetooth.c |   2 +
> obexd/src/obexd.h         |   1 +
> src/profile.c             |  55 ++++++++
> 6 files changed, 451 insertions(+)
> create mode 100644 obexd/client/map-event.h
> create mode 100644 obexd/client/mns.c

same here. Why is this all intermixed with each other. Please learn how to split patches up properly into small digestible ones.

Even additions to the build system can be done after adding the sources. And at no time intermix src/ with obexd/ directory.

Regards

Marcel

