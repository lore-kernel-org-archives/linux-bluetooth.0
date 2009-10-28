Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20091028233425.GA13183@jh-x301>
References: <1256253562-22532-1-git-send-email-jaikumar@google.com>
	<2d5a2c100910230649u1946e632qa4c50b33b6654218@mail.gmail.com>
	<e8892a6a0910230817l6f096f70s4de1fe534799de86@mail.gmail.com>
	<2d5a2c100910231044u6a6c65e0ka8258a6f65d08f41@mail.gmail.com>
	<e8892a6a0910260820g43b4f688g2c33d7d1ae771d07@mail.gmail.com>
	<20091028233425.GA13183@jh-x301>
From: Jaikumar Ganesh <jaikumar@google.com>
Date: Wed, 28 Oct 2009 16:45:05 -0700
Message-ID: <e8892a6a0910281645r39d3b793wa9b9f2cc948da3da@mail.gmail.com>
Subject: Re: [PATCH] Update SDP storage records when a record is deleted.
To: Jaikumar Ganesh <jaikumar@google.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan:

On Wed, Oct 28, 2009 at 4:34 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Jaikumar,
>
> On Mon, Oct 26, 2009, Jaikumar Ganesh wrote:
>> When the device is removed, we remove the cache and remove the device->uuids
>> value. So when the device is created the next time, we cannot depend on
>> the profiles_removed value, we need to reconstruct from device->uuids.
>> device_remove_drivers call is based on the profiles_removed flag and hence that
>> call will never be made, when a new device is created.
>>
>> My change removes the dependency of SDP records and the probe_drivers,
>> Thus, removal of SDP records doesn't depend on the profiles_removed flag
>> but rather uses device->uuids directly.
>>
>> profiles_added and profiles_removed flags are useful in the case where
>> the user calls discover services on an already created device and there
>> are changes in the SDP records.
>
> If a device was removed then we shouldn't have any records stored records
> for it left in the cache and so it shouldn't matter that the
> profiles_removed list is empty when the device is recreated again, right?
> It seems there's a bug in the device_remove_stored function in device.c
> since it doesn't remove the record cache, so that's at least something
> that should be fixed.
>

The SDP cache is  removed when the device is removed. In fact, you
fixed this a few days back.
This is the scenario I am referring to:

a) Device is paired and SDP records fetched.
b) Device is unpaired - device cache records of SDP is freed
c) On Remote Device - some SDP records are deleted.
d) When the device is created again and the SDP records fetched,
profiles_removed is empty and so

        if (req->profiles_removed)
                device_remove_drivers(device, req->profiles_removed);

device_remove_drivers will not be called and hence SDP records will
never get deleted.

e) My change removes the coupling of SDP records with the drivers code
and hence we will remove the SDP records in this scenario.

> Johan
>

Thanks
Jaikumar
