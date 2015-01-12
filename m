Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAHrH25SfDPiS0GKQ0EpTC-iWL7Cvo2GR+=6AbKD4q7DtPDvSGg@mail.gmail.com>
References: <1420696108-29699-1-git-send-email-armansito@chromium.org>
	<CAHrH25SfDPiS0GKQ0EpTC-iWL7Cvo2GR+=6AbKD4q7DtPDvSGg@mail.gmail.com>
Date: Mon, 12 Jan 2015 20:58:25 -0200
Message-ID: <CABBYNZJfP18RYpLuyysO3xfqe-gDC-RjGAjQpEpa+fcN7Rsjpg@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 00/14] Implmenet doc/gatt-api.txt for client
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Arman Uguray <armansito@chromium.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

On Mon, Jan 12, 2015 at 7:37 PM, Arman Uguray <armansito@chromium.org> wrote:
> On Wed, Jan 7, 2015 at 9:48 PM, Arman Uguray <armansito@chromium.org> wrote:
>> *v2: This set addresses comments by Luiz and includes several bug fixes:
>>   - Make shared/gatt-client read/write procedures cancelable. Have exported
>>     characteristics and descriptors keep track of their operations and cancel
>>     them when free'd.
>>   - Fix bug in attribute value caching by truncating the value before setting
>>     it.
>>   - Expose extended properties in the GattCharacteristic1.Flags property.
>>   - Hande Service Changed events.
>>   - Fix bug in profile probing that created a btd_service for each GATT service
>>     as opposed to once per UUID (mostly due to a misunderstanding).
>>   - Fix crash introduced by recent gatt_db_find_by_type refactor.
>>   - Fix incorrect behavior caused by using gatt_db_service_set_active to mark
>>     services as claimed.
>>
>> *v1: Picking up remaining patches from before the holidays:
>>   - Rebased on top of Luiz's modifications.
>>   - Fixed small bugs that appeared after the merge.
>>   - Addressed some of the initial comments.
>>   - Added StartNotify/StopNotify. I left these methods as they are.
>>     I'm planning to address the issue with potentially missed
>>     notifications in a GattProfile1 API.
>>
>> Arman Uguray (14):
>>   core: gatt: Expose charac. extended properties.
>>   shared/gatt-client: Make read/write cancelable
>>   shared/gatt-client: Make long-write cancelable
>>   core: gatt: Cancel pending reads/writes
>>   shared/gatt-db: Add gatt_db_attribute_reset
>>   core: gatt: Reset value in db when caching
>>   core: gatt: Issue long write for reliable-write
>>   core: gatt: Handle Service Changed.
>>   core: device: Fix GATT profile probing
>>   profiles/gap: Fix probe/accept behavior.
>>   core: service: Remove GATT handle logic
>>   shared/gatt-db: Fix crash in gatt_db_find_by_type
>>   shared/gatt-db: Add "claimed" field to services
>>   core: gatt: Use "claimed" instead of "active"
>>
>>  profiles/gap/gas.c       | 124 +++++++------
>>  src/device.c             | 183 +++++++------------
>>  src/gatt-client.c        | 359 ++++++++++++++++++++++++++-----------
>>  src/service.c            |  38 ----
>>  src/service.h            |   7 -
>>  src/shared/gatt-client.c | 458 ++++++++++++++++++++++++++++++++++-------------
>>  src/shared/gatt-client.h |  16 +-
>>  src/shared/gatt-db.c     |  39 ++++
>>  src/shared/gatt-db.h     |   6 +
>>  9 files changed, 781 insertions(+), 449 deletions(-)
>>
>> --
>> 2.2.0.rc0.207.ga3a616c
>>
>
> ping
> --

Ive applied patches 1-7, please rebase and check the comments
regarding patch 8/14.


-- 
Luiz Augusto von Dentz
