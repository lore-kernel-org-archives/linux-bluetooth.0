Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.1 \(3096.5\))
Subject: Re: [PATCH 2/4] Bluetooth: Move BR/EDR default events behind its features
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20151101134205.GB21304@t440s.P-661HNU-F1>
Date: Tue, 3 Nov 2015 22:21:35 +0900
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <E4BDA832-3DD5-4EA4-9F9F-E065DB75A2E8@holtmann.org>
References: <1446367191-67668-2-git-send-email-marcel@holtmann.org> <20151101134205.GB21304@t440s.P-661HNU-F1>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

>> There are some BR/EDR default events for Bluetooth 1.2 or later
>> controllers that are not conditional on their features being present.
>> 
>> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
>> ---
>> net/bluetooth/hci_core.c | 12 ++++++++----
>> 1 file changed, 8 insertions(+), 4 deletions(-)
> 
> I realize I already applied this one, but:
> 
>> +	if (lmp_esco_capable(hdev)) {
>> +		events[5] |= 0x08; /* Synchronous Connection Complete */
>> +		events[5] |= 0x10; /* Synchronous Connection Changed */
>> +	}
> 
> Synchronous Connection Complete is relevant also for non-ESCO
> controllers, isn't it?

that is true, but if you look at hci_conn.c and sco.c, then you see we use the same logic there to decide if we use Add SCO or Setup Sync Connection. So this just brings that in sync.

Regards

Marcel

