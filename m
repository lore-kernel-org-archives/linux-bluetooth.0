Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <68A01E8B-5BF3-41AD-AF79-0DF619566069@holtmann.org>
References: <1387533387-6724-1-git-send-email-luiz.dentz@gmail.com>
	<6E8A8CD1-5CB6-4D65-9BD7-DF4CF23F274C@holtmann.org>
	<CABBYNZKcsaSSEXLV+gQuxXMzu8ePCyiyU5cJcNQ8rTjzsP-PUg@mail.gmail.com>
	<68A01E8B-5BF3-41AD-AF79-0DF619566069@holtmann.org>
Date: Fri, 20 Dec 2013 16:09:32 +0200
Message-ID: <CABBYNZLm6kvHuNJsCwN57CQraWs8pgmQviWP2_LySH2c=284Lg@mail.gmail.com>
Subject: Re: [PATCH BlueZ] android/AVDTP: Duplicate fd passed to avdtp_new
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "linux-bluetooth@vger.kernel.org development" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Fri, Dec 20, 2013 at 3:52 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Luiz,
>
>>>> This use dup to create a new fd to be used by AVDTP session leaving the
>>>> caller free to close the original fd. Note that even if the caller
>>>> decides to keep the original fd it will still be notified when
>>>> avdtp_shutdown is called since it uses shutdown.
>>>
>>> I would be more curious on why this is needed.
>>
>> It is basically to make the caller able to release any resources, such
>> as GIOChannel managed by btio, without causing a disconnect.
>
> you do not have to set close_on_unref with the GIOChannel. You can just unset that one. Then GIOChannel will not touch it and will not call close on it.

That is what we used to do, but it is not very convenient since there
it is still possible to call g_io_channel_shutdown which would cause a
disconnect. Also dup turn out to be handful to check if the fd is
valid and free the user to do whatever it pleases with the original
fd, in the end what we are doing with the fd is very similar to what
we would do to a GIOChannel as dup just creates another reference the
underline socket is the same.


-- 
Luiz Augusto von Dentz
