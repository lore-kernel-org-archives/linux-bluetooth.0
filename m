Return-Path: <cyrus@holtmann.org>
Message-id: <D5966BC142C34C93B808CF99839A204A@sisodomain.com>
From: Jaganath <jaganath.k@samsung.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
References: <1329742172-12124-1-git-send-email-jaganath.k@samsung.com>
 <CABBYNZLNPeRkTbyoJ7a82SmVehmvTosTDqX0zjy_-eZRMS=ALA@mail.gmail.com>
In-reply-to: <CABBYNZLNPeRkTbyoJ7a82SmVehmvTosTDqX0zjy_-eZRMS=ALA@mail.gmail.com>
Subject: Re: [PATCH obexd] client: Fix ABORT command not sending when user
 cancels the transfer
Date: Mon, 20 Feb 2012 19:25:05 +0530
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=iso-8859-1; reply-type=original
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz.

--------------------------------------------------
From: "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>
Sent: Monday, February 20, 2012 6:53 PM
To: "Jaganath Kanakkassery" <jaganath.k@samsung.com>
Cc: <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH obexd] client: Fix ABORT command not sending when user 
cancels the transfer

> Hi Jaganath,
>
> On Mon, Feb 20, 2012 at 2:49 PM, Jaganath Kanakkassery
> <jaganath.k@samsung.com> wrote:
>> Issue: When user cancels the tranfer, after queuing the ABORT command
>> transfer->callback() with error will be called. In that session_unref
>> is called which disconnects the transport.
>
> I don't get the issue, you don't want to disconnect immediately if the
> transfer aborts and the last reference is released? IMO that is fine
> in most of the cases, btw by disconnecting it also serves as an ABORT.
User perspective this is fine but PTS requires ABORT command before
transport disconnection
> The only cases where we would not do it is if the session object is
> created, e.g. ftp, but if that happens than the module is responsible
> to hold a reference to the session preventing it to disconnect.
>
>> diff --git a/gobex/gobex-transfer.c b/gobex/gobex-transfer.c
>> index c62a91e..706952f 100644
>> --- a/gobex/gobex-transfer.c
>> +++ b/gobex/gobex-transfer.c
>> @@ -635,6 +635,10 @@ gboolean g_obex_cancel_transfer(guint id)
>>        if (transfer == NULL)
>>                return FALSE;
>>
>> -       transfer_free(transfer);
>> +       if (transfer->req_id > 0)
>> +               g_obex_cancel_req(transfer->obex, transfer->req_id, 
>> FALSE);
>> +       else
>> +               transfer_free(transfer);
>> +
>>        return TRUE;
>>  }
>
> Btw, when you changing gobex please send its changes separately
> starting with gobex:, so not that after g_obex_cancel_transfer the id
> and callback should no longer be accessible so the application should
> be able to free its resources, so if we call the callback latter it
> will very likely cause a crash.
I don't get you. In g_obex_cancel_transfer() it just sends abort command.
Transfer will be freed in transfer_complete().
>
> -- 
> Luiz Augusto von Dentz 

