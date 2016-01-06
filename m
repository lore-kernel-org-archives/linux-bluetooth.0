Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Subject: Re: [PATCH v2] Bluetooth: avoid rebuilding hci_sock all the time
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1452087520-29599-1-git-send-email-johannes@sipsolutions.net>
Date: Wed, 6 Jan 2016 07:22:06 -0800
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Message-Id: <5E2EA838-CED6-437D-9464-1FAA5183FFA3@holtmann.org>
References: <1452087520-29599-1-git-send-email-johannes@sipsolutions.net>
To: Johannes Berg <johannes@sipsolutions.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johannes,

> Instead, allow using string formatting with send_monitor_note()
> and access init_utsname().
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
> net/bluetooth/hci_sock.c | 28 ++++++++++++++++++----------
> 1 file changed, 18 insertions(+), 10 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

