Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [PATCH v2] bluetooth: fix variable shadow warnings
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1381162756-18353-1-git-send-email-johannes@sipsolutions.net>
Date: Mon, 7 Oct 2013 18:53:38 +0200
Cc: linux-wireless@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Message-Id: <815BA104-681B-4C6B-AD03-E52EB8834904@holtmann.org>
References: <1381162756-18353-1-git-send-email-johannes@sipsolutions.net>
To: Johannes Berg <johannes@sipsolutions.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johannes,

> From: Johannes Berg <johannes.berg@intel.com>
> 
> Sparse points out three places where variables are shadowed,
> rename two of the variables and remove the duplicate third.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
> net/bluetooth/hci_event.c  | 12 +++++++-----
> net/bluetooth/l2cap_sock.c |  2 +-
> 2 files changed, 8 insertions(+), 6 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

