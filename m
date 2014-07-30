Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH] shared/att: Handle disconnects.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CABBYNZJdppvFb_KCBAzX9_3aVpx8r47myxPFW_ZgLUnESDJ+Hg@mail.gmail.com>
Date: Wed, 30 Jul 2014 09:27:12 -0700
Cc: Arman Uguray <armansito@chromium.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <3E59062F-919F-46E2-99F3-39BFCDB0C706@holtmann.org>
References: <1406664819-24970-1-git-send-email-armansito@chromium.org> <CABBYNZJdppvFb_KCBAzX9_3aVpx8r47myxPFW_ZgLUnESDJ+Hg@mail.gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

>> This patch adds disconnect handling to bt_att, in which
>> io_set_disconnect_handler is used to set up a handler which cancels all
>> pending and queued ATT operations, marks the bt_att structure as invalid
>> and notifies the user via a specialized callback which can be set using
>> bt_att_set_disconnect_cb.
>> ---
>> src/shared/att.c | 62 +++++++++++++++++++++++++++++++++++++++++++++++++++++---
>> src/shared/att.h |  5 +++++
>> 2 files changed, 64 insertions(+), 3 deletions(-)
>> 
>> diff --git a/src/shared/att.c b/src/shared/att.c
>> index 0d27dfa..bc856dc 100644
>> --- a/src/shared/att.c
>> +++ b/src/shared/att.c
>> @@ -49,7 +49,11 @@ struct bt_att {
>>        int fd;
>>        bool close_on_unref;
>>        struct io *io;
>> -       bool invalid;  /* bt_att becomes invalid when a request times out */
>> +
>> +       /* bt_att becomes invalid when a request times out or if the physical
>> +        * link is disconnected.
>> +        */
>> +       bool invalid;
> 
> Usually this can be done by freeing and setting the io to NULL so it
> is no longer connected.

this might be a simpler way to achieve this. Not having a valid IO around means that we do not have a transport anymore.

Regards

Marcel

