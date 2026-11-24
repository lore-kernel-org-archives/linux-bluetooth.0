Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795534855;
	b=CE+qcAf7uaRcadv2iooGmrbjJGsaWb1xz69NWhu458kaD3w2El3pyIeaDWx4zNx2H4Ok
	 nc09WwKgzRiteYKrIeqqLQhloCPgv+DhAnMlie0Yzr4xfAVPrvn21n/TJVDLxtGYPj9wT
	 vudntUVhOXZi2L+71s6EpS60CAvuLbUayJesFkiey+8HaroxLHtx/f26irJdJWhErr4at
	 WzUVZ1WkksCJzaB+a0gusFKG98TxshtnLRYW0K9ZE92+WDmz8UwVm9ZI5KuulF82K3xqf
	 Ob2tSNlZhiacjK8aPGpKgH8HeHgavGYGvMl+XwfOYRFGJ4JGsdvPRIvNHqDvWs+HftQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795534855;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ZohoMailClient;
	bh=68mthMIvUfI7bxI4fE5iQ8kHnRupALWyjA7PGWOoGPI=;
	b=zikUHzHmIX3d4bYWiqJTluQIdG35nFNBIA8io6foUQyzfKJmh5R/BlsUrEWiAq7I8C4T
	 7I6l95v2XRs3UOuQ/u0d4nhFxexNZyopPS/rii0BFLhhlHr1+jaG03aiOhy6LCe4vNBg+
	 g+ouoUN2bEO/uTXAf4IH1iu17QSevgH8UDJKVYsAlwwm5IpcYUIyyegbpLGIFbQ7FTkIC
	 9NAICPJWUNVzwe2Pw5citaaWmImuIvvyG0fMmavZT9gMqmVsM5T9ORUBQHmJ89Xn7t7xb
	 1Uqq05U4uTOOW7PawPSWV4zX4EBGreORAwNwE9mvFpjhGnnHIxanAygkhmyw4OYGZGA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=Hq3yRElD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.12
Received: from sender5-op-o12.zoho.com (sender5-op-o12.zoho.com [165.173.182.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB544606A31E
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 15:40:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB544606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=Hq3yRElD
ARC-Seal: i=1; a=rsa-sha256; t=1795534851; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Xvwu8Kn5qBWk5qalk+1Q73HxRvErCkJ9HPwRz5BhBWc1kKjesipUJraixWSdwzk3Ttj7jhwJ0jAM8jzzyf5cD7T1yUjYGUyniUYO/rs22SzN6STGUtdste16yhn3XcvqYXrtARR9iD44oG08+RDeIcBCQQnu6rVLcKCUBLixEbU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1795534851; h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=68mthMIvUfI7bxI4fE5iQ8kHnRupALWyjA7PGWOoGPI=; 
	b=fhHsPSDU+8TUMe8cEh+fupgjjVUjWFgPRufhKl+vKI6XnsmbjsqPDT/Pu9s5dtPKr7LsrP0AKJ1ACh+Z43ZAsKYStoeIk67sQq9u1WfTa3DEh5lkBVELweZTFwSAwk6Ouog00J3/0G69IIKOqWfpbPEz1RmsFBiKDqBJFGwFF/g=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=frederic.danis@collabora.com;
	dmarc=pass header.from=<frederic.danis@collabora.com>
DKIM-Signature: a=rsa-sha256; b=Hq3yRElDhEkZZHODZkd9gc8Zc3fEEhdHf7YT/wn/JydwXN/cG5ljLXpKZWrO5VEJuQQEdfJn6TovAEdKvzKJTd8B9hFlSTrwy1dbcQ+n5u1ZWUN5ea7jza3BykIW5j7NlhQCRPnWTcjuCWC53vMESxJGrlzdV1zYU/9Mcihioro=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=68mthMIvUfI7bxI4fE5iQ8kHnRupALWyjA7PGWOoGPI=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795534848991627.7874587789807;
	Tue, 24 Nov 2026 07:40:48 -0800 (PST)
Message-ID: <066a8c1e-7461-4a00-b65e-ff097e2ed41d@collabora.com>
Date: Tue, 24 Nov 2026 16:40:46 +0100
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: client/btpclient: Security Level reporting
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 linux-bluetooth@vger.kernel.org
References: <20261124100035.245953-2-frederic.danis@collabora.com>
 <6b05756c.018c0331.11d296.c08e@mx.google.com>
 <CABBYNZJRrv81NNbbD9cJ9Q2r+FGMxmxjWiVPzde+1YuCMga4aQ@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Fr=C3=A9d=C3=A9ric_Danis?= <frederic.danis@collabora.com>
In-Reply-To: <CABBYNZJRrv81NNbbD9cJ9Q2r+FGMxmxjWiVPzde+1YuCMga4aQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Hi Luiz,

On 24/11/2026 16:37, Luiz Augusto von Dentz wrote:
> Hi Frederic,
>
> On Tue, Nov 24, 2026 at 6:31 AM <bluez.test.bot@gmail.com> wrote:
>> This is automated email and please do not reply to this email!
>>
>> Dear submitter,
>>
>> Thank you for submitting the patches to the linux bluetooth mailing list.
>> This is a CI test results with your patch series:
>> PW Link:https://patchwork.kernel.org/series/1220644/
>>
>> ---Test result---
>>
>> Test Summary:
>> CheckPatch                    PASS      0.99 seconds
>> GitLint                       PASS      0.69 seconds
>> BuildEll                      PASS      15.91 seconds
>> BluezMake                     PASS      229.50 seconds
>> MakeCheck                     PASS      13.53 seconds
>> MakeDistcheck                 PASS      117.21 seconds
>> CheckValgrind                 PASS      280.36 seconds
>> CheckSmatch                   PASS      234.25 seconds
>> bluezmakeextell               PASS      75.46 seconds
>> TestFunctional                PASS      1003.52 seconds
>> IncrementalBuild              PASS      235.64 seconds
>> ScanBuild                     PASS      844.91 seconds
>>
>>
>>
>> https://github.com/bluez/bluez/pull/2896
> Copilot flagged a problem:
>
> https://github.com/bluez/bluez/pull/2896#pullrequestreview-6038693469
>
This has been fixed in version 3.

Regards,

Fred

-- 
Frédéric Danis
Senior Software Engineer

Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, United Kingdom
Registered in England & Wales, no. 5513718


