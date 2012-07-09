Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120709140005.GA3293@x220>
References: <1341340993-7480-1-git-send-email-jprvita@openbossa.org>
	<20120709140005.GA3293@x220>
Date: Mon, 9 Jul 2012 17:08:01 -0500
Message-ID: <CABUK1agL-wTZE1cTmO3=eBcApt0_emHcFMg9kQJ19pbo-dH5sA@mail.gmail.com>
Subject: Re: [PATCH 00/21] HID over GATT plugin
From: Pavan Savoy <pavan_savoy@sify.com>
To: =?UTF-8?Q?Jo=C3=A3o_Paulo_Rechi_Vita?= <jprvita@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Johan, Joao,

Why wasn't uinput sub-system used ?
May be there was a discussion regarding this on list & I missed it ?

why invent uHID ? or the project previously existed ?

On Mon, Jul 9, 2012 at 9:00 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi João Paulo,
>
> On Tue, Jul 03, 2012, João Paulo Rechi Vita wrote:
>> This is the plugin to support HID over GATT. It has the uHID module as a
>> dependency, which is now integrated on the HID maintainer's tree [1] and will
>> be part of the HID's 3.6 pull request. Right now a merge of the 'uhid' branch
>> of this tree witht the master branch of bluetooth-next is necessary to test
>> this plugin, with the uhid module compiled and loaded.
>>
>> [1] git://git.kernel.org/pub/scm/linux/kernel/git/jikos/hid.git
>>
>> Known limitations:
>>
>> - No characteristics / descriptors handle storage, we discover everything on
>>   every re-connection;
>>
>> - Discovery doesn't work when there is a bonded non-connected HoG device. We're
>>   working to improve LE connection and discovery management in general, so this
>>   will be addressed soon.
>>
>> Claudio Takahasi (8):
>>   hog: Register HID over GATT device driver
>>   hog: Add checking for 'EnableGatt'
>>   hog: Discover descriptors for all characteristics
>>   hog: Use real values for vendor and product IDs
>>   gatt: add Report Reference descriptor UUID
>>   hog: Add read Report Reference descriptor
>>   hog: Add HID Information Characteristic read
>>   hog: Use hardware country code
>>
>> João Paulo Rechi Vita (12):
>>   hog: Register ATTIO callbacks
>>   hog: Load primary service handle
>>   hog: Discover all characteristics declaration
>>   hog: Discover the "Report Map" characteristic
>>   hog: Enable "Report" characteristic notifications
>>   hog: Add report notification handler
>>   hog: HID I/O driver
>>   hog: Prepend Report ID to the HID report
>>   hog: Add support for uHID events
>>   hog: Handle output reports
>>   hog: Handle output events
>>   hog: Handle feature reports
>>
>> Paulo Alcantara (1):
>>   hog: Handle HID devices operating in Boot Protocol Mode
>>
>>  Makefile.am        |    5 +
>>  acinclude.m4       |    8 +
>>  attrib/gatt.h      |    1 +
>>  configure.ac       |    2 +
>>  input/hog_device.c |  694 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  input/hog_device.h |   28 +++
>>  input/main.c       |   24 ++
>>  input/manager.c    |   38 +++
>>  input/manager.h    |    3 +
>>  9 files changed, 803 insertions(+)
>>  create mode 100644 input/hog_device.c
>>  create mode 100644 input/hog_device.h
>
> Patches 1-9 and 12 have been applied. The rest will need to wait a bit
> until I can compile test them on a system with the kernel side support.
>
> Johan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
