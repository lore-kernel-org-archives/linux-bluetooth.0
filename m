Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [PATCH 1/2] Bluetooth: Remove unneeded val variable when setting SSP
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20131010110117.GI23879@aemeltch-MOBL1>
Date: Thu, 10 Oct 2013 13:07:08 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <DB2A2D4A-F434-4D90-A6A4-A687AD48E72E@holtmann.org>
References: <1381399691-42391-1-git-send-email-marcel@holtmann.org> <20131010110117.GI23879@aemeltch-MOBL1>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

>> The variable val in the set_ssp() function of the management interface
>> is not needed. Just use cp->val directly since its input values have
>> already been validated.
>> 
>> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
>> ---
>> net/bluetooth/mgmt.c | 8 +++-----
>> 1 file changed, 3 insertions(+), 5 deletions(-)
>> 
>> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
>> index a9d7506..2fb4d35 100644
>> --- a/net/bluetooth/mgmt.c
>> +++ b/net/bluetooth/mgmt.c
>> @@ -1290,7 +1290,7 @@ static int set_ssp(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
>> {
>> 	struct mgmt_mode *cp = data;
>> 	struct pending_cmd *cmd;
>> -	u8 val, status;
>> +	u8 status;
>> 	int err;
>> 
>> 	BT_DBG("request for %s", hdev->name);
>> @@ -1309,8 +1309,6 @@ static int set_ssp(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
>> 
>> 	hci_dev_lock(hdev);
>> 
>> -	val = !!cp->val;
>> -
>> 	if (!hdev_is_powered(hdev)) {
>> 		bool changed = false;
>> 
>> @@ -1335,7 +1333,7 @@ static int set_ssp(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
>> 		goto failed;
>> 	}
>> 
>> -	if (test_bit(HCI_SSP_ENABLED, &hdev->dev_flags) == val) {
>> +	if (!!cp->val == test_bit(HCI_SSP_ENABLED, &hdev->dev_flags)) {
>> 		err = send_settings_rsp(sk, MGMT_OP_SET_SSP, hdev);
>> 		goto failed;
>> 	}
>> @@ -1346,7 +1344,7 @@ static int set_ssp(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
>> 		goto failed;
>> 	}
>> 
>> -	err = hci_send_cmd(hdev, HCI_OP_WRITE_SSP_MODE, sizeof(val), &val);
>> +	err = hci_send_cmd(hdev, HCI_OP_WRITE_SSP_MODE, 1, &cp->val);
> 
> I think sizeof is read better then magic number

if you look at the whole code base, for cases of single u8, we use the "magic" number 1 a lot to keep the lines shorter.

Regards

Marcel

