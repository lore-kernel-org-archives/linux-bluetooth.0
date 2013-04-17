Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1365758946-8682-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
References: <1365758946-8682-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
Date: Wed, 17 Apr 2013 14:01:21 +0300
Message-ID: <CABBYNZKMi-EXtDowasnESvkpYH4LY2swEuA7BBE8Sx0P9Xg3ig@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] MAP client: Read MASInstanceID for the current connection
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Christian,

On Fri, Apr 12, 2013 at 12:29 PM, Christian Fetzer
<christian.fetzer@oss.bmw-carit.de> wrote:
> From: Christian Fetzer <christian.fetzer@bmw-carit.de>
>
> Changelog v2:
> - Replaced get_service_record by get_attribute
> - Removed force sdp lookup
>
> --
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
> transports (like Bluetooth) to specify a getattribute function and made
> it available through obc_session_get_attribute. This way, transports can
> provide additional service information to the client implementations.
>
> Christian Fetzer (6):
>   obexd: Cache SDP record in bluetooth transport
>   obexd: Add getattribute to obc_transport
>   obexd: Add bluetooth_getattribute to Bluetooth transport
>   obexd: Add obc_session_get_attribute to session
>   lib: Add attributes MASInstanceID and SupportedMessageTypes
>   obexd: Read service attributes when instantiating MAP session
>
>  lib/sdp.h                |  2 ++
>  obexd/client/bluetooth.c | 36 ++++++++++++++++++++++++++++++++++--
>  obexd/client/map.c       | 31 +++++++++++++++++++++++++++++--
>  obexd/client/session.c   | 11 +++++++++++
>  obexd/client/session.h   |  3 +++
>  obexd/client/transport.h |  1 +
>  6 files changed, 80 insertions(+), 4 deletions(-)
>
> --
> 1.8.2.1

Applied, thanks.

Note that I did some modification to bluetooth_getattribute to check
sdp_record pointer against NULL to be consistent with the rest of the
code and obc_session_get_attribute I simplified it a little bit to be
more readable. Together with this set I pushed some changes to sdptool
so it can now parse MASInstanceID and SupportedMessageTypes.

--
Luiz Augusto von Dentz
