Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <3E59062F-919F-46E2-99F3-39BFCDB0C706@holtmann.org>
References: <1406664819-24970-1-git-send-email-armansito@chromium.org>
	<CABBYNZJdppvFb_KCBAzX9_3aVpx8r47myxPFW_ZgLUnESDJ+Hg@mail.gmail.com>
	<3E59062F-919F-46E2-99F3-39BFCDB0C706@holtmann.org>
Date: Wed, 30 Jul 2014 14:52:41 -0700
Message-ID: <CAHrH25S+Kny+h6QmGpfydvMaYEu-odB_Vd1Jkdh27PtLoe9xqQ@mail.gmail.com>
Subject: Re: [PATCH] shared/att: Handle disconnects.
From: Arman Uguray <armansito@chromium.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz & Marcel,

I think the current way we have things is pretty simple and clean
already, but I'll go ahead with your suggestion if you guys prefer
that.

One small question: is it safe to call io_destroy inside the
disconnect callback? If not, then we would have to post an
asynchronous task to clean up the IO and this would complicate the
code a little bit. We would actually still want to mark the the att
structure as invalid somehow so that any calls made to bt_att_send,
bt_att_register etc before the IO is freed can return false, which
would lead us to have a "bool invalid" field somewhere.

In the timeout case, it might make sense to destroy the IO there. Then
again, we could leave it up to the upper layer to unref the bt_att
which would then destroy the connection.

Thanks,
Arman

On Wed, Jul 30, 2014 at 9:27 AM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Luiz,
>
>>> This patch adds disconnect handling to bt_att, in which
>>> io_set_disconnect_handler is used to set up a handler which cancels all
>>> pending and queued ATT operations, marks the bt_att structure as invalid
>>> and notifies the user via a specialized callback which can be set using
>>> bt_att_set_disconnect_cb.
>>> ---
>>> src/shared/att.c | 62 +++++++++++++++++++++++++++++++++++++++++++++++++++++---
>>> src/shared/att.h |  5 +++++
>>> 2 files changed, 64 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/src/shared/att.c b/src/shared/att.c
>>> index 0d27dfa..bc856dc 100644
>>> --- a/src/shared/att.c
>>> +++ b/src/shared/att.c
>>> @@ -49,7 +49,11 @@ struct bt_att {
>>>        int fd;
>>>        bool close_on_unref;
>>>        struct io *io;
>>> -       bool invalid;  /* bt_att becomes invalid when a request times out */
>>> +
>>> +       /* bt_att becomes invalid when a request times out or if the physical
>>> +        * link is disconnected.
>>> +        */
>>> +       bool invalid;
>>
>> Usually this can be done by freeing and setting the io to NULL so it
>> is no longer connected.
>
> this might be a simpler way to achieve this. Not having a valid IO around means that we do not have a transport anymore.
>
> Regards
>
> Marcel
>
