Return-Path: <cyrus@holtmann.org>
From: <Waldemar.Rymarkiewicz@tieto.com>
To: <johan.hedberg@gmail.com>
CC: <linux-bluetooth@vger.kernel.org>
Date: Wed, 1 Jun 2011 13:58:17 +0300
Subject: RE: [PATCH v2] Add support of secure pin code in mgmt code
Message-ID: <99B09243E1A5DA4898CDD8B700111448175631BC06@EXMB04.eu.tieto.com>
References: <1306401315-10948-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
 <20110529184859.GB32088@dell.ger.corp.intel.com>
In-Reply-To: <20110529184859.GB32088@dell.ger.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan, 

>struct authentictation_req (device->authr) is the right place 
>to store this value since it's bound is to the lifetime of the 
>authentication request, whereas struct btd_device isn't. Also, 
>as previously mentioned the type should be gboolean and not uint8_t.
>

You mentioned that the check should be done in kernel as well. However, mgmt API is like mgmt_pincode_replay and mgmt_pincode_neg_replay what means that I should do a check (secure == 1 && pinlen !=16) on mgmt_pincode_replay and if the pin is in fact not secure then send pincode_neg_replay to the controller.

In that case we could skipp checking in bluez at all to avoid double checking, but it's fine if we do so.

What about replaceing mgmt_pincode_replay and mgmt_pincode_neg_replay with one mgmt_pincode_replay + error field in the struct to indicate user space succeded or not. This way the checking could be done only in the kernel I guess.

Can you comment on my thoughts?

Waldek
