Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.0 \(1990.1\))
Subject: Re: [PATCH 0/2] Bluetooth: Fix LE connection timeout handling
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1414531407-9785-1-git-send-email-johan.hedberg@gmail.com>
Date: Tue, 28 Oct 2014 14:52:08 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <4B8B0E6A-9647-4FD6-850F-3ACA8FB65BA9@holtmann.org>
References: <1414531407-9785-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> This patch set fixes LE connection timeout handling when advertising is
> enabled and triggering an LE Create Connection command for the
> connection creation.
> 
> Johan
> 
> ----------------------------------------------------------------
> Johan Hedberg (2):
>      Bluetooth: Fix LE connection timeout deadlock
>      Bluetooth: Fix check for direct advertising
> 
> net/bluetooth/hci_conn.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)

both patches have been applied to bluetooth-next tree.

Regards

Marcel

