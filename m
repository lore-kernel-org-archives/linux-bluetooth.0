Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDAE7372069
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 May 2026 18:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778782216; cv=none; b=aKetThXRNzjkjxUa3VaQKymwQBA5dz9LQmVkUFsis9FkrzBwand7g3YdK8SpBbkXRmEbwE0ekCjzBSHmIVE9AWLHlBL5tkt418ZchqSWe+So+/JndSqR4ffl1t7SpgTgO9F9D0lLNewFmv9BdGgxa7zG3wY5wJ0/IPMz8Zyxb5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778782216; c=relaxed/simple;
	bh=I5DU1a/8sDq7wA3o3yi6lrhVCAISGKns4nN/7sADBag=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oLYPYMN4Iduj+ekDOmUSasZVXgGnWy92FdBRQITm0WGTfxFKckiS5QbKmgU4ADf63pg3gkpGq1jj4E5DUOq5ZeWriYkShnGpzOYBGcPqmBbYM6YCOlOGtogEijlLY2P9LN9T2WTQsFUbx4bcDAudUMgEfNhvXrjmC6iI+lmU8VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=std.uestc.edu.cn; spf=pass smtp.mailfrom=std.uestc.edu.cn; dkim=fail (0-bit key) header.d=std.uestc.edu.cn header.i=@std.uestc.edu.cn header.b=2saY95A5 reason="key not found in DNS"; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=std.uestc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=std.uestc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=std.uestc.edu.cn header.i=@std.uestc.edu.cn header.b="2saY95A5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=std.uestc.edu.cn; s=dkim; h=Received:Message-ID:Date:
	MIME-Version:User-Agent:Subject:To:Cc:References:From:
	In-Reply-To:Content-Type:Content-Transfer-Encoding; bh=vk3Fqdeat
	pDPshtmaA1B5OOj8FfRicrso7wCv91SdYU=; b=2saY95A5g568kTsJC3h5XyxDJ
	JruVlDx8L77nvnaSe0EGjppKpDhDRyCMRvpMzqheZZZGXbTCJ/wT0s4VQc0hjI62
	Px/TtzcpVB+rSGjglZXBi43RAiLkcweVaFI9xWG33+tvDobKkY14+VcWio2gzsV5
	HvPoGa+rPpbh3TGw2w=
Received: from [IPV6:240c:c983:1:5c8b:7c38:24c4:d48c:e6a7] (unknown [240c:c983:1:5c8b:7c38:24c4:d48c:e6a7])
	by hzbj-edu-front-3.icoremail.net (Coremail) with SMTP id BbQMCkAmTzn8DwZqrmwWAg--.57856S3;
	Fri, 15 May 2026 02:10:06 +0800 (CST)
Message-ID: <c44ef2c6-ab81-4e29-8427-720fc625ee91@std.uestc.edu.cn>
Date: Fri, 15 May 2026 02:10:04 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: btintel: Fix insufficient skb length check in
 btintel_print_fseq_info()
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, kiran.k@intel.com, marcel@holtmann.org
References: <20260514164913.3123671-1-2022090917019@std.uestc.edu.cn>
 <CABBYNZJ+qJ4RfRz3W9Uf7Rs5kmyJfN_oqD5o8B6_eLLja8nXpg@mail.gmail.com>
From: Quan Sun <2022090917019@std.uestc.edu.cn>
In-Reply-To: <CABBYNZJ+qJ4RfRz3W9Uf7Rs5kmyJfN_oqD5o8B6_eLLja8nXpg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:BbQMCkAmTzn8DwZqrmwWAg--.57856S3
X-Coremail-Antispam: 1UD129KBjvJXoWxJF1UKF1fXryfGFWDXw4Dtwb_yoW8CFWfpF
	WUKFyjyFsrGw4UWr12qa1rtF90vw43W34rCF97Arn8uwn8CF40gF98KFyjg3Wqkrs5Ar1S
	y3WjqFnrCF1DAr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUk2b7Iv0xC_Cr1lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4
	A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x0
	82IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGw
	Av7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxAI
	w28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr
	4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxG
	rwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8Jw
	CI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2
	z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUco7KDUUUU
X-CM-SenderInfo: asqsjiyzqzilqqrzq21wgo3vxvwfhvlgxou0/

Hi,

On 2026/5/15 1:35, Luiz Augusto von Dentz wrote:
> Hi,
> 
> On Thu, May 14, 2026 at 12:49 PM Quan Sun
> <2022090917019@std.uestc.edu.cn> wrote:
>>
>> The length check at the top of btintel_print_fseq_info() verifies
>> that the skb has at least 66 bytes (sizeof(u32) * 16 + 2), but the
>> function actually consumes 74 bytes:
>>
>>    2 calls to skb_pull_data(skb, 1)  =  2 bytes
>>    18 calls to skb_pull_data(skb, 4) = 72 bytes
>>
>> When the firmware returns a packet of exactly 66 bytes, the last two
>> skb_pull_data(skb, 4) calls return NULL, which is then passed directly
>> to get_unaligned_le32(), resulting in a NULL pointer dereference.
>>
>> Fix the length check to account for all 74 bytes actually consumed:
>>    sizeof(u32) * 16 + 2  ->  sizeof(u32) * 18 + 2
>>
>> Fixes: a7ba218a44aa ("Bluetooth: btintel: Print Firmware Sequencer information")
>> Signed-off-by: Quan Sun <2022090917019@std.uestc.edu.cn>
>> ---
>>   drivers/bluetooth/btintel.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
>> index dcaaa4ca02b99..114a8beeab92d 100644
>> --- a/drivers/bluetooth/btintel.c
>> +++ b/drivers/bluetooth/btintel.c
>> @@ -3356,7 +3356,7 @@ void btintel_print_fseq_info(struct hci_dev *hdev)
>>                  return;
>>          }
>>
>> -       if (skb->len < (sizeof(u32) * 16 + 2)) {
>> +       if (skb->len < (sizeof(u32) * 18 + 2)) {
> 
> Or we stop doing this manually and the check the return of
> skb_pull_data, that way we garantee we don't use its returns without
> checking if it return NULL, which is the whole point in using
> skb_pull_data otherwise we had just used skb_pull.
> 
>>                  bt_dev_dbg(hdev, "Malformed packet of length %u received",
>>                             skb->len);
>>                  kfree_skb(skb);
>> --
>> 2.43.0
>>
> 
> 

You are right. I will refactor the function to check the return value of 
each skb_pull_data() call to make it more robust.

