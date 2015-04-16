Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCH] Bluetooth: Pre-initialize variables in read_local_oob_ext_data_complete()
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1429212265-26750-1-git-send-email-geert@linux-m68k.org>
Date: Thu, 16 Apr 2015 13:34:54 -0700
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	BlueZ development <linux-bluetooth@vger.kernel.org>,
	netdev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org
Message-Id: <A962A040-4EB5-4AE6-A790-A8767185172B@holtmann.org>
References: <1429212265-26750-1-git-send-email-geert@linux-m68k.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Geert,

> net/bluetooth/mgmt.c: In function ‘read_local_oob_ext_data_complete’:
> net/bluetooth/mgmt.c:6474: warning: ‘r256’ may be used uninitialized in this function
> net/bluetooth/mgmt.c:6474: warning: ‘h256’ may be used uninitialized in this function
> net/bluetooth/mgmt.c:6474: warning: ‘r192’ may be used uninitialized in this function
> net/bluetooth/mgmt.c:6474: warning: ‘h192’ may be used uninitialized in this function
> 
> While these are false positives, the code can be shortened by
> pre-initializing the hash table pointers and eir_len. This has the side
> effect of killing the compiler warnings.

can you be a bit specific on which compiler version is this. I fixed one occurrence that seemed valid. However in this case the compiler seems to be just plain stupid. On a gcc 4.9, I am not seeing these for example.

Regards

Marcel

