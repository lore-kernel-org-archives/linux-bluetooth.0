Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <22ba2dcc-325a-ea3a-85c9-48c47c4a4292@jp.fujitsu.com>
References: <e75606ee-1e0f-5225-21d7-d6129202d9ac@jp.fujitsu.com> <22ba2dcc-325a-ea3a-85c9-48c47c4a4292@jp.fujitsu.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 7 Jul 2017 10:44:40 +0300
Message-ID: <CABBYNZ+0eHaWgJNQ=BNtV2apmBM_d7mKHdNVJiP3kEuDve3j5w@mail.gmail.com>
Subject: Re: [PATCH BlueZ] client: Fix memory leak due to the option to
 register an agent
To: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Eramoto,

On Tue, Jul 4, 2017 at 10:21 AM, ERAMOTO Masaya
<eramoto.masaya@jp.fujitsu.com> wrote:
> Hi Luiz,
>
> Would you apply my patch to git master branch if there are not any proble=
ms?
> I confirmed that it was applied to the latest master branch with no probl=
em.
>
> Regards,
> Eramoto
>
> On 2017=E5=B9=B406=E6=9C=8821=E6=97=A5 19:07, ERAMOTO Masaya wrote:
>> When bluetoothctl runs with the command line option "-a <capability>", i=
t
>> does not free the variable auto_register_agent registering the initial
>> agent and allocates new memory for it.
>>
>> This frees the allocated memory before allocating new memory.
>> (The related commit id is 6db3470c2ea161b4b808ad1fc80dfd7e014fd359.)
>>
>> ---
>>  client/main.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/client/main.c b/client/main.c
>> index 2f269af..9b01dfb 100644
>> --- a/client/main.c
>> +++ b/client/main.c
>> @@ -2358,6 +2358,7 @@ static gboolean parse_agent(const char *key, const=
 char *value,
>>       if (!value)
>>               return FALSE;
>>
>> +     g_free(auto_register_agent);
>>       auto_register_agent =3D g_strdup(value);
>>
>>       return TRUE;
>>

Applied, thanks.

--=20
Luiz Augusto von Dentz
