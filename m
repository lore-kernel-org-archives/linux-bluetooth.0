Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAAngNMbS0oDkxe0TQEu2mrxrf7dyViYcHZFeKgtREDd1jtp-yA@mail.gmail.com>
References: <1356189162-11584-1-git-send-email-jprvita@openbossa.org>
 <1356189162-11584-4-git-send-email-jprvita@openbossa.org> <1356194171.29264.14.camel@aeonflux>
 <CAAngNMbS0oDkxe0TQEu2mrxrf7dyViYcHZFeKgtREDd1jtp-yA@mail.gmail.com>
From: Joao Paulo Rechi Vita <jprvita@openbossa.org>
Date: Sat, 22 Dec 2012 15:41:02 -0300
Message-ID: <CAAngNMawM-hVHwD0QCrRU4PPLavSkinH+k4zLdCQzh403MTBaw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 4/4] hog: Remove pre-existing suspend FIFO
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

On Sat, Dec 22, 2012 at 3:39 PM, Joao Paulo Rechi Vita
<jprvita@openbossa.org> wrote:
> On Sat, Dec 22, 2012 at 1:36 PM, Marcel Holtmann <marcel@holtmann.org> wr=
ote:
>> Hi Joao Paulo,
>>
>>> If bluetoothd crashes the exit routine of the suspend plugin will not b=
e
>>> executed, leaving the suspend FIFO behind and preventing the plugin loa=
d
>>> on subsequent executions. This commit checks for pre-existence of the
>>> suspend FIFO and tries to remove and re-create it.
>>> ---
>>>  profiles/input/suspend-dummy.c | 16 ++++++++++++++++
>>>  1 file changed, 16 insertions(+)
>>>
>>> diff --git a/profiles/input/suspend-dummy.c b/profiles/input/suspend-du=
mmy.c
>>> index 33b790a..43384c0 100644
>>> --- a/profiles/input/suspend-dummy.c
>>> +++ b/profiles/input/suspend-dummy.c
>>> @@ -119,6 +119,22 @@ int suspend_init(suspend_event suspend, resume_eve=
nt resume)
>>>
>>>       if (mkfifo(HOG_SUSPEND_FIFO, S_IRWXU) < 0) {
>>>               int err =3D -errno;
>>> +
>>> +             if (err =3D=3D -EEXIST) {
>>> +                     DBG("FIFO (%s) already exists, trying to remove",
>>> +                                                     HOG_SUSPEND_FIFO)=
;
>>> +
>>> +                     /* remove pre-existing FIFO and retry */
>>> +                     if (remove(HOG_SUSPEND_FIFO) < 0) {
>>
>> you are looking for unlink() to use here.
>>
>
> What's the problem with remove()? From the manpage it's part of
> stdio.h and calls unlink() for files, and rmdir() for directories.
> From my understanding if someone else created a directory on the FIFO
> path, unlink() will return with EISDIR and we would need to handle
> this error as well.
>

And BTW, remove() is also been used on suspend_exit().

--
Jo=C3=A3o Paulo Rechi Vita
Openbossa Labs - INdT
