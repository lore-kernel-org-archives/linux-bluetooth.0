Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [PATCH 1/2] Bluetooth: Ignore A2MP data on non-BR/EDR links
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20131016085445.GL2861@aemeltch-MOBL1>
Date: Wed, 16 Oct 2013 11:10:54 +0200
Cc: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org
Message-Id: <11E330A9-CB86-4630-9699-D279DC98ED59@holtmann.org>
References: <1381912621-10238-1-git-send-email-johan.hedberg@gmail.com> <20131016085445.GL2861@aemeltch-MOBL1>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

>> The A2MP CID is only valid for BR/EDR transports. We should ignore A2MP
>> data on non-BR/EDR links and refuse to create an amp_mgr object.
>> 
>> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
>> ---
>> net/bluetooth/a2mp.c | 3 +++
>> 1 file changed, 3 insertions(+)
>> 
>> diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
>> index fe32a33..efcd108 100644
>> --- a/net/bluetooth/a2mp.c
>> +++ b/net/bluetooth/a2mp.c
>> @@ -836,6 +836,9 @@ struct l2cap_chan *a2mp_channel_create(struct l2cap_conn *conn,
>> {
>> 	struct amp_mgr *mgr;
>> 
>> +	if (conn->hcon->type != ACL_LINK)
>> +		return NULL;
>> +
> 
> Have you experienced this ever happened?

this is how good software is written. You check that your input is valid first. Otherwise you open yourself up to vulnerabilities.

Regards

Marcel

