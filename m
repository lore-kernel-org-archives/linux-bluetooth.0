Return-Path: <johan.hedberg@gmail.com>
Date: Wed, 9 Mar 2016 17:14:36 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Add support for limited privacy mode
Message-ID: <20160309151436.GA25633@t440s.P-661HNU-F1>
References: <1457522545-30785-1-git-send-email-johan.hedberg@gmail.com>
 <C144B935-3349-41BF-8D3D-46EC6E9C9DBF@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <C144B935-3349-41BF-8D3D-46EC6E9C9DBF@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Mar 09, 2016, Marcel Holtmann wrote:
> > +static bool conn_use_rpa(struct hci_conn *conn)
> > +{
> > +	struct hci_dev *hdev = conn->hdev;
> > +
> > +	/* If privacy is not enabled don't use RPA */
> > +	if (!hci_dev_test_flag(hdev, HCI_PRIVACY))
> > +		return false;
> > +
> > +	/* If privacy is enabled in the basic mode use RPA */
> > +	if (!hci_dev_test_flag(hdev, HCI_LIMITED_PRIVACY))
> > +		return true;
> > +
> > +	/* If the limited privacy mode is enabled use an RPA only if
> > +	 * we're already paired.
> > +	 */
> > +	if (hci_find_ltk(hdev, &conn->dst, conn->dst_type, conn->role))
> > +		return true;
> > +
> > +	return false;
> > +}
> > +
> > static void hci_req_add_le_create_conn(struct hci_request *req,
> > 				       struct hci_conn *conn)
> > {
> > @@ -726,14 +747,15 @@ static void hci_req_add_le_create_conn(struct hci_request *req,
> > 	struct hci_dev *hdev = conn->hdev;
> > 	u8 own_addr_type;
> > 
> > -	memset(&cp, 0, sizeof(cp));
> > -
> > 	/* Update random address, but set require_privacy to false so
> > 	 * that we never connect with an non-resolvable address.
> > 	 */
> > -	if (hci_update_random_address(req, false, &own_addr_type))
> > +	if (hci_update_random_address(req, false, conn_use_rpa(conn),
> > +				      &own_addr_type))
> > 		return;
> 
> so this is something I really wonder if that is needed at all. If we
> create a connection, I think we should always create it with the RPA.
> I mean if we do not connect with the RPA, then on every connection
> attempt we leak the identity address. My thinking of the mode 0x02 was
> that when we are going to make ourselves discoverable, then we allow
> the identity address to be revealed. Mainly since that is what happens
> on BR/EDR when it becomes discoverable. Leaking the address when
> initiating connections seems unclear.

As discussed on IRC I was just following what had been documented in
mgmt-api.txt, but I agree that we should just remove this extra
condition for the privacy 0x02 mode (and fix mgmt-api.txt as well).

> However if that is wanted, then I rather also add mode 0x03 that goes
> one step further, but for mode 0x02 this seems a bit too much.

Sure, though I'm right now failing to see the benefit of 0x03 at all,
i.e. let's leave it for the future if a clear need arises.

> > +	memset(&cp, 0, sizeof(cp));
> > +
> 
> Don't get this memset moving around.

You're right, this should probably be split to a separate patch.

> > 	/* Adding or removing entries from the white list must
> > @@ -866,6 +872,9 @@ static u32 get_adv_instance_flags(struct hci_dev *hdev, u8 instance)
> > 		if (hci_dev_test_flag(hdev, HCI_ADVERTISING_CONNECTABLE))
> > 			flags |= MGMT_ADV_FLAG_CONNECTABLE;
> > 
> > +		if (hci_dev_test_flag(hdev, HCI_DISCOVERABLE))
> > +			flags |= MGMT_ADV_FLAG_DISCOV;
> > +
> 
> Seems unrelated to this patch. Is this a bug we already have?

It's related since this influences the RPA/identity selection, however
I'll move it into a separate patch.

> > -	if (hci_dev_test_flag(hdev, HCI_ADVERTISING))
> > +	if (hci_dev_test_flag(hdev, HCI_ADVERTISING)) {
> > 		__hci_req_update_adv_data(req, 0x00);
> > 
> > +		/* Discoverable mode affects the local advertising
> > +		 * address in limited privacy mode.
> > +		 */
> > +		if (hci_dev_test_flag(hdev, HCI_LIMITED_PRIVACY))
> > +			__hci_req_enable_advertising(req);
> 
> Isn't this unbalanced now. I do not want to end up in the case where
> we try to enable advertising twice.

__hci_req_enable_advertising() first disables advertising if it was
enabled. I suppose __hci_req_reenable_advertising() might be a better
name.

Johan
