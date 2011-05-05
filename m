Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <EE9AF3E8-0C89-4B05-93F1-D77B46A7BAF7@signove.com>
References: <4dbf1776.0bd9650a.1733.7e99@mx.google.com>
	<20110504213936.GA22493@jh-x301>
	<BANLkTikbokOzYmnbPGcLGPVV_qJUCf3SkQ@mail.gmail.com>
	<EE9AF3E8-0C89-4B05-93F1-D77B46A7BAF7@signove.com>
Date: Thu, 5 May 2011 11:05:09 +0300
Message-ID: <BANLkTikLnb229tLvdeeWMnfqkqdSAva1bQ@mail.gmail.com>
Subject: Re: [PATCH] Remove btio.c compilation warning
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: =?ISO-8859-1?Q?Elvis_Pf=FCtzenreuter?= <epx@signove.com>
Cc: Anderson Briglia <anderson.briglia@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, May 5, 2011 at 2:23 AM, Elvis Pfützenreuter <epx@signove.com> wrote:
> On 4 May 2011, at 20:09 , Anderson Briglia wrote:
>
>> Hi Johan,
>>
>> On Wed, May 4, 2011 at 5:39 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
>>> Hi,
>>>
>>> On Mon, May 02, 2011, anderson.briglia@openbossa.org wrote:
>>>> This patch fixes a compilation warning regarding btio/btio.c
>>>> compilation.
>>>> ---
>>>>  btio/btio.c |    2 +-
>>>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>>>
>>>> diff --git a/btio/btio.c b/btio/btio.c
>>>> index 6d71b90..8f166cc 100644
>>>> --- a/btio/btio.c
>>>> +++ b/btio/btio.c
>>>> @@ -800,7 +800,7 @@ static gboolean l2cap_get(int sock, GError **err, BtIOOption opt1,
>>>>       uint8_t dev_class[3];
>>>>       uint16_t handle;
>>>>       socklen_t len;
>>>> -     gboolean flushable;
>>>> +     gboolean flushable = TRUE;
>>>>
>>>>       len = sizeof(l2o);
>>>>       memset(&l2o, 0, len);
>>>
>>> So are we going to get an updated patch for this (with the modifications
>>> that were requested)? It's quite clearly a false positive by the
>>> compiler (i.e. a compiler bug) but I still think that we should try to
>>> keep the BlueZ tree compilable with "./bootstrap-configure && make" for
>>> all major distributions.
>>
>> Elvis is going to open a bug in Ubuntu bug system regarding this false
>> positive. I believe it is worth to wait what Ubuntu developers will
>> say.

I don't see why it would be ubuntu specific, this seems to be some
kind of regression/'feature' with gcc 4.5.

-- 
Luiz Augusto von Dentz
Computer Engineer
