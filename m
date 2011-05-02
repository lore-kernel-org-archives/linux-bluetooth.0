Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Remove btio.c compilation warning
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: =?iso-8859-1?Q?Elvis_Pf=FCtzenreuter?= <epx@signove.com>
In-Reply-To: <20110502211537.GA17551@jh-x301>
Date: Mon, 2 May 2011 18:23:17 -0300
Cc: anderson.briglia@openbossa.org, linux-bluetooth@vger.kernel.org
Message-Id: <0074C043-DBA7-4BE3-9D9E-9CEC1FFA4096@signove.com>
References: <y> <4dbf1776.0bd9650a.1733.7e99@mx.google.com> <20110502211537.GA17551@jh-x301>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On May 2, 2011, at 6:15 PM, Johan Hedberg wrote:

> Hi Briglia,
> 
> On Mon, May 02, 2011, anderson.briglia@openbossa.org wrote:
>> This patch fixes a compilation warning regarding btio/btio.c
>> compilation.
>> ---
>> btio/btio.c |    2 +-
>> 1 files changed, 1 insertions(+), 1 deletions(-)
>> 
>> diff --git a/btio/btio.c b/btio/btio.c
>> index 6d71b90..8f166cc 100644
>> --- a/btio/btio.c
>> +++ b/btio/btio.c
>> @@ -800,7 +800,7 @@ static gboolean l2cap_get(int sock, GError **err, BtIOOption opt1,
>> 	uint8_t dev_class[3];
>> 	uint16_t handle;
>> 	socklen_t len;
>> -	gboolean flushable;
>> +	gboolean flushable = TRUE;
>> 
>> 	len = sizeof(l2o);
>> 	memset(&l2o, 0, len);
> 
> I don't get the warning with my compiler, so in addition to the already
> requested compiler logs please also mention the compiler version. Also,
> the value should default to FALSE and not TRUE.

It looks like a false alarm from gcc 4.5.2 (Ubuntu Natty), or at least I feel
like it (got it here, too). If you agree, a bug ticket could be submitted to them.