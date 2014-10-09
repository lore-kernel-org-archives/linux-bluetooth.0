Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAHrH25TbsEmz3qdQTLZdcqFx8=dRRqpcivT2mPM+xWEOi0HFyA@mail.gmail.com>
References: <1412629304-3391-1-git-send-email-armansito@chromium.org>
	<CAHrH25TbsEmz3qdQTLZdcqFx8=dRRqpcivT2mPM+xWEOi0HFyA@mail.gmail.com>
Date: Thu, 9 Oct 2014 11:29:19 +0300
Message-ID: <CABBYNZJoC3ULkJ-k91dUeqteuz3spempTQf84mPFfRExYif35w@mail.gmail.com>
Subject: Re: [PATCH BlueZ v1 0/5] Introduce shared/gatt-server.
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Arman Uguray <armansito@chromium.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

On Wed, Oct 8, 2014 at 6:14 PM, Arman Uguray <armansito@chromium.org> wrote:
> On Mon, Oct 6, 2014 at 5:01 PM, Arman Uguray <armansito@chromium.org> wrote:
>> *v1:
>>   - Make gatt-db external to gatt-server, as initially discussed.
>>   - Also implement Read By Group Type request.
>>
>> Arman Uguray (5):
>>   Revert "plugins/sixaxis: Add a set_leds_sysfs() function"
>>   shared/att: Drop the connection is a request is received while one is
>>     pending.
>>   shared/gatt-server: Introduce shared/gatt-server.
>>   shared/gatt-server: Support Exchange MTU request.
>>   shared/gatt-server: Support Read By Group Type request.
>>
>>  Makefile.am              |   1 +
>>  configure.ac             |   4 +-
>>  plugins/sixaxis.c        |  89 +-----------
>>  src/shared/att.c         | 101 ++++++++------
>>  src/shared/gatt-server.c | 347 +++++++++++++++++++++++++++++++++++++++++++++++
>>  src/shared/gatt-server.h |  40 ++++++
>>  6 files changed, 455 insertions(+), 127 deletions(-)
>>  create mode 100644 src/shared/gatt-server.c
>>  create mode 100644 src/shared/gatt-server.h
>>
>> --
>> 2.1.0.rc2.206.gedb03e5
>>
>
> ping.
>
> Also ignore the bit about 'Revert "plugins/sixaxis: Add a
> set_leds_sysfs() function"'. I revert it locally since it gives me
> some dependency issues when compiling for Chromium OS; it's not part
> of the patch set I uploaded.

Apart from the comments of the last patch Im fine with this set.


-- 
Luiz Augusto von Dentz
