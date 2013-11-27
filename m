Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Wed, 27 Nov 2013 11:40:02 +0800
Message-ID: <CAFv23QmyQL1QTy8=HkYVpb94kFzNuULfdByqYcyCAQa__dg9Nw@mail.gmail.com>
Subject: Loading ath3k firmware failed
From: AceLan Kao <acelan.kao@canonical.com>
To: Marcel Holtmann <marcel@holtmann.org>, Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>, linux-bluetooth@vger.kernel.org,
	Chen Chong <chongc@qca.qualcomm.com>, Peng Chen <pengchen@qca.qualcomm.com>
Cc: Anthony Wong <anthony.wong@canonical.com>, YK <yk@canonical.com>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

Sorry to spam you guys.
I recently encountered a issue that I can't figure out how to fix it,
so I write to you and hope some of you can give me hints.

The issue is ath3k easily fails to load its firmware when the USB port
is switchable(EHCI -> XHCI).
   ath3k: probe of 2-7:1.0 failed with error -110
Sometimes it fails to load the firmware when boot up, sometimes it
fails when resume from S3.

I try to set the D0 register to 0 to force it use EHCI, then it works well.
Disable the USB 3.0 function from BIOS, it also works well.
And another workaround is to delay loading the ath3k module around 30
seconds, it can load the firmware without problems.

It's not only happened on a certain Atheros chip, we've encountered
this issue on many Atheros chips.
To get rid of this issue, please give me some hints, I can help to
verify your ideas.

Best regards,
AceLan Kao.
