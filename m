Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <F0070FBC0FB3174D8D11444EB2D5B026457760@DNCE02.ent.ti.com>
References: <1323820654-16820-1-git-send-email-vinicius.gomes@openbossa.org>
	<1323820654-16820-4-git-send-email-vinicius.gomes@openbossa.org>
	<F0070FBC0FB3174D8D11444EB2D5B026457760@DNCE02.ent.ti.com>
Date: Wed, 14 Dec 2011 10:56:27 -0300
Message-ID: <CAE6HaMn_z7gUuQOVfM79jDAKFAHurCaWbsQKBcTWz=hGg2366g@mail.gmail.com>
Subject: Re: [PATCH BlueZ 4/5] Remove the default security level from btio
From: Vinicius Gomes <vinicius.gomes@openbossa.org>
To: "Ganir, Chen" <chen.ganir@ti.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chen,

On Wed, Dec 14, 2011 at 8:43 AM, Ganir, Chen <chen.ganir@ti.com> wrote:
> Vinicius
>
>> -----Original Message-----
>> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
>> owner@vger.kernel.org] On Behalf Of Vinicius Costa Gomes
>> Sent: Wednesday, December 14, 2011 1:58 AM
>> To: linux-bluetooth@vger.kernel.org
>> Cc: Vinicius Costa Gomes
>> Subject: [PATCH BlueZ 4/5] Remove the default security level from btio
>>
>> The default value of sec_level when setting *any* option
>> using bt_io_set() was BT_SECURITY_MEDIUM. This was causing
>> the security procedure being started in some situations that
>> it should not.
>> ---
>>  btio/btio.c |    1 -
>>  1 files changed, 0 insertions(+), 1 deletions(-)
>>
>> diff --git a/btio/btio.c b/btio/btio.c
>> index 5641a9c..c26a734 100644
>> --- a/btio/btio.c
>> +++ b/btio/btio.c
>> @@ -698,7 +698,6 @@ static gboolean parse_set_opts(struct set_opts
>> *opts, GError **err,
>>       /* Set defaults */
>>       opts->defer = DEFAULT_DEFER_TIMEOUT;
>>       opts->master = -1;
>> -     opts->sec_level = BT_IO_SEC_MEDIUM;
>
> So removing this simply sets the default security level to none ?

Yes. But this is a fix for an API bug, that if I don't want the
security level to increase to medium
when setting an option using btio, I need to specify the security
level on bt_io_set().

>
>>       opts->mode = L2CAP_MODE_BASIC;
>>       opts->flushable = -1;
>>       opts->priority = 0;
>> --
>> 1.7.8
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-
>> bluetooth" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
> Thanks,
> Chen Ganir
>


Cheers,
-- 
Vinicius
