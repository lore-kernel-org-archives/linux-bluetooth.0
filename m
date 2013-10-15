Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [PATCH 1/2] Bluetooth: Add support for entering limited discoverable mode
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1381844037-24424-1-git-send-email-marcel@holtmann.org>
Date: Tue, 15 Oct 2013 15:45:51 +0200
Message-Id: <674BAD06-AFE6-4DB2-ABB1-6BFB119981E9@holtmann.org>
References: <1381844037-24424-1-git-send-email-marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

> The limited discoverable mode should be used when a device is only
> discoverable for a certain amount of time and after that it returns
> back into being non-discoverable.
> 
> The management interface allows to specify a timeout parameter when
> makeing a device discoverable. If such a timeout is specified or
> changed, enter limited discoverable mode. Otherwise enter general
> discoverable mode.
> 
> Devices in limited discoverable mode can still be found by the
> general discovery procedure. It is mandatory that a device sets
> both GIAC and LIAC when entering limited discoverable mode.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
> include/net/bluetooth/hci.h |  6 ++++++
> net/bluetooth/mgmt.c        | 41 +++++++++++++++++++++++++++++++++++++----
> 2 files changed, 43 insertions(+), 4 deletions(-)

I send this by accident. It is the same as the last one and better be not applied. I am re-working this one right now.

Regards

Marcel

