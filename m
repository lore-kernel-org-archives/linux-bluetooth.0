Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Subject: Re: [PATCH] Bluetooth: Add support for limited privacy mode
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20160309151436.GA25633@t440s.P-661HNU-F1>
Date: Wed, 9 Mar 2016 07:24:58 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <ECC14388-6955-4EDE-B818-14CAF048E8C8@holtmann.org>
References: <1457522545-30785-1-git-send-email-johan.hedberg@gmail.com> <C144B935-3349-41BF-8D3D-46EC6E9C9DBF@holtmann.org> <20160309151436.GA25633@t440s.P-661HNU-F1>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

>>> +static bool conn_use_rpa(struct hci_conn *conn)
>>> +{
>>> +	struct hci_dev *hdev = conn->hdev;
>>> +
>>> +	/* If privacy is not enabled don't use RPA */
>>> +	if (!hci_dev_test_flag(hdev, HCI_PRIVACY))
>>> +		return false;
>>> +
>>> +	/* If privacy is enabled in the basic mode use RPA */
>>> +	if (!hci_dev_test_flag(hdev, HCI_LIMITED_PRIVACY))
>>> +		return true;
>>> +
>>> +	/* If the limited privacy mode is enabled use an RPA only if
>>> +	 * we're already paired.
>>> +	 */
>>> +	if (hci_find_ltk(hdev, &conn->dst, conn->dst_type, conn->role))
>>> +		return true;
>>> +
>>> +	return false;
>>> +}
>>> +
>>> static void hci_req_add_le_create_conn(struct hci_request *req,
>>> 				       struct hci_conn *conn)
>>> {
>>> @@ -726,14 +747,15 @@ static void hci_req_add_le_create_conn(struct hci_request *req,
>>> 	struct hci_dev *hdev = conn->hdev;
>>> 	u8 own_addr_type;
>>> 
>>> -	memset(&cp, 0, sizeof(cp));
>>> -
>>> 	/* Update random address, but set require_privacy to false so
>>> 	 * that we never connect with an non-resolvable address.
>>> 	 */
>>> -	if (hci_update_random_address(req, false, &own_addr_type))
>>> +	if (hci_update_random_address(req, false, conn_use_rpa(conn),
>>> +				      &own_addr_type))
>>> 		return;
>> 
>> so this is something I really wonder if that is needed at all. If we
>> create a connection, I think we should always create it with the RPA.
>> I mean if we do not connect with the RPA, then on every connection
>> attempt we leak the identity address. My thinking of the mode 0x02 was
>> that when we are going to make ourselves discoverable, then we allow
>> the identity address to be revealed. Mainly since that is what happens
>> on BR/EDR when it becomes discoverable. Leaking the address when
>> initiating connections seems unclear.
> 
> As discussed on IRC I was just following what had been documented in
> mgmt-api.txt, but I agree that we should just remove this extra
> condition for the privacy 0x02 mode (and fix mgmt-api.txt as well).

lets remove this extra condition since it actually can not work. It actually does not help to track if we have the LTK of the remote. It has no real relations to our IRK.

We would actually need to track if we handed out our IRK to the remote to make this work correctly. Currently we are not tracking that at all. We might be offering our IRK, but that does not mean the remote side actually said it wants it. We are only tracking if we have the remote IRK, not if we handed out ours.

Regards

Marcel

