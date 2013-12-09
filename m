Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <3479757.7T9GkbTkhq@uw000953>
References: <1386074528-8020-1-git-send-email-szymon.janc@tieto.com>
	<3479757.7T9GkbTkhq@uw000953>
Date: Mon, 9 Dec 2013 11:34:56 +0200
Message-ID: <CABBYNZKHfLk+aBJ1_+L+E1fDRYZpuw5-tqdiMLUVX5BKvx7fnw@mail.gmail.com>
Subject: Re: [PATCH] android: Fix missing failure check in ipc_init
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Mon, Dec 9, 2013 at 10:55 AM, Szymon Janc <szymon.janc@tieto.com> wrote:
>
>> If connecting command socket failed daemon should be terminated.
>> ---
>>  android/ipc.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/android/ipc.c b/android/ipc.c
>> index 1d369a8..6f940cd 100644
>> --- a/android/ipc.c
>> +++ b/android/ipc.c
>> @@ -229,6 +229,8 @@ static gboolean cmd_connect_cb(GIOChannel *io, GIOCondition cond,
>>  void ipc_init(void)
>>  {
>>       cmd_io = connect_hal(cmd_connect_cb);
>> +     if (!cmd_io)
>> +             raise(SIGTERM);
>>  }
>>
>>  void ipc_cleanup(void)
>>

Applied, thanks.


-- 
Luiz Augusto von Dentz
