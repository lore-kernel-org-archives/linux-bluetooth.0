Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZKk0m=Wp3zuNfLpTFCnGy1PE0LTOFQq8uNoEGARVV+TAg@mail.gmail.com>
References: <1372060588-4595-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
	<CABBYNZLG0CW8hZTd=T292nSwAvo4rUGHN7Vq7RfYQNvKmqwJ6A@mail.gmail.com>
	<51DFB81B.8000705@oss.bmw-carit.de>
	<CABBYNZJSE_TRBr9YGQEUfncuu5hNNTebz43uxyxgF2WcNLGAKg@mail.gmail.com>
	<CABBYNZKk0m=Wp3zuNfLpTFCnGy1PE0LTOFQq8uNoEGARVV+TAg@mail.gmail.com>
Date: Mon, 9 Sep 2013 15:19:42 +0300
Message-ID: <CABBYNZKPKECWWNvJd1O3QEMxkfNsbEQUTD34r0pPe_ttYG7vsw@mail.gmail.com>
Subject: Re: [RFC 0/1] MAP Notification API
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Christian,

On Wed, Aug 7, 2013 at 12:15 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Christian,
>
> On Fri, Jul 12, 2013 at 11:23 AM, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
>> Hi Christian,
>>
>> On Fri, Jul 12, 2013 at 11:02 AM, Christian Fetzer
>> <christian.fetzer@oss.bmw-carit.de> wrote:
>>> Hi Luiz,
>>>
>>> On 07/10/2013 10:56 AM, Luiz Augusto von Dentz wrote:
>>>> Hi Christian,
>>>>
>>>> On Mon, Jun 24, 2013 at 10:56 AM, Christian Fetzer
>>>> <christian.fetzer@oss.bmw-carit.de> wrote:
>>>>> From: Christian Fetzer <christian.fetzer@bmw-carit.de>
>>>>>
>>>>> Now that the MAP MNS support is progressing, I'd like to start the discussion
>>>>> on how the MAP event reports should be signaled in the D-Bus API.
>>>>>
>>>>> I've listed therefore the 9 different event types and the parameters that we
>>>>> get from the remote device, together with a proposal on how the API could look
>>>>> like.
>>>>>
>>>>>
>>>>> Prerequisite:
>>>>>
>>>>> The current existing MAP client relies on the fact that the application tracks
>>>>> the folder a message belongs to. Since notifications can be received for any
>>>>> folder, it would make sense to remove this restriction and provide a 'Folder'
>>>>> property for the Message interface. This is needed for the NewMessage,
>>>>> MessageDeleted, and MessageShift event.
>>>>>
>>>>>
>>>>> Events:
>>>>>
>>>>> NewMessage(handle, folder, msg_type):
>>>>>   - New messages can be signaled by registering a corresponding Message
>>>>>     interface, that would be announced using the ObjectManager.
>>>>>   - Since we do not get any meta data, it would make sense to implicitly query
>>>>>     this information using GetMessagesListing with MaxListCount=1.
>>>>>     That way, the application would not have to query this data explicitly and
>>>>>     we would not expose an empty message with no properties set.
>>>>
>>>> Sound good to me.
>>>>
>>>>> DeliverySuccess,SendingSuccess,DeliveryFailure,
>>>>> SendingFailure(handle, folder, msg_type):
>>>>>   - This events are only relevant when sending messages (PushMessage).
>>>>>     Therefore, I'd suggest to register the Message interface already in
>>>>>     PushMessage for the outgoing message and add a SendingStatus property
>>>>>     when we receive this events.
>>>>
>>>> I wonder how this is actually implemented, is there a NewMessage event
>>>> when using PushMessage? If yes does it indicates Sent flag or we
>>>> should listen to this event and notified when it is sent, anyway the
>>>> event doesn't give us detailed error so perhaps we could just set
>>>> Status to error or something like that, adding another status would be
>>>> confusing IMO.
>>>>
>>>
>>> According to the spec, it should be implemented like this:
>>> - The client sends the PushMessage request
>>> - In the response, the server sets the OBEX Name parameter of the last
>>>   response packet to the handle that this message gets on the server.
>>> - The server will try to send the message and will inform the client
>>>   about the status using above notifications. This usually takes some
>>>   seconds (or longer, especially when the reception is bad).
>>>
>>> MCE                                    MSE
>>>  | --- PushMessage_Req ---------------> |
>>>  | <-- PushMessage_Res(Name=handle) --- |
>>>              ...
>>>          MSE tries to deliver message
>>>              ...
>>>  | <-- Status event report ------------ |
>>>
>>> Note that the type of notification also depend on the network.
>>> Sometimes, the operator accepts all messages (and you only get
>>> SendingSuccess notifications). In error cases, you receive a SMS,
>>> saying that the delivery failed. In this case you get a NewMessage
>>> notification (but only plain text, no status codes).
>>
>> So if I understand you correctly the NewMessage is only generated when
>> the message is sent, in that case we should probably create the
>> message object with the response as you said.
>>
>>> The idea was, to then register the new message's D-Bus interface
>>> as soon as we have transfered the message to the phone (when we received
>>> the handle in PushMessage_Res). Later, when we receive
>>> a status notification, we update a property in the message.
>>> The Status property could be reused as well here if you don't want a
>>> dedicated property. Does that make sense for you?
>>
>> The Status should be used as the status of the message not only for
>> receiving status, for direction we have the Sent property. We should
>> always try to keep the API as simple as possible so there is less risk
>> we need to break APIs, adding those latter is possible but I don't
>> think it will the case here.
>>
>>> I've done some tests with a BB Z10 to verify that the described
>>> behavior is correct. (see below for a trace)
>>>
>>>>> MemoryFull, MemoryAvailable():
>>>>>   - Add MemoryAvailable property in MessageAccess interface.
>>>>
>>>> It is not very clear how we would use this? Do you actually have any
>>>> stack generating these events? Anyway we could also handle it
>>>> internally and do not send any data upon receiving MemoryFull, anyway
>>>> lets think about it latter.
>>>>
>>>
>>> I don't think we have to 'handle' anything in case of MemoryFull.
>>> This is just an indication for the application/UI that you will
>>> not be able to receive / send any new messages.
>>
>> Lets concentrate on the other events we can come back to this latter.
>
> Anything coming from your side anything soon or are you waiting some feedback?

We are still lacking the processing of the events in
obexd/client/map.c:map_handle_notification, are you going to send the
patches to add it?


-- 
Luiz Augusto von Dentz
