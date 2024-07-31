Received: from pv50p00im-ztdg10021201.me.com (pv50p00im-ztdg10021201.me.com [17.58.6.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1656946F
	for <linux-bluetooth@vger.kernel.org>; Wed, 31 Jul 2024 01:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722389301; cv=none; b=XHmWoph73uXRG3hizJ0lo6AAKOI+hZCPL5jt0bUESHmogfJ7ahnPlPd//mbJona7zgbeF5Ut+KA1FF9ko/cpJqXWnS8RVHLWR2anM8uyIqO7EhBBbcRO0vpmkfz/LsiZIJs7BKXUbrR/98m5Akcysl1lkcxOdn5CZtrASCLi904=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722389301; c=relaxed/simple;
	bh=XoiFHRh5kSMydfHNzk7c6DRzmIVpis/amHTntELtn+A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n5VGKHUzWEKhtICjCjmR2m94+fhfzFydZPXgoUleAAtgehfU6FX6FcbCOZopKd+a3QNs3ia+36GvrX0LW48XDUp1YouUOL+ORA0M9K4iU8PanKpBL6h/UVeCnuInJzyrqOiVUPZlveGIoQ7BPvTijso2QG2Fa8LCRFcHNf+a33c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=aZg12fmQ; arc=none smtp.client-ip=17.58.6.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="aZg12fmQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1722389299;
	bh=i5UjbYgpPHBxuJklrxlOsJ228mvCOcaNaWk9wClBz/c=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	b=aZg12fmQqlMWDdQdhj2VGowJ6PayeeyBF7hLaIu79u96VeX6djTfCk5eZ7+hWvtBD
	 wOBHNH1DTq08JM3YLVLsZSzjEJOVo4LKKwtFFjDG/PeSJN7zShc+CH8TaSvbeH03TF
	 yI2suSNTPzimkPtzj9vanuaWTSlk9Robf+7bGvYj982zmfJjrc+iMQ0H/PTqNBlkRL
	 eMoyd2dJEJH+BwoUquqiHhA0zg27XwIv05yHoL/kPJFEnYXAtEjYLQ/i77Kp6/sU6C
	 ttxKjGzyt3rCNZwKxPe9NDwCHd55DFcJy2Yl49iqW4CIyLxS5us/f2tTCl3E5fW8Gm
	 K0JirLH1FwZsA==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10021201.me.com (Postfix) with ESMTPSA id 09ACB68022A;
	Wed, 31 Jul 2024 01:28:15 +0000 (UTC)
Message-ID: <3996ac6a-4b9b-4049-83e7-530eb49616de@icloud.com>
Date: Wed, 31 Jul 2024 09:28:12 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: QCA6390 broken in current kernel
To: Wren Turkal <wt@penguintechs.org>, Zijun Hu <zijun_hu@icloud.com>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc: linux-bluetooth@vger.kernel.org, regressions@lists.linux.dev,
 Paul Menzel <pmenzel@molgen.mpg.de>
References: <27e6a6c5-fb63-4219-be0b-eefa2c116e06@penguintechs.org>
 <CABBYNZ+vVFUm1Tb+BvViYMJd6XQczTYPgyO++GGbCcWrkaC4Kg@mail.gmail.com>
 <30319168-9456-49dd-be27-480b2a068fe3@penguintechs.org>
 <1a519b2f-f5cf-40b3-8223-162dc04f8ca8@penguintechs.org>
 <21645f07-da90-4441-8dbb-d999298165e9@penguintechs.org>
 <09962266-9b55-408b-8b5d-d2387c871eef@icloud.com>
 <0940abda-fe74-4009-9a83-7384bb8cf103@penguintechs.org>
 <1ff58133-7322-47fc-b3db-6fe4a697aefe@penguintechs.org>
 <7e447839-4976-4d3b-aee5-c0961637deb5@penguintechs.org>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <7e447839-4976-4d3b-aee5-c0961637deb5@penguintechs.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: aK8TWiCLMxNqUNkptQPKiZ2-SNKNmcsE
X-Proofpoint-GUID: aK8TWiCLMxNqUNkptQPKiZ2-SNKNmcsE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-30_21,2024-07-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 bulkscore=0 clxscore=1011 malwarescore=0
 phishscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2308100000 definitions=main-2407310009
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

On 2024/7/31 04:12, Wren Turkal wrote:
> Zijun,
> 
> On 7/30/24 12:48 PM, Wren Turkal wrote:
>> Zijun,
>>
>> On 7/30/24 12:26 PM, Wren Turkal wrote:
>>> On 7/29/24 9:25 AM, Zijun Hu wrote:
>>>> On 2024/7/27 03:25, Wren Turkal wrote:
>>>>> On 7/26/24 11:52 AM, Wren Turkal wrote:
>>>>>> On 7/25/24 1:47 PM, Wren Turkal wrote:
>>>>>>> On 7/25/24 1:35 PM, Luiz Augusto von Dentz wrote:
>>>>>>>> Hi Wren,
>>>>>>>>
>>>>>>>> On Thu, Jul 25, 2024 at 2:35 PM Wren Turkal <wt@penguintechs.org>
>>>>>>>> wrote:
>>>>>>>>>
>>>>>>>>> Hello BT folks,
>>>>>>>>>
>>>>>>>>> Just so y'all know, the QCA6390 bluetooth hardware appears to be
>>>>>>>>> broken
>>>>>>>>> at least since commit 720261cfc732.
>>>>>>>>>
>>>>>>>>> The KDE and Gnome bluetooth control panels appear to think
>>>>>>>>> there is no
>>>>>>>>> bluetooth hardware. Rolling back to 6.10 appear to function.
>>>>>>>>>
>>>>>>>>> I have a Dell XPS13 9310.
>>>>>>>>>
>>>>>>>>> I will attempt to capture some kernel logs in a bit.
>>>>>>>>
>>>>>>>> git show 720261cfc732
>>>>>>>> fatal: ambiguous argument '720261cfc732': unknown revision or
>>>>>>>> path not
>>>>>>>> in the working tree.
>>>>>>>
>>>>>>> I gave you the sha for the built fedora rawhide kernel package,
>>>>>>> not a
>>>>>>> mainline sha. Sorry about that. I thought it was a mainline sha.
>>>>>>> I am
>>>>>>> trying to bisect the problem. Hopefully, I can get a mainline git
>>>>>>> sha
>>>>>>> for you soon.
>>>>>>>
>>>>>>> If it helps, the build date of the kernel is 2024-07-19.
>>>>>>>
>>>>>>> Sorry about the confusion. Hope this helps track down the problem.
>>>>>>
>>>>>> I have managed to get the following commit id range for the issue:
>>>>>> 80ab5445da6235..e2f710f97f35
>>>>>
>>>>> Narrowed to 80ab5445da6235..586f14a6a182
>>>>>
>>>> i feel a little sad that QCA6390 of your machine are broken again.
>>>> i find out a doubtful point by checking recent changes.
>>>>
>>>> you maybe have a attempt for below change if you would like to do that.
>>>> https://patchwork.kernel.org/project/bluetooth/patch/20240730-
>>>> qca6390_fix-v1-1-e0340a511756@icloud.com/
>>>>
>>>> thanks
>>>>
>>>>
>>>
>>> Yeah, I am sad that my bluetooth is broken again as well. I am trying
>>> your patch now to see if it gets my hardware working. Will reply back
>>> soon.
>>>
>>> wt
>>
>> This patch does not fix the problem. The first broken commit is
>> 9a15ce685706e73154. This patch effectively reverts only one part of
>> that patch.
>>
>> FTR, I applied this patch on top of the parent commit of the first
>> broken commit. I will try it on the tip of mainline as well.
> 
> This patch doesn't appear to apply cleanly to the current tip of
> bluetooth-next/master, so I can't really go further in testing it right
> now.
> 

my aim is to known which commit cause this issue ASAP since i very care
about QCA6390, now i got it, so don't need any further actions any more.

> Also, so you know, Bartosz has said that he is aware of the regression
> and is working on it.
> 

i did not notice above info before my last reply, i did not see such
info in this discussion thread until your reply as well.

BTW, you maybe add relevant link if you are referring something from
another discussion thread.

> Zijun, you should talk the folks at qualcomm and see if there is any
> appetite for getting closer to the Linaro folks with regard to this
> stuff. You have been very eager to jump in, and I see that Bartosz and
> Luis also seem interested in fixing this. I do wonder if there a way to
> take advantage of that to build a better working relationship in this
> bluetooth space with qualcomm and the linux kernel devs.
> 

you maybe ignore that all my reply come from icloud.com, so you maybe
not associate it with qualcomm, it is the first time for icloud.com to
join BT relevant discussion. (^^)

> If qualcomm would be interested in hiring a tech person to help with
> this stuff. I am definitely interested in helping in this area.
> 
> Thanks,
> wt

