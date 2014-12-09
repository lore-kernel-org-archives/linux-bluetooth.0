Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZK2dy1FU9GbfbxfEsWa_A3b=0WcKh4hZpxfF8LQSeL3GQ@mail.gmail.com>
References: <1418085655-7304-1-git-send-email-armansito@chromium.org>
	<1418085655-7304-3-git-send-email-armansito@chromium.org>
	<CABBYNZK2dy1FU9GbfbxfEsWa_A3b=0WcKh4hZpxfF8LQSeL3GQ@mail.gmail.com>
Date: Tue, 9 Dec 2014 05:04:02 -0800
Message-ID: <CAHrH25RbWkL4cF+sVvYQmh1at86ukyv9D8ALTNa2ffhJAgYo5Q@mail.gmail.com>
Subject: Re: [PATCH BlueZ 02/15] shared/att: Add bt_att_get_fd.
From: Arman Uguray <armansito@chromium.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> On Tue, Dec 9, 2014 at 4:50 AM, Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:
> Hi Arman,
>
> On Tue, Dec 9, 2014 at 2:40 AM, Arman Uguray <armansito@chromium.org> wrote:
>> This patch adds a getter for a bt_att structure's underlying connection
>> file descriptor.
>> ---
>>  src/shared/att.c | 8 ++++++++
>>  src/shared/att.h | 1 +
>>  2 files changed, 9 insertions(+)
>>
>> diff --git a/src/shared/att.c b/src/shared/att.c
>> index ee425d8..9511bb2 100644
>> --- a/src/shared/att.c
>> +++ b/src/shared/att.c
>> @@ -922,6 +922,14 @@ void bt_att_unref(struct bt_att *att)
>>         free(att);
>>  }
>>
>> +int bt_att_get_fd(struct bt_att *att)
>> +{
>> +       if (!att)
>> +               return -EINVAL;
>> +
>> +       return att->fd;
>> +}
>> +
>>  bool bt_att_set_close_on_unref(struct bt_att *att, bool do_close)
>>  {
>>         if (!att || !att->io)
>> diff --git a/src/shared/att.h b/src/shared/att.h
>> index 99b5a5b..b946b18 100644
>> --- a/src/shared/att.h
>> +++ b/src/shared/att.h
>> @@ -33,6 +33,7 @@ struct bt_att *bt_att_new(int fd);
>>  struct bt_att *bt_att_ref(struct bt_att *att);
>>  void bt_att_unref(struct bt_att *att);
>>
>> +int bt_att_get_fd(struct bt_att *att);
>
> It is not clear why this would be necessary?
>

I added this to make one call site work where src/device uses it to
obtain a socket error in the event of a disconnect. I could probably
avoid this by getting the fd out of the GIOChannel which device is
still caching anyway.

-Arman
