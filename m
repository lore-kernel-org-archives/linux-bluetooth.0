Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: [PATCH BlueZ v1 03/17] gdbus/client: Allow specifying ObjectManager path
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1424927610-26226-4-git-send-email-armansito@chromium.org>
Date: Thu, 26 Feb 2015 07:38:06 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <938707CA-DE91-41D5-B611-B89CFF9236C6@holtmann.org>
References: <1424927610-26226-1-git-send-email-armansito@chromium.org> <1424927610-26226-4-git-send-email-armansito@chromium.org>
To: Arman Uguray <armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

> GDBusClient currently hard-codes "/" as the remote ObjectManager path.
> This is generally incorrect, as an application can choose to expose an
> ObjectManager at any well-known path. This patch fixes this by allowing
> the user to pass in the ObjectManager path to g_dbus_client_new.
> ---
> client/main.c            |  2 +-
> gdbus/client.c           | 23 ++++++++++++++++-------
> gdbus/gdbus.h            |  5 +++--
> plugins/hostname.c       |  2 +-
> profiles/iap/main.c      |  2 +-
> tools/bluetooth-player.c |  2 +-
> tools/gap-tester.c       |  3 ++-
> tools/gatt-service.c     |  2 +-
> tools/mpris-proxy.c      |  2 +-
> tools/obexctl.c          |  2 +-
> unit/test-gdbus-client.c | 39 ++++++++++++++++++++++++++-------------
> 11 files changed, 54 insertions(+), 30 deletions(-)

please to not intermix gdbus/ changes with others. Everything in gdbus/ needs to be a separate patch. You are affecting more than one project here.

Regards

Marcel

