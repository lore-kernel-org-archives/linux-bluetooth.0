Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [PATCH v4 0/8] Add CSA 4 commands and events in hci.h
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1380718493-4577-1-git-send-email-dh79.pyun@samsung.com>
Date: Wed, 2 Oct 2013 18:57:06 +0200
Cc: linux-bluetooth@vger.kernel.org, steve.jun@samsung.com
Message-Id: <4E93E6C3-2C6F-4986-AA76-292403E91DF1@holtmann.org>
References: <1380718493-4577-1-git-send-email-dh79.pyun@samsung.com>
To: Dohyun Pyun <re20sfree@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dohyun,

> This patchset contains several HCI commands and events addition.
> These HCI commands and events are included in Bluetooth Core
> Specification Addendum 4, and it will be used to implement 3DS
> profile.
> 
> Also I'm still implementing 3DS profile's master role in the BR/EDR
> controller. Summit and I'll send the patchsets about 3DS MGMT APIs
> soon.
> 
> Regards,
> Pyun
> 
> * Rebased the patchsets
> * Modify the subject and commit message
> 
> ----------------------------------------------------------------
> DoHyun Pyun (8):
>      Bluetooth: Add the definition and structure for Set Reserved LT_ADDR
>      Bluetooth: Add the definition and structure for Delete Reserved LT_ADDR
>      Bluetooth: Add the definition and structure for Set CSB Data
>      Bluetooth: Add the structure for Write Sync Train Parameters
>      Bluetooth: Add the definition and structure for Set CSB
>      Bluetooth: Add the definition for Start Synchronization Train
>      Bluetooth: Add the definition and stcuture for Sync Train Complete
>      Bluetooth: Add the definition for Slave Page Response Timeout
> 
> include/net/bluetooth/hci.h | 69 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 69 insertions(+)

I applied all 8 patches to bluetooth-next tree.

Regards

Marcel

