Return-Path: <cyrus@holtmann.org>
Message-ID: <50126072.3090801@linux.intel.com>
Date: Fri, 27 Jul 2012 11:33:38 +0200
From: Frederic Danis <frederic.danis@linux.intel.com>
MIME-Version: 1.0
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v15 02/14] audio: Move telephony drivers to D-Bus interface
References: <1343292324-959-1-git-send-email-frederic.danis@linux.intel.com> <1343292324-959-3-git-send-email-frederic.danis@linux.intel.com> <CANT-zCXbpTQUd9RHJdADL7OWNwzgnn84Kyre2VvoO5eZxtrqjw@mail.gmail.com>
In-Reply-To: <CANT-zCXbpTQUd9RHJdADL7OWNwzgnn84Kyre2VvoO5eZxtrqjw@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Mikel,

On 27/07/2012 10:25, Mikel Astiz wrote:
>> -static void hfp_slc_complete(struct audio_device *dev)
>> +void headset_slc_complete(struct audio_device *dev)
>
> Just to clarify: Is this a trivial rename being squashed in the same
> patch? Or is there some reason behind?

This is used by telephony.c to inform headset.c that connection has been 
completed for HSP or HFP.

It is no more specific to HFP.

>
>>   {
>>          struct headset *hs = dev->headset;
>>          struct pending_connect *p = hs->pending;
>>
>> -       DBG("HFP Service Level Connection established");
>> +       DBG("Service Level Connection established");
>
> Same here.

idem

<snip>

>> +gboolean telephony_get_ready_state(struct btd_adapter *adapter);
>> +uint32_t telephony_get_ag_features(void);
>
> Shouldn't we start using uint16_t everywhere?
>
> If not, the D-Bus agent should also support uint32_t, right?

Those 2 functions are removed in patch 8 "audio: Move HFP/HSP AG servers 
to telephony.c".
So to avoid too many changes in headset.c I kept the previously used types.

Regards

Fred


-- 
Frederic Danis                            Open Source Technology Center
frederic.danis@intel.com                              Intel Corporation

