Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Re: [PATCH] core/advertising: Fix byte order for
 MGMT_OP_ADD_ADVERTISING flags
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <55AF7668.7030903@ubnt.com> <20160317080201.GA24997@t440s>
From: Andrejs Hanins <andrejs.hanins@ubnt.com>
Message-ID: <56EA8214.2040902@ubnt.com>
Date: Thu, 17 Mar 2016 12:08:20 +0200
MIME-Version: 1.0
In-Reply-To: <20160317080201.GA24997@t440s>
Content-Type: text/plain; charset=windows-1252
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On 03/17/2016 10:02 AM, Johan Hedberg wrote:
> Hi,
>
> On Wed, Jul 22, 2015, Andrejs Hanins wrote:
>> Fix byte order for MGMT_OP_ADD_ADVERTISING flags
>> ---
>>  src/advertising.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/src/advertising.c b/src/advertising.c
>> index d56b7a2..8c249d1 100644
>> --- a/src/advertising.c
>> +++ b/src/advertising.c
>> @@ -500,7 +500,7 @@ static DBusMessage *refresh_advertisement(struct advertisement *ad)
>>  		return btd_error_failed(ad->reg, "Failed");
>>  	}
>>  
>> -	cp->flags = flags;
>> +	cp->flags = htobl(flags);
>>  	cp->instance = ad->instance;
>>  	cp->adv_data_len = adv_data_len;
>>  	memcpy(cp->data, adv_data, adv_data_len);
> I'm surprised you never pinged about this forgotten patch (which I
> noticed now when cleaning up my linux-bluetooth folder). Anyway, the
> patch has been applied. Thanks.
I was hoping that subject is an immediate attention grabber :)
I'm glad it is finally applied.
>
> Johan

