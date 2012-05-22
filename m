Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120522080002.GA9688@x220>
References: <1337374667-17802-1-git-send-email-paulo.alcantara@openbossa.org>
	<1337633316-4992-1-git-send-email-paulo.alcantara@openbossa.org>
	<1337633316-4992-3-git-send-email-paulo.alcantara@openbossa.org>
	<20120522080002.GA9688@x220>
Date: Tue, 22 May 2012 14:33:57 -0300
Message-ID: <CAKT1EBey5fb-GSzapxk7vF5iVfaOV3O-scPQSJtUh+whpVUJbg@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 2/2] core: Fix creating device from "primary" file
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: Paulo Alcantara <paulo.alcantara@openbossa.org>,
	linux-bluetooth@vger.kernel.org,
	Johan Hedberg <johan.hedberg@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Tue, May 22, 2012 at 5:00 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi,
>
> On Mon, May 21, 2012, Paulo Alcantara wrote:
>> From: Claudio Takahasi <claudio.takahasi@openbossa.org>
>>
>> This patch removes the hard-coded address type for the BLE device
>> created from the storage.
>> ---
>>  src/adapter.c |   10 +++++++---
>>  1 files changed, 7 insertions(+), 3 deletions(-)
>>
>> diff --git a/src/adapter.c b/src/adapter.c
>> index dafe595..1ca21e6 100644
>> --- a/src/adapter.c
>> +++ b/src/adapter.c
>> @@ -1940,13 +1940,17 @@ static void create_stored_device_from_primary(char *key, char *value,
>>       struct btd_adapter *adapter = user_data;
>>       struct btd_device *device;
>>       GSList *services, *uuids, *l;
>> +     char address[18];
>> +     uint8_t bdaddr_type;
>> +
>> +     if (sscanf(key, "%17s#%hhu", address, &bdaddr_type) < 2)
>> +             bdaddr_type = BDADDR_LE_PUBLIC;
>
> That's not safe. What if sscanf returns 0 or a negative value? In that
> case the address variable will remain uninitialized (which is why you
> should have just followed my suggestion of testing for < 1 and returning
> in such a case).

IMO, it is not necessary to add extra verification since only
bluetoothd changes this file.
It will be an unnecessary overhead.

>
> Thinking more about this situation I'm not sure if it's any better to
> allow creation of old entries since you won't be able to remove them
> anyway: the remove code looks for a bdaddr#type key which won't exist
> and adding code to look for both types of keys is just bloating the code
> base for a minor benefit.
>
> So maybe your initial patch of failing in the case of sscanf returning < 2
> is good enough after all.
>
> Johan

As you mentioned in the reply for "v2 1/2" of this patch series, LE
was enabled by default recently, and there isn't releases supporting
officially LE. Keep the compatibility with the old format will not
give a valuable benefit.
We will fix the other issues that you pointed, and send the patch series again.

Claudio.
