Return-Path: <cyrus@holtmann.org>
Message-ID: <51DFB81B.8000705@oss.bmw-carit.de>
Date: Fri, 12 Jul 2013 10:02:35 +0200
From: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
MIME-Version: 1.0
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [RFC 0/1] MAP Notification API
References: <1372060588-4595-1-git-send-email-christian.fetzer@oss.bmw-carit.de> <CABBYNZLG0CW8hZTd=T292nSwAvo4rUGHN7Vq7RfYQNvKmqwJ6A@mail.gmail.com>
In-Reply-To: <CABBYNZLG0CW8hZTd=T292nSwAvo4rUGHN7Vq7RfYQNvKmqwJ6A@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On 07/10/2013 10:56 AM, Luiz Augusto von Dentz wrote:
> Hi Christian,
> 
> On Mon, Jun 24, 2013 at 10:56 AM, Christian Fetzer
> <christian.fetzer@oss.bmw-carit.de> wrote:
>> From: Christian Fetzer <christian.fetzer@bmw-carit.de>
>>
>> Now that the MAP MNS support is progressing, I'd like to start the discussion
>> on how the MAP event reports should be signaled in the D-Bus API.
>>
>> I've listed therefore the 9 different event types and the parameters that we
>> get from the remote device, together with a proposal on how the API could look
>> like.
>>
>>
>> Prerequisite:
>>
>> The current existing MAP client relies on the fact that the application tracks
>> the folder a message belongs to. Since notifications can be received for any
>> folder, it would make sense to remove this restriction and provide a 'Folder'
>> property for the Message interface. This is needed for the NewMessage,
>> MessageDeleted, and MessageShift event.
>>
>>
>> Events:
>>
>> NewMessage(handle, folder, msg_type):
>>   - New messages can be signaled by registering a corresponding Message
>>     interface, that would be announced using the ObjectManager.
>>   - Since we do not get any meta data, it would make sense to implicitly query
>>     this information using GetMessagesListing with MaxListCount=1.
>>     That way, the application would not have to query this data explicitly and
>>     we would not expose an empty message with no properties set.
> 
> Sound good to me.
> 
>> DeliverySuccess,SendingSuccess,DeliveryFailure,
>> SendingFailure(handle, folder, msg_type):
>>   - This events are only relevant when sending messages (PushMessage).
>>     Therefore, I'd suggest to register the Message interface already in
>>     PushMessage for the outgoing message and add a SendingStatus property
>>     when we receive this events.
> 
> I wonder how this is actually implemented, is there a NewMessage event
> when using PushMessage? If yes does it indicates Sent flag or we
> should listen to this event and notified when it is sent, anyway the
> event doesn't give us detailed error so perhaps we could just set
> Status to error or something like that, adding another status would be
> confusing IMO.
> 

According to the spec, it should be implemented like this:
- The client sends the PushMessage request
- In the response, the server sets the OBEX Name parameter of the last
  response packet to the handle that this message gets on the server.
- The server will try to send the message and will inform the client
  about the status using above notifications. This usually takes some
  seconds (or longer, especially when the reception is bad).

MCE                                    MSE
 | --- PushMessage_Req ---------------> |
 | <-- PushMessage_Res(Name=handle) --- |
             ...
         MSE tries to deliver message
             ...
 | <-- Status event report ------------ |

Note that the type of notification also depend on the network.
Sometimes, the operator accepts all messages (and you only get
SendingSuccess notifications). In error cases, you receive a SMS,
saying that the delivery failed. In this case you get a NewMessage
notification (but only plain text, no status codes).

The idea was, to then register the new message's D-Bus interface
as soon as we have transfered the message to the phone (when we received
the handle in PushMessage_Res). Later, when we receive
a status notification, we update a property in the message.
The Status property could be reused as well here if you don't want a
dedicated property. Does that make sense for you?

I've done some tests with a BB Z10 to verify that the described
behavior is correct. (see below for a trace)

>> MemoryFull, MemoryAvailable():
>>   - Add MemoryAvailable property in MessageAccess interface.
> 
> It is not very clear how we would use this? Do you actually have any
> stack generating these events? Anyway we could also handle it
> internally and do not send any data upon receiving MemoryFull, anyway
> lets think about it latter.
> 

I don't think we have to 'handle' anything in case of MemoryFull.
This is just an indication for the application/UI that you will
not be able to receive / send any new messages.

>> MessageDeleted(handle, folder, msg_type),
>> MessageShift(handle, folder, old_folder, msg_type):
>>   - If the message was moved into the current folder, we can register its
>>     Message interface.
>>   - If we don't have its interface yet and it was not moved into the current
>>     folder, we could ignore the event.
>>   - If we have the Message interface, we simply update property 'Folder'.
> 
> Sounds good.
> 
> 
> 
> --
> Luiz Augusto von Dentz
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

Cheers,
Christian



---
Trace: Sending SMS with BB Z10. The phone assigns the handle 53 to the message.

2013-07-11 10:17:17.444093 < ACL data: handle 21 flags 0x00 dlen 303
    L2CAP(d): cid 0x0040 len 299 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 0 ilen 294 fcs 0x5a 
        OBEX: Put cmd(c): len 294
        Connection ID (0xcb) = 1
        Name (0x01) = Unicode length 0
        Type (0x42) = Sequence length 13
        0000: 78 2d 62 74 2f 6d 65 73  73 61 67 65 00           x-bt/message.
        Length (0xc3) = 253
        App. Parameters (0x4c) = Sequence length 3
        0000: 14 01 01                                          ...
        Body (0x48) = Sequence length 253
        0000: 42 45 47 49 4e 3a 42 4d  53 47 0d 0a 56 45 52 53  BEGIN:BMSG..VERS
        0010: 49 4f 4e 3a 31 2e 30 0d  0a 53 54 41 54 55 53 3a  ION:1.0..STATUS:
        0020: 55 4e 52 45 41 44 0d 0a  54 59 50 45 3a 53 4d 53  UNREAD..TYPE:SMS
        0030: 5f 47 53 4d 0d 0a 46 4f  4c 44 45 52 3a 2f 74 65  _GSM..FOLDER:/te
        0040: 6c 65 63 6f 6d 2f 6d 73  67 2f 6f 75 74 62 6f 78  lecom/msg/outbox
        0050: 0d 0a 42 45 47 49 4e 3a  42 45 4e 56 0d 0a 42 45  ..BEGIN:BENV..BE
        0060: 47 49 4e 3a 56 43 41 52  44 0d 0a 56 45 52 53 49  GIN:VCARD..VERSI
        0070: 4f 4e 3a 32 2e 31 0d 0a  4e 3a 4e 61 6d 65 0d 0a  ON:2.1..N:Name..
        0080: 54 45 4c 3a 30 31 35 32  35 34 39 38 30 34 32 37  TEL:015254980427
        0090: 0d 0a 45 4e 44 3a 56 43  41 52 44 0d 0a 42 45 47  ..END:VCARD..BEG
        00a0: 49 4e 3a 42 42 4f 44 59  0d 0a 43 48 41 52 53 45  IN:BBODY..CHARSE
        00b0: 54 3a 55 54 46 2d 38 0d  0a 4c 45 4e 47 54 48 3a  T:UTF-8..LENGTH:
        00c0: 32 36 0d 0a 42 45 47 49  4e 3a 4d 53 47 0d 0a 54  26..BEGIN:MSG..T
        00d0: 45 53 54 0d 0a 45 4e 44  3a 4d 53 47 0d 0a 45 4e  EST..END:MSG..EN
        00e0: 44 3a 42 42 4f 44 59 0d  0a 45 4e 44 3a 42 45 4e  D:BBODY..END:BEN
        00f0: 56 0d 0a 45 4e 44 3a 42  4d 53 47 0d 0a           V..END:BMSG..
2013-07-11 10:17:17.444109 < HCI Command: Exit Sniff Mode (0x02|0x0004) plen 2
    handle 21
2013-07-11 10:17:17.448630 > HCI Event: Command Status (0x0f) plen 4
    Exit Sniff Mode (0x02|0x0004) status 0x00 ncmd 1
2013-07-11 10:17:17.615702 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 21 packets 1
2013-07-11 10:17:17.616721 > HCI Event: Mode Change (0x14) plen 6
    status 0x00 handle 21 mode 0x00 interval 0
    Mode: Active
2013-07-11 10:17:17.654372 > ACL data: handle 21 flags 0x02 dlen 11
    L2CAP(d): cid 0x0041 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 8 pf 0 ilen 3 fcs 0x80 
        OBEX: Put rsp(f): status 100 len 3
2013-07-11 10:17:17.654594 < ACL data: handle 21 flags 0x00 dlen 14
    L2CAP(d): cid 0x0040 len 10 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 0 ilen 6 fcs 0x5a 
        OBEX: Put cmd(f): len 6 (continue)
        End of Body (0x49) = Sequence length 0
2013-07-11 10:17:17.657657 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 21 packets 1
2013-07-11 10:17:17.993101 > ACL data: handle 21 flags 0x02 dlen 19
    L2CAP(d): cid 0x0041 len 15 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 8 pf 1 ilen 10 fcs 0x9c credits 2
        OBEX: Put rsp(f): status 200 len 10
        Status 200 = Success
        Name (0x01) = Unicode length 4
        0000: 00 35 00 33                                       .5.3
2013-07-11 10:17:20.444111 > ACL data: handle 21 flags 0x02 dlen 212
    L2CAP(d): cid 0x0041 len 208 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 35 pf 1 ilen 202 fcs 0x81 credits 1
        OBEX: Put cmd(c): len 202
        Connection ID (0xcb) = 5
        Type (0x42) = Sequence length 22
        0000: 78 2d 62 74 2f 4d 41 50  2d 65 76 65 6e 74 2d 72  x-bt/MAP-event-r
        0010: 65 70 6f 72 74 00                                 eport.
        App. Parameters (0x4c) = Sequence length 3
        0000: 0f 01 00                                          ...
        Body (0x48) = Sequence length 160
        0000: 3c 3f 78 6d 6c 20 76 65  72 73 69 6f 6e 3d 22 31  <?xml version="1
        0010: 2e 30 22 3f 3e 0a 3c 4d  41 50 2d 65 76 65 6e 74  .0"?>.<MAP-event
        0020: 2d 72 65 70 6f 72 74 20  76 65 72 73 69 6f 6e 3d  -report version=
        0030: 22 31 2e 30 22 3e 3c 65  76 65 6e 74 20 6d 73 67  "1.0"><event msg
        0040: 5f 74 79 70 65 3d 22 53  4d 53 5f 47 53 4d 22 20  _type="SMS_GSM" 
        0050: 66 6f 6c 64 65 72 3d 22  74 65 6c 65 63 6f 6d 2f  folder="telecom/
        0060: 6d 73 67 2f 73 65 6e 74  22 20 68 61 6e 64 6c 65  msg/sent" handle
        0070: 3d 22 35 33 22 20 74 79  70 65 3d 22 53 65 6e 64  ="53" type="Send
        0080: 69 6e 67 53 75 63 63 65  73 73 22 2f 3e 3c 2f 4d  ingSuccess"/></M
        0090: 41 50 2d 65 76 65 6e 74  2d 72 65 70 6f 72 74 3e  AP-event-report>
2013-07-11 10:17:20.444447 < ACL data: handle 21 flags 0x00 dlen 11
    L2CAP(d): cid 0x0040 len 7 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 35 pf 0 ilen 3 fcs 0x47 
        OBEX: Put rsp(f): status 100 len 3
2013-07-11 10:17:20.447670 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 21 packets 1
2013-07-11 10:17:20.455672 > ACL data: handle 21 flags 0x02 dlen 14
    L2CAP(d): cid 0x0041 len 10 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 35 pf 0 ilen 6 fcs 0x9d 
        OBEX: Put cmd(f): len 6 (continue)
        End of Body (0x49) = Sequence length 0
2013-07-11 10:17:20.455874 < ACL data: handle 21 flags 0x00 dlen 11
    L2CAP(d): cid 0x0040 len 7 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 35 pf 0 ilen 3 fcs 0x47 
        OBEX: Put rsp(f): status 200 len 3
2013-07-11 10:17:20.458603 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 21 packets 1

