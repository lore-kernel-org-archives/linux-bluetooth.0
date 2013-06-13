Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
Subject: Re: [PATCH] Bluetooth: Fix conditions for HCI_Delete_Stored_Link_Key
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20130613104216.GA17870@joana>
Date: Thu, 13 Jun 2013 12:48:51 +0200
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org, pavel@ucw.cz
Message-Id: <C40E0870-3699-41E2-8764-AD5DB1344927@holtmann.org>
References: <1371110473-15072-1-git-send-email-johan.hedberg@gmail.com> <5B6FB8F0-A31D-4C86-B15A-3FA04CB237FF@holtmann.org> <20130613104216.GA17870@joana>
To: Gustavo Padovan <gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

>>> Even though the HCI_Delete_Stored_Link_Key command is mandatory for 1.1
>>> and later controllers some controllers do not seem to support it
>>> properly as was witnessed by one Broadcom based controller:
>>> 
>>> < HCI Command: Delete Stored Link Key (0x03|0x0012) plen 7
>>>   bdaddr 00:00:00:00:00:00 all 1
>>>> HCI Event: Command Complete (0x0e) plen 4
>>>   Delete Stored Link Key (0x03|0x0012) ncmd 1
>>>   status 0x11 deleted 0
>>>   Error: Unsupported Feature or Parameter Value
>>> 
>>> Luckily this same controller also doesn't list the command in its
>>> supported commands bit mask (counting from 0 bit 7 of octet 6):
>>> 
>>> < HCI Command: Read Local Supported Commands (0x04|0x0002) plen 0
>>>> HCI Event: Command Complete (0x0e) plen 68
>>>   Read Local Supported Commands (0x04|0x0002) ncmd 1
>>>   status 0x00
>>>   Commands: ffffffffffff1ffffffffffff30fffff3f
>>> 
>>> Therefore, it makes sense to move sending of HCI_Delete_Stored_Link_Key
>>> to after receiving the supported commands response and to only send it
>>> if its respective bit in the mask is set. The downside of this is that
>>> we no longer send the HCI_Delete_Stored_Link_Key command for Bluetooth
>>> 1.1 controllers since HCI_Read_Local_Supported_Command was introduced in
>>> version 1.2, but this is an acceptable penalty as the command in
>>> question shouldn't affect critical behavior.
>>> 
>>> Reported-by: Pavel Machek <pavel@ucw.cz>
>>> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
>>> ---
>>> net/bluetooth/hci_core.c |   14 +++++++++-----
>>> 1 file changed, 9 insertions(+), 5 deletions(-)
>>> 
>>> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
>>> index d817c93..d68425c 100644
>>> --- a/net/bluetooth/hci_core.c
>>> +++ b/net/bluetooth/hci_core.c
>>> @@ -341,7 +341,6 @@ static void hci_init1_req(struct hci_request *req, unsigned long opt)
>>> 
>>> static void bredr_setup(struct hci_request *req)
>>> {
>>> -	struct hci_cp_delete_stored_link_key cp;
>>> 	__le16 param;
>>> 	__u8 flt_type;
>>> 
>>> @@ -365,10 +364,6 @@ static void bredr_setup(struct hci_request *req)
>>> 	param = __constant_cpu_to_le16(0x7d00);
>>> 	hci_req_add(req, HCI_OP_WRITE_CA_TIMEOUT, 2, &param);
>>> 
>>> -	bacpy(&cp.bdaddr, BDADDR_ANY);
>>> -	cp.delete_all = 0x01;
>>> -	hci_req_add(req, HCI_OP_DELETE_STORED_LINK_KEY, sizeof(cp), &cp);
>>> -
>>> 	/* Read page scan parameters */
>>> 	if (req->hdev->hci_ver > BLUETOOTH_VER_1_1) {
>>> 		hci_req_add(req, HCI_OP_READ_PAGE_SCAN_ACTIVITY, 0, NULL);
>>> @@ -602,6 +597,15 @@ static void hci_init3_req(struct hci_request *req, unsigned long opt)
>>> 	struct hci_dev *hdev = req->hdev;
>>> 	u8 p;
>> 
>> I would have added here a comment to explain what bit we are checking for.
> 
> I just added:
> 
> /* Only send HCI_Delete_Stored_Link_Key if it is supported */

that is the super cheap way out. There is no harm in going into details.

	/* Some Broadcom based Bluetooth controllers do not support the
	 * Delete Stored Link Key command. They are clearly indicating its
	 * absence in the bit mask of supported commands.
	 *
	 * Check the supported commands and only if the the command is marked as
	 * supported send it. If not supported assume that the controller does not
	 * have actual support for stored link keys which makes this command
	 * redundant anyway.
	 */

Regards

Marcel

