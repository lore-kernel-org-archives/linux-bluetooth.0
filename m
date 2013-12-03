Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAJdJm_M5nf5L-efYVtY-4UYT2S4JRypGKYgu7PoVOz9DFxBS6g@mail.gmail.com>
References: <1386063385-31263-1-git-send-email-luiz.dentz@gmail.com>
	<CAJdJm_M5nf5L-efYVtY-4UYT2S4JRypGKYgu7PoVOz9DFxBS6g@mail.gmail.com>
Date: Tue, 3 Dec 2013 13:40:53 +0200
Message-ID: <CABBYNZJvw0v8-xJkbh5_92EszcUeU23L4FDnEd6BQJ01GD2-aw@mail.gmail.com>
Subject: Re: [PATCH BlueZ] audio/AVCTP: Fix crash
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

On Tue, Dec 3, 2013 at 1:24 PM, Anderson Lizardo
<anderson.lizardo@openbossa.org> wrote:
> Hi Luiz,
>
> On Tue, Dec 3, 2013 at 5:36 AM, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
>> --- a/profiles/audio/avctp.c
>> +++ b/profiles/audio/avctp.c
>> @@ -1488,7 +1488,7 @@ static struct avctp_pending_req *pending_create(struct avctp_channel *chan,
>>         tmp = g_slist_copy(chan->processed);
>>
>>         /* Find first unused transaction id */
>> -       for (l = tmp; l; l = l->next) {
>> +       for (l = tmp; l; l = g_slist_next(l)) {
>
> Are you sure this fixes the problem? AFAIK g_list_next() will still
> access invalid memory unless the "next" pointer is saved *before* the
> current entry is freed. See e.g. remove_temp_devices() in
> src/adapter.c.

Yep, I tested and it fixes the problem. The problem is not actually
removing the item, but reassigning tmp to the head of the list which
can be NULL so doing l = l->next before deleting the node doesn't help
in this case. Anyway this is now applied but we will be changing the
logic how to check the available transaction to use bitmask operations
so we find the next transaction without looping in a list.
