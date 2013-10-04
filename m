Return-Path: <cyrus@holtmann.org>
Message-ID: <524F2BDC.7070804@openbossa.org>
Date: Fri, 04 Oct 2013 17:58:04 -0300
From: Andre Guedes <andre.guedes@openbossa.org>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 4/4] Bluetooth: Refactor hci_connect_le
References: <1380835547-3640-1-git-send-email-andre.guedes@openbossa.org> <1380835547-3640-5-git-send-email-andre.guedes@openbossa.org> <AC94A523-A61F-4089-8BB8-5EFE52C34ACE@holtmann.org>
In-Reply-To: <AC94A523-A61F-4089-8BB8-5EFE52C34ACE@holtmann.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On 10/04/2013 03:27 AM, Marcel Holtmann wrote:
> Hi Andre,
>
>> This patch does some code refactoring in hci_connect_le() by moving
>> the exception code into if statements and letting the main flow in
>> first level of function scope. It also adds extra comments to improve
>> the code readability.
>>
>> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
>> ---
>> net/bluetooth/hci_conn.c | 55 ++++++++++++++++++++++++++++++------------------
>> 1 file changed, 35 insertions(+), 20 deletions(-)
>>
>> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
>> index cb0e5d7..ff15841 100644
>> --- a/net/bluetooth/hci_conn.c
>> +++ b/net/bluetooth/hci_conn.c
>> @@ -531,34 +531,49 @@ static struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
>> 	if (test_bit(HCI_LE_PERIPHERAL, &hdev->flags))
>> 		return ERR_PTR(-ENOTSUPP);
>>
>> +	/* XXX: Some devices send ATT messages as soon as the physical link
>
> no idea what the XXX wants to tell me here.

The XXX: tag is just a convention programmers use to warn other 
programmers about some problematic or special condition in the code. It 
is used widely in several projects, including the Linux kernel.

I just "grep'ed" and realized we are not used to use XXX: in Bluetooth 
subsystem so I'll remove it.

>
>> +	 * is established. To be able to handle these ATT messages, the user-
>> +	 * space first establishes the connection and then starts the pairing
>> +	 * process.
>> +	 *
>> +	 * So if a hci_conn object already exists for the following connection
>> +	 * attempt, we simply update pending_sec_level and auth_type fields
>> +	 * and return the object found.
>> +	 */
>> 	conn = hci_conn_hash_lookup_ba(hdev, LE_LINK, dst);
>> -	if (!conn) {
>> -		conn = hci_conn_hash_lookup_state(hdev, LE_LINK, BT_CONNECT);
>> -		if (conn)
>> -			return ERR_PTR(-EBUSY);
>> -
>> -		conn = hci_conn_add(hdev, LE_LINK, dst);
>> -		if (!conn)
>> -			return ERR_PTR(-ENOMEM);
>> +	if (conn) {
>> +		conn->pending_sec_level = sec_level;
>> +		conn->auth_type = auth_type;
>> +		goto out;
>> +	}
>
> Call such a label "done". I never really liked the out part.

Ok, I'll rename this label.

Regards,

Andre
