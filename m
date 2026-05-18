Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6783D2AD03
	for <linux-bluetooth@vger.kernel.org>; Mon, 18 May 2026 04:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779076937; cv=none; b=W+ZEzFVrwMBgewfclqtnS0ZAQEkwRbgdn91NEdc4zy1dEs4j/CYAxbs9qYnTQ/IT8y5SR2if9+MbQEjGO6CaheDcVy4DW28jSZ+zFUB/MGDnJUjitrWW7LCxY2fkG0o+smWKAUpo3Mj7ouJcP6Kp0ivzAkv+KVJkhAOFbUKP8PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779076937; c=relaxed/simple;
	bh=FD309anZJFGvb3b1mUlkKSqrkqnrjLS401lzppMi0Hg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KHtGh7Q9hvEV/8xoI+lCq49hlUePPxhfsDCmDUvM2tOkip9mddZkfN20BqXjptlGU1pUD66WuzAOFRt3MYMhjU96TdN6Tggl748iMFf4LUHMMfe2wJceu+txwd2I2v8CFZXG2w7RCaZku4OuCTb/TUN08VSkE1H1923G5IQxziw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=std.uestc.edu.cn; spf=pass smtp.mailfrom=std.uestc.edu.cn; dkim=fail (0-bit key) header.d=std.uestc.edu.cn header.i=@std.uestc.edu.cn header.b=zpEJYU7n reason="key not found in DNS"; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=std.uestc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=std.uestc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=std.uestc.edu.cn header.i=@std.uestc.edu.cn header.b="zpEJYU7n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=std.uestc.edu.cn; s=dkim; h=Received:Message-ID:Date:
	MIME-Version:User-Agent:Subject:To:Cc:References:From:
	In-Reply-To:Content-Type:Content-Transfer-Encoding; bh=KkxpiW6iU
	aQfhcSyWB0dqtx2TvUu+G7SLOwPCZkpSq8=; b=zpEJYU7n1gKXyzFO+I3v5LTN1
	ewwGatvZJjIHUPCB0fQCJF6q2D1YTtaV4hjE41ZAnKYoDDPfOWOJ7eL/wRVeMOS8
	XlXmltTDt8DUwyEWa08YYPpJctCRQVKdKWGRp1zWbm9Uy7j6iCwK/urkZDutIURh
	Ra3mrsEEfY/pCq3r2U=
Received: from [IPV6:240c:c983:9:f75d:d073:8d85:2c9e:8984] (unknown [240c:c983:9:f75d:d073:8d85:2c9e:8984])
	by hzbj-edu-front-3.icoremail.net (Coremail) with SMTP id BbQMCkBGbzk3jwpqxEokAg--.4435S3;
	Mon, 18 May 2026 12:02:04 +0800 (CST)
Message-ID: <3fa1a0e5-7f6b-42a8-9d46-b02f4738e8fd@std.uestc.edu.cn>
Date: Mon, 18 May 2026 12:01:58 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] Bluetooth: btintel: Use skb_pull_data return for
 bounds check
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, kiran.k@intel.com,
 linux-bluetooth@vger.kernel.org
References: <20260517060142.24510-1-2022090917019@std.uestc.edu.cn>
 <e12a170f-5340-4f45-8550-127039de805a@molgen.mpg.de>
From: Quan Sun <2022090917019@std.uestc.edu.cn>
In-Reply-To: <e12a170f-5340-4f45-8550-127039de805a@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:BbQMCkBGbzk3jwpqxEokAg--.4435S3
X-Coremail-Antispam: 1UD129KBjvdXoW7GF4fAF4DCryDtF1UAF4UCFg_yoWDXrXEga
	yxZ3srGw1UGFsrAwnaka17ArZrKrWkZry8Zrs5XwsIv3sYvr1qyF4kJwnIvr1IkayxJrnr
	Can5GrnIywnrujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbs8YjsxI4VWxJwAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I
	6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
	8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0
	cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I
	8E87Iv6xkF7I0E14v26r4UJVWxJr1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8I
	j28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr
	4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCY
	1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8Jw
	C20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAF
	wI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjx
	v20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2
	jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43
	ZEXa7IU8lfO7UUUUU==
X-CM-SenderInfo: asqsjiyzqzilqqrzq21wgo3vxvwfhvlgxou0/

Dear Paul,

Thanks for your review and feedback!

> How did you find this? Manual review, or some tool?

This was found via manual code review. I noticed that skb_pull_data(skb, 
4) is actually called 18 times, meaning the function consumes 74 bytes 
in total, but the initial check only verified that skb->len was at least 
66 bytes.

> Where you able to test the new code on hardware?

Unfortunately, I wasn't able to test this on actual hardware as I don't
have access to this specific Intel Bluetooth chip. However, the fix
strictly ensures that we don't dereference a NULL pointer returned by
skb_pull_data() when the packet is shorter than expected.

> It’d be great to log more information, wouldn’t it?

That's a very good point. I'm planning to update the malformed label to 
log the remaining length, like this:

     bt_dev_dbg(hdev, "Malformed packet received, remaining len %u", 
skb->len);

Does this look good to you, or would you prefer logging some other details?

Kind regards,
Quan Sun

