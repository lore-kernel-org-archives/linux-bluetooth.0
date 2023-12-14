Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="g0c3TMZc"
X-Greylist: delayed 93235 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 14 Dec 2023 02:44:13 PST
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22730BD
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 Dec 2023 02:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1702550651;
	bh=197OT/NR6dODFsg/RL2+h0idtrOmFpUUcyfHIWUZauI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=g0c3TMZcAShLGfnjcWym/1kMp8SEOshcT06X9HhOwm/y9WRsRhBH/zn/5aUnRhgK2
	 XpyJdHsSVoa/VXLdMWTH4Hngdit26ePx43eHYAWfYByc+nRle+t1FvECQxv6XnB6a9
	 05oEBSlm4qAoDDjMYBmQDAuFKhh459gSkSyjzEmiN21u7/Nt/AyYjRXhug+tzYJaT/
	 FmW7ApaFrTVPgEkeVKouc1O5WvP6kbzLpvEmFytqW32eBFVL0IfV+L1bEkqX4G2H/V
	 QRIDo3QsXzn89Z/VdLrZa9BjQS9S8/jMsEIV83H5kerFc1qSNEfJbfSWApV4l4tLV0
	 YcArdPAa8xNkw==
Received: from [100.72.96.248] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 8FA12378000B;
	Thu, 14 Dec 2023 10:44:11 +0000 (UTC)
Message-ID: <08015729-1917-4d0f-be93-a26b5bd966ed@collabora.com>
Date: Thu, 14 Dec 2023 11:44:10 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH BlueZ] hog-lib: Fix HoG discovering characteristics order
Content-Language: en-US
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
References: <20231213085011.1152912-1-frederic.danis@collabora.com>
 <CABBYNZK8u1iuHA8FRXO9HL-kbYrL8jngo=UJG71+HHXJuSNSFw@mail.gmail.com>
From: =?UTF-8?Q?Fr=C3=A9d=C3=A9ric_Danis?= <frederic.danis@collabora.com>
In-Reply-To: <CABBYNZK8u1iuHA8FRXO9HL-kbYrL8jngo=UJG71+HHXJuSNSFw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Luiz,

On 13/12/2023 18:27, Luiz Augusto von Dentz wrote:
> Hi Frédéric,
>
> On Wed, Dec 13, 2023 at 3:50 AM Frédéric Danis
> <frederic.danis@collabora.com> wrote:
>> PTS test HOGP/RH/HGRF/BV-01-I fails as inconclusive after waiting for
>> second report map read request with message 'Please send ReadRequest to
>> read Report Map characteristic with handle = 0x00E7'.
>> Handle which has already been read, as it can be seen in btmon traces.
>>
>> This commit change the recursion order to read instance characteristics
>> before recurring to next instances.
>>
>> Closes: https://github.com/bluez/bluez/issues/657
>> ---
>>   profiles/input/hog-lib.c | 12 ++++++------
>>   1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/profiles/input/hog-lib.c b/profiles/input/hog-lib.c
>> index 7ff1ede3d..db62a3c9f 100644
>> --- a/profiles/input/hog-lib.c
>> +++ b/profiles/input/hog-lib.c
>> @@ -1780,12 +1780,6 @@ bool bt_hog_attach(struct bt_hog *hog, void *gatt)
>>
>>          queue_foreach(hog->bas, (void *) bt_bas_attach, gatt);
>>
>> -       for (l = hog->instances; l; l = l->next) {
>> -               struct bt_hog *instance = l->data;
>> -
>> -               bt_hog_attach(instance, gatt);
>> -       }
>> -
>>          if (!hog->uhid_created) {
>>                  DBG("HoG discovering characteristics");
>>                  if (hog->attr)
>> @@ -1798,6 +1792,12 @@ bool bt_hog_attach(struct bt_hog *hog, void *gatt)
>>                                          char_discovered_cb, hog);
>>          }
>>
>> +       for (l = hog->instances; l; l = l->next) {
>> +               struct bt_hog *instance = l->data;
>> +
>> +               bt_hog_attach(instance, gatt);
>> +       }
>> +
>>          if (!hog->uhid_created)
>>                  return true;
> While I don't oppose this change, but this seems to be a limitation on
> the PTS side which expects a certain order of the operation which
> doesn't seem to be a requirement coming from the spec, so perhaps we
> should file an issue to PTS.

Yes, I opened an issue to PTS.
Let's see what they will reply.

Regards,

Fred

-- 

Frédéric Danis
Senior Software Engineer

Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, United Kingdom
Registered in England & Wales, no. 5513718

