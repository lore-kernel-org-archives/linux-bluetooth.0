Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1332147523-9984-1-git-send-email-arik@wizery.com>
References: <1332147523-9984-1-git-send-email-arik@wizery.com>
From: Arik Nemtsov <arik@wizery.com>
Date: Tue, 20 Mar 2012 18:15:01 +0200
Message-ID: <CA+XVXffAPkKFunFQS34RVDEB1bR0RgGqf8-3RGc6J-2HEQXa=g@mail.gmail.com>
Subject: Fwd: [PATCH v4 0/6] Implement ProximityReporter profiles
To: "Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Johan, Gustavo,

It seems there are no further comments. Is this patch-set good to go?

Regards,
Arik

On Mon, Mar 19, 2012 at 10:58, Arik Nemtsov <arik@wizery.com> wrote:
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
> v3->4: More minor function renames
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
>  attrib/att.h           |    6 +-
>  plugins/gatt-example.c |    3 +-
>  proximity/immalert.c   |  288 +++++++++++++++++++++++++++++++++++++++++
>  proximity/immalert.h   |   26 ++++
>  proximity/linkloss.c   |  336 ++++++++++++++++++++++++++++++++++++++++++++++++
>  proximity/linkloss.h   |   26 ++++
>  proximity/reporter.c   |  250 ++++++++++++++++++++++++++----------
>  proximity/reporter.h   |   16 +++
>  src/attrib-server.c    |   19 ++-
>  time/server.c          |    6 +-
>  11 files changed, 900 insertions(+), 80 deletions(-)
>  create mode 100644 proximity/immalert.c
>  create mode 100644 proximity/immalert.h
>  create mode 100644 proximity/linkloss.c
>  create mode 100644 proximity/linkloss.h
>
> --
> 1.7.5.4
>
