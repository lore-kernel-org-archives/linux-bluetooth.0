Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1365508448-13171-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
References: <1365508448-13171-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
Date: Thu, 11 Apr 2013 12:23:00 +0300
Message-ID: <CABBYNZLdgaL_vWX4h-bWE5nxU474WS4_KgOWyqeNCXBhCYOwog@mail.gmail.com>
Subject: Re: [PATCH 0/8] MAP client: Read MASInstanceID for the current connection
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Christian,

On Tue, Apr 9, 2013 at 2:54 PM, Christian Fetzer
<christian.fetzer@oss.bmw-carit.de> wrote:
> From: Christian Fetzer <christian.fetzer@bmw-carit.de>
>
> This patch set allows the MAP client profile implementation to read the
> instance id of the MAS server it is connected to.
>
> This is a prerequisite for receiving event reports and distributing them to the
> correct MAS client instance. The instance id is only available as SDP
> attribute.
>
> Due to the current transport layer abstraction in obexd, the MAP client has no
> direct access to SDP. Therefore I have extended obc_transport to allow concrete
> transports (like Bluetooth) to specify a get_service_record function and made
> it available through obc_session_get_service_record. This way, transports can
> provide additional service information to the client implementations.
>
> The Bluetooth transport will now always do a SDP lookup (if the driver's
> obc_driver->force_service_lookup is set) and cache the connection specific
> service record to be accessed via get_service_record.
>
> I will send the dispatching of notifications itself in a third set.
>
> Christian Fetzer (8):
>   obexd: Cache SDP record in bluetooth transport
>   obexd: Add get_service_record to obc_transport
>   obexd: Add get_bluetooth_service_record to Bluetooth transport
>   obexd: Add obc_session_get_service_record to session
>   lib: Add attributes MASInstanceID and SupportedMessageTypes
>   obexd: Read SDP attributes when instantiating MAP session
>   obexd: Add the possibility for drivers to force a service lookup
>   obexd: Force service lookup when instantiating MAP session
>
>  lib/sdp.h                |  2 ++
>  obexd/client/bluetooth.c | 51 +++++++++++++++++++++++++++++++++++++++++-------
>  obexd/client/driver.h    |  1 +
>  obexd/client/map.c       | 35 +++++++++++++++++++++++++++++++--
>  obexd/client/session.c   | 14 +++++++++++--
>  obexd/client/session.h   |  2 ++
>  obexd/client/transport.h |  2 ++
>  7 files changed, 96 insertions(+), 11 deletions(-)
>
> --
> 1.8.2.1

Lets drop force_lookup for now, if the application is using the
channel directly it should know which instance it is connected and
should not attempt to connect another instance.

For get_service_record I was thinking that it would be better not to
expose the raw record as it is being done, perhaps get_instance_id or
a generic get_attribute which should take the sdp attribute.


--
Luiz Augusto von Dentz
