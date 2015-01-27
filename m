Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: [PATCH] Bluetooth: Limit OOB to P-256 values for Secure Connection Only mode
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <2080375.GZdINHllEn@leonov>
Date: Tue, 27 Jan 2015 12:39:45 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <8055BE26-B2E8-43A1-A038-D40AC32FB60E@holtmann.org>
References: <1422386512-15819-1-git-send-email-marcel@holtmann.org> <2080375.GZdINHllEn@leonov>
To: Szymon Janc <szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

>> When using Secure Connection Only mode, the P-192 hash and rand values
>> for BR/EDR and the TK value for LE are not valid. The Secure Connections
>> Only mode limits the encryption keys to P-256 derived values for both
>> transports. To avoid accidentally loading weak values for pairing just
>> restrict it to P-256 values.
> 
> If so, shouldn't enabling Secure Connection Only mode result in clearing OOB 
> data (or at least removing legacy ones)?

most likely it should. However that can be a separate patch.

I think actually any change to SSP or SC setting should cause the remote OOB information to be flushed.

>> 
>> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
>> ---
>> net/bluetooth/mgmt.c | 30 ++++++++++++++++++++++++++----
>> 1 file changed, 26 insertions(+), 4 deletions(-)
>> 
>> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
>> index 8417ab387d1a..5c7340b1cd66 100644
>> --- a/net/bluetooth/mgmt.c
>> +++ b/net/bluetooth/mgmt.c
>> @@ -3660,6 +3660,21 @@ static int add_remote_oob_data(struct sock *sk,
>> struct hci_dev *hdev, goto unlock;
>> 		}
>> 
>> +		/* In case Secure Connections Only made has been enabled,
> 
> typo:  made -> mode

Johan can make that change before applying the patch. However good catch.

> 
>> +		 * do not allow providing P-192 hash and rand values.
>> +		 *
>> +		 * This actually means that in Secure Connections Only
>> +		 * mode this command with the legacy parameter list
>> +		 * is not supported at all.
>> +		 */
>> +		if (test_bit(HCI_SC_ONLY, &hdev->dev_flags)) {
>> +			err = cmd_complete(sk, hdev->id,
>> +					   MGMT_OP_ADD_REMOTE_OOB_DATA,
>> +					   MGMT_STATUS_INVALID_PARAMS,
>> +					   addr, sizeof(*addr));
>> +			goto unlock;
>> +		}
>> +
>> 		err = hci_add_remote_oob_data(hdev, &cp->addr.bdaddr,
>> 					      cp->addr.type, cp->hash,
>> 					      cp->rand, NULL, NULL);
>> @@ -3675,10 +3690,17 @@ static int add_remote_oob_data(struct sock *sk,
>> struct hci_dev *hdev, u8 *rand192, *hash192;
>> 		u8 status;
>> 
>> -		if (bdaddr_type_is_le(cp->addr.type)) {
>> -			/* Enforce zero-valued 192-bit parameters as
>> -			 * long as legacy SMP OOB isn't implemented.
>> -			 */
>> +		/* For Bluetooth LE, currently only P-256 hash and rand
>> +		 * values are allowed. The P-192 hash and rand values
>> +		 * are required to be zero. This is required since Legacy
>> +		 * Pairing for LE with OOB is not implemented yet.
>> +		 *
>> +		 * In case Secure Connections Only made has been enabled,
> 
> same typo

Same here, Johan, please fix this before applying.

>> +		 * do not allow providing P-192 hash and rand values. It
>> +		 * is required that the values are zero here as well.
>> +		 */
>> +		if (bdaddr_type_is_le(cp->addr.type) ||
>> +		    test_bit(HCI_SC_ONLY, &hdev->dev_flags)) {
>> 			if (memcmp(cp->rand192, ZERO_KEY, 16) ||
>> 			    memcmp(cp->hash192, ZERO_KEY, 16)) {
>> 				err = cmd_complete(sk, hdev->id,

Regards

Marcel

