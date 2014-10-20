Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.0 \(1990.1\))
Subject: Re: [PATCH BlueZ 1/1] GATT shim to src/shared bt_att
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1413824244-35297-2-git-send-email-jamuraa@chromium.org>
Date: Mon, 20 Oct 2014 20:10:07 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <526D5B5F-0DB1-4FED-B193-59B2604BE719@holtmann.org>
References: <1413824244-35297-1-git-send-email-jamuraa@chromium.org> <1413824244-35297-2-git-send-email-jamuraa@chromium.org>
To: Michael Janssen <jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Michael,

> This patch implements a version of GAttrib which is backed by
> bt_att, which enables the simultaneous use of GAttrib and bt_att.
> 
> This should enable smooth transition of profiles from the GAttrib
> API to the src/shared bt_att API.
> ---
> Makefile.am             |   8 +-
> Makefile.tools          |  11 +-
> attrib/gattrib-shared.c | 306 ++++++++++++++++++++++++++++++++++++++++++++++++
> configure.ac            |   4 +
> 4 files changed, 327 insertions(+), 2 deletions(-)
> create mode 100644 attrib/gattrib-shared.c

to be honest, I would convert this in one go. If we can have a shim that just provides the GAttrib API, then lets use that and put it into src/ and remove attrib/ directory.

Having a few unit tests that ensure we do not break things with would nice. I mean have test cases first, run it, make the switch, run the tests again.

Regards

Marcel

