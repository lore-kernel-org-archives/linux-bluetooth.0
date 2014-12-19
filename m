Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: [PATCH 1/4] Bluetooth: Move struct hci_request definition higher up in hci_core.h
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20141219101512.GB17821@t440s.lan>
Date: Fri, 19 Dec 2014 11:36:09 +0100
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <885E66E0-5EE9-44D2-B846-C837D9762C5A@holtmann.org>
References: <1418981017-10462-1-git-send-email-johan.hedberg@gmail.com> <1418981017-10462-2-git-send-email-johan.hedberg@gmail.com> <0B9AB68C-9A0A-4767-9909-56EBDB2CEA36@holtmann.org> <20141219101512.GB17821@t440s.lan>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

>>> We'll soon start using struct hci_request as a parameter to several more
>>> functions in hci_core.h. To avoid compiler warnings of an undefined
>>> struct the definition needs to be moved higher up in the file. This
>>> patch moves it to the end of the block where several other structs are
>>> also defined.
>>> 
>>> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
>>> ---
>>> include/net/bluetooth/hci_core.h | 20 ++++++++++----------
>>> 1 file changed, 10 insertions(+), 10 deletions(-)
>>> 
>>> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
>>> index 3c7827005c25..75aaae07037f 100644
>>> --- a/include/net/bluetooth/hci_core.h
>>> +++ b/include/net/bluetooth/hci_core.h
>>> @@ -479,6 +479,16 @@ struct hci_conn_params {
>>> 	struct hci_conn *conn;
>>> };
>>> 
>>> +struct hci_request {
>>> +	struct hci_dev		*hdev;
>>> +	struct sk_buff_head	cmd_q;
>>> +
>>> +	/* If something goes wrong when building the HCI request, the error
>>> +	 * value is stored in this field.
>>> +	 */
>>> +	int			err;
>>> +};
>>> +
>>> extern struct list_head hci_dev_list;
>>> extern struct list_head hci_cb_list;
>>> extern rwlock_t hci_dev_list_lock;
>>> @@ -1284,16 +1294,6 @@ static inline int hci_check_conn_params(u16 min, u16 max, u16 latency,
>>> int hci_register_cb(struct hci_cb *hcb);
>>> int hci_unregister_cb(struct hci_cb *hcb);
>>> 
>>> -struct hci_request {
>>> -	struct hci_dev		*hdev;
>>> -	struct sk_buff_head	cmd_q;
>>> -
>>> -	/* If something goes wrong when building the HCI request, the error
>>> -	 * value is stored in this field.
>>> -	 */
>>> -	int			err;
>>> -};
>>> -
>>> void hci_req_init(struct hci_request *req, struct hci_dev *hdev);
>>> int hci_req_run(struct hci_request *req, hci_req_complete_t complete);
>>> void hci_req_add(struct hci_request *req, u16 opcode, u32 plen,
>> 
>> any reason to not move these along with the data structure? They
>> actually do belong together.
> 
> Nothing else except that hci_core.h didn't seem to have a very well
> established order to begin with and there seemed to be a general section
> for structs where I moved this to. I can move the functions along with
> it.

I think that at some point I tried to split hci_core.h into smaller pieces and because of its dependencies ended up giving up on it.

What might be worth while trying is to create a net/bluetooth/hci_request.[ch] and move the whole hci_request stuff locally into net/bluetooth/. This is at least one of the things that is limited to bluetooth.ko core module.

Regards

Marcel

