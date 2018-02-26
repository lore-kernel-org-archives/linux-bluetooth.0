Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH] Bluetooth: Fix data type of appearence
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1519627267-20496-1-git-send-email-jaganathx.kanakkassery@intel.com>
Date: Mon, 26 Feb 2018 07:52:17 +0100
Cc: Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Message-Id: <FBD1C90C-8B7F-4306-BA3B-569CAABF4ACD@holtmann.org>
References: <1519627267-20496-1-git-send-email-jaganathx.kanakkassery@intel.com>
To: Jaganath Kanakkassery <jaganath.k.os@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jaganath,

> It should be __le16 instead of __u16 since its part of
> mgmt API.
> 
> Signed-off-by: Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
> ---
> include/net/bluetooth/mgmt.h | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

