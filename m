Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: [RFC] bluetooth: Try to avoid forming scatternets
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CABBYNZL4GSbxuZgWT9OkXejG06+O98VJDufd6VaHt5g_6_w=bQ@mail.gmail.com>
Date: Sun, 1 Jun 2014 03:47:34 +0200
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <03E381BB-AD1C-4284-8225-D29DBD12CB36@holtmann.org>
References: <1401277204-28062-1-git-send-email-luiz.dentz@gmail.com> <BE96F0F6-FB1C-463E-A75B-6F9BE4EE0ABC@holtmann.org> <CABBYNZL4GSbxuZgWT9OkXejG06+O98VJDufd6VaHt5g_6_w=bQ@mail.gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,


>>> In case of multiple connections automatically attempt to become master
>>> to avoid scatternet topology.
>>> 
>>> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>> ---
>>> net/bluetooth/hci_event.c | 21 ++++++++++++++++-----
>>> 1 file changed, 16 insertions(+), 5 deletions(-)
>>> 
>>> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
>>> index 492d8d5..e6aed6e 100644
>>> --- a/net/bluetooth/hci_event.c
>>> +++ b/net/bluetooth/hci_event.c
>>> @@ -2017,8 +2017,15 @@ static void hci_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
>>>      if (ev->status) {
>>>              hci_proto_connect_cfm(conn, ev->status);
>>>              hci_conn_del(conn);
>>> -     } else if (ev->link_type != ACL_LINK)
>>> +     } else if (ev->link_type != ACL_LINK) {
>>>              hci_proto_connect_cfm(conn, ev->status);
>>> +     } else if (hci_conn_num(hdev, ACL_LINK) > 1) {
>>> +             /* Attempt to switch to master to avoid scatternet */
>>> +             list_for_each_entry(conn, &hdev->conn_hash.list, list) {
>>> +                     if (conn->type == ACL_LINK)
>>> +                             hci_conn_switch_role(conn, 0x00);
>>> +             }
>>> +     }
>> 
>> I am not convinced this is a good idea. We do not know if the other also has two connections and wants to be the master. I think we can not generalize this on the HCI level. This has to be L2CAP socket policy that will allow us to make smart decisions. Sometimes the scatternet is just the better choice since our scatternet will result in a cheaper one than the others.
> 
> I thought it is a very common policy in many stacks actually, for
> example apple's has the following in its bluetooth guidelines:
> 
> 'In a Bluetooth connection, one device is the master and the other the
> slave. The master can have multiple
> slaves, thusforming a piconet. The master device can also be a slave
> role to another master, creating a scatternet.
> Such a scenario creates complications since the device has to
> alternate between the two piconets and thus
> wastes valuable bandwidth. Managing the topology of the network is
> therefore important for maximum
> performance. The Apple product may request a Role Switch, depending on
> its current topology, and the remote
> device shall accept the request. The Apple product may also reject a
> request for a Role Switch because of
> topology concerns. Having a suboptimal topology may degrade the audio
> quality and the user's experience.
> 
> Only when it is maintaining multiple links, either Bluetooth or WiFi,
> will the Apple product request or deny
> role switches. Hence, it will grant a role switch if there is no
> reason for the Apple product to be master. It is
> expected that the accessory will behave the same, only trying to be
> master when there is a legitimate reason.
> 
> The accessory should not always request to be master by default if
> there is no need in the system topology to
> do so. If later the accessory needs to be master in order to maintain
> multiple links, it should ask to be master
> at that time.’

and BlueZ can also be the accessory in a lot of cases. It is not that simple. If we would be always the phone than a simple policy like that might be acceptable. However BlueZ can also be the laptop or the car kit or something else. And that is my point, this really needs to be driven by the sockets that are open and not the ACL links.

> We can't possible know how many connection the remote side has but it
> can reject the role switch which will just keep us in a scatternet.
> 
>>> 
>>> unlock:
>>>      hci_dev_unlock(hdev);
>>> @@ -2035,6 +2042,12 @@ static void hci_conn_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
>>>      BT_DBG("%s bdaddr %pMR type 0x%x", hdev->name, &ev->bdaddr,
>>>             ev->link_type);
>>> 
>>> +     hci_dev_lock(hdev);
>>> +
>>> +     /* Allways attempt to become the master in multiple connection case */
>>> +     if (hci_conn_num(hdev, ev->link_type) > 0)
>>> +             mask |= HCI_LM_MASTER;
>>> +
>> 
>> Isn’t this useless for SCO and eSCO links since the master definition is really only for the ACL link.
> 
> I believe the topology does influence SCO/eSCO too, there was actually
> a patch in AOSP that did always request to be the master if SCO/eSCO
> is connected which is probably the wrong think to do since that should
> depend on what role of HFP/HSP we are assuming, btw if the topology
> really influences SCO/eSCO I guess we shoud think about a socket
> option to request the initial role like L2CAP and RFCOMM have.

Every SCO and eSCO link require the existence of an ACL link. So it does not matter what SCO and eSCO topology we have. The topology deciding bearer is the ACL link.

Regards

Marcel

