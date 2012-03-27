Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1332879859-20268-1-git-send-email-arik@wizery.com>
References: <1332879859-20268-1-git-send-email-arik@wizery.com>
Date: Tue, 27 Mar 2012 16:58:14 -0400
Message-ID: <CAJdJm_PnyWBYxWZXY-6n98NUhSsqvnZjUNV-Lte-BK02q5xwLw@mail.gmail.com>
Subject: Re: [PATCH v6 0/6] Implement ProximityReporter profiles
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Arik Nemtsov <arik@wizery.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arik,

On Tue, Mar 27, 2012 at 4:24 PM, Arik Nemtsov <arik@wizery.com> wrote:
> This patch-set implements the Link loss and Immediate Alert GATT
> server profiles.
>
> A few API calls are added/changed in preparation, the most notable of
> which is the addition of the remote-device to each GATT read/write callback.
>
> The new profiles are separated into their own files for clarity.
>
> A ProximityReporter D-Bus interface is registered for each remote device.
> Property queries and PropertyChanged notifications are implemented, in
> accordance to doc/proximity-api.txt.
>
> v5->6: Fix immalert bug on unregister path. Rename att-bluez.h to
> att-database.h. Rebase on latest master (Makefile.am changes).
>
> Arik Nemtsov (6):
>  att: add remote btd_device to ATT read/write callbacks
>  proximity: reporter: save global D-Bus connection
>  proximity: reporter: move definitions to .h and add util function
>  proximity: link loss: implement link loss server
>  proximity: immediate alert: implement immediate alert server
>  proximity: reporter: implement D-Bus API
>
>  Makefile.am            |    4 +-
>  attrib/att-database.h  |   44 +++++++
>  attrib/att.h           |   20 ---
>  attrib/gatt-service.c  |    1 +
>  plugins/gatt-example.c |    4 +-
>  proximity/immalert.c   |  289 +++++++++++++++++++++++++++++++++++++++++
>  proximity/immalert.h   |   26 ++++
>  proximity/linkloss.c   |  337 ++++++++++++++++++++++++++++++++++++++++++++++++
>  proximity/linkloss.h   |   26 ++++
>  proximity/reporter.c   |  250 ++++++++++++++++++++++++++----------
>  proximity/reporter.h   |   16 +++
>  src/attrib-server.c    |   20 ++-
>  time/server.c          |    7 +-
>  13 files changed, 946 insertions(+), 98 deletions(-)
>  create mode 100644 attrib/att-database.h
>  create mode 100644 proximity/immalert.c
>  create mode 100644 proximity/immalert.h
>  create mode 100644 proximity/linkloss.c
>  create mode 100644 proximity/linkloss.h

Patch set looks good to me, but I have a few notes, that you should
pay attention on future patches (or if Johan complains, you will need
to fix here as well):

* You are not being consistent on indentation, specially on statements
and function declarations that take multiple lines. Be sure to always
indent the continuation lines to the right, with _tabs only_.
* When sending newer series versions, please use --in-reply-to for
"git send-email", passing the message ID of the previous patch series
version. This makes a lot easier to look for differences between
previous versions, and helps threading on mail clients.

Best regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
