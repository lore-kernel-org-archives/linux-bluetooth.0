Return-Path: <cyrus@holtmann.org>
Message-ID: <511CA64E.4080206@oss.bmw-carit.de>
Date: Thu, 14 Feb 2013 09:54:38 +0100
From: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
MIME-Version: 1.0
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [RFC 0/8] MAP client: notification support
References: <1360161922-6585-1-git-send-email-christian.fetzer@oss.bmw-carit.de> <CABBYNZ+uC+BP0dQZdOrP35E7uu9Q_SwrxfTaxm2+vRh+6-bpbw@mail.gmail.com>
In-Reply-To: <CABBYNZ+uC+BP0dQZdOrP35E7uu9Q_SwrxfTaxm2+vRh+6-bpbw@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz

On 02/12/2013 10:02 AM, Luiz Augusto von Dentz wrote:
> Hi Christian,
>
> On Wed, Feb 6, 2013 at 4:45 PM, Christian Fetzer
> <christian.fetzer@oss.bmw-carit.de>  wrote:
>> From: Christian Fetzer<christian.fetzer@bmw-carit.de>
>>
>> This patchset adds the necessary blocks for receiving notifications in the MAP client.
>> So far this covers only bluetooth protocol related additions, leaving out end user D-Bus API changes.
>>
>> The patchset consists of the following parts:
>> - Message Notification Server (MNS)
>>    Once connected, the MNS will receive XML based event reports from the MSE and parse them into a struct
>>    for further processing.
>>
>> - RegisterNotification function
>>    The function sends the SetNotificationRegistration command to the MSE which will then try to connect
>>    to the MNS.
>>
>> - Notification dispatcher (that dispatches event reports by their MAS instance id to the correct client instance)
>>    The message access part of every client instance registers a notification handler function.
>>    The MNS will call the associated handler for all received event report.
>>
>> Since the dispatching needs to be done on the mas instance id, the message access part of the client
>> needs to be aware of the instance id of the server it connects to. Unfortunately this information is only
>> available as SDP attribute.
>>
>> Due to the current transport layer abstraction in obexd, the MAP client has no direct access to SDP.
>> Therefore I have extended obc_transport to allow concrete transports (like Bluetooth) to specify
>> a get_service_record function and made it available through obc_session_get_service_record.
>> This way, transports can provide additional service information to the client implementations.
>> The bluetooth transport will now always do a sdp lookup (if the driver's obc_driver->force_service_lookup is set).
>> In addition it will cache sdp record associated with the connection and make it accessible in get_service_record.
>>
>> Christian Fetzer (8):
>>    obexd: Add get_service_record to obc_transport
>>    obexd: Provide SDP record in get_service_record
>>    obexd: Read MAP client SDP attributes
>>    obexd: Add Message Notification Server (MNS)
>>    obexd: Add RegisterNotifications function
>>    obexd: Add MAP notification dispatcher
>>    obexd: Register MAP notification handler
>>    obexd: Notify registered notification handlers
>>
>>   Makefile.obexd                |   4 +
>>   doc/obex-api.txt              |   7 +
>>   lib/sdp.h                     |   2 +
>>   obexd/client/bluetooth.c      |  51 ++++++-
>>   obexd/client/driver.h         |   1 +
>>   obexd/client/map-dispatcher.c |  86 +++++++++++
>>   obexd/client/map-dispatcher.h |  45 ++++++
>>   obexd/client/map-event.h      |  42 +++++
>>   obexd/client/map.c            | 144 +++++++++++++++++-
>>   obexd/client/mns.c            | 346 ++++++++++++++++++++++++++++++++++++++++++
>>   obexd/client/session.c        |  11 +-
>>   obexd/client/session.h        |   2 +
>>   obexd/client/transport.h      |   2 +
>>   obexd/plugins/bluetooth.c     |   2 +
>>   obexd/src/obexd.h             |   1 +
>>   src/profile.c                 |  55 +++++++
>>   16 files changed, 790 insertions(+), 11 deletions(-)
>>   create mode 100644 obexd/client/map-dispatcher.c
>>   create mode 100644 obexd/client/map-dispatcher.h
>>   create mode 100644 obexd/client/map-event.h
>>   create mode 100644 obexd/client/mns.c
>>
>> --
>> 1.8.1.2
> Did not like so much the thing with force_service_lookup although I
> see that we gonna need it, but perhaps we should try to think about
> other alternatives. The implementation of MNS as a proper driver is
> what made us to integrate the server and client but we should go one
> step forward and integrate client and server core specially the plugin
> handling should be common to both client and server just the drivers
> need to be different.
One alternative might be doing the service lookup when needed.
Calling obc_session_get_service_record could trigger the lookup,
when there's no yet a cached sdp record available.
In case of MAP for example, when registering for notifications.
But, this would make the implementation more complex as we would need
obc_session_get_service_record to be asynchronous.
Personally, I don't see a big advantage in this.
Especially when we want to support newer profile versions later, we will 
need
to do the service lookup to get the remote profile version at the very 
beginning
of the session establishment.
What's your opinion on this? Any other ideas?

Indeed, the hard coded loading of client implementations is not very nice.
It would be better to have them loaded by plugin_init() that came with 
the server part.
I could send a patch that removes the static loading from 
obexd/client/manager.c,
adds OBEX_PLUGIN_DEFINE to all client plugins and adapts the makefile.
Is that the right approach? Should they be renamed and moved into the 
plugin directory as well?

Thanks and best regards,
Christian
