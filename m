Return-Path: <cyrus@holtmann.org>
From: <Waldemar.Rymarkiewicz@tieto.com>
To: <anderson.lizardo@openbossa.org>
CC: <johan.hedberg@gmail.com>, <linux-bluetooth@vger.kernel.org>
Date: Thu, 2 Jun 2011 16:28:28 +0300
Subject: RE: [PATCH v3] Add support of secure pin code in mgmt code
Message-ID: <99B09243E1A5DA4898CDD8B700111448175631BF32@EXMB04.eu.tieto.com>
References: <1306942320-12400-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
 <BANLkTik3r6-4ik6+bvJ0kJbGKMYxDUprQg@mail.gmail.com>
In-Reply-To: <BANLkTik3r6-4ik6+bvJ0kJbGKMYxDUprQg@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi, 

>I think this does not make sense. Regardless of secure being 
>TRUE or FALSE, "pinlen > 0" will never influence the condition 
>check, so this is actually equivalent to "if (secure && pinlen 
>== 16)". Maybe you
>meant:

Absolutely you are right. I think, that should look like 

if (pinlen > 0 && (!secure || pinlen == 16)) {
       btd_adapter_pincode_reply(adapter, dba, pin, pinlen);
       return 0;
}


Thanks,
Waldek
