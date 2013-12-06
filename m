Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=US-ASCII
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1822\))
Subject: Re: [RFC v3 00/12] LE auto connection and connection parameters
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CACJA=fWLf7wAmgooAkmbH3e2R+AE9dbfutvbjTewkp+5bJkmeQ@mail.gmail.com>
Date: Fri, 6 Dec 2013 06:40:32 +0200
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <4993FF9F-65A6-4FB8-8065-A0F01CA21B1E@holtmann.org>
References: <1384985340-2902-1-git-send-email-andre.guedes@openbossa.org> <CACJA=fWLf7wAmgooAkmbH3e2R+AE9dbfutvbjTewkp+5bJkmeQ@mail.gmail.com>
To: Andre Guedes <andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

> Ping.
> 
>> The main changes from the previous version are:
>>  * Debugfs interface to add auto connect address instead of new mgmt
>>    commands.
>>  * We always stop LE scanning in favor of connection establishment even if
>>    the controller supports scanning and connection at the same time.
>>  * Background scanning is now controlled in one single place (hci_update_
>>    background_scan function).
>>  * RCU was replaced by hdev->lock to protect hdev->le_conn_params list. After
>>    all the changes since the original version of this patch set, I realized
>>    we always operate on hdev->le_conn_params with hdev->lock held so there is
>>    no point in use RCU to protect this list.

can you send a re-based v4 against the latest bluetooth-next tree please.

Regards

Marcel

