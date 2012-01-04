Return-Path: <cyrus@holtmann.org>
Message-ID: <4F047716.3000500@monom.org>
Date: Wed, 04 Jan 2012 16:58:14 +0100
From: Daniel Wagner <wagi@monom.org>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC v0 2/3] Bluetooth: Use hci_conn_auth() instead of open coded
 version
References: <1325689584-15121-1-git-send-email-wagi@monom.org>  <1325689584-15121-3-git-send-email-wagi@monom.org> <1325692315.6454.36.camel@aeonflux>
In-Reply-To: <1325692315.6454.36.camel@aeonflux>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On 04.01.2012 16:51, Marcel Holtmann wrote:
> Hi Daniel,
> 
>> Note this will also enable the encryption which will
>> not happen in the open coded version.
>>
>> Signed-off-by: Daniel Wagner <daniel.wagner@bmw-carit.de>
>> ---
>>  net/bluetooth/hci_event.c |   12 ++----------
>>  1 files changed, 2 insertions(+), 10 deletions(-)
>>
>> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
>> index d37f5b2..453e483 100644
>> --- a/net/bluetooth/hci_event.c
>> +++ b/net/bluetooth/hci_event.c
>> @@ -1296,11 +1296,7 @@ static void hci_cs_remote_name_req(struct hci_dev *hdev, __u8 status)
>>  	if (!hci_outgoing_auth_needed(hdev, conn))
>>  		goto unlock;
>>  
>> -	if (!test_and_set_bit(HCI_CONN_AUTH_PEND, &conn->pend)) {
>> -		struct hci_cp_auth_requested cp;
>> -		cp.handle = __cpu_to_le16(conn->handle);
>> -		hci_send_cmd(hdev, HCI_OP_AUTH_REQUESTED, sizeof(cp), &cp);
>> -	}
>> +	hci_conn_auth(conn, BT_SECURITY_HIGH, conn->auth_type);
> 
> this is not a replacement. Not even a little bit. You are currently
> messing with powers that can break qualification.

I suspected this :) In this case I better leave this stuff untouched.

cheers,
daniel
