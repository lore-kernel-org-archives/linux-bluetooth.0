Return-Path: <cyrus@holtmann.org>
Message-id: <B6FA980DEB6A49D7B309B3B9F8E44D49@sisodomain.com>
From: Jaganath <jaganath.k@samsung.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
References: <1322827022-27391-1-git-send-email-jaganath.k@samsung.com>
 <CABBYNZ+uimY=eA6PnND5mqeAj2411rk0hseXp1PXbdEDt6P4vw@mail.gmail.com>
 <90B4470ABE8C438C9650ED03BF611926@sisodomain.com>
 <CABBYNZKvf=-GjM24J3jQOwRVrLJ90y8SvHXsQNSeHZMEEudFvg@mail.gmail.com>
In-reply-to: <CABBYNZKvf=-GjM24J3jQOwRVrLJ90y8SvHXsQNSeHZMEEudFvg@mail.gmail.com>
Subject: Re: [PATCH obexd] Fix file size issue in GetProperties
Date: Fri, 02 Dec 2011 20:28:26 +0530
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=iso-8859-1; reply-type=original
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

--------------------------------------------------
From: "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>
Sent: Friday, December 02, 2011 8:01 PM
To: "Jaganath" <jaganath.k@samsung.com>
Cc: <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH obexd] Fix file size issue in GetProperties

> Hi Jaganath,
>
> On Fri, Dec 2, 2011 at 3:00 PM, Jaganath <jaganath.k@samsung.com> wrote:
>>>
>>>
>>> Nice catch, but I would like to avoid another public function for
>>> this, so how about making obc_transfer_set_file static on transfer.c
>>> calling it in obc_transfer_register?
>>>
>>> --
>>> Luiz Augusto von Dentz
>>> --
>>
>>
>> obc_transfer_register is being called from obc_session_get which
>> eventually calls obc_transfer_get in which if transfer->name is NULL
>> transfer->filename is open with write mode. obc_session_get is used from
>> pbap and sync with name as NULL and filename as NOT NULL.
>
> Now I realize why I didn't do it since the beginning, because the
> application can skip the files it is probably better to not open them
> until they are acknowledged, also it is very bad idea to call back the
> daemon while within the Request as the daemon could be waiting the
> application to acknowledged it can cause a deadlock where both the
> application and obex-client are waiting for each other.
>
> There are plans to change this API so OPP would also register a
> session and all transfers register an object, with this we will
> probably not need the agent interface anymore and things became a bit
> simpler as we return the transfer object directly on SendFile.
>
> -- 
> Luiz Augusto von Dentz
> --
I accept that it is bad to have a dbus round trip. But I am unclear about 
the deadlock
scenario since deamon is calling "Request" method asynchronously.
Since transfer is already registered before "Request" method, application 
can
call "GetProperties" at any point of time. 

