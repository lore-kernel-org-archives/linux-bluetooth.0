Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAJdJm_Pd=iUz6iavWn-_g=bDZTDd86FSqRNB=nKSLxRgq_+=KA@mail.gmail.com>
References: <1332711499-5928-1-git-send-email-arik@wizery.com> <CAJdJm_Pd=iUz6iavWn-_g=bDZTDd86FSqRNB=nKSLxRgq_+=KA@mail.gmail.com>
From: Arik Nemtsov <arik@wizery.com>
Date: Mon, 26 Mar 2012 15:41:41 +0200
Message-ID: <CA+XVXfddvejDKNbOyX=+iz1nYt57cDY_oCGSuPCkdrsMqPEj+g@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] Implement ProximityReporter profiles
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Mar 26, 2012 at 15:35, Anderson Lizardo
<anderson.lizardo@openbossa.org> wrote:
> Hi Arik,
>
> On Sun, Mar 25, 2012 at 5:38 PM, Arik Nemtsov <arik@wizery.com> wrote:
>> This patch-set implements the Link loss and Immediate Alert GATT
>> server profiles.
>>
>> A few API calls are added/changed in preparation, the most notable of
>> which is the addition of the remote-device to each GATT read/write callback.
>>
>> The new profiles are separated into their own files for clarity.
>>
>> A ProximityReporter D-Bus interface is registered for each remote device.
>> Property queries and PropertyChanged notifications are implemented, in
>> accordance to doc/proximity-api.txt.
>>
>> v4->5: Add remote device to ATT callback function in a saner way.
>> Move bluez-dependent defintions from att.h to att-bluez.h and add
>> a btd_device argument to the function there. (Thanks Johan)
>>
>> Arik Nemtsov (6):
>>  att: add remote btd_device to ATT read/write callbacks
>>  proximity: reporter: save global D-Bus connection
>>  proximity: reporter: move definitions to .h and add util function
>>  proximity: link loss: implement link loss server
>>  proximity: immediate alert: implement immediate alert server
>>  proximity: reporter: implement D-Bus API
>>
>>  Makefile.am            |    4 +-
>>  attrib/att-bluez.h     |   44 +++++++
>>  attrib/att.h           |   20 ---
>>  attrib/gatt-service.c  |    1 +
>>  plugins/gatt-example.c |    4 +-
>>  proximity/immalert.c   |  289 +++++++++++++++++++++++++++++++++++++++++
>>  proximity/immalert.h   |   26 ++++
>>  proximity/linkloss.c   |  337 ++++++++++++++++++++++++++++++++++++++++++++++++
>>  proximity/linkloss.h   |   26 ++++
>>  proximity/reporter.c   |  251 ++++++++++++++++++++++++++----------
>>  proximity/reporter.h   |   16 +++
>>  src/attrib-server.c    |   20 ++-
>>  time/server.c          |    7 +-
>>  13 files changed, 947 insertions(+), 98 deletions(-)
>>  create mode 100644 attrib/att-bluez.h
>>  create mode 100644 proximity/immalert.c
>>  create mode 100644 proximity/immalert.h
>>  create mode 100644 proximity/linkloss.c
>>  create mode 100644 proximity/linkloss.h
>
> This patch set looks good to me, except for the comment I made on one patch.
>
> Other notes:
> * make sure it is rebased against current master (and at least build
> tested after this), specially because Johan applied some Chen commits
> that may conflict with your patches.

Of course.

> * I'm not sure "att-bluez.h" is a good name. What about
> "att-helper.h", "att-item.h", "att-database.h" ? "bluez" seems
> redundant to me :)

"att-databse" does sound better. I'll switch the names.

Regards,
Arik
