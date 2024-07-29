Received: from mr85p00im-ztdg06011101.me.com (mr85p00im-ztdg06011101.me.com [17.58.23.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56E715CD7F
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jul 2024 16:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722270320; cv=none; b=iv6pMs3kGjAHIs89qt2fbX4RpuE0LtwWfxJG4nA7682ypBcjYqXcTQfwJYfEkxNkO8+1a7fEDdOBkPqOgRWYXpjNYHE8Ezw+7C5z6V4ft7XZZUnL8nkoS+7e6FinjSM1e3burvLYyOfT4TqH5urpqTfK/p+iKt5jI2vqis4LbhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722270320; c=relaxed/simple;
	bh=r/F3iIRqf4k027XfLlRecRR4by/sm8fT3dp3ec98uJ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IbmJKLBOVaDqHdI/wa4gTtl14QR6DQsr/YGyMl6p3SnnJSMlvY0VYDig+sxg/dmjyV/4rk9MZMjCFU0gN60FqlAsiiH79wdwrKuLmTH6jgWeWacz1oushjVIgQAepAC9brseM3x8oo3m5e+4trUnlHtb4iuOP+1vrXyUSt4pD/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=aL38q4Qn; arc=none smtp.client-ip=17.58.23.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="aL38q4Qn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1722270319;
	bh=7rKJ2lXzfu2h4kyLwKXVgGR8R2Mb89gfb6wVtXvor1Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	b=aL38q4QnZZttFrpq2ywebhjODv+joRbetW9FGq4Eejjh9rHhXPUNqizH9K6mZeFku
	 tb2NhGLS0JYvB9DSw2Ut6wxKYQQJ1F7fTVQGmccn7TegVUuOYpI4wq653IqQ/2e55E
	 mxRIdCdIrWavb6t9YJn76V4VmMmpmmJcIQjr29v4kaQ+8tOI09c11iMbGbO/2rBbOq
	 Lg3/NnjNltwmuf4EsBufjLG9baBcHyNeI0xrGczjoM4/36pEXYd9slm/rzLzaNJK7Y
	 UkUAIgzEFcFnZsmz7NqpDxbfjHvgP39PhPwZLES6+skd6Zfztzi3qVgSqW/k6185JX
	 cG8ze0pqZdRGQ==
Received: from [192.168.1.26] (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-ztdg06011101.me.com (Postfix) with ESMTPSA id CD833DA049D;
	Mon, 29 Jul 2024 16:25:16 +0000 (UTC)
Message-ID: <09962266-9b55-408b-8b5d-d2387c871eef@icloud.com>
Date: Tue, 30 Jul 2024 00:25:12 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: QCA6390 broken in current kernel
To: Wren Turkal <wt@penguintechs.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, regressions@lists.linux.dev,
 Paul Menzel <pmenzel@molgen.mpg.de>
References: <27e6a6c5-fb63-4219-be0b-eefa2c116e06@penguintechs.org>
 <CABBYNZ+vVFUm1Tb+BvViYMJd6XQczTYPgyO++GGbCcWrkaC4Kg@mail.gmail.com>
 <30319168-9456-49dd-be27-480b2a068fe3@penguintechs.org>
 <1a519b2f-f5cf-40b3-8223-162dc04f8ca8@penguintechs.org>
 <21645f07-da90-4441-8dbb-d999298165e9@penguintechs.org>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <21645f07-da90-4441-8dbb-d999298165e9@penguintechs.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: XHfUFPvkbX7z9VdUdkmEWZhcK9BiUKcv
X-Proofpoint-ORIG-GUID: XHfUFPvkbX7z9VdUdkmEWZhcK9BiUKcv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-29_14,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 clxscore=1011
 phishscore=0 spamscore=0 adultscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2407290110

On 2024/7/27 03:25, Wren Turkal wrote:
> On 7/26/24 11:52 AM, Wren Turkal wrote:
>> On 7/25/24 1:47 PM, Wren Turkal wrote:
>>> On 7/25/24 1:35 PM, Luiz Augusto von Dentz wrote:
>>>> Hi Wren,
>>>>
>>>> On Thu, Jul 25, 2024 at 2:35 PM Wren Turkal <wt@penguintechs.org>
>>>> wrote:
>>>>>
>>>>> Hello BT folks,
>>>>>
>>>>> Just so y'all know, the QCA6390 bluetooth hardware appears to be
>>>>> broken
>>>>> at least since commit 720261cfc732.
>>>>>
>>>>> The KDE and Gnome bluetooth control panels appear to think there is no
>>>>> bluetooth hardware. Rolling back to 6.10 appear to function.
>>>>>
>>>>> I have a Dell XPS13 9310.
>>>>>
>>>>> I will attempt to capture some kernel logs in a bit.
>>>>
>>>> git show 720261cfc732
>>>> fatal: ambiguous argument '720261cfc732': unknown revision or path not
>>>> in the working tree.
>>>
>>> I gave you the sha for the built fedora rawhide kernel package, not a
>>> mainline sha. Sorry about that. I thought it was a mainline sha. I am
>>> trying to bisect the problem. Hopefully, I can get a mainline git sha
>>> for you soon.
>>>
>>> If it helps, the build date of the kernel is 2024-07-19.
>>>
>>> Sorry about the confusion. Hope this helps track down the problem.
>>
>> I have managed to get the following commit id range for the issue:
>> 80ab5445da6235..e2f710f97f35
> 
> Narrowed to 80ab5445da6235..586f14a6a182
> 
i feel a little sad that QCA6390 of your machine are broken again.
i find out a doubtful point by checking recent changes.

you maybe have a attempt for below change if you would like to do that.
https://patchwork.kernel.org/project/bluetooth/patch/20240730-qca6390_fix-v1-1-e0340a511756@icloud.com/

thanks


