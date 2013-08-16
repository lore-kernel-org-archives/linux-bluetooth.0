Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=iso-8859-1
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
Subject: Re: [PATCH v10 06/10] Bluetooth: Parameters for outgoing SCO connections
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1376499814-11386-7-git-send-email-frederic.dalleau@linux.intel.com>
Date: Fri, 16 Aug 2013 11:47:50 -0700
Cc: linux-bluetooth@vger.kernel.org,
	Johan Hedberg <johan.hedberg@intel.com>
Message-Id: <83B2ED45-3482-4A10-8258-ACF78F6117B8@holtmann.org>
References: <1376499814-11386-1-git-send-email-frederic.dalleau@linux.intel.com> <1376499814-11386-7-git-send-email-frederic.dalleau@linux.intel.com>
To: =?iso-8859-1?Q?Fr=E9d=E9ric_Dalleau?=
	<frederic.dalleau@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fred,

> In order to establish a transparent SCO connection, the correct settings
> must be specified in the Setup Synchronous Connection request. For that,
> a setting field is added to ACL connection data to set up the desired
> parameters. The patch also removes usage of hdev->voice_setting in CVSD
> connection and makes use of T2 parameters for transparent data.
> 
> Signed-off-by: Frédéric Dalleau <frederic.dalleau@linux.intel.com>
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> include/net/bluetooth/hci_core.h |    5 +++--
> net/bluetooth/hci_conn.c         |   24 +++++++++++++++++++-----
> net/bluetooth/sco.c              |    2 +-
> 3 files changed, 23 insertions(+), 8 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel

