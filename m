Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120404115301.GA5081@x220>
References: <1333539940-29061-1-git-send-email-vishal.agarwal@stericsson.com>
	<20120404115301.GA5081@x220>
Date: Wed, 4 Apr 2012 17:44:35 +0530
Message-ID: <CA+_sZW9cqfW4Nz0C21av25VzwkSTat6QW6FoWGDzcA=oezgGLg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Temporary keys should be retained during connection
From: vishal agarwal <vishal.bluez@gmail.com>
To: Vishal Agarwal <vishal.agarwal@stericsson.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Wed, Apr 4, 2012 at 5:23 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Vishal,
>
> On Wed, Apr 04, 2012, Vishal Agarwal wrote:
>> If a key is non persistent then it should not be used in future
>> connections but it should be kept for current connection. And it
>> should be removed when connecion is removed.
>>
>> Signed-off-by: Vishal Agarwal <vishal.agarwal@stericsson.com>
>> ---
>>  include/net/bluetooth/hci_core.h |    1 +
>>  net/bluetooth/hci_core.c         |    8 ++++----
>>  net/bluetooth/mgmt.c             |    6 ++++++
>>  3 files changed, 11 insertions(+), 4 deletions(-)
>
> Firstly, did you verify that this fixes your test case? You still didn't
> tell us what test case this is, btw.
>
>> --- a/net/bluetooth/hci_core.c
>> +++ b/net/bluetooth/hci_core.c
>> @@ -1330,10 +1330,10 @@ int hci_add_link_key(struct hci_dev *hdev, struct hci_conn *conn, int new_key,
>>
>>       mgmt_new_link_key(hdev, key, persistent);
>>
>> -     if (!persistent) {
>> -             list_del(&key->list);
>> -             kfree(key);
>> -     }
>> +     if (persistent)
>> +             conn->temp_link_key = false;
>> +     else
>> +             conn->temp_link_key = true;
>>
>>       return 0;
>>  }
>> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
>> index b4f7e32..bc6f89e 100644
>> --- a/net/bluetooth/mgmt.c
>> +++ b/net/bluetooth/mgmt.c
>> @@ -3060,12 +3060,18 @@ int mgmt_device_disconnected(struct hci_dev *hdev, bdaddr_t *bdaddr,
>>  {
>>       struct mgmt_addr_info ev;
>>       struct sock *sk = NULL;
>> +     struct hci_conn *conn;
>>       int err;
>>
>>       mgmt_pending_foreach(MGMT_OP_DISCONNECT, hdev, disconnect_rsp, &sk);
>>
>>       bacpy(&ev.bdaddr, bdaddr);
>>       ev.type = link_to_mgmt(link_type, addr_type);
>> +     if (link_type == ACL_LINK) {
>> +             conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, bdaddr);
>> +             if (conn->temp_link_key)
>> +                     hci_remove_link_key(hdev, bdaddr);
>> +     }
>>
>>       err = mgmt_event(MGMT_EV_DEVICE_DISCONNECTED, hdev, &ev, sizeof(ev),
>>                        sk);
>
> Since setting the flag is outside of mgmt.c I think the removal should
> also be. That way you also avoid an extra call to
> hci_conn_hash_lookup_ba. I.e. please put the removal in
> hci_disconn_complete_evt.
>
> I'd also still like to hear your opinion of the second option I
> proposed. If you had a reference to struct link_key in hci_conn then
> you'd just need to call list_del() and nothing else to remove it (i.e.
> no iteration of hdev->link_keys necessary.
>
If I implement it this way then there will be two new variables added, one in
hci_conn to store the reference of key and other one is inside
link_key structure
to store if key is temporary or not.
or you want me to store reference of key to hci_conn only when the key
is temporary?
in this case also code might become complicated to handle cases if key
is re generated
and new key is not temporary but the older one was.
So in my opinion after the changes you suggested (moving code in
hci_disconn_complete_evt),
this is also OK. lesser and clearer code.
> Johan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Thanks
Vishal
