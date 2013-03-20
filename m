Return-Path: <cyrus@holtmann.org>
Message-ID: <5149C95C.6050202@oss.bmw-carit.de>
Date: Wed, 20 Mar 2013 15:36:12 +0100
From: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
MIME-Version: 1.0
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: MAP client: Add support for receiving notifications
References: <51472E9E.50807@oss.bmw-carit.de> <CABBYNZKB7LkBWNkk-pP069H_iOhJuWCYHsSFBkRL9+gw3Cfccg@mail.gmail.com>
In-Reply-To: <CABBYNZKB7LkBWNkk-pP069H_iOhJuWCYHsSFBkRL9+gw3Cfccg@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On 03/19/2013 04:39 PM, Luiz Augusto von Dentz wrote:
> Hi Christian,
> 
> On Mon, Mar 18, 2013 at 12:11 PM, Christian Fetzer
> <christian.fetzer@oss.bmw-carit.de> wrote:
>> Hi,
>>
>> This is a follow-up on the discussion started in my patch set
>> "MAP client: notification support". The patches were implementing
>> notification support only for one remote device and needed an additional
>> API function for choosing that device.
>>
>> It's better to implement this implicitly and support multiple devices
>> from the beginning.
>>
>> In this E-Mail I'd like to suggest how we could implement the
>> notification connection setup in BlueZ. I'll try to explain the relevant
>> part of the spec to have a base for discussion.
>>
>> MAP consists of two different OBEX applications, Message Access Service
>> (MAS) for browsing messages and Message Notification Service (MNS) for
>> receiving event reports about changes on the server (like new messages,
>> moved messages, delivery reports, ...).
>>
>> The spec describes the single phone use case where the MAP client (MCE)
>> consists of several MAS client instances for the different accounts and
>> one common MNS server instance:
>>
>>   MCE (Car Kit)       MSE (Phone)
>> +---------------+   +-------------------------+
>> | MAS client 1  |<->| MAS server 1 (SMS)      |
>> | MAS client 2  |<->| MAS server 2 (E-Mail A) |
>> |     ...       |   |     ...                 |
>> | MNS server    |<->| MNS client              |
>> +---------------+   +-------------------------+
>>
>> Every MAS client instance, that wants to use notifications, needs to
>> use the SetNotificationRegistration function to enable it.
>> If the MNS connection isn't established already, the server (MSE) will
>> start the SDP lookup for the MNS instance on the client and connect to
>> it. The event reports that are sent on the MNS channel contain the MAS
>> instance ID, that can be used to map the event to the MAS client.
>>
>> Since an OBEX instance, like the MNS server, cannot be connected to
>> different remote devices at the same time, it will not work to have one
>> static MNS server instance. Instead we need one MNS server instance for
>> every connected remote device (that we want to use with MAP). Since the
>> MNS connection establishment is based on SDP, we have to make sure that
>> there's only one MNS server SDP record visible. Otherwise, the MSE
>> cannot know which one to connect to.
> 
> But it should not the same instance, for every connection it will be a
> different OBEX instance just like any OPP instance. RFCOMM limitation
> is to the same device we can only have one connection, actually 2 one
> in each direction, but for different devices we can connect just fine.
> 
>> If we want to hide this all from the application level, we could do the
>> connection establishment for two devices (MSE 1 and MSE 2) as described
>> here.
>>
>>   MCE (Car Kit)       MSE 1 (Business phone)
>> +---------------+   +-------------------------+
>> | MAS client 1  |<->| MAS server 1 (SMS)      |
>> | MAS client 2  |<->| MAS server 2 (E-Mail A) |
>> |     ...       |   |     ...                 |
>> | MNS server 1  |<->| MNS client              |
>> |               |   +-------------------------+
>> |               |
>> |               |     MSE 2 (private phone)
>> |               |   +-------------------------+
>> | MAS client 3  |<->| MAS server 1 (SMS)      |
>> |     ...       |   |     ...                 |
>> | MNS server 2  |<->| MNS client              |
>> +---------------+   +-------------------------+
>>
>> - MCE connects MAS client 1 to MSE 1
>> - MCE dynamically instantiates MNS server 1 and registers its SDP record
>> - MAS client 1 sends SetNotificationRegistration(on)
>> - MSE does SDP lookup and connects to the found MNS server 1
>> - MCE removes SDP record for MNS server 1
>> - MCE connects MAS client 2 to MSE 1
>> - MAS client 2 sends SetNotificationRegistration(on)
>>      (MNS channel is already up, MSE just responds OK)
>> - MCE connects MAS client 3 to MSE 2
>> - MCE dynamically instantiates MNS server 2 and registers its SDP record
>> - MAS client 3 sends SetNotificationRegistration(on)
>> - MSE does SDP lookup and connects to the found MNS server 2
>> - MCE removes SDP record for MNS server 2
>> ...
>>
>> Does that sound reasonable for you?
>>
>> Currently it's not possible to dynamically add OBEX servers, as they are
>> all instantiated at startup on predefined RFCOMM channels.
>> Could you comment on how this should be implemented best?
> 
> We should be able to differentiate each connection already, in fact
> bluetoothd and obexd are already able to handle multiple
> instances/connections to e.g. OPP:
> 
> bluetoothd[18792]: src/profile.c:ext_confirm() incoming connect from
> 6C:83:36:BA:55:B4
> bluetoothd[18792]: src/profile.c:ext_confirm() Object Push authorizing
> connection from 6C:83:36:BA:55:B4
> bluetoothd[18792]: src/profile.c:ext_auth() Connection from
> 6C:83:36:BA:55:B4 authorized but still waiting for SDP
> bluetoothd[18792]: src/profile.c:ext_svc_complete() Services resolved
> for 6C:83:36:BA:55:B4
> bluetoothd[18792]: src/profile.c:ext_svc_complete() 6C:83:36:BA:55:B4
> authorized to connect to Object Push
> bluetoothd[18792]: src/profile.c:ext_connect() Object Push connected
> to 6C:83:36:BA:55:B4
> bluetoothd[18792]: src/device.c:device_profile_connected() Object Push
> Success (0)
> bluetoothd[18792]: src/adapter.c:connected_callback() hci0 device
> B4:EE:D4:93:34:8F connected eir_len 5
> bluetoothd[18792]: src/profile.c:ext_confirm() incoming connect from
> B4:EE:D4:93:34:8F
> bluetoothd[18792]: src/profile.c:ext_confirm() Object Push authorizing
> connection from B4:EE:D4:93:34:8F
> bluetoothd[18792]: src/profile.c:ext_auth() Connection from
> B4:EE:D4:93:34:8F authorized but still waiting for SDP
> bluetoothd[18792]: src/profile.c:ext_svc_complete() Services resolved
> for B4:EE:D4:93:34:8F
> bluetoothd[18792]: src/profile.c:ext_svc_complete() B4:EE:D4:93:34:8F
> authorized to connect to Object Push
> bluetoothd[18792]: src/profile.c:ext_connect() Object Push connected
> to B4:EE:D4:93:34:8F
> bluetoothd[18792]: src/device.c:device_profile_connected() Object Push
> Success (0)
> 
> Every connection is represented by a GObex instance, since there is
> only one MSN independent of how many MAS instances there is no need to
> have multiple records because each device will connection only once
> and each will have a dedicated GObex instance.
> 
> --
> Luiz Augusto von Dentz
> 

You are right. I have tested this a couple of weeks ago and could not
establish the second connection. Additionally, I found a thread saying
that it's only possible to have multiple connections to a service when
using L2CAP, but not RFCOMM. However, I've retested it today with
different devices and it seems to work.

Then as discussed, I'll modify my patch set and setup/close the MNS
connection together with the MAS connection. The dispatching mechanism
then needs to be changed to use both BDAddr + MASInstanceID.

Thanks,
Christian

