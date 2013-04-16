Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=iso-8859-1
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
Subject: Re: [PATCH v6 3/6] Bluetooth: Use hci_connect_sco directly
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1366126143-28545-4-git-send-email-frederic.dalleau@linux.intel.com>
Date: Tue, 16 Apr 2013 10:42:42 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <516899C6-2EB6-466D-9D8E-4EFDE3A8444D@holtmann.org>
References: <1366126143-28545-1-git-send-email-frederic.dalleau@linux.intel.com> <1366126143-28545-4-git-send-email-frederic.dalleau@linux.intel.com>
To: =?iso-8859-1?Q?Fr=E9d=E9ric_Dalleau?=
	<frederic.dalleau@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fred,

> hci_connect is a super function for connecting hci protocols. But the
> voice_setting parameter is only needed by SCO and security requirements are not
> needed for SCO channels. Thus, it makes sense to have a separate function.
> 
> Signed-off-by: Frédéric Dalleau <frederic.dalleau@linux.intel.com>
> ---
> include/net/bluetooth/hci_core.h |    2 ++
> net/bluetooth/hci_conn.c         |    9 +++------
> net/bluetooth/sco.c              |    3 +--
> 3 files changed, 6 insertions(+), 8 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel

