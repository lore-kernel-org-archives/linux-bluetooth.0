Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4DE1B393B
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Oct 2024 15:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729007071; cv=none; b=U20STzmb8mZxriQ1ueS88E2mVnFUVIQaXG9bmU1qDY26PSdymLllpdMFcCJvMRnRyayEw0C0Rp6B1UPzCt0IL2MFAgSzZk/GcLtsLzMOz0I6gIuQedcKFuwbOtEcI7CYUgdBImgCGhF1r11Xo2ZIKebifl1Rjvw8dpKFjgUkowM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729007071; c=relaxed/simple;
	bh=ZMviXiAqX/1vRejHCZJsZfvVa1vrc6BGMbmi0/4asaQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D19Okln7Qj5x2nKG3kk461tSpPzwDpv6LjgAWq6nktzXcjSfIwk10f6LnS391mIUiFfogW8FP/ZPHeb7TPOjasdib9hb7EAP7NWQ8hhO3Ei+blRWfztXjuTSBoMQR3BYg0WHIKOi8G+XmCTmlpyj+ckrUo9SCbsnTNjXRAqmi/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IcC4MuBB; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IcC4MuBB"
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-8369b14fb91so169658539f.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Oct 2024 08:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1729007068; x=1729611868; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3Bntwg/Atv9rqd2TP5mnLWBftbDjm7MQLD0dLGG8M38=;
        b=IcC4MuBBDBUfHkmcsJjWYgckIJVM2Yyjul5BULi0GU2C/LX7lci7kyPrnztBqGNPQE
         JGnC27ZfXRqC4H2EqxBixuWBHJaBZ3UcxNq2MxoDzTjhBxQqMeujazX2s0TJiOB4oXGa
         /91FvFsCGhC4cr/butS2T6fe/3wh9/CVXXV4Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729007068; x=1729611868;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3Bntwg/Atv9rqd2TP5mnLWBftbDjm7MQLD0dLGG8M38=;
        b=UrC9rzpgharMdhqpObCd3cM65hpsbDYEgMVir8kT38BKO+1QGJDYXTvpTOknarPwQO
         +e1qdN10zVJ04eEmqFFSC3m2cJPzxYLH4zbwtMhSdgdCtmFfaZJqdKZPFkjxCYhb/ljb
         FX68zarbWNoy0rWSQN3suWMkEFPXg7/AOVCnc7ExaS1LlzPcpBpqZIevfPY5kFlo7SOy
         gN5CiBprCBJJ+bhUPM1cXdZSBR8JvH0sf8smNRb/2aSsVzn0XzHMjinI1x8pGciF3T5v
         He/wKNpgJb81MEYUnUhHNQDX45nvI4+v35ZOODeK5r+aN1jua7U/Al7xlT8tNOcxIV/a
         +Jwg==
X-Forwarded-Encrypted: i=1; AJvYcCUEzFSiXbJ3tOsiDFM5StWTgNhKRsv1TtBWUGNnnu7btoNoXRw5xmDGUc+AeWzx1Eudj40349DgvvBQQSDcJTc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSR91Efp67fFzh1YFyL4atgOhdXOEnbiAMbjzj4yCyAJy6XDaj
	bAnwqOB+du2Q2bNB+kHGDudh1/WLhI5gatNAADuLvjsS9HsRyyWqqYVsKgIzyIhqclPMO5UvYJu
	t
X-Google-Smtp-Source: AGHT+IFRGisUuDXjoDnaEkZXdXJnMpumv6OGpg87Zn/JEQr2OVhnvKMYBa0BDP1KgXedaRFG0AVMRQ==
X-Received: by 2002:a05:6602:13cf:b0:835:3884:77a3 with SMTP id ca18e2360f4ac-83a947117d5mr132679039f.13.1729007068306;
        Tue, 15 Oct 2024 08:44:28 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dbec9b24cdsm367688173.63.2024.10.15.08.44.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2024 08:44:27 -0700 (PDT)
Message-ID: <b744b13e-f226-49fa-996a-c9dca2cfe90f@linuxfoundation.org>
Date: Tue, 15 Oct 2024 09:44:27 -0600
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] Bluetooth: btintel_pcie: Remove structually
 deadcode
To: "Everest K.C." <everestkc@everestkc.com.np>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241014163001.4537-1-everestkc@everestkc.com.np>
 <31a73bb7-47ec-496c-8a65-02e331051e0e@linuxfoundation.org>
 <CAEO-vhEg_whKPkWmym99+a1Lx2kU5CcBCYrz6unKANbCbV9dHg@mail.gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <CAEO-vhEg_whKPkWmym99+a1Lx2kU5CcBCYrz6unKANbCbV9dHg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/14/24 22:52, Everest K.C. wrote:
> On Mon, Oct 14, 2024 at 6:02 PM Shuah Khan <skhan@linuxfoundation.org> wrote:
>>
>> On 10/14/24 10:30, Everest K.C. wrote:
>>> The switch case statement has a default branch. Thus, the return
>>> statement at the end of the function can never be reached.
>>> Fixing it by removing the return statement at the end of the
>>
>> Change "Fixing" to "Fix it"
> Will fix it in V2.
>>> function.
>>>
>>> This issue was reported by Coverity Scan.
>>> https://scan7.scan.coverity.com/#/project-view/51525/11354?selectedIssue=1600709
>>
>> Please include the output from the scan. People can't see this report
>> without logging in.
> The issue is no longer visible in Coverity. Though the code is still
> the same. The issue hasn't
> been fixed. Should I remove the link too ?

What's the use of including a link that don't show the problem?

>>>
>>> Fixes: 5ea625845b0f ("Bluetooth: btintel_pcie: Add handshake between driver and firmware")
>>> Signed-off-by: Everest K.C. <everestkc@everestkc.com.np>
>>> ---
>>>    drivers/bluetooth/btintel_pcie.c | 1 -
>>>    1 file changed, 1 deletion(-)
>>>
>>> diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
>>> index e4ae8c898dfd..660496e55276 100644
>>> --- a/drivers/bluetooth/btintel_pcie.c
>>> +++ b/drivers/bluetooth/btintel_pcie.c
>>> @@ -391,7 +391,6 @@ static inline char *btintel_pcie_alivectxt_state2str(u32 alive_intr_ctxt)
>>>        default:
>>>                return "unknown";
>>>        }
>>> -     return "null";
>>
>> What happens when you build your patch with -Werror?
>> Do you see any build errors?
> I compiled the intel bluetooth module without error. Will mention that
> in V2 patch too.

Okay.

>>>    }
>>>
>>>    /* This function handles the MSI-X interrupt for gp0 cause (bit 0 in
>>

thanks,
-- Shuah

