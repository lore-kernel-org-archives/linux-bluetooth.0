Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20110504213936.GA22493@jh-x301>
References: <4dbf1776.0bd9650a.1733.7e99@mx.google.com> <20110504213936.GA22493@jh-x301>
From: Anderson Briglia <anderson.briglia@openbossa.org>
Date: Wed, 4 May 2011 19:09:38 -0400
Message-ID: <BANLkTikbokOzYmnbPGcLGPVV_qJUCf3SkQ@mail.gmail.com>
Subject: Re: [PATCH] Remove btio.c compilation warning
To: anderson.briglia@openbossa.org, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Wed, May 4, 2011 at 5:39 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi,
>
> On Mon, May 02, 2011, anderson.briglia@openbossa.org wrote:
>> This patch fixes a compilation warning regarding btio/btio.c
>> compilation.
>> ---
>>  btio/btio.c |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/btio/btio.c b/btio/btio.c
>> index 6d71b90..8f166cc 100644
>> --- a/btio/btio.c
>> +++ b/btio/btio.c
>> @@ -800,7 +800,7 @@ static gboolean l2cap_get(int sock, GError **err, BtIOOption opt1,
>>       uint8_t dev_class[3];
>>       uint16_t handle;
>>       socklen_t len;
>> -     gboolean flushable;
>> +     gboolean flushable = TRUE;
>>
>>       len = sizeof(l2o);
>>       memset(&l2o, 0, len);
>
> So are we going to get an updated patch for this (with the modifications
> that were requested)? It's quite clearly a false positive by the
> compiler (i.e. a compiler bug) but I still think that we should try to
> keep the BlueZ tree compilable with "./bootstrap-configure && make" for
> all major distributions.

Elvis is going to open a bug in Ubuntu bug system regarding this false
positive. I believe it is worth to wait what Ubuntu developers will
say.

Briglia
>
> Johan
>



-- 
INdT - Instituto Nokia de tecnologia
+55 2126 1122
http://techblog.briglia.net
