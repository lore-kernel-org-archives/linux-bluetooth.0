Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <3119819.bMHWn5I4f0@athlon>
References: <1390575403-30860-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<1390575403-30860-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<3119819.bMHWn5I4f0@athlon>
Date: Sun, 26 Jan 2014 06:29:00 +0200
Message-ID: <CABBYNZLzyQqZ+LQoB+C7A2UA2GiZQOMfjqvNsuCLRMtqHfgMMg@mail.gmail.com>
Subject: Re: [PATCH 2/3] android/avdtp: Retry send on EAGAIN as well
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Szymon Janc <szymon.janc@gmail.com>
Cc: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Sat, Jan 25, 2014 at 12:16 AM, Szymon Janc <szymon.janc@gmail.com> wrote:
> Hi Andrei,
>
> On Friday 24 January 2014 16:56:42 Andrei Emeltchenko wrote:
>> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>>
>> ---
>>  android/avdtp.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/android/avdtp.c b/android/avdtp.c
>> index 5da1206..1055bc1 100644
>> --- a/android/avdtp.c
>> +++ b/android/avdtp.c
>> @@ -444,7 +444,7 @@ static gboolean try_send(int sk, void *data, size_t len)
>>
>>       do {
>>               err = send(sk, data, len, 0);
>> -     } while (err < 0 && errno == EINTR);
>> +     } while (err < 0 && (errno == EINTR || errno == EAGAIN));
>>
>
> This makes try_send() blocking, if this is ok then at least some explanation
> in commit message would be welcome.

And if we want to block we should not set the socket as non-blocking
in first place, Im not even sure this is easy to currently reproduce
any case that would block since the command are quite small we would
have to schedule several in a sequence but normally we can only have
one command outstanding.


-- 
Luiz Augusto von Dentz
