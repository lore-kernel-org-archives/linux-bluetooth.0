Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1360161922-6585-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
References: <1360161922-6585-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
Date: Tue, 12 Feb 2013 11:02:44 +0200
Message-ID: <CABBYNZ+uC+BP0dQZdOrP35E7uu9Q_SwrxfTaxm2+vRh+6-bpbw@mail.gmail.com>
Subject: Re: [RFC 0/8] MAP client: notification support
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Christian,

On Wed, Feb 6, 2013 at 4:45 PM, Christian Fetzer
<christian.fetzer@oss.bmw-carit.de> wrote:
> From: Christian Fetzer <christian.fetzer@bmw-carit.de>
>
> This patchset adds the necessary blocks for receiving notifications in the MAP client.
> So far this covers only bluetooth protocol related additions, leaving out end user D-Bus API changes.
>
> The patchset consists of the following parts:
> - Message Notification Server (MNS)
>   Once connected, the MNS will receive XML based event reports from the MSE and parse them into a struct
>   for further processing.
>
> - RegisterNotification function
>   The function sends the SetNotificationRegistration command to the MSE which will then try to connect
>   to the MNS.
>
> - Notification dispatcher (that dispatches event reports by their MAS instance id to the correct client instance)
>   The message access part of every client instance registers a notification handler function.
>   The MNS will call the associated handler for all received event report.
>
> Since the dispatching needs to be done on the mas instance id, the message access part of the client
> needs to be aware of the instance id of the server it connects to. Unfortunately this information is only
> available as SDP attribute.
>
> Due to the current transport layer abstraction in obexd, the MAP client has no direct access to SDP.
> Therefore I have extended obc_transport to allow concrete transports (like Bluetooth) to specify
> a get_service_record function and made it available through obc_session_get_service_record.
> This way, transports can provide additional service information to the client implementations.
> The bluetooth transport will now always do a sdp lookup (if the driver's obc_driver->force_service_lookup is set).
> In addition it will cache sdp record associated with the connection and make it accessible in get_service_record.
>
> Christian Fetzer (8):
>   obexd: Add get_service_record to obc_transport
>   obexd: Provide SDP record in get_service_record
>   obexd: Read MAP client SDP attributes
>   obexd: Add Message Notification Server (MNS)
>   obexd: Add RegisterNotifications function
>   obexd: Add MAP notification dispatcher
>   obexd: Register MAP notification handler
>   obexd: Notify registered notification handlers
>
>  Makefile.obexd                |   4 +
>  doc/obex-api.txt              |   7 +
>  lib/sdp.h                     |   2 +
>  obexd/client/bluetooth.c      |  51 ++++++-
>  obexd/client/driver.h         |   1 +
>  obexd/client/map-dispatcher.c |  86 +++++++++++
>  obexd/client/map-dispatcher.h |  45 ++++++
>  obexd/client/map-event.h      |  42 +++++
>  obexd/client/map.c            | 144 +++++++++++++++++-
>  obexd/client/mns.c            | 346 ++++++++++++++++++++++++++++++++++++++++++
>  obexd/client/session.c        |  11 +-
>  obexd/client/session.h        |   2 +
>  obexd/client/transport.h      |   2 +
>  obexd/plugins/bluetooth.c     |   2 +
>  obexd/src/obexd.h             |   1 +
>  src/profile.c                 |  55 +++++++
>  16 files changed, 790 insertions(+), 11 deletions(-)
>  create mode 100644 obexd/client/map-dispatcher.c
>  create mode 100644 obexd/client/map-dispatcher.h
>  create mode 100644 obexd/client/map-event.h
>  create mode 100644 obexd/client/mns.c
>
> --
> 1.8.1.2

Did not like so much the thing with force_service_lookup although I
see that we gonna need it, but perhaps we should try to think about
other alternatives. The implementation of MNS as a proper driver is
what made us to integrate the server and client but we should go one
step forward and integrate client and server core specially the plugin
handling should be common to both client and server just the drivers
need to be different.


-- 
Luiz Augusto von Dentz
