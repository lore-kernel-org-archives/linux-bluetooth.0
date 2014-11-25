Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <001901d00890$32d6b8b0$98842a10$@samsung.com>
References: <1416559765-26427-1-git-send-email-gowtham.ab@samsung.com>
	<1416559765-26427-2-git-send-email-gowtham.ab@samsung.com>
	<001901d00890$32d6b8b0$98842a10$@samsung.com>
Date: Tue, 25 Nov 2014 23:51:31 +0200
Message-ID: <CABBYNZLgBR_b-wzC+ZKuOxmhJnz4j5yo69FCvzw2fah7D+EhGw@mail.gmail.com>
Subject: Re: [PATCH] plugins/autopair: Provide descriptive error log
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Gowtham Anandha Babu <gowtham.ab@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Dmitry Kasatkin <d.kasatkin@samsung.com>,
	Bharat Panda <bharat.panda@samsung.com>, cpgs@samsung.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Nov 25, 2014 at 11:14 AM, Gowtham Anandha Babu
<gowtham.ab@samsung.com> wrote:
> Hi,
>
>> -----Original Message-----
>> From: Gowtham Anandha Babu [mailto:gowtham.ab@samsung.com]
>> Sent: Friday, November 21, 2014 2:19 PM
>> To: linux-bluetooth@vger.kernel.org
>> Cc: d.kasatkin@samsung.com; bharat.panda@samsung.com;
>> cpgs@samsung.com; Gowtham Anandha Babu
>> Subject: [PATCH] plugins/autopair: Provide descriptive error log
>>
>> Add more description in error logging.
>> ---
>>  plugins/autopair.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/plugins/autopair.c b/plugins/autopair.c index
> d63da93..43b0e00
>> 100644
>> --- a/plugins/autopair.c
>> +++ b/plugins/autopair.c
>> @@ -172,8 +172,8 @@ static int autopair_init(void)
>>       n = read(fd, &seed, sizeof(seed));
>>       if (n < (ssize_t) sizeof(seed)) {
>>               err = (n == -1) ? -errno : -EIO;
>> -             error("Failed to read %zu bytes from /dev/urandom",
>> -
> sizeof(seed));
>> +             error("Failed to read %zu bytes from /dev/urandom: %s
>> (%d)",
>> +                                     sizeof(seed), strerror(-err), -err);
>>               close(fd);
>>               return err;
>>       }
>> --
>> 1.9.1
>
> Ping.

Applied, thanks.


-- 
Luiz Augusto von Dentz
