Return-Path: <cyrus@holtmann.org>
From: Amitkumar Karwar <akarwar@marvell.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: BlueZ development <linux-bluetooth@vger.kernel.org>,
	Avinash Patil <patila@marvell.com>,
	Cathy Luo <cluo@marvell.com>, Marc Yang <yangyang@marvell.com>
Date: Wed, 31 Dec 2014 04:00:17 -0800
Subject: RE: [PATCH 1/4] Bluetooth: btmrvl: fix race issue while stopping
 main thread
Message-ID: <5FF020A1CFFEEC49BD1E09530C4FF5951B16178D67@SC-VEXCH1.marvell.com>
References: <1420024442-12137-1-git-send-email-akarwar@marvell.com>
 <B54F0CE9-1DE7-4985-851A-CD7E06AB7DA8@holtmann.org>
In-Reply-To: <B54F0CE9-1DE7-4985-851A-CD7E06AB7DA8@holtmann.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

>
>Hi Amitkumar,
>
>> btmrvl_remove_card() calls kthread_stop() to stop the main thread, but
>> kthread_should_stop() is checked when all the activities are done in
>> the main thread before sleeping.
>> We will have kthread_should_stop() check as soon as main thread is
>> woken up. This fixes a crash issue caused due to an invalid memory
>> access while unnecessarily processing interrupts after card removal.
>>
>> Signed-off-by: Avinash Patil <patila@marvell.com>
>> Signed-off-by: Cathy Luo <cluo@marvell.com>
>> Signed-off-by: Amitkumar Karwar <akarwar@marvell.com>
>
>I can not apply the patches like this. I assume that Avinash wrote the
>patch and with that he should be listed as patch author. So the email
>needs a proper From: line that allows git am to pick this up properly.
>
>Same applies to the other 3 patches.
>

Do you mean the patch author's Signed-off should be always first? In that case I'll change signed off sequence accordingly and send updated version.
All 4 patches are written by me.

Best Regards,
Amitkumar
