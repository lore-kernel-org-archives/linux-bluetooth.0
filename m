Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <000301d04126$9db398a0$d91ac9e0$@samsung.com>
References: <1422945043-4387-1-git-send-email-gowtham.ab@samsung.com>
	<000301d04126$9db398a0$d91ac9e0$@samsung.com>
Date: Thu, 5 Feb 2015 12:31:48 +0200
Message-ID: <CABBYNZJOdJSp3LSQf3J9=fa75OXpq_h=DaXSB47iqw-Rha+o0g@mail.gmail.com>
Subject: Re: [PATCH] tools/btgatt-server: Fix help message for GATT
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Gowtham Anandha Babu <gowtham.ab@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Bharat Panda <bharat.panda@samsung.com>, cpgs@samsung.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gowtham,

On Thu, Feb 5, 2015 at 11:32 AM, Gowtham Anandha Babu
<gowtham.ab@samsung.com> wrote:
> Ping.
>
>> -----Original Message-----
>> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
>> owner@vger.kernel.org] On Behalf Of Gowtham Anandha Babu
>> Sent: Tuesday, February 03, 2015 12:01 PM
>> To: linux-bluetooth@vger.kernel.org
>> Cc: bharat.panda@samsung.com; cpgs@samsung.com; Gowtham Anandha
>> Babu
>> Subject: [PATCH] tools/btgatt-server: Fix help message for GATT
>>
>> Added '\n' to make help message looks good as below:
>> btgatt-server
>> Usage:
>>       btgatt-server [options]
>> Options:
>>       -i, --index <id>                Specify adapter index, e.g. hci0
>>       -m, --mtu <mtu>                 The ATT MTU to use
>>       -s, --security-level <sec>      Set security level (low|medium|high)
>>       -v, --verbose                   Enable extra logging
>>       -r, --heart-rate                Enable Heart Rate service
>>       -h, --help                      Display help
>> ---
>>  tools/btgatt-server.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/btgatt-server.c b/tools/btgatt-server.c index
>> f6ad8c3..d27cf10 100644
>> --- a/tools/btgatt-server.c
>> +++ b/tools/btgatt-server.c
>> @@ -631,7 +631,7 @@ static void usage(void)
>>               "\t-s, --security-level <sec>\tSet security level (low|"
>>
>>       "medium|high)\n"
>>               "\t-v, --verbose\t\t\tEnable extra logging\n"
>> -             "\t-r, --heart-rate\t\tEnable Heart Rate service"
>> +             "\t-r, --heart-rate\t\tEnable Heart Rate service\n"
>>               "\t-h, --help\t\t\tDisplay help\n");
>>  }
>>
>> --
>> 1.9.1

Applied, thanks.


-- 
Luiz Augusto von Dentz
