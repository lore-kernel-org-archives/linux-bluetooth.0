Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5C21DDA14
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Dec 2024 11:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734004563; cv=none; b=acDu6Q02tCDLyyXHGTVF9Yjk8qA0atpWAu64HQ8fTyOr/Wf2V3yhRg8L76UmIodZY5e0YMC4P2eQPxaw26Csh1McL6vcYaQ6d7vTIJ/2xxT9Ayk7bylSd/ImTm/MCwJbKc8Lq3hpI8zzLKYtojNJSu9nD3cMiLG1H8KNcDkquS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734004563; c=relaxed/simple;
	bh=2nF4sMbNNcAbjh6M6CI4/V5hj1XPKTswrGt6J91nTus=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rec/w/sYWNJ/bCFYZEwzaJOYaVwPTkHW90Xn0RryRDs8rnRO/Xi0+LzOFrajDFSJV0FoMJn3kb36lrb8RntE72Imao+xOPmjOxpmTutxgeDBfqe4CBilfmEVcHfC7PLaN9pPxoRO8a+WLOzo8ywfJ9J7ocXFSzOIfhljtiH6QmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QoMICHdr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QoMICHdr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734004561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3euoebI4IXSCrPQSncwT3g7j7yaCMbga1TfcWV4sQzs=;
	b=QoMICHdrrV/gwbDIOAv9fHevt7SxwbRzoBeZllMY0Iv/bZKXq2hsjXeUfwxqZNIvLtUnVl
	HlAWokDrdTEZeMbMH6hEh/iBCauE/fn+oVO3nNeWccEKRNY3mWyaH1hThb7ua5sdwc/+iZ
	la9MWFQGCBiuXToFME5WAqnOgHFDz2w=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-kQE0kSbhOAa2Yz5KWfP6nw-1; Thu, 12 Dec 2024 06:55:59 -0500
X-MC-Unique: kQE0kSbhOAa2Yz5KWfP6nw-1
X-Mimecast-MFC-AGG-ID: kQE0kSbhOAa2Yz5KWfP6nw
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-385d52591d6so313617f8f.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Dec 2024 03:55:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734004558; x=1734609358;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3euoebI4IXSCrPQSncwT3g7j7yaCMbga1TfcWV4sQzs=;
        b=SV1fK1o0AovPZpz5qPHmEyc8kZTnIDYh1zfwqVJbshsQWegwt94NvcPzVVaXK86GOq
         tF3z6qf6pjEyb2z+uetAq7fDwXgcNcny9BGhMXabZZu1ZpZrRMcgNMQ/ZUbLZwCp2qz1
         7TzHcYVJ8D8KdfwcMr6atDKv9uxE2/ZwHm+n8IBtJftCJZ94UN4fY339SJIXtrI9VGYw
         uEbD6Fpo9uDnV8UX2niZthl7XR12y54oAyPI39TRNC/771+t7md4BRcUi4hD/hhT2+NB
         IuphjXabvEHiLCQBq4zpTmF6pWimpQ2sOQbEj8NVcxX8/MxiOEWY77wSJY1lTUexQYzu
         YmBg==
X-Gm-Message-State: AOJu0Yz2BcGq0jkVjeHqcvsXjLxClqgUGchuJyMAKoxvJEpgaIm8GZ96
	S/HAFVb+e6xlVANQVqp2Dc53/vi9A0xvrv/qUkyeRR5JhdcwjgzM+gOS6MBrHn4XaO1Qe1ilmhl
	zLXuE1mLjQ6iV/R4ZNzTiNOMP2H4nq6T9G/oHPR/F/p8tOiA3M+U3Fz3bSrFLjD8aiQ==
X-Gm-Gg: ASbGncswKrKZ3Fn5ZW0tP3GsIlC8yFnycRDDCChv/dWuqYswprecSjzxxCX9MAb5VTS
	+qVu0UaaUUK0aO60APZ2HN+DPR7rBVldUTPf6X8IMoHWxMQiQbhhugXxQ7hEw1jtzfz/NbUziva
	z68MGh19MzTCP9+IOiSpPTvVMpMkZhKaPQkEReVHxP2NSDEgb9Uy546ITWNoIhf/8xjugEnE4GA
	38uk2GyD+mrwrfkZMS7Cm6hFVlkQNsG1xUMxOpyYj2Zzl5qp77fAz/r6Aueu5h8VSCym6w+iv1e
	+8VkKqU=
X-Received: by 2002:a5d:59ae:0:b0:386:4244:15c7 with SMTP id ffacd0b85a97d-387888628d6mr2044443f8f.25.1734004558329;
        Thu, 12 Dec 2024 03:55:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEcPhZnYsOjIwfm7ByMsW6dzEWzI5foPYWVqg+0x2zxmXyXth64gr4How96aoMJjPfh8zMifg==
X-Received: by 2002:a5d:59ae:0:b0:386:4244:15c7 with SMTP id ffacd0b85a97d-387888628d6mr2044432f8f.25.1734004558004;
        Thu, 12 Dec 2024 03:55:58 -0800 (PST)
Received: from [192.168.88.24] (146-241-48-67.dyn.eolo.it. [146.241.48.67])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4362559ef66sm14560265e9.25.2024.12.12.03.55.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 03:55:56 -0800 (PST)
Message-ID: <ba32a8c5-3d90-437e-a4bc-a67304230f79@redhat.com>
Date: Thu, 12 Dec 2024 12:55:55 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: pull request: bluetooth 2024-12-11
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, davem@davemloft.net,
 kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
References: <20241211172115.1816733-1-luiz.dentz@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241211172115.1816733-1-luiz.dentz@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/11/24 18:21, Luiz Augusto von Dentz wrote:
> The following changes since commit 3dd002f20098b9569f8fd7f8703f364571e2e975:
> 
>   net: renesas: rswitch: handle stop vs interrupt race (2024-12-10 19:08:00 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2024-12-11
> 
> for you to fetch changes up to 69e8a8410d7bcd3636091b5915a939b9972f99f1:
> 
>   Bluetooth: btmtk: avoid UAF in btmtk_process_coredump (2024-12-11 12:01:13 -0500)

On top of this I see a new build warning:

net/bluetooth/hci_core.c:60:1: warning: symbol 'hci_cb_list_lock' was
not declared. Should it be static?

Would you mind fixing that and re-sending? We are still on time for
tomorrow 'net' PR.

Thanks,

Paolo

