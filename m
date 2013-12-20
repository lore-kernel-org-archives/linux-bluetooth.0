Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <F4C8A536-4F92-42DF-8492-B81330118461@holtmann.org>
References: <1387533387-6724-1-git-send-email-luiz.dentz@gmail.com>
	<6E8A8CD1-5CB6-4D65-9BD7-DF4CF23F274C@holtmann.org>
	<CABBYNZKcsaSSEXLV+gQuxXMzu8ePCyiyU5cJcNQ8rTjzsP-PUg@mail.gmail.com>
	<68A01E8B-5BF3-41AD-AF79-0DF619566069@holtmann.org>
	<CABBYNZLm6kvHuNJsCwN57CQraWs8pgmQviWP2_LySH2c=284Lg@mail.gmail.com>
	<F4C8A536-4F92-42DF-8492-B81330118461@holtmann.org>
Date: Fri, 20 Dec 2013 17:40:46 +0200
Message-ID: <CABBYNZKWzxUd1_Pi86jx2fxLR9PjctVuMGTYiSGz2uiCEFy3WA@mail.gmail.com>
Subject: Re: [PATCH BlueZ] android/AVDTP: Duplicate fd passed to avdtp_new
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "linux-bluetooth@vger.kernel.org development" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Fri, Dec 20, 2013 at 4:39 PM, Marcel Holtmann <marcel@holtmann.org> wrot=
e:
> Hi Luiz,
>
>>>>>> This use dup to create a new fd to be used by AVDTP session leaving =
the
>>>>>> caller free to close the original fd. Note that even if the caller
>>>>>> decides to keep the original fd it will still be notified when
>>>>>> avdtp_shutdown is called since it uses shutdown.
>>>>>
>>>>> I would be more curious on why this is needed.
>>>>
>>>> It is basically to make the caller able to release any resources, such
>>>> as GIOChannel managed by btio, without causing a disconnect.
>>>
>>> you do not have to set close_on_unref with the GIOChannel. You can just=
 unset that one. Then GIOChannel will not touch it and will not call close =
on it.
>>
>> That is what we used to do, but it is not very convenient since there
>> it is still possible to call g_io_channel_shutdown which would cause a
>> disconnect. Also dup turn out to be handful to check if the fd is
>> valid and free the user to do whatever it pleases with the original
>> fd, in the end what we are doing with the fd is very similar to what
>> we would do to a GIOChannel as dup just creates another reference the
>> underline socket is the same.
>
> if the original caller calls g_io_channel_shutdown it will still cause a =
disconnect. No matter if you duped the fd or not. Not getting your point. I=
f the caller is doing something stupid, then you have a problem not matter =
what.

Nope, g_io_channel_shutdown does not call shutdown, it only does close
and therefore do not affect in case of duped fd. The point is
convenience, having same code path regardless if the fd has been hand
over or not.

> This duped fd is different from everything else we have in src/shared/ in=
 any of the projects. You hand over the fd and then it is owned by that par=
t. After that you are not suppose to touch it anymore. That is the semantic=
 that I want. And not another complicated concept of reference counting fd =
in multiple levels of the code.

Well I don't think we had defined any semantic for fd ownership,
mgmt_new is the only one that actually have such a thing but it does
not work with GIOChannel/btio handling the connection setup, and if
you look at other examples like libdbus it does make use of dup when
passing fds around (and no this is not necessary with SCM_RIGTHS since
the kernel does take a reference while transferring the fd to another
process).

We could perhaps do the close_on_unref function similar to the mgmt,
which perhaps was inspired in the GIOChannel that also take ownership
and thus requires close_on_unref helper function to instrument how it
should deal with the fd, imo dup is probably less code since you can
always close on unref.

--=20
Luiz Augusto von Dentz
