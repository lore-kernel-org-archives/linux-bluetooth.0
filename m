Return-Path: <cyrus@holtmann.org>
Message-ID: <4F7C2AF7.10500@tieto.com>
Date: Wed, 4 Apr 2012 13:05:27 +0200
From: Garbat Rafal <rafal.garbat@tieto.com>
MIME-Version: 1.0
To: Johan Hedberg <johan.hedberg@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] Bluetooth: Finalize discovery after discover message
 was rejected.
References: <1331314055-18669-1-git-send-email-rafal.garbat@tieto.com> <20120404102047.GA29893@x220>
In-Reply-To: <20120404102047.GA29893@x220>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan

On 04/04/2012 12:20 PM, Johan Hedberg wrote:
> Hi Rafal,
>
> On Fri, Mar 09, 2012, Rafal Garbat wrote:
>> Finalize discovery and disconnect l2cap after discover
>> message was rejected.
>> ---
>>   audio/avdtp.c |    6 ++++++
>>   1 files changed, 6 insertions(+), 0 deletions(-)
>>
>> diff --git a/audio/avdtp.c b/audio/avdtp.c
>> index cd66fd4..64e5800 100644
>> --- a/audio/avdtp.c
>> +++ b/audio/avdtp.c
>> @@ -3064,6 +3064,12 @@ static gboolean avdtp_parse_rej(struct avdtp *session,
>>   			return FALSE;
>>   		error("DISCOVER request rejected: %s (%d)",
>>   				avdtp_strerror(&err), err.err.error_code);
>> +		if (session->discov_cb) {
>> +			session->discov_cb(session, session->seps,
>> +						&err, session->user_data);
>> +			session->discov_cb = NULL;
>> +			session->used_data = NULL;
>> +		}
>>   		return TRUE;
>>   	case AVDTP_GET_CAPABILITIES:
>>   	case AVDTP_GET_ALL_CAPABILITIES:
> The patch looks ok'ish but it doesn't compile:
>
> audio/avdtp.c: In function ‘avdtp_parse_rej’:
> audio/avdtp.c:3071:11: error: ‘struct avdtp’ has no member named ‘used_data’
>
> Secondly, please use a "avdtp:" prefix for the commit message
> ("Bluetooth" is only reserved for kernel patches) and remove the '.'
> from the end of the summary line.
>
> Johan

Sorry, just a nasty typo. Will fix it and send patch once again.

Rafal
