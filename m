Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1252564369.8931.38.camel@violet>
References: <5078d8af0909092016g7ba97265yc725537e04a709d5@mail.gmail.com>
	 <1252564369.8931.38.camel@violet>
Date: Thu, 10 Sep 2009 18:24:54 +0300
Message-ID: <5078d8af0909100824k4dbea674u222d138ecd14e5fd@mail.gmail.com>
Subject: Re: Source device selection for org.bluez.client.SendFiles
From: Timothy Madden <terminatorul@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
To: unlisted-recipients:; (no To-header on input)
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Oh, yes, indeed

On Thu, Sep 10, 2009 at 9:32 AM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Timothy,
>
>> I noticed method SendFiles in org.bluez.client was ignoring the given
>> source in the device dictionary passed as argument.
>>
>> I had to modify the send_files() function in obexd-0.17/client/main.c
>> and replace the NULL parameter it was passing on to session_create
>> with the given source from the dictionary. Than I could select the
>> source device when calling SendFiles from python. Should I send in a
>> patch ?
>
> you mean something like this:
>
> commit e1214330b4391d5577e5e2411a6ee34604d6bea4
> Author: Claudio Takahasi <claudio.takahasi@openbossa.org>
> Date:   Thu Sep 3 11:17:42 2009 -0300
>
>    Fixed SendFiles to use "Source" argument.
>
>    SendFiles was ignoring "Source" argument and using the default adapter
>    always.
>
> diff --git a/client/main.c b/client/main.c
> index e903a75..32eca26 100644
> --- a/client/main.c
> +++ b/client/main.c
> @@ -187,7 +187,7 @@ static DBusMessage *send_files(DBusConnection *connection,
>        data->agent = g_strdup(agent);
>        data->files = files;
>
> -       if (session_create(NULL, dest, "OPP", channel, create_callback,
> +       if (session_create(source, dest, "OPP", channel, create_callback,
>                                data) == 0)
>                return NULL;
>
> Regards
>
> Marcel
>
>
>
