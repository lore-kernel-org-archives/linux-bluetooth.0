Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E4B5D75F
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jan 2024 15:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706022029; cv=none; b=UjEdlPmJ7AqETg4+IT6m7zYc0b0iRPVZEUIf0APIwkUT4AH2WF2eAJSyZELmyQjhYeFZ+qMTn2tiGZM1pqXuW+hrssIDVJk6NmZ8esM+zJf21ckJWfvVW+i+f5MB0NZ9aFOHRBEAC+9ON0cY7zi2576xUzRuTAErqPgpwcf4kwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706022029; c=relaxed/simple;
	bh=7/e10B05hfRhOQNu8SWY+EllLe43V8FFR/nwKjyPgoY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FAyQfjTT6CvkLufHOS0aRtQ0W5dt0F5M2k4XdWXcdtD7VeuHSH3GJMfJ50cKqkCvbO18xgtvLE0WjVaMsQ91FNUh9uSIQKS+c4tmfSvXA2WsJXIlltp3laPC9d58lWI2JCHCovDtoCdAkphV3uUJKx+Wmc1gENXEUCMAy1hZB1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=kKlmQJ3G; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="kKlmQJ3G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706022026;
	bh=7/e10B05hfRhOQNu8SWY+EllLe43V8FFR/nwKjyPgoY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kKlmQJ3GMkDW+ULzjLl9eFouSnoe71beGUrHYurWjiBh0uys+gRe3utcVypeF7/+0
	 56lFpjxNvHFbo5o8vTGOFnDzDUu8Ev/oyKXPJiA1zd0dVSDbbXD4tMZNXVVSSY54eY
	 F2ioYnxfSW7JOXjzChZ+D15j3/FtKoESUq0AyP1fui8TmbENYIqVK7RON2ga3pqwdP
	 TCHCRaP7ncW55pxl/KX3hjJUiscjjonc9Si2vRu9iajskctic7lrVk9cXVYlAl/dJW
	 f6dfw1auMugtgwxgyh3g0vfza/cK+azhW3rUxaLwJTES7VfUYQCRLYZpl8kIkPGCRH
	 4fF/1LbU2PwNQ==
Received: from [100.72.96.248] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id F004637820AC;
	Tue, 23 Jan 2024 15:00:25 +0000 (UTC)
Message-ID: <741ff02f-596c-4c50-b809-d5fd39b77244@collabora.com>
Date: Tue, 23 Jan 2024 16:00:24 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH BlueZ 2/2] device: Update local and remote CSRK on
 management event
Content-Language: en-US
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
References: <20240123121519.523735-1-frederic.danis@collabora.com>
 <20240123121519.523735-2-frederic.danis@collabora.com>
 <CABBYNZKMry5Vh5Xu5t7ykoWOo8zjqjVfS+zfYk1fxDomHRpDQg@mail.gmail.com>
From: =?UTF-8?Q?Fr=C3=A9d=C3=A9ric_Danis?= <frederic.danis@collabora.com>
In-Reply-To: <CABBYNZKMry5Vh5Xu5t7ykoWOo8zjqjVfS+zfYk1fxDomHRpDQg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Luiz,

On 23/01/2024 14:53, Luiz Augusto von Dentz wrote:
> Hi Frédéric,
>
> On Tue, Jan 23, 2024 at 7:15 AM Frédéric Danis
> <frederic.danis@collabora.com> wrote:
>> The local and remote CSRK keys are only loaded from storage during start.
>>
>> Those keys should be updated on MGMT_EV_NEW_CSRK event to be able to
>> perform signed write for GAP/SEC/CSIGN/BV-02-C.
>> ---
>>   src/adapter.c |  2 ++
>>   src/device.c  | 16 ++++++++++++++++
>>   src/device.h  |  2 ++
>>   3 files changed, 20 insertions(+)
>>
>> diff --git a/src/adapter.c b/src/adapter.c
>> index 022390f0d..fb71ef83e 100644
>> --- a/src/adapter.c
>> +++ b/src/adapter.c
>> @@ -8882,6 +8882,8 @@ static void new_csrk_callback(uint16_t index, uint16_t length,
>>                  return;
>>          }
>>
>> +       device_set_csrk(device, key->val, key->type & 0x01);
>> +
>>          if (!ev->store_hint)
>>                  return;
>>
>> diff --git a/src/device.c b/src/device.c
>> index 17bcfbc49..34f64ca5b 100644
>> --- a/src/device.c
>> +++ b/src/device.c
>> @@ -1955,6 +1955,22 @@ bool btd_device_get_ltk(struct btd_device *device, uint8_t key[16],
>>          return true;
>>   }
>>
>> +void device_set_csrk(struct btd_device *device, const uint8_t val[16],
>> +                               bool remote)
>> +{
>> +       if (remote) {
>> +               g_free(device->remote_csrk);
>> +               device->remote_csrk = g_new0(struct csrk_info, 1);
>> +               memcpy(device->remote_csrk->key, val,
>> +                      sizeof(device->remote_csrk->key));
>> +       } else {
>> +               g_free(device->local_csrk);
>> +               device->local_csrk = g_new0(struct csrk_info, 1);
>> +               memcpy(device->local_csrk->key, val,
>> +                      sizeof(device->local_csrk->key));
>> +       }
>> +}
>> +
>>   static bool match_sirk(const void *data, const void *match_data)
>>   {
>>          const struct sirk_info *sirk = data;
>> diff --git a/src/device.h b/src/device.h
>> index 8bb38669d..d00c002c3 100644
>> --- a/src/device.h
>> +++ b/src/device.h
>> @@ -134,6 +134,8 @@ void device_set_ltk(struct btd_device *device, const uint8_t val[16],
>>                                  bool central, uint8_t enc_size);
>>   bool btd_device_get_ltk(struct btd_device *device, uint8_t val[16],
>>                                  bool *central, uint8_t *enc_size);
>> +void device_set_csrk(struct btd_device *device, const uint8_t val[16],
>> +                               bool remote);
> Looks like there is only one use of this function and it is always set
> for the remote, actually the fact that this is on the device object
> already means it is for the remote so I wonder if we really need to
> store the local as well?

As device is able to store and load both keys from storage I think it 
could be better to keep them in sync, no?

>>   bool btd_device_add_set(struct btd_device *device, bool encrypted,
>>                                  uint8_t sirk[16], uint8_t size, uint8_t rank);
>>   void device_store_svc_chng_ccc(struct btd_device *device, uint8_t bdaddr_type,
>> --
>> 2.34.1
>>
>>
>

-- 
Frédéric Danis
Senior Software Engineer

Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, United Kingdom
Registered in England & Wales, no. 5513718

