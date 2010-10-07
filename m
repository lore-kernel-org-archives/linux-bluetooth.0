Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 4/7] Bluetooth: Use LE buffers for LE traffic
From: Marcel Holtmann <marcel@holtmann.org>
To: Ville Tervo <ville.tervo@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <1286390535-27462-5-git-send-email-ville.tervo@nokia.com>
References: <1286390535-27462-1-git-send-email-ville.tervo@nokia.com>
	 <1286390535-27462-5-git-send-email-ville.tervo@nokia.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 07 Oct 2010 13:07:53 +0200
Message-ID: <1286449673.6145.99.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ville,

> BLuetooth chips may have separate buffers for
> LE traffic. This patch add support to use LE
> buffers provided by the chip.
> 
> Signed-off-by: Ville Tervo <ville.tervo@nokia.com>
> ---
>  include/net/bluetooth/hci_core.h |    6 +++
>  net/bluetooth/hci_conn.c         |   11 +++++-
>  net/bluetooth/hci_core.c         |   77 +++++++++++++++++++++++++++++++++++--
>  net/bluetooth/hci_event.c        |   34 ++++++++++++++++-
>  4 files changed, 120 insertions(+), 8 deletions(-)

this whole patch needs some re-thinking and proper LE init phase for
combo chips where BR/EDR and LE can share the buffers.

Regards

Marcel


