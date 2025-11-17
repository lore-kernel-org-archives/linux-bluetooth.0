Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF65330F7E3
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Nov 2025 11:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763377944; cv=none; b=Gdj6uu6cvn3k7zowrFro0DWPn20ByFbwCFLlKMG6phho09Tv3QlQGCYluLOkAnDY8UYfS/BpZ2Aef4RBvAgtK7BKLXsjJeu2jgTQ8Gdh3BdbxyrQv73twI8OlYiI43kg3eYli/f76m4D3Q6vd4LjpQooI0RyocONxm96zc3FDbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763377944; c=relaxed/simple;
	bh=AHLles5Jcf0F9ORDFR08zYErFm1pjc1HLOvtS88lw/g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WwGlF+GIXzOoWHkLIfBsJheHA272md+KTMBP1cpMFkzgBZHP8fFU9/AmSOh94aV/uytw5a27njEgTfAc5pDaV+G7DARlga2a4Z325en+IKDpEWGOc2Umlla0LO4JFAkFKXY30f4lswaDS/TBCI0D4l0IFmyAG6YDiQ3yX+BYqVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Y8+FhxF2; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Y8+FhxF2"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-42b32a5494dso2414272f8f.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Nov 2025 03:12:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763377940; x=1763982740; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=55OpoEHjg+k9Hwdg26LzJybhsUdEBiM20c1eLJukucw=;
        b=Y8+FhxF2uC8inIBHAQ/Dh3jHegCDnOphhvUShSKxNDe4XbnWtqaLTbkUPRIr8nlhFE
         0y4ICzILh7DZ1MCuPLCB5kCiEkozohjmdaS25nXmZ+MBCcmnWnCvoEeHNfz3br6w6kfg
         CE6ZGGLgjwmu6+lAEQ/KKwZ2lQB25qRwYIdHRHIh4ITWVZVNVVijcGG2wQLDQfwbNB/d
         G1k7OayOvuvzp/UMq65MesgmtekLWNEQ/7aBqd49SO7Ii89HgN0JFd77fF+ZdgQ0f9sp
         xL7O/KCg4pAUgjVLFTyIKs2fPGV3a9fffNnTn1rRsWCK144E2seP68IwATfhP2fSI2J7
         N6Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763377940; x=1763982740;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=55OpoEHjg+k9Hwdg26LzJybhsUdEBiM20c1eLJukucw=;
        b=c5UInCP/1Lk/tZh/062YjE9MBYJMJTciXAf8ZmHA3gIl/WE6snuWZWiggBfQFLkdrG
         jy+YZvKVHEZdNTkJ5KQ3mNFIXe2OmefUeocEZWIU/Jk+m34pbuqQNx2rCmG+PaMAZKDn
         XH7RIFjlcZGHUQBZTQ8gMSVkmimGqOhmWyuRF6vKLqTXHNK6i5KcubC+drV0WcGWyQsW
         WTxDeEFb9J9BkeKxxC/+1FtkU/KqypwSKckbxUqB5fTftupRO2VzLEXdBVYzcZy+TcCA
         5Rf70gsBDMOF/GlMOsw8xJP+1gdRPoARqf2FolkYcLHK51ANJICxrY4Gy4B1b0CjuNyy
         l82w==
X-Forwarded-Encrypted: i=1; AJvYcCU0e05NgArCQ4vW2zVxvqOV/PtK65AvfHyBIn2NP0Aq/amwJkQTo+1qB6l7vLHeWNa4zMgaGrez5v4pvzYQpy8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxWxlRA5SkQ7rEcUyFFF9WYElFgOyHICbomvlXwPMfsdjX6Bj9
	Yb/qSYSQXVaPypbfyhNbe0osEqImBkMix/JQlBk6agvwW8hk5h6n8OrtnXj5DruDSnQ=
X-Gm-Gg: ASbGncsXCy8MrGMKhbkAQ40pvRjNLH/LKjVScuVdlzc0xoGUSX5bxHweVoil+yYbQ48
	UcPYXq6iBuNUU8Lq+mBuxzVklxlSFI0HLVAb2avxAF5mcO7KsWw5F8zQWYTsOqKfTfc7namU1sd
	47VIYWhfnxXGJ8midyoVQNeoZLRt+Jlu+MWtSR0YUoBuN19AVX6q+4IGCZnOL348puzje80D/oa
	Ly4rpWCX190k0sBT6D7i87rVAHsBmokriYJ0cTnKz0l0YockGhakhQDu9ZWIyAOXFjJJ0UwdXFN
	dX++W9h4f7AaGA9lN3+Pr7hUoIR9DAeT9HllCHl3xECHcyy9y4NmYANIrCUAz9OsCMQz0IOTPBN
	enQwAZXFNVYI2W9TY7WwYpU94cbUnPRk5apQ/LcV1ai5hftTGpLR3YVoWvdwhUeu3s/YD48GhRA
	Lz0+8t4U6h9C2TyKJndgOFd3/nnTBsmrql/YTEkQoI7zg=
X-Google-Smtp-Source: AGHT+IHZ/LlWsXEth5ooIfcUswGNjCr8sU9sWvk+zsGJHYIfypICk+meeo/a9C6xJZ5mLbVHIMhM1Q==
X-Received: by 2002:a05:6000:200f:b0:42b:32f5:ad43 with SMTP id ffacd0b85a97d-42b5933afb0mr11188814f8f.17.1763377939915;
        Mon, 17 Nov 2025 03:12:19 -0800 (PST)
Received: from ?IPV6:2001:a61:135b:d501:afb9:2d58:ff29:3734? ([2001:a61:135b:d501:afb9:2d58:ff29:3734])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e7b074sm25003452f8f.7.2025.11.17.03.12.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Nov 2025 03:12:19 -0800 (PST)
Message-ID: <39c777ec-acaa-46dc-b706-5d512de2c991@suse.com>
Date: Mon, 17 Nov 2025 12:12:18 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: needless flag BTUSB_BARROT
To: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org
References: <18fefbc6-4912-45b8-a07d-173f2434e971@suse.com>
 <CAGFh02696VMHA-3D6xe2Zpi3WrD6nhAGm+211ZwaPZ7fMJ9zcw@mail.gmail.com>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <CAGFh02696VMHA-3D6xe2Zpi3WrD6nhAGm+211ZwaPZ7fMJ9zcw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

thank you for the kind explanation.

On 14.11.25 09:17, Arkadiusz Bokowy wrote:
>  > Do we really want to do that? What is the use of that flag?
> 
> I've been asked by Luiz to keep it because in the future we might need to add some quirks for Barrot. 
I see. But then should we not surpress logging a message on known
bad chips? We are cluttering logs neeedlessly.
Would you like a patch doing so?

	Regards
		Oliver

