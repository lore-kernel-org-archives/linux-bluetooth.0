Return-Path: <cyrus@holtmann.org>
From: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 0/1] MAP Notification API
Date: Mon, 24 Jun 2013 09:56:27 +0200
Message-Id: <1372060588-4595-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Christian Fetzer <christian.fetzer@bmw-carit.de>

Now that the MAP MNS support is progressing, I'd like to start the discussion
on how the MAP event reports should be signaled in the D-Bus API.

I've listed therefore the 9 different event types and the parameters that we
get from the remote device, together with a proposal on how the API could look
like.


Prerequisite:

The current existing MAP client relies on the fact that the application tracks
the folder a message belongs to. Since notifications can be received for any
folder, it would make sense to remove this restriction and provide a 'Folder'
property for the Message interface. This is needed for the NewMessage,
MessageDeleted, and MessageShift event.


Events:

NewMessage(handle, folder, msg_type):
  - New messages can be signaled by registering a corresponding Message
    interface, that would be announced using the ObjectManager.
  - Since we do not get any meta data, it would make sense to implicitly query
    this information using GetMessagesListing with MaxListCount=1.
    That way, the application would not have to query this data explicitly and
    we would not expose an empty message with no properties set.

DeliverySuccess,SendingSuccess,DeliveryFailure,
SendingFailure(handle, folder, msg_type):
  - This events are only relevant when sending messages (PushMessage).
    Therefore, I'd suggest to register the Message interface already in
    PushMessage for the outgoing message and add a SendingStatus property
    when we receive this events.

MemoryFull, MemoryAvailable():
  - Add MemoryAvailable property in MessageAccess interface.

MessageDeleted(handle, folder, msg_type),
MessageShift(handle, folder, old_folder, msg_type):
  - If the message was moved into the current folder, we can register its
    Message interface.
  - If we don't have its interface yet and it was not moved into the current
    folder, we could ignore the event.
  - If we have the Message interface, we simply update property 'Folder'.


Christian Fetzer (1):
  doc: MAP Notification API

 doc/obex-api.txt | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

-- 
1.8.2.3

