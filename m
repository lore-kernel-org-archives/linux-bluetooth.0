Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <7AF5DE79-4CEA-453C-895C-EF03DE9205B8@holtmann.org>
References: <1390854261-5325-1-git-send-email-luiz.dentz@gmail.com>
	<7AF5DE79-4CEA-453C-895C-EF03DE9205B8@holtmann.org>
Date: Mon, 27 Jan 2014 12:44:22 -0800
Message-ID: <CABBYNZKttkV3X+7M4QB6oZCx1F_jfRZ+aZKpmngw=A57uKAOWw@mail.gmail.com>
Subject: Re: [RFC BlueZ] android/AVDTP: Make signalling channel high priority
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Mon, Jan 27, 2014 at 12:40 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Luiz,
>
>> This makes signalling high priority (6) so it can push commands before
>> the stream channel, without this the stream channel may be schedule
>> first and cause the signalling commands to timeout while waiting a slot.
>> ---
>> android/avdtp.c | 9 +++++++++
>> 1 file changed, 9 insertions(+)
>>
>> diff --git a/android/avdtp.c b/android/avdtp.c
>> index 4abcd75..4cfffc8 100644
>> --- a/android/avdtp.c
>> +++ b/android/avdtp.c
>> @@ -2057,6 +2057,7 @@ struct avdtp *avdtp_new(int fd, size_t imtu, size_t omtu, uint16_t version)
>>       struct avdtp *session;
>>       GIOCondition cond = G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL;
>>       int new_fd;
>> +     int priority;
>>
>>       new_fd = dup(fd);
>>       if (new_fd < 0) {
>> @@ -2064,6 +2065,14 @@ struct avdtp *avdtp_new(int fd, size_t imtu, size_t omtu, uint16_t version)
>>               return NULL;
>>       }
>>
>> +     priority = 6;
>> +     if (setsockopt(new_fd, SOL_SOCKET, SO_PRIORITY,
>> +                     (const void *) &priority, sizeof(priority)) < 0) {
>> +             error("setsockopt(SO_PRIORITY): %s (%d)", strerror(errno),
>> +                                                                     errno);
>> +             return NULL;
>> +     }
>> +
>
> I think we should make it one higher than the media channel. If we are currently using priority 6 on the media channel than this should be 7. If 7 is not possible, then we might degrade the media channel to 5.

Setting anything bigger than 6 requires CAP_NET_ADMIN so it would
requires unit tests to run with it, perhaps we can do some logic that
checks if we can over 6 or not depending on what capabilities we have.


-- 
Luiz Augusto von Dentz
