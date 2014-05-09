Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20140509102748.GA31552@t440s.lan>
References: <1399555935-702-1-git-send-email-andrzej.kaczmarek@tieto.com>
 <1399555935-702-5-git-send-email-andrzej.kaczmarek@tieto.com>
 <5725B981-E83A-467E-80ED-18B9C8FE285F@holtmann.org> <20140509102748.GA31552@t440s.lan>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Date: Fri, 9 May 2014 13:04:04 +0200
Message-ID: <CAF3PWx3q+GtaMgOY-b4eMy0t=8yq1RsGf2vmpape4GNW4h3X5g@mail.gmail.com>
Subject: Re: [PATCH 4/8] Bluetooth: Add support for user data in hci_request
To: Marcel Holtmann <marcel@holtmann.org>, Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On 9 May 2014 12:27, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Marcel,
>
> On Thu, May 08, 2014, Marcel Holtmann wrote:
>> > This patch makes possible to store some user data in hci_request struct
>> > which will be available in completion callback. Data can be added when
>> > initializing new request using hci_req_init(). With this it's now easy
>> > to run request which can be associated with e.g. specific hci_conn.
>> >
>> > Signed-off-by: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
>> > ---
>> > include/net/bluetooth/bluetooth.h |  3 +-
>> > include/net/bluetooth/hci_core.h  |  3 +-
>> > net/bluetooth/hci_conn.c          |  4 +-
>> > net/bluetooth/hci_core.c          | 29 +++++++++-----
>> > net/bluetooth/mgmt.c              | 84 +++++++++++++++++++++------------------
>> > 5 files changed, 69 insertions(+), 54 deletions(-)
>> >
>> > diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
>> > index 904777c1..28378ad 100644
>> > --- a/include/net/bluetooth/bluetooth.h
>> > +++ b/include/net/bluetooth/bluetooth.h
>> > @@ -273,12 +273,13 @@ struct l2cap_ctrl {
>> >
>> > struct hci_dev;
>> >
>> > -typedef void (*hci_req_complete_t)(struct hci_dev *hdev, u8 status);
>> > +typedef void (*hci_req_complete_t)(struct hci_dev *hdev, u8 status, void *data);
>> >
>> > struct hci_req_ctrl {
>> >     bool                    start;
>> >     u8                      event;
>> >     hci_req_complete_t      complete;
>> > +   void                    *data;
>> > };
>> >
>> > struct bt_skb_cb {
>> > diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
>> > index 211bad6..30d245f 100644
>> > --- a/include/net/bluetooth/hci_core.h
>> > +++ b/include/net/bluetooth/hci_core.h
>> > @@ -1162,6 +1162,7 @@ int hci_unregister_cb(struct hci_cb *hcb);
>> > struct hci_request {
>> >     struct hci_dev          *hdev;
>> >     struct sk_buff_head     cmd_q;
>> > +   void                    *data;
>> >
>> >     /* If something goes wrong when building the HCI request, the error
>> >      * value is stored in this field.
>> > @@ -1169,7 +1170,7 @@ struct hci_request {
>> >     int                     err;
>> > };
>> >
>> > -void hci_req_init(struct hci_request *req, struct hci_dev *hdev);
>> > +void hci_req_init(struct hci_request *req, struct hci_dev *hdev, void *data);
>>
>> do we really want to have everybody add extra data in here. We are now
>> touching every possible call that we have so far. I do not really like
>> this at the moment.
>
> Maybe hci_sent_cmd_data() could be used instead to help look up the
> connection that the completed command was targeting?

For purpose of this set of patches it should be fine, both Read RSSI
and Read Transmit Power Level have handle as first parameter so we
don't even need to bother with checking which command was sent last in
case of error. So we can use this now and just get back to user_data
in case something pops in future which cannot be resolved using
available structures.

BR,
Andrzej
