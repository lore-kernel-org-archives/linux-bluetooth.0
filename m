Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120817082916.GB31481@x220>
References: <CAKT1EBfp+iJfRSodDfoqtDB4X90BNR1wEJh_zXvw0t6JvnaWuA@mail.gmail.com>
	<1345147991-31320-1-git-send-email-claudio.takahasi@openbossa.org>
	<20120817082916.GB31481@x220>
Date: Fri, 17 Aug 2012 11:04:50 -0300
Message-ID: <CAKT1EBc1dmhZ89QjtjqPYS+2VkVNJdnHCJYJ75zX_SkN5mr6DQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ v1 00/10] GATT Plugin
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Fri, Aug 17, 2012 at 5:29 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Claudio,
>
> On Thu, Aug 16, 2012, Claudio Takahasi wrote:
>> This patch series adds a new GATT based plugin for GAP and GATT service.
>> The objective is cleanup: moving some GATT related operations from the
>> device(core) to a GATT based plugin.
>>
>> This first part is related to GAP appearance characteristic. A second
>> patch will be sent soon to manage Service Changed and GATT/ATT MTU.
>>
>> Claudio Takahasi (10):
>>   gatt: Add Generic Access/Attribute Profile plugin
>>   gatt: Add GAP/GATT device registration
>>   gatt: Add read Appearance characteristic
>>   gatt: Add storing Appearance
>>   core: Remove Appearance characteristic read
>>   gatt: Emit PropertyChanged for Appearance
>>   core: PropertyChanged signal for Icon/class
>>   core: PropertyChanged signal for Icon/Appearance
>>   gatt: Map Appearance value 0x0000 to "unknown"
>>   gatt: Don't store Appearance if value is "unknown"
>>
>>  Makefile.am             |    8 ++-
>>  profiles/gatt/gas.c     |  179 +++++++++++++++++++++++++++++++++++++++++++++++
>>  profiles/gatt/gas.h     |   25 +++++++
>>  profiles/gatt/main.c    |   52 ++++++++++++++
>>  profiles/gatt/manager.c |   82 +++++++++++++++++++++
>>  profiles/gatt/manager.h |   24 ++++++
>>  src/dbus-common.c       |    2 +
>>  src/device.c            |   74 +++++--------------
>>  src/device.h            |    1 +
>>  9 files changed, 390 insertions(+), 57 deletions(-)
>>  create mode 100644 profiles/gatt/gas.c
>>  create mode 100644 profiles/gatt/gas.h
>>  create mode 100644 profiles/gatt/main.c
>>  create mode 100644 profiles/gatt/manager.c
>>  create mode 100644 profiles/gatt/manager.h
>
> Besides the one comment I already sent about this patch set it looks
> more or less ok to me. Would it also make sense to move the server-side
> GAP functionality into this plugin?
>
> Johan

Probably yes. If we don't find impediments we will send patches to
move this code.

BR,
Claudio
