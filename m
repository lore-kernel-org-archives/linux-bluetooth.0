Return-Path: <cyrus@holtmann.org>
Message-id: <E6D3ADF70E2545DB94C315D230502089@sisodomain.com>
From: Jaganath <jaganath.k@samsung.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
References: <1335783797-7430-1-git-send-email-jaganath.k@samsung.com>
 <CABBYNZJOy_-t_vQ542c+t=Kht6HRHqs3jy7DR302f7M8FkCeXg@mail.gmail.com>
In-reply-to: <CABBYNZJOy_-t_vQ542c+t=Kht6HRHqs3jy7DR302f7M8FkCeXg@mail.gmail.com>
Subject: Re: [PATCH obexd 2/3] client: Wait for abort completion before
 Transfer.Cancel returns
Date: Wed, 02 May 2012 19:19:28 +0530
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=iso-8859-1; reply-type=original
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

--------------------------------------------------
From: "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>
Sent: Wednesday, May 02, 2012 6:14 PM
To: "Jaganath Kanakkassery" <jaganath.k@samsung.com>
Cc: <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH obexd 2/3] client: Wait for abort completion before 
Transfer.Cancel returns

> Hi Jaganath,
>
> On Mon, Apr 30, 2012 at 2:03 PM, Jaganath Kanakkassery
> <jaganath.k@samsung.com> wrote:
>> -       if (callback) {
>> -               GError *err;
>> +       dbus_message_unref(transfer->msg);
>> +       transfer->msg = NULL;
>>
>> +       if (callback) {
>>                err = g_error_new(OBC_TRANSFER_ERROR, -ECANCELED, "%s",
>> 
>> strerror(ECANCELED));
>>                callback->func(transfer, transfer->transferred, err,
>
> This looks wrong, you should not overwrite the err if it is set as it
> will leak, you probably should forward the err if not NULL or create a
> new GError if abort was successful because either way we are going to
> stop the transfer.

Ok, I will raise patch for as per your comments.

Thanks,
Jaganath 

