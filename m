Return-Path: <cyrus@holtmann.org>
Message-ID: <53A01181.1050402@linux.intel.com>
Date: Tue, 17 Jun 2014 12:59:29 +0300
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
MIME-Version: 1.0
To: Szymon Janc <szymon.janc@tieto.com>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH_v2 1/4] profiles/health/hdp: Fix memory leak in SDP record
 preparati Sdp record preparation part is copied to android/health.c from
 profiles/health/hdp_utils.c. Memory leak is noticed while testing. Memory
 summay is from android daemon, but code snippet is same. It is already fixed
 in android/health.c while submitting android related patches.
References: <1402956170-18356-1-git-send-email-ravikumar.veeramally@linux.intel.com> <1402956170-18356-2-git-send-email-ravikumar.veeramally@linux.intel.com> <1478681.tbExyMG8XR@uw000953>
In-Reply-To: <1478681.tbExyMG8XR@uw000953>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On 06/17/2014 12:29 PM, Szymon Janc wrote:
> Hi Ravi,
>
> On Tuesday 17 of June 2014 01:02:47 Ravi kumar Veeramally wrote:
>> ==12515== 286 (16 direct, 270 indirect) bytes in 1 blocks are definitely lost in loss record 158 of 165
>> ==12515==    at 0x4C2AB80: malloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
>> ==12515==    by 0x44AC45: sdp_list_append (sdp.c:1743)
>> ==12515==    by 0x4398F9: register_features (health.c:381)
>> ==12515==    by 0x4091CC: queue_foreach (queue.c:219)
>> ==12515==    by 0x43A31F: bt_health_mdep_cfg_data (health.c:398)
>> ==12515==    by 0x418B50: cmd_watch_cb (ipc.c:144)
>> ==12515==    by 0x4E7FCE4: g_main_context_dispatch (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.4000.0)
>> ==12515==    by 0x4E80047: ??? (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.4000.0)
>> ==12515==    by 0x4E80309: g_main_loop_run (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.4000.0)
>> ==12515==    by 0x4044F2: main (main.c:538)
>> ---
> There is something wrong with this patch. Subject is very long. Should that be
> in commit message body?
   Oops, I will correct it.
>>   profiles/health/hdp_util.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/profiles/health/hdp_util.c b/profiles/health/hdp_util.c
>> index 58770b5..47c464e 100644
>> --- a/profiles/health/hdp_util.c
>> +++ b/profiles/health/hdp_util.c
>> @@ -652,6 +652,8 @@ static gboolean register_service_sup_features(GSList *app_list,
>>   		return FALSE;
>>   	}
>>   
>> +	sdp_list_free(sup_features, free_hdp_list);
>> +
>>   	return TRUE;
>>   }
>>   
>>
  Thanks,
  Ravi.
