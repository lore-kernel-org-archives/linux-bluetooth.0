Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152BB1494C2
	for <linux-bluetooth@vger.kernel.org>; Thu, 31 Oct 2024 10:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730370712; cv=none; b=QY4PPiVmR6deB67jcflGu8mm5EWWj+pQwIsrCy9ZQ1CHJP87rOLsIe9KAd+5UKG4h3PSYzPRtSZju4A2mFFi4XDuTZ7+uITLIbuqbAFAM+apjwmO11Y4LVkIuHCePDV6LilQKFA1mUuGwZ+MjuUqU/tIdC8zCTzl/NPmPVMuqBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730370712; c=relaxed/simple;
	bh=MAxrGkYBTB4lsgQpsbbTi320t0etIsLAZy+HTb2JCJw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hOBDJ2fxV1OwcG5d+P1AGVR7aRHufh5qTv+JUmWEc4vGCK40Vb9aGT6+gzszrIM4JpbguteuCOdcinwsDK/kVxHD//buzZ2rZa5O48g9SYgxK0Zww+ZUMa0k9RdXrz0rcyR3d9U2gDQWwnGVHg43RrJRu9YJEQybLgD4rHBXvjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eQGHXKrG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eQGHXKrG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730370708;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hH1YLckJ09rnGx5FtwuGX8PiOK1vIS/MMWnvFkTaFuk=;
	b=eQGHXKrG5mZ3B28fe0GG5hXQOHCdt6Q8tUY6C1YtxwxTFlaCDHapWotJA35PXiQNhcJqsP
	ITNOMdqaEFTjdmskMrIrPGkNOfbzdgvYPgUskme/WmNe2Q4V5dMhJ3ojowl1MgCscEXeX/
	XnYBtwei8Vorb4XO13R/HcG7VzyT0PA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-448-se8xySIcNJCis0qCIVtxyg-1; Thu, 31 Oct 2024 06:31:46 -0400
X-MC-Unique: se8xySIcNJCis0qCIVtxyg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43159c07193so6605055e9.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 31 Oct 2024 03:31:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730370705; x=1730975505;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hH1YLckJ09rnGx5FtwuGX8PiOK1vIS/MMWnvFkTaFuk=;
        b=IZNbSv/tKoH9/9Vox3eJsmP+tQcODe06Zx/exO+5FrHAKMtUs+qFvUA9FJAJvCjDr7
         y/+THoUoLmpYzh36Ra1G6/TQCsBMfDZ3m9Sxp4GMPk+9YVTRNcks+mZLKBORuvC7OnVe
         +PkQya1qyx0JQwqExxC34ahKNGS94j28qPD2n5vuRcKyxq1KNkKaCUi557U1wZatTgLJ
         A0HFyCuSikA99b/voUDLMs0vd5mfQ2AEj1iWA8ofy4JaCt3XDyRgXxiCFq1XlZbWtKpF
         qe9LIHsb7G1H1gwsQ6uRlVifXB+lHngvXrhqPopZc5/4ClBCoHtzkxgqntKd8EdmRcPh
         /J4w==
X-Gm-Message-State: AOJu0YwdoHsiXPjpYbQJS7oaePu9SNKc/bDk4MlJflKimGklKekmFi47
	670E4t23TqXff6rGaxtIZ12WDzikyTVlT8uvllbBAKAksFDY3Oofn8GoL/IwbGl6uvgSuxuo+Ob
	xYT4I1bxBJIfN5HjcIhoLkcoV1WJCUR3+HgnGuCf5uj1KKj/0oxci89D5g/dIxjVA4A==
X-Received: by 2002:a05:600c:35c2:b0:431:5533:8f0d with SMTP id 5b1f17b1804b1-4319ad26eafmr194075535e9.30.1730370705339;
        Thu, 31 Oct 2024 03:31:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRGxV0+TZbdoUeDZDodJcDv+grkJBQ1+llkypgfemEdjGygC+QAOO6D/yANc2dcoSYn5qwyg==
X-Received: by 2002:a05:600c:35c2:b0:431:5533:8f0d with SMTP id 5b1f17b1804b1-4319ad26eafmr194075165e9.30.1730370704890;
        Thu, 31 Oct 2024 03:31:44 -0700 (PDT)
Received: from [192.168.88.248] (146-241-44-112.dyn.eolo.it. [146.241.44.112])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4327d69845csm20819025e9.47.2024.10.31.03.31.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2024 03:31:44 -0700 (PDT)
Message-ID: <91ce8149-718b-4c6d-929b-65b8fc4ca933@redhat.com>
Date: Thu, 31 Oct 2024 11:31:43 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: pull request: bluetooth 2024-10-23
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, davem@davemloft.net,
 kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
References: <20241030185633.34818-1-luiz.dentz@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241030185633.34818-1-luiz.dentz@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/30/24 19:56, Luiz Augusto von Dentz wrote:
> The following changes since commit c05c62850a8f035a267151dd86ea3daf887e28b8:
> 
>   Merge tag 'wireless-2024-10-29' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless (2024-10-29 18:57:12 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2024-10-30
> 
> for you to fetch changes up to 1e67d8641813f1876a42eeb4f532487b8a7fb0a8:
> 
>   Bluetooth: hci: fix null-ptr-deref in hci_read_supported_codecs (2024-10-30 14:49:09 -0400)
> 
> ----------------------------------------------------------------
> bluetooth pull request for net:
> 
>  - hci: fix null-ptr-deref in hci_read_supported_codecs
> 
> ----------------------------------------------------------------
> Sungwoo Kim (1):
>       Bluetooth: hci: fix null-ptr-deref in hci_read_supported_codecs
> 
>  net/bluetooth/hci_sync.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)

Just to state the obvious and avoid some dumb error on my side, this is
superseded by:

https://lore.kernel.org/netdev/20241030192205.38298-1-luiz.dentz@gmail.com/

due to the bad subj here, right?

Thanks!

Paolo

