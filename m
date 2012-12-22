Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1356194171.29264.14.camel@aeonflux>
References: <1356189162-11584-1-git-send-email-jprvita@openbossa.org>
 <1356189162-11584-4-git-send-email-jprvita@openbossa.org> <1356194171.29264.14.camel@aeonflux>
From: Joao Paulo Rechi Vita <jprvita@openbossa.org>
Date: Sat, 22 Dec 2012 15:39:11 -0300
Message-ID: <CAAngNMbS0oDkxe0TQEu2mrxrf7dyViYcHZFeKgtREDd1jtp-yA@mail.gmail.com>
Subject: Re: [PATCH BlueZ 4/4] hog: Remove pre-existing suspend FIFO
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

On Sat, Dec 22, 2012 at 1:36 PM, Marcel Holtmann <marcel@holtmann.org> wrot=
e:
> Hi Joao Paulo,
>
>> If bluetoothd crashes the exit routine of the suspend plugin will not be
>> executed, leaving the suspend FIFO behind and preventing the plugin load
>> on subsequent executions. This commit checks for pre-existence of the
>> suspend FIFO and tries to remove and re-create it.
>> ---
>>  profiles/input/suspend-dummy.c | 16 ++++++++++++++++
>>  1 file changed, 16 insertions(+)
>>
>> diff --git a/profiles/input/suspend-dummy.c b/profiles/input/suspend-dum=
my.c
>> index 33b790a..43384c0 100644
>> --- a/profiles/input/suspend-dummy.c
>> +++ b/profiles/input/suspend-dummy.c
>> @@ -119,6 +119,22 @@ int suspend_init(suspend_event suspend, resume_even=
t resume)
>>
>>       if (mkfifo(HOG_SUSPEND_FIFO, S_IRWXU) < 0) {
>>               int err =3D -errno;
>> +
>> +             if (err =3D=3D -EEXIST) {
>> +                     DBG("FIFO (%s) already exists, trying to remove",
>> +                                                     HOG_SUSPEND_FIFO);
>> +
>> +                     /* remove pre-existing FIFO and retry */
>> +                     if (remove(HOG_SUSPEND_FIFO) < 0) {
>
> you are looking for unlink() to use here.
>

What's the problem with remove()? From the manpage it's part of
stdio.h and calls unlink() for files, and rmdir() for directories.
>From my understanding if someone else created a directory on the FIFO
path, unlink() will return with EISDIR and we would need to handle
this error as well.

--
Jo=C3=A3o Paulo Rechi Vita
Openbossa Labs - INdT
