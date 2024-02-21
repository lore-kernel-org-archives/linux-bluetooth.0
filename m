Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F500EC5
	for <linux-bluetooth@vger.kernel.org>; Wed, 21 Feb 2024 22:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708554783; cv=none; b=kMwJ1aRT04llR3GzWOActdbVZRkhClfT9VRwiPdIb/clLdFEmEGTdWjQfRZvCE2XZ2kRrXhTxRoqGpAZ0QYUqnex/PxZccOOfpLKIjQHDut+Hdz+A8zxXwWjhVTVi4zFFl1heCePG7JT6Mdrje3NH84BgdXARwEcZ/tOwgAQn4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708554783; c=relaxed/simple;
	bh=OY4viTy1e/+0/hmdZ278LPJ2ffPNZ/RPsCNCJY8/4lA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=WO5gdf+MYDl90zyTpP6YZ+N/f5dgQYCJ+BPRmzzaa9A/gICwLQ4M6vWcXnlR9SYdloYpUZpwRFgRjcJIG4PqHsFkdXWVp0ow3nNgExMGRgUrLJYr3YMTi9E5/4f0Q1GzZcs8vPM3QMptjMd7V4gO3duj0tWbde3pFHETy1X1iF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=v0yd.nl; spf=pass smtp.mailfrom=v0yd.nl; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=v0yd.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=v0yd.nl
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Tg9pQ011Qz9spb;
	Wed, 21 Feb 2024 23:25:50 +0100 (CET)
Message-ID: <f3f594bd-9974-48ad-9857-374a157b8660@v0yd.nl>
Date: Wed, 21 Feb 2024 23:25:48 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?Q?Jonas_Dre=C3=9Fler?= <verdre@v0yd.nl>
Subject: Re: [PATCH v2 3/3] Bluetooth: hci_sync: Attempt to dequeue connection
 attempt
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
References: <20240213213123.403654-3-luiz.dentz@gmail.com>
 <5df46404-15f7-4830-bc4f-f19d5fefae3a@v0yd.nl>
 <CABBYNZKmvgG4zDg1_5zxjDoeauuA61gpR9kq-RJ20ce2asBorQ@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CABBYNZKmvgG4zDg1_5zxjDoeauuA61gpR9kq-RJ20ce2asBorQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4Tg9pQ011Qz9spb

Hi Luiz,

On 14.02.24 19:44, Luiz Augusto von Dentz wrote:
> Hi Jonas,
> 
> On Tue, Feb 13, 2024 at 6:47 PM Jonas Dreßler <verdre@v0yd.nl> wrote:
>>
>> Hi Luiz,
>>
>>> If connection is still queued/pending in the cmd_sync queue it means no
>>> command has been generated and it should be safe to just dequeue the
>>> callback when it is being aborted.
>>>
>>> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>> ---
>>>   include/net/bluetooth/hci_core.h | 19 ++++++++
>>>   include/net/bluetooth/hci_sync.h | 10 +++--
>>>   net/bluetooth/hci_conn.c         | 70 ++++++------------------------
>>>   net/bluetooth/hci_sync.c         | 74 ++++++++++++++++++++++++++++----
>>>   4 files changed, 102 insertions(+), 71 deletions(-)
>>>
>>> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
>>> index 2bdea85b7c44..317d495cfcf5 100644
>>> --- a/include/net/bluetooth/hci_core.h
>>> +++ b/include/net/bluetooth/hci_core.h
>>> @@ -1083,6 +1083,24 @@ static inline unsigned int hci_conn_count(struct hci_dev *hdev)
>>>        return c->acl_num + c->amp_num + c->sco_num + c->le_num + c->iso_num;
>>>   }
>>>
>>> +static inline bool hci_conn_valid(struct hci_dev *hdev, struct hci_conn *conn)
>>> +{
>>> +     struct hci_conn_hash *h = &hdev->conn_hash;
>>> +     struct hci_conn  *c;
>>> +
>>> +     rcu_read_lock();
>>> +
>>> +     list_for_each_entry_rcu(c, &h->list, list) {
>>> +             if (c == conn) {
>>> +                     rcu_read_unlock();
>>> +                     return true;
>>> +             }
>>> +     }
>>> +     rcu_read_unlock();
>>> +
>>> +     return false;
>>> +}
>>> +
>>>   static inline __u8 hci_conn_lookup_type(struct hci_dev *hdev, __u16 handle)
>>>   {
>>>        struct hci_conn_hash *h = &hdev->conn_hash;
>>> @@ -1493,6 +1511,7 @@ struct hci_conn *hci_connect_le_scan(struct hci_dev *hdev, bdaddr_t *dst,
>>>   struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
>>>                                u8 dst_type, bool dst_resolved, u8 sec_level,
>>>                                u16 conn_timeout, u8 role);
>>> +void hci_connect_le_scan_cleanup(struct hci_conn *conn, u8 status);
>>>   struct hci_conn *hci_connect_acl(struct hci_dev *hdev, bdaddr_t *dst,
>>>                                 u8 sec_level, u8 auth_type,
>>>                                 enum conn_reasons conn_reason, u16 timeout);
>>> diff --git a/include/net/bluetooth/hci_sync.h b/include/net/bluetooth/hci_sync.h
>>> index 4ff4aa68ee19..6a9d063e9f47 100644
>>> --- a/include/net/bluetooth/hci_sync.h
>>> +++ b/include/net/bluetooth/hci_sync.h
>>> @@ -48,11 +48,11 @@ int hci_cmd_sync_submit(struct hci_dev *hdev, hci_cmd_sync_work_func_t func,
>>>                        void *data, hci_cmd_sync_work_destroy_t destroy);
>>>   int hci_cmd_sync_queue(struct hci_dev *hdev, hci_cmd_sync_work_func_t func,
>>>                       void *data, hci_cmd_sync_work_destroy_t destroy);
>>> +int hci_cmd_sync_queue_once(struct hci_dev *hdev, hci_cmd_sync_work_func_t func,
>>> +                         void *data, hci_cmd_sync_work_destroy_t destroy);
>>>   struct hci_cmd_sync_work_entry *
>>>   hci_cmd_sync_lookup_entry(struct hci_dev *hdev, hci_cmd_sync_work_func_t func,
>>>                          void *data, hci_cmd_sync_work_destroy_t destroy);
>>> -int hci_cmd_sync_queue_once(struct hci_dev *hdev, hci_cmd_sync_work_func_t func,
>>> -                         void *data, hci_cmd_sync_work_destroy_t destroy);
>>>   void hci_cmd_sync_cancel_entry(struct hci_dev *hdev,
>>>                               struct hci_cmd_sync_work_entry *entry);
>>>   bool hci_cmd_sync_dequeue(struct hci_dev *hdev, hci_cmd_sync_work_func_t func,
>>> @@ -139,8 +139,6 @@ struct hci_conn;
>>>
>>>   int hci_abort_conn_sync(struct hci_dev *hdev, struct hci_conn *conn, u8 reason);
>>>
>>> -int hci_le_create_conn_sync(struct hci_dev *hdev, struct hci_conn *conn);
>>> -
>>>   int hci_le_create_cis_sync(struct hci_dev *hdev);
>>>
>>>   int hci_le_remove_cig_sync(struct hci_dev *hdev, u8 handle);
>>> @@ -152,3 +150,7 @@ int hci_le_big_terminate_sync(struct hci_dev *hdev, u8 handle);
>>>   int hci_le_pa_terminate_sync(struct hci_dev *hdev, u16 handle);
>>>
>>>   int hci_connect_acl_sync(struct hci_dev *hdev, struct hci_conn *conn);
>>> +
>>> +int hci_connect_le_sync(struct hci_dev *hdev, struct hci_conn *conn);
>>> +
>>> +int hci_cancel_connect_sync(struct hci_dev *hdev, struct hci_conn *conn);
>>> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
>>> index 587eb27f374c..21e0b4064d05 100644
>>> --- a/net/bluetooth/hci_conn.c
>>> +++ b/net/bluetooth/hci_conn.c
>>> @@ -68,7 +68,7 @@ static const struct sco_param esco_param_msbc[] = {
>>>   };
>>>
>>>   /* This function requires the caller holds hdev->lock */
>>> -static void hci_connect_le_scan_cleanup(struct hci_conn *conn, u8 status)
>>> +void hci_connect_le_scan_cleanup(struct hci_conn *conn, u8 status)
>>>   {
>>>        struct hci_conn_params *params;
>>>        struct hci_dev *hdev = conn->hdev;
>>> @@ -1124,6 +1124,9 @@ void hci_conn_del(struct hci_conn *conn)
>>>         * rest of hci_conn_del.
>>>         */
>>>        hci_conn_cleanup(conn);
>>> +
>>> +     /* Dequeue callbacks using connection pointer as data */
>>> +     hci_cmd_sync_dequeue(hdev, NULL, conn, NULL);
>>>   }
>>>
>>>   struct hci_dev *hci_get_route(bdaddr_t *dst, bdaddr_t *src, uint8_t src_type)
>>> @@ -1258,53 +1261,6 @@ u8 hci_conn_set_handle(struct hci_conn *conn, u16 handle)
>>>        return 0;
>>>   }
>>>
>>> -static void create_le_conn_complete(struct hci_dev *hdev, void *data, int err)
>>> -{
>>> -     struct hci_conn *conn;
>>> -     u16 handle = PTR_UINT(data);
>>> -
>>> -     conn = hci_conn_hash_lookup_handle(hdev, handle);
>>> -     if (!conn)
>>> -             return;
>>> -
>>> -     bt_dev_dbg(hdev, "err %d", err);
>>> -
>>> -     hci_dev_lock(hdev);
>>> -
>>> -     if (!err) {
>>> -             hci_connect_le_scan_cleanup(conn, 0x00);
>>> -             goto done;
>>> -     }
>>> -
>>> -     /* Check if connection is still pending */
>>> -     if (conn != hci_lookup_le_connect(hdev))
>>> -             goto done;
>>> -
>>> -     /* Flush to make sure we send create conn cancel command if needed */
>>> -     flush_delayed_work(&conn->le_conn_timeout);
>>> -     hci_conn_failed(conn, bt_status(err));
>>> -
>>> -done:
>>> -     hci_dev_unlock(hdev);
>>> -}
>>> -
>>> -static int hci_connect_le_sync(struct hci_dev *hdev, void *data)
>>> -{
>>> -     struct hci_conn *conn;
>>> -     u16 handle = PTR_UINT(data);
>>> -
>>> -     conn = hci_conn_hash_lookup_handle(hdev, handle);
>>> -     if (!conn)
>>> -             return 0;
>>> -
>>> -     bt_dev_dbg(hdev, "conn %p", conn);
>>> -
>>> -     clear_bit(HCI_CONN_SCANNING, &conn->flags);
>>> -     conn->state = BT_CONNECT;
>>> -
>>> -     return hci_le_create_conn_sync(hdev, conn);
>>> -}
>>> -
>>>   struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
>>>                                u8 dst_type, bool dst_resolved, u8 sec_level,
>>>                                u16 conn_timeout, u8 role)
>>> @@ -1371,9 +1327,7 @@ struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
>>>        conn->sec_level = BT_SECURITY_LOW;
>>>        conn->conn_timeout = conn_timeout;
>>>
>>
>> Might want to add a
>>
>> +       if (conn->state != BT_OPEN && conn->state != BT_CLOSED)
>> +               return conn;
>>
>> before setting the conn->dst_type while at it, similar to how it's
>> in hci_connect_acl().
> 
> Hmm but shall never be the case since we have the following check before it:
> 
>      /* Since the controller supports only one LE connection attempt at a
>       * time, we return -EBUSY if there is any connection attempt running.
>       */
>      if (hci_lookup_le_connect(hdev))
>          return ERR_PTR(-EBUSY);

Ahh okay, fair, didn't notice that!

> 
>>
>>> -     err = hci_cmd_sync_queue(hdev, hci_connect_le_sync,
>>> -                              UINT_PTR(conn->handle),
>>> -                              create_le_conn_complete);
>>> +     err = hci_connect_le_sync(hdev, conn);
>>>        if (err) {
>>>                hci_conn_del(conn);
>>>                return ERR_PTR(err);
>>> @@ -2909,12 +2863,10 @@ u32 hci_conn_get_phy(struct hci_conn *conn)
>>>
>>>   static int abort_conn_sync(struct hci_dev *hdev, void *data)
>>>   {
>>> -     struct hci_conn *conn;
>>> -     u16 handle = PTR_UINT(data);
>>> +     struct hci_conn *conn = data;
>>>
>>> -     conn = hci_conn_hash_lookup_handle(hdev, handle);
>>> -     if (!conn)
>>> -             return 0;
>>> +     if (!hci_conn_valid(hdev, conn))
>>> +             return -ECANCELED;
>>>
>>>        return hci_abort_conn_sync(hdev, conn, conn->abort_reason);
>>>   }
>>> @@ -2949,8 +2901,10 @@ int hci_abort_conn(struct hci_conn *conn, u8 reason)
>>>                        hci_cmd_sync_cancel(hdev, -ECANCELED);
>>>                        break;
>>>                }
>>> +     /* Cancel connect attempt if still queued/pending */
>>> +     } else if (!hci_cancel_connect_sync(hdev, conn)) {
>>> +             return 0;
>>>        }
>>>
>>> -     return hci_cmd_sync_queue(hdev, abort_conn_sync, UINT_PTR(conn->handle),
>>> -                               NULL);
>>> +     return hci_cmd_sync_queue_once(hdev, abort_conn_sync, conn, NULL);
>>>   }
>>> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
>>> index 5b314bf844f8..b7d8e99e2a30 100644
>>> --- a/net/bluetooth/hci_sync.c
>>> +++ b/net/bluetooth/hci_sync.c
>>> @@ -6285,12 +6285,21 @@ static int hci_le_ext_create_conn_sync(struct hci_dev *hdev,
>>>                                        conn->conn_timeout, NULL);
>>>   }
>>>
>>> -int hci_le_create_conn_sync(struct hci_dev *hdev, struct hci_conn *conn)
>>> +static int hci_le_create_conn_sync(struct hci_dev *hdev, void *data)
>>>   {
>>>        struct hci_cp_le_create_conn cp;
>>>        struct hci_conn_params *params;
>>>        u8 own_addr_type;
>>>        int err;
>>> +     struct hci_conn *conn = data;
>>> +
>>> +     if (!hci_conn_valid(hdev, conn))
>>> +             return -ECANCELED;
>>> +
>>> +     bt_dev_dbg(hdev, "conn %p", conn);
>>> +
>>> +     clear_bit(HCI_CONN_SCANNING, &conn->flags);
>>> +     conn->state = BT_CONNECT;
>>>
>>>        /* If requested to connect as peripheral use directed advertising */
>>>        if (conn->role == HCI_ROLE_SLAVE) {
>>> @@ -6611,16 +6620,11 @@ int hci_update_adv_data(struct hci_dev *hdev, u8 instance)
>>>
>>>   static int hci_acl_create_conn_sync(struct hci_dev *hdev, void *data)
>>>   {
>>> -     struct hci_conn *conn;
>>> -     u16 handle = PTR_UINT(data);
>>> +     struct hci_conn *conn = data;
>>>        struct inquiry_entry *ie;
>>>        struct hci_cp_create_conn cp;
>>>        int err;
>>>
>>> -     conn = hci_conn_hash_lookup_handle(hdev, handle);
>>> -     if (!conn)
>>> -             return 0;
>>> -
>>>        /* Many controllers disallow HCI Create Connection while it is doing
>>>         * HCI Inquiry. So we cancel the Inquiry first before issuing HCI Create
>>>         * Connection. This may cause the MGMT discovering state to become false
>>> @@ -6679,6 +6683,58 @@ static int hci_acl_create_conn_sync(struct hci_dev *hdev, void *data)
>>>
>>>   int hci_connect_acl_sync(struct hci_dev *hdev, struct hci_conn *conn)
>>>   {
>>> -     return hci_cmd_sync_queue(hdev, hci_acl_create_conn_sync,
>>> -                               UINT_PTR(conn->handle), NULL);
>>> +     return hci_cmd_sync_queue_once(hdev, hci_acl_create_conn_sync, conn,
>>> +                                    NULL);
>>> +}
>>> +
>>> +static void create_le_conn_complete(struct hci_dev *hdev, void *data, int err)
>>> +{
>>> +     struct hci_conn *conn = data;
>>> +
>>> +     bt_dev_dbg(hdev, "err %d", err);
>>> +
>>> +     if (err == -ECANCELED)
>>> +             return;
>>> +
>>> +     hci_dev_lock(hdev);
>>> +
>>> +     if (!err) {
>>> +             hci_connect_le_scan_cleanup(conn, 0x00);
>>> +             goto done;
>>> +     }
>>> +
>>> +     /* Check if connection is still pending */
>>> +     if (conn != hci_lookup_le_connect(hdev))
>>> +             goto done;
>>> +
>>> +     /* Flush to make sure we send create conn cancel command if needed */
>>> +     flush_delayed_work(&conn->le_conn_timeout);
>>> +     hci_conn_failed(conn, bt_status(err));
>>> +
>>> +done:
>>> +     hci_dev_unlock(hdev);
>>> +}
>>> +
>>> +int hci_connect_le_sync(struct hci_dev *hdev, struct hci_conn *conn)
>>> +{
>>> +     return hci_cmd_sync_queue_once(hdev, hci_le_create_conn_sync, conn,
>>> +                                    create_le_conn_complete);
>>> +}
>>> +
>>> +int hci_cancel_connect_sync(struct hci_dev *hdev, struct hci_conn *conn)
>>> +{
>>> +     if (conn->state != BT_OPEN)
>>> +             return -EINVAL;
>>> +
>>> +     switch (conn->type) {
>>> +     case ACL_LINK:
>>> +             return !hci_cmd_sync_dequeue_once(hdev,
>>> +                                               hci_acl_create_conn_sync,
>>> +                                               conn, NULL);
>>> +     case LE_LINK:
>>> +             return !hci_cmd_sync_dequeue_once(hdev, hci_le_create_conn_sync,
>>> +                                               conn, create_le_conn_complete);
>>> +     }
>>> +
>>> +     return -ENOENT;
>>>   }
>>> --
>>> 2.43.0
>>
>> Thanks for sending those patches, this is pretty much exactly what I had in mind!
>>
>> I came up with a slightly different cancel function for the queued work, one that
>> also cancels the ongoing work. I'm not sure if it makes too much sense, because it
>> means adding careful -ECANCELED handling to those sync_work callbacks.
>>
>> The nice thing about it is that it should also allow getting rid of the
>> hci_cmd_sync_cancel(hdev, -ECANCELED) in hci_abort_conn().
>>
>> Adding the patch below, feel free to reuse whatever you like!
>>
>> Cheers,
>> Jonas
>>
>> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
>> index 067d445701..a2b14f6be1 100644
>> --- a/net/bluetooth/hci_sync.c
>> +++ b/net/bluetooth/hci_sync.c
>> @@ -154,6 +154,13 @@ struct sk_buff *__hci_cmd_sync_sk(struct hci_dev *hdev, u16 opcode, u32 plen,
>>
>>          bt_dev_dbg(hdev, "Opcode 0x%4x", opcode);
>>
>> +       if (hdev->cur_hci_sync_work_cancelled) {
>> +               hdev->cur_hci_sync_work_cancelled = false;
>> +
>> +               return ERR_PTR(-ECANCELED);
>> +       }
>> +       mutex_unlock(&hdev->cmd_sync_work_lock);
>> +
>>          hci_req_init(&req, hdev);
>>
>>          hci_cmd_sync_add(&req, opcode, plen, param, event, sk);
>> @@ -303,9 +310,29 @@ static void hci_cmd_sync_work(struct work_struct *work)
>>                          int err;
>>
>>                          hci_req_sync_lock(hdev);
>> +
>> +                       mutex_lock(&hdev->cmd_sync_work_lock);
>> +                       hdev->cur_hci_sync_work_func = entry->func;
>> +                       hdev->cur_hci_sync_work_data = entry->data;
>> +                       mutex_unlock(&hdev->cmd_sync_work_lock);
>> +
>>                          err = entry->func(hdev, entry->data);
>>                          if (entry->destroy)
>>                                  entry->destroy(hdev, entry->data, err);
>> +
>> +                       mutex_lock(&hdev->cmd_sync_work_lock);
>> +                       hdev->cur_hci_sync_work_func = NULL;
>> +                       hdev->cur_hci_sync_work_data = NULL;
>> +
>> +                       if (hdev->cur_hci_sync_work_cancelled) {
>> +                               /* If cur_hci_sync_work_cancelled is still set at this point,
>> +                                * no more request was sent and the work func has never been
>> +                                * notified of our cancellation.
>> +                                */
>> +                               hdev->cur_hci_sync_work_cancelled = false;
>> +                       }
>> +                       mutex_unlock(&hdev->cmd_sync_work_lock);
> 
> Not really following this code, do you want to be able to cancel
> callbacks that are actually executing, rather than queued?

Yup exactly, I'm using __hci_cmd_sync_cancel(-ECANCELED) for that, and
in the case where there's not currently a hci req ongoing, I'm setting
a flag so that the next hci req will return -ECANCELED immediately.

It's not too necessary to cancel the ongoing callback too I think, but
since we have __hci_cmd_sync_cancel() already it seemed to make sense.
And IMO it's a lot more elegant than the check for hci_skb_event() that
hci_abort_conn() currently does.

> 
>>                          hci_req_sync_unlock(hdev);
>>                  }
>>
>> @@ -735,6 +762,87 @@ int hci_cmd_sync_queue(struct hci_dev *hdev, hci_cmd_sync_work_func_t func,
>>    }
>>    EXPORT_SYMBOL(hci_cmd_sync_queue);
>>
>> +bool hci_cmd_sync_has_cmd(struct hci_dev *hdev, hci_cmd_sync_work_func_t func,
>> +                         void *data)
>> +{
>> +       struct hci_cmd_sync_work_entry *entry;
>> +
>> +       mutex_lock(&hdev->cmd_sync_work_lock);
>> +       if (hdev->cur_hci_sync_work_func == func &&
>> +           hdev->cur_hci_sync_work_data == data) {
>> +               mutex_unlock(&hdev->cmd_sync_work_lock);
>> +               return true;
>> +       }
>> +
>> +       list_for_each_entry(entry, &hdev->cmd_sync_work_list, list) {
>> +               if (entry->func == func && entry->data == data) {
>> +                       mutex_unlock(&hdev->cmd_sync_work_lock);
>> +                       return true;
>> +               }
>> +       }
>> +       mutex_unlock(&hdev->cmd_sync_work_lock);
>> +
>> +       return false;
>> +}
>> +
>> +void hci_cmd_sync_cancel_cmd(struct hci_dev *hdev, hci_cmd_sync_work_func_t func,
>> +                            void *data)
>> +{
>> +       struct hci_cmd_sync_work_entry *entry;
>> +       bool work_already_ongoing;
>> +
>> +       mutex_lock(&hdev->cmd_sync_work_lock);
>> +       if (hdev->cur_hci_sync_work_func == func &&
>> +           hdev->cur_hci_sync_work_data == data) {
>> +               /* If the command is already ongoing, we check if we're currently
>> +                * sending a async HCI request. If we are, we can cancel that
>> +                * and hope that the hci_cmd_sync_work_func is handling -ECANCELED.
>> +                */
>> +
>> +               if (hdev->req_status == HCI_REQ_PEND) {
>> +                       /* If we're already executing a request, cancel that request.
>> +                        * This will signal cancellation to the work func which sent
>> +                        * the request in the first place.
>> +                        */
>> +                       __hci_cmd_sync_cancel(hdev, -ECANCELED);
>> +               } else {
>> +                       /* Otherwise, just set a flag which will cancel the next
>> +                        * request. Just as above, this will then signal cancellation
>> +                        * to the work func.
>> +                        */
>> +                       hdev->cur_hci_sync_work_cancelled = true;
>> +               }
> 
> It might be better to save the executing entry at hdev and then make
> the lookup_entry return it if the parameters match so it can be
> cancelled with cancel_entry,

Ahh yeah, now that lookup_entry() is a thing, that seems nicer indeed.

> that said perhaps it would be better to
> just cancel the work if -ECANCELED is received so we don't have to
> keep checking if it is returned on every command the callback
> generates
Hmm, I don't see how it makes sense to cancel the cmd_sync_work, and
we can't cancel the callback execution from outside, can we? I don't
think there's a way around checking -ECANCELED all the time as long
as __hci_cmd_sync_cancel()/hci_cmd_sync_cancel() are a thing, we
should probably ensure that every hci_sync callback handles this
properly anyway.

Cheers
Jonas

> 
>> +               mutex_unlock(&hdev->cmd_sync_work_lock);
>> +
>> +               return;
>> +       } else {
>> +               /* Or is it still queued? Then we remove it from the queue and
>> +                * execute the destroy callback.
>> +                */
>> +               list_for_each_entry(entry, &hdev->cmd_sync_work_list, list) {
>> +                       if (entry->func == func && entry->data == data) {
>> +                               if (entry->destroy)
>> +                                       entry->destroy(hdev, entry->data, -ECANCELED);
>> +                               list_del(&entry->list);
>> +                               kfree(entry);
>> +
>> +                               mutex_unlock(&hdev->cmd_sync_work_lock);
>> +
>> +                               if (list_empty(&hdev->cmd_sync_work_list)) {
>> +                                       cancel_work_sync(&hdev->cmd_sync_work);
>> +                                       cancel_work_sync(&hdev->reenable_adv_work);
>> +                               }
>> +
>> +                               return;
>> +                       }
>> +               }
>> +
>> +       }
>> +
>> +       mutex_unlock(&hdev->cmd_sync_work_lock);
>> +}
>> +
>>    int hci_update_eir_sync(struct hci_dev *hdev)
>>    {
>>          struct hci_cp_write_eir cp;
>> @@ -6262,15 +6370,20 @@ int hci_le_create_conn_sync(struct hci_dev *hdev, struct hci_conn *conn)
>>                  }
>>
>>                  /* Pause advertising while doing directed advertising. */
>> -               hci_pause_advertising_sync(hdev);
>> +               err = hci_pause_advertising_sync(hdev);
>> +               if (err == -ECANCELED)
>> +                       goto done;
>>
>>                  err = hci_le_directed_advertising_sync(hdev, conn);
>>                  goto done;
>>          }
>>
>>          /* Disable advertising if simultaneous roles is not in use. */
>> -       if (!hci_dev_test_flag(hdev, HCI_LE_SIMULTANEOUS_ROLES))
>> -               hci_pause_advertising_sync(hdev);
>> +       if (!hci_dev_test_flag(hdev, HCI_LE_SIMULTANEOUS_ROLES)) {
>> +               err = hci_pause_advertising_sync(hdev);
>> +               if (err == -ECANCELED)
>> +                       goto done;
>> +       }
>>
>>          params = hci_conn_params_lookup(hdev, &conn->dst, conn->dst_type);
>>          if (params) {
>> @@ -6292,7 +6405,10 @@ int hci_le_create_conn_sync(struct hci_dev *hdev, struct hci_conn *conn)
>>           * state.
>>           */
>>          if (hci_dev_test_flag(hdev, HCI_LE_SCAN)) {
>> -               hci_scan_disable_sync(hdev);
>> +               err = hci_scan_disable_sync(hdev);
>> +               if (err == -ECANCELED)
>> +                       goto done;
>> +
>>                  hci_dev_set_flag(hdev, HCI_LE_SCAN_INTERRUPTED);
>>          }
>>
>> @@ -6336,11 +6452,10 @@ int hci_le_create_conn_sync(struct hci_dev *hdev, struct hci_conn *conn)
>>                                         HCI_EV_LE_ENHANCED_CONN_COMPLETE :
>>                                         HCI_EV_LE_CONN_COMPLETE,
>>                                         conn->conn_timeout, NULL);
>> +       if (err == -ECANCELED || err == -ETIMEDOUT)
>> +               hci_le_connect_cancel_sync(hdev, conn, conn->abort_reason || 0x00);
>>
>>    done:
>> -       if (err == -ETIMEDOUT)
>> -               hci_le_connect_cancel_sync(hdev, conn, 0x00);
>> -
>>          /* Re-enable advertising after the connection attempt is finished. */
>>          hci_resume_advertising_sync(hdev);
>>          return err;
>> @@ -6586,7 +6701,9 @@ static int __hci_acl_create_connection_sync(struct hci_dev *hdev, void *data)
>>          if (test_bit(HCI_INQUIRY, &hdev->flags)) {
>>                  err = __hci_cmd_sync_status(hdev, HCI_OP_INQUIRY_CANCEL, 0,
>>                                              NULL, HCI_CMD_TIMEOUT);
>> -               if (err)
>> +               if (err == -ECANCELED)
>> +                       return -ECANCELED;
>> +               else if (err)
>>                          bt_dev_warn(hdev, "Failed to cancel inquiry %d", err);
>>          }
>>
>> @@ -6625,15 +6742,10 @@ static int __hci_acl_create_connection_sync(struct hci_dev *hdev, void *data)
>>                                         HCI_EV_CONN_COMPLETE,
>>                                         HCI_ACL_CONN_TIMEOUT, NULL);
>>
>> -       if (err == -ETIMEDOUT)
>> -               hci_abort_conn_sync(hdev, conn, HCI_ERROR_LOCAL_HOST_TERM);
>> +       if (err == -ECANCELED || err == -ETIMEDOUT) {
>> +               hci_connect_cancel_sync(hdev, conn, conn->abort_reason || HCI_ERROR_LOCAL_HOST_TERM);
>> +               return err;
>> +       }
>>
>>          return err;
>>    }
>>
> 
> 
