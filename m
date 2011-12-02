Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20111202111827.GB15891@x220.ger.corp.intel.com>
References: <1322144076-1913-1-git-send-email-s.syam@samsung.com>
	<1322144076-1913-2-git-send-email-s.syam@samsung.com>
	<20111202111827.GB15891@x220.ger.corp.intel.com>
Date: Fri, 2 Dec 2011 12:25:37 +0100
Message-ID: <CACLukzLHz+zc=hMVf=7O+gusa5W2959U-p7kHTGWSq5fgj2fVg@mail.gmail.com>
Subject: Re: [PATCH 2/3] Remove unwanted GError* assignment to NULL
From: Santiago Carot <sancane@gmail.com>
To: Syam Sidhardhan <s.syam@samsung.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

2011/12/2 Johan Hedberg <johan.hedberg@gmail.com>:
> Hi Syam,
>
> On Thu, Nov 24, 2011, Syam Sidhardhan wrote:
>> ---
>>  health/hdp.c |    1 -
>>  1 files changed, 0 insertions(+), 1 deletions(-)
>>
>> diff --git a/health/hdp.c b/health/hdp.c
>> index d167ab0..403d4c8 100644
>> --- a/health/hdp.c
>> +++ b/health/hdp.c
>> @@ -551,7 +551,6 @@ static void hdp_get_dcpsm_cb(uint16_t dcpsm, gpointer user_data, GError *err)
>>       hdp_tmp_dc_data_unref(hdp_conn);
>>       hdp_conn->cb(hdp_chann->mdl, err, hdp_conn);
>>       g_error_free(gerr);
>> -     gerr = NULL;
>>  }
>
> Applied, however a bigger question is whether gerr is even needed in
> this function at all since it's never used after potentially being set.
>

I think it would be better get ride of it at least we can add a debug
message here if MCAP fails trying to connect the data channel.

Regards.
