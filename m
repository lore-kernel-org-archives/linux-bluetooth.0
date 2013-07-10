Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1372060588-4595-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
References: <1372060588-4595-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
Date: Wed, 10 Jul 2013 11:56:02 +0300
Message-ID: <CABBYNZLG0CW8hZTd=T292nSwAvo4rUGHN7Vq7RfYQNvKmqwJ6A@mail.gmail.com>
Subject: Re: [RFC 0/1] MAP Notification API
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Christian,

On Mon, Jun 24, 2013 at 10:56 AM, Christian Fetzer
<christian.fetzer@oss.bmw-carit.de> wrote:
> From: Christian Fetzer <christian.fetzer@bmw-carit.de>
>
> Now that the MAP MNS support is progressing, I'd like to start the discussion
> on how the MAP event reports should be signaled in the D-Bus API.
>
> I've listed therefore the 9 different event types and the parameters that we
> get from the remote device, together with a proposal on how the API could look
> like.
>
>
> Prerequisite:
>
> The current existing MAP client relies on the fact that the application tracks
> the folder a message belongs to. Since notifications can be received for any
> folder, it would make sense to remove this restriction and provide a 'Folder'
> property for the Message interface. This is needed for the NewMessage,
> MessageDeleted, and MessageShift event.
>
>
> Events:
>
> NewMessage(handle, folder, msg_type):
>   - New messages can be signaled by registering a corresponding Message
>     interface, that would be announced using the ObjectManager.
>   - Since we do not get any meta data, it would make sense to implicitly query
>     this information using GetMessagesListing with MaxListCount=1.
>     That way, the application would not have to query this data explicitly and
>     we would not expose an empty message with no properties set.

Sound good to me.

> DeliverySuccess,SendingSuccess,DeliveryFailure,
> SendingFailure(handle, folder, msg_type):
>   - This events are only relevant when sending messages (PushMessage).
>     Therefore, I'd suggest to register the Message interface already in
>     PushMessage for the outgoing message and add a SendingStatus property
>     when we receive this events.

I wonder how this is actually implemented, is there a NewMessage event
when using PushMessage? If yes does it indicates Sent flag or we
should listen to this event and notified when it is sent, anyway the
event doesn't give us detailed error so perhaps we could just set
Status to error or something like that, adding another status would be
confusing IMO.

> MemoryFull, MemoryAvailable():
>   - Add MemoryAvailable property in MessageAccess interface.

It is not very clear how we would use this? Do you actually have any
stack generating these events? Anyway we could also handle it
internally and do not send any data upon receiving MemoryFull, anyway
lets think about it latter.

> MessageDeleted(handle, folder, msg_type),
> MessageShift(handle, folder, old_folder, msg_type):
>   - If the message was moved into the current folder, we can register its
>     Message interface.
>   - If we don't have its interface yet and it was not moved into the current
>     folder, we could ignore the event.
>   - If we have the Message interface, we simply update property 'Folder'.

Sounds good.



--
Luiz Augusto von Dentz
