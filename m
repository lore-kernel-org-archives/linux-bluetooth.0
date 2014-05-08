Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <5725B981-E83A-467E-80ED-18B9C8FE285F@holtmann.org>
References: <1399555935-702-1-git-send-email-andrzej.kaczmarek@tieto.com>
 <1399555935-702-5-git-send-email-andrzej.kaczmarek@tieto.com> <5725B981-E83A-467E-80ED-18B9C8FE285F@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Date: Thu, 8 May 2014 21:41:04 +0200
Message-ID: <CAF3PWx0tyor+2KiCKRSYGP26BSovCgbRpHrEcjiTscDVj=d0iw@mail.gmail.com>
Subject: Re: [PATCH 4/8] Bluetooth: Add support for user data in hci_request
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On 8 May 2014 17:32, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Andrzej,
>
>> This patch makes possible to store some user data in hci_request struct
>> which will be available in completion callback. Data can be added when
>> initializing new request using hci_req_init(). With this it's now easy
>> to run request which can be associated with e.g. specific hci_conn.
>>
>> Signed-off-by: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
>> ---
>> include/net/bluetooth/bluetooth.h |  3 +-
>> include/net/bluetooth/hci_core.h  |  3 +-
>> net/bluetooth/hci_conn.c          |  4 +-
>> net/bluetooth/hci_core.c          | 29 +++++++++-----
>> net/bluetooth/mgmt.c              | 84 +++++++++++++++++++++------------------
>> 5 files changed, 69 insertions(+), 54 deletions(-)
>>
>> diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
>> index 904777c1..28378ad 100644
>> --- a/include/net/bluetooth/bluetooth.h
>> +++ b/include/net/bluetooth/bluetooth.h
>> @@ -273,12 +273,13 @@ struct l2cap_ctrl {
>>
>> struct hci_dev;
>>
>> -typedef void (*hci_req_complete_t)(struct hci_dev *hdev, u8 status);
>> +typedef void (*hci_req_complete_t)(struct hci_dev *hdev, u8 status, void *data);
>>
>> struct hci_req_ctrl {
>>       bool                    start;
>>       u8                      event;
>>       hci_req_complete_t      complete;
>> +     void                    *data;
>> };
>>
>> struct bt_skb_cb {
>> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
>> index 211bad6..30d245f 100644
>> --- a/include/net/bluetooth/hci_core.h
>> +++ b/include/net/bluetooth/hci_core.h
>> @@ -1162,6 +1162,7 @@ int hci_unregister_cb(struct hci_cb *hcb);
>> struct hci_request {
>>       struct hci_dev          *hdev;
>>       struct sk_buff_head     cmd_q;
>> +     void                    *data;
>>
>>       /* If something goes wrong when building the HCI request, the error
>>        * value is stored in this field.
>> @@ -1169,7 +1170,7 @@ struct hci_request {
>>       int                     err;
>> };
>>
>> -void hci_req_init(struct hci_request *req, struct hci_dev *hdev);
>> +void hci_req_init(struct hci_request *req, struct hci_dev *hdev, void *data);
>
> do we really want to have everybody add extra data in here. We are now touching every possible call that we have so far. I do not really like this at the moment.

We can skip it here and either introduce helper to set user data for
request or set it directly in structure, but anyway we'll still need
to modify callbacks.

> Two questions. a) can we do this without this change and b) if we do it can someone benefit from it.

In our case, perhaps we can create queue (in hdev?) where we'll put
hci_conn for each conn info request run so we can pop it from queue in
callback. Should be enough.
But user data could be reused in case other request needs more context
than just hdev, e.g. hci_connect_le has request which also needs
hci_conn in callback but right now it deals with it by looking for
single connection in BT_CONNECT state. We obviously can't do this
since we'll have multiple connections in BT_CONNECTED state.

BR,
Andrzej
