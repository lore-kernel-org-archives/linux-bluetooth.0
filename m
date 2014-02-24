Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20140224065517.GB4133@aemeltch-MOBL1>
References: <1392996230-11789-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<1392996230-11789-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<20140224065517.GB4133@aemeltch-MOBL1>
Date: Mon, 24 Feb 2014 14:31:23 +0200
Message-ID: <CABBYNZLOYM_4g3SyHaOdL+PEvBMtOcMNEteWPLWvhY1zRQrc_g@mail.gmail.com>
Subject: Re: [PATCHv2 4/6] android/avrcp: Use NULL for zero pointers
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Andrei Emeltchenko <andrei.emeltchenko@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Mon, Feb 24, 2014 at 8:55 AM, Andrei Emeltchenko
<andrei.emeltchenko@gmail.com> wrote:
> On Fri, Feb 21, 2014 at 05:23:48PM +0200, Andrei Emeltchenko wrote:
>> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>
> ping
>
>>
>> ---
>>  android/avrcp.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/android/avrcp.c b/android/avrcp.c
>> index 8ac9e2f..acffd56 100644
>> --- a/android/avrcp.c
>> +++ b/android/avrcp.c
>> @@ -222,7 +222,7 @@ static sdp_record_t *avrcp_record(void)
>>       features = sdp_data_alloc(SDP_UINT16, &feat);
>>       sdp_attr_add(record, SDP_ATTR_SUPPORTED_FEATURES, features);
>>
>> -     sdp_set_info_attr(record, "AVRCP TG", 0, 0);
>> +     sdp_set_info_attr(record, "AVRCP TG", NULL, NULL);
>>
>>       sdp_data_free(psm);
>>       sdp_data_free(version);
>> --
>> 1.8.3.2

Applied, thanks.


-- 
Luiz Augusto von Dentz
