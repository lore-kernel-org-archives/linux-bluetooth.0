Received: from mr85p00im-ztdg06021701.me.com (mr85p00im-ztdg06021701.me.com [17.58.23.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438051DF660
	for <linux-bluetooth@vger.kernel.org>; Fri,  2 Aug 2024 12:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722600516; cv=none; b=QYbORChkn0b/CVH88LmjE3PwRdayA2kBjfFhfdU05IX5fwxZ7uVaQRYLb2RCueUzu/desDuLs3aYhLpcMcRLVu6VZf5f6KDlDGBmcZzY5ewkvLjg6Jc/95x3aXKPQQatz6EyfbD61ZfoEFZEcgqHeLboEykSDquvmHcIfisk5aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722600516; c=relaxed/simple;
	bh=89nulqnXxNwhGOlndsgyv3bH0m3zbFfHEdrmKz4/xVI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i8XhNH99wsHzQzZFKmic2ouS0oIeGCB8wAgG6FTON0sDDXd+OwCM68lY3DJFe8fVajyRNSbMC5jihmHZf050Te9I0QBGLuGhTL9v+2S3TDtK2Heydiq+t+HhVz5gio88dujRi3bfrpa84R3y6OKcO3UCuWxyRsxayv75L/JGIK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=D2zIFqrl; arc=none smtp.client-ip=17.58.23.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="D2zIFqrl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1722600514;
	bh=ZDCmrHFtysqSllvt/pIep85MEC+dACdY7R8MN51kJpA=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	b=D2zIFqrli3F3CZA9nFE4EpTDTVsuzPwpq+EQLpL0qE7u9UZbruQfeEZzALl5N9jVh
	 qoMRv9PGkoEWKmg2UKsK22Gz/gP26Mq6G0Ropu2VpIP2ZGF2Fo0ikGktGXgw++CdBv
	 Pe/9ZJZVd+lmIJIDF9AhXhnv//blRk6YPKAfvqYc30mFLGIP7JhKEliUiLl4DC1X8a
	 RgGGsCTgG0LM8CPVVir12d2YbFH9K7KzKD0YvLMmuEixXeouQ32OP8iAVBnxLc9Mzm
	 UsBMqjX5OtMDy7kv+SRLNQNs/gZlLgan29Kn1v9veiPyZZJt+Zi3dFUDHzKkVph/R2
	 ApsHgCZ7svK4Q==
Received: from [192.168.1.26] (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-ztdg06021701.me.com (Postfix) with ESMTPSA id 3D91526334E7;
	Fri,  2 Aug 2024 12:08:31 +0000 (UTC)
Message-ID: <34b74dbf-d57d-473a-93aa-ba970f4e4b7b@icloud.com>
Date: Fri, 2 Aug 2024 20:08:25 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: QCA6390 broken in current kernel
To: Wren Turkal <wt@penguintechs.org>,
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
 <3996ac6a-4b9b-4049-83e7-530eb49616de@icloud.com>
 <9fd98bc2-d19a-4ad2-9f0a-02baae89ac08@penguintechs.org>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <9fd98bc2-d19a-4ad2-9f0a-02baae89ac08@penguintechs.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: EiLxPi1gUcE58RVUAbJOSRjMY-Wu2Hqr
X-Proofpoint-GUID: EiLxPi1gUcE58RVUAbJOSRjMY-Wu2Hqr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-02_08,2024-08-01_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 clxscore=1015 bulkscore=0 spamscore=0
 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2408020082

On 2024/8/1 15:53, Wren Turkal wrote:
> Zijun,
> 
> On 7/30/24 6:28 PM, Zijun Hu wrote:
>> On 2024/7/31 04:12, Wren Turkal wrote:
>>> Zijun,
>>>
>>> On 7/30/24 12:48 PM, Wren Turkal wrote:
>>>> Zijun,
>>>>
>>>> On 7/30/24 12:26 PM, Wren Turkal wrote:
>>>>> On 7/29/24 9:25 AM, Zijun Hu wrote:
>>>>>> On 2024/7/27 03:25, Wren Turkal wrote:
>>>>>>> On 7/26/24 11:52 AM, Wren Turkal wrote:
>>>>>>>> On 7/25/24 1:47 PM, Wren Turkal wrote:
>>>>>>>>> On 7/25/24 1:35 PM, Luiz Augusto von Dentz wrote:
>>>>>>>>>> Hi Wren,
>>>>>>>>>>
>>>>>>>>>> On Thu, Jul 25, 2024 at 2:35 PM Wren Turkal <wt@penguintechs.org>
>>>>>>>>>> wrote:
>>>>>>>>>>>
>>>>>>>>>>> Hello BT folks,
>>>>>>>>>>>
>>>>>>>>>>> Just so y'all know, the QCA6390 bluetooth hardware appears to be
>>>>>>>>>>> broken
>>>>>>>>>>> at least since commit 720261cfc732.
>>>>>>>>>>>
>>>>>>>>>>> The KDE and Gnome bluetooth control panels appear to think
>>>>>>>>>>> there is no
>>>>>>>>>>> bluetooth hardware. Rolling back to 6.10 appear to function.
>>>>>>>>>>>
>>>>>>>>>>> I have a Dell XPS13 9310.
>>>>>>>>>>>
>>>>>>>>>>> I will attempt to capture some kernel logs in a bit.
>>>>>>>>>>
>>>>>>>>>> git show 720261cfc732
>>>>>>>>>> fatal: ambiguous argument '720261cfc732': unknown revision or
>>>>>>>>>> path not
>>>>>>>>>> in the working tree.
>>>>>>>>>
>>>>>>>>> I gave you the sha for the built fedora rawhide kernel package,
>>>>>>>>> not a
>>>>>>>>> mainline sha. Sorry about that. I thought it was a mainline sha.
>>>>>>>>> I am
>>>>>>>>> trying to bisect the problem. Hopefully, I can get a mainline git
>>>>>>>>> sha
>>>>>>>>> for you soon.
>>>>>>>>>
>>>>>>>>> If it helps, the build date of the kernel is 2024-07-19.
>>>>>>>>>
>>>>>>>>> Sorry about the confusion. Hope this helps track down the problem.
>>>>>>>>
>>>>>>>> I have managed to get the following commit id range for the issue:
>>>>>>>> 80ab5445da6235..e2f710f97f35
>>>>>>>
>>>>>>> Narrowed to 80ab5445da6235..586f14a6a182
>>>>>>>
>>>>>> i feel a little sad that QCA6390 of your machine are broken again.
>>>>>> i find out a doubtful point by checking recent changes.
>>>>>>
>>>>>> you maybe have a attempt for below change if you would like to do
>>>>>> that.
>>>>>> https://patchwork.kernel.org/project/bluetooth/patch/20240730-
>>>>>> qca6390_fix-v1-1-e0340a511756@icloud.com/
>>>>>>
>>>>>> thanks
>>>>>>
>>>>>>
>>>>>
>>>>> Yeah, I am sad that my bluetooth is broken again as well. I am trying
>>>>> your patch now to see if it gets my hardware working. Will reply back
>>>>> soon.
>>>>>
>>>>> wt
>>>>
>>>> This patch does not fix the problem. The first broken commit is
>>>> 9a15ce685706e73154. This patch effectively reverts only one part of
>>>> that patch.
>>>>
>>>> FTR, I applied this patch on top of the parent commit of the first
>>>> broken commit. I will try it on the tip of mainline as well.
>>>
>>> This patch doesn't appear to apply cleanly to the current tip of
>>> bluetooth-next/master, so I can't really go further in testing it right
>>> now.
>>>
>>
>> my aim is to known which commit cause this issue ASAP since i very care
>> about QCA6390, now i got it, so don't need any further actions any more.
>>
>>> Also, so you know, Bartosz has said that he is aware of the regression
>>> and is working on it.
>>>
>>
>> i did not notice above info before my last reply, i did not see such
>> info in this discussion thread until your reply as well.
>>
>> BTW, you maybe add relevant link if you are referring something from
>> another discussion thread.
> 
> The discussion was in a another branch on this thread. I think I added
> you to the discussion there.
> 

actually, my first reply is earlier than the other branch of this thread
as shown by below link (^^).

https://lore.kernel.org/linux-bluetooth/27e6a6c5-fb63-4219-be0b-eefa2c116e06@penguintechs.org/
2024-07-25 18:34 QCA6390 broken in current kernel Wren Turkal
2024-07-25 20:35 ` Luiz Augusto von Dentz
2024-07-25 20:47   ` Wren Turkal
2024-07-26 18:52     ` Wren Turkal
2024-07-26 19:25       ` Wren Turkal
*2024-07-29 16:25         ` Zijun Hu*
2024-07-30 19:26           ` Wren Turkal
2024-07-30 19:48             ` Wren Turkal
2024-07-30 20:12               ` Wren Turkal
2024-07-31  1:28                 ` Zijun Hu
2024-08-01  7:53                   ` Wren Turkal
*2024-07-30 19:03         ` Wren Turkal*
2024-07-30 19:59           ` Bartosz Golaszewski
2024-07-30 20:05             ` Wren Turkal
2024-07-31  8:51               ` Bartosz Golaszewski
......
>>> Zijun, you should talk the folks at qualcomm and see if there is any
>>> appetite for getting closer to the Linaro folks with regard to this
>>> stuff. You have been very eager to jump in, and I see that Bartosz and
>>> Luis also seem interested in fixing this. I do wonder if there a way to
>>> take advantage of that to build a better working relationship in this
>>> bluetooth space with qualcomm and the linux kernel devs.
>>>
>>
>> you maybe ignore that all my reply come from icloud.com, so you maybe
>> not associate it with qualcomm, it is the first time for icloud.com to
>> join BT relevant discussion. (^^)
> 
> I'm sorry. I didn't realize you weren't associated with Qualcomm here.
> Apologies.
>it is all right (^^).
>>> If qualcomm would be interested in hiring a tech person to help with
>>> this stuff. I am definitely interested in helping in this area.
>>>
>>> Thanks,
>>> wt
>>
> 

