Return-Path: <cyrus@holtmann.org>
From: <Waldemar.Rymarkiewicz@tieto.com>
To: <padovan@profusion.mobi>
CC: <linux-bluetooth@vger.kernel.org>, <johan.hedberg@gmail.com>
Date: Thu, 2 Jun 2011 11:27:09 +0300
Subject: RE: [PATCH 2/2] Bluetooth: Verify a pin code in pin_code_reply
Message-ID: <99B09243E1A5DA4898CDD8B700111448175631BE94@EXMB04.eu.tieto.com>
References: <1306942128-5325-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
 <1306942128-5325-2-git-send-email-waldemar.rymarkiewicz@tieto.com>
 <20110601205119.GH2564@joana>
In-Reply-To: <20110601205119.GH2564@joana>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo, 

>>  	struct hci_dev *hdev;
>> +	struct hci_conn *conn;
>>  	struct mgmt_cp_pin_code_reply *cp;
>> +	struct mgmt_cp_pin_code_neg_reply ncp;
>>  	struct hci_cp_pin_code_reply reply;
>>  	struct pending_cmd *cmd;
>
>please pay more attention on the compiler warnings. cmd is 
>unused here. I fixed it up.

Right, but gcc 4.5 doesn't show me that. Will update to 4.6 then.

Thanks,
Waldek
