Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5853CE498
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Apr 2026 13:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776087699; cv=none; b=qnRcbrpJIxzWTWSQ//iwdHLgJAp4A2P0jqLgNhAFSl5nOCKsdewvwXV8J4Z/cq4DAZzU10R+LSVuav+xmQjksdrYo2OZZPCWpYt6zjlQ1qMPzl2ZpK7YJzvVWkS3RbyOOd3VvJaZbATuoH1Q5sSk5vj3ajdQvS3m6HnfTw8Rl8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776087699; c=relaxed/simple;
	bh=6J091rsAiUHEa6MeYHP2u/eIOcdWJdLOZN2c5zK3G4M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HiUi6UqyOZVr58RjET+IOJyFPEIiJoUbfi5Fhc0eOl9DCSIgZqWV99u2uT0xcvxqnA1VLsYaAIp3o+ygXOgsdMKbEVl+0czKVYFahEjTWiWmE6J9IdalMwgUa1jjpIveicd0J9+Q3oLoxxkv+z18qXNu/D2QknUZRk2SYbyqg4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eW6U5cNe; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=af4QWh/f; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eW6U5cNe";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="af4QWh/f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776087695;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JzkXPd9kyWfE50Lh59h3/IfJjaKK6mMqEemEYMCknmQ=;
	b=eW6U5cNeOoNwXU6z58oBDIT35/AdgwZfEPIzPEjlZ/JaZOLr0hlUs8wHHCXNSzCkx/z/Hd
	5Wn0J5FtyH86uoe4qUqwlSgLWcbImSYHwCfz3WaUmLtY0RdJlbZxOj6yxvk5zB7zI/86oc
	YVPptYDbhjsNeP/alZXjbgfjntzsgSE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-NUrnBUnoPNSAqfV35n09BQ-1; Mon, 13 Apr 2026 09:41:33 -0400
X-MC-Unique: NUrnBUnoPNSAqfV35n09BQ-1
X-Mimecast-MFC-AGG-ID: NUrnBUnoPNSAqfV35n09BQ_1776087692
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-43cff5bc312so3412022f8f.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Apr 2026 06:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776087692; x=1776692492; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JzkXPd9kyWfE50Lh59h3/IfJjaKK6mMqEemEYMCknmQ=;
        b=af4QWh/fQAqxIHlaHxSdH8oozlLXgL9HJos6x1JARUv8vY/5q5+nNIYNKqLA2ihGJ3
         pKxAxjmgzTVoqSHfrU3PrimB875GtN7SFviT+AuLomu9SI73YTvNxcTvd/5KIzCKr4ss
         haSQHHhoJ4JyQZ6JLZdtkKrpbYoN3826khMvfhIhBs+P5MepnEJeCNQh4SJfmiaUhT6l
         J0noR5pgqOkkkt1t4VNNAfJpT/yDnA/ubfm9UCkdf6lOUeGuWhCQc44tLmO7CLmpuSjp
         bvTAfEdHMTg+usxIBQyXVR5uPwqBQBCFKCcczbgfxSHpxA9VBhKf7Wbk+5NsqW2Z1WeL
         ahpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776087692; x=1776692492;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JzkXPd9kyWfE50Lh59h3/IfJjaKK6mMqEemEYMCknmQ=;
        b=Ig01xkxtydNt1wqly5nw099iDeVlLu3cBM6oqVRLe5oRxkpHz/0+a7/2AT3pxPJMBt
         ejC/XyXAuKQ3KFontCJ2YisIj4f7hXGp+NPYUMvv2YQZWyW//yAm2c5xf8uH1E3hDC6K
         TsnsUO9PkWBXGv/jy2UHETIy9CK+YmL8Y61o6eHZ5rIatKKgib0v30m7K8/iKjI4KcQy
         AFet08eDy3SI56LR7bYlWujh3fKSgEVzyCkV1Mv288u+CKzoFKCRFhlzgS02OWCpc2kZ
         451pBVqH2GtsCX5F6OUl0NaaB27Sa9GQGmSeFNCEy7xBCrwRWnD2Qt5ac4yQ0/UxMLCe
         rxKw==
X-Gm-Message-State: AOJu0Yyroy24+tMVemxwLb1HJV6sA3RC4jkp9LwqPiWYBu+CA6ycwk8g
	2Wxd/SsTFRAvIAjtZsKmdGVeKx/WMxQpW3wIxF9/aTxJyIJEe2my/5DMbcRPeMTPEnWR6Bo0dti
	gxL8TSZd73/jyrAQw121gNbNzO1AhMMcXjcP7tcoRUkixRL5xKyjsZgBw2SJa2XIkM5xI0w==
X-Gm-Gg: AeBDievyPF5kp3gxacMHRlumnbilY5z/q/2/GKyxjLHccYYMI3aJV8ktnRM/kcyWxfg
	iPKqgkxTdz9GMCZ26BHCwxrqWqCX9jZAXc/MvUibj60hNQGe3+WtuAlATstNOtEGv4n5tLEhzx3
	xXQxa5Xynu0lRQAt5tYlyCNvewnsdx/xC5HvWLnibISEBJBswipfSqgis2aTAPh5ybLKEm39zcJ
	iwvHR3exun1xfPbx7T+3+knzlV3VZcxC8giucH0hFhcpSIA0kz1PcVPkLn5ApVpjyOKTDT1yh3t
	32RC/mZgb4qqllpXdY83b6ZoqUMDsD+1o2YIrC/vGMKgWCZf4F//AFn0/DRX1TvxhWeEIHjE7NE
	dq1/01mAjwxwlgUC1dE3GHm3nJEfE/6kFWDV4X4sXrL2hefGxT9TJ+/oD
X-Received: by 2002:a05:6000:25c6:b0:43d:7cb5:43a6 with SMTP id ffacd0b85a97d-43d7cb5513amr2973313f8f.2.1776087692290;
        Mon, 13 Apr 2026 06:41:32 -0700 (PDT)
X-Received: by 2002:a05:6000:25c6:b0:43d:7cb5:43a6 with SMTP id ffacd0b85a97d-43d7cb5513amr2973255f8f.2.1776087691813;
        Mon, 13 Apr 2026 06:41:31 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.125])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d6f4bf2b4sm17467514f8f.20.2026.04.13.06.41.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Apr 2026 06:41:31 -0700 (PDT)
Message-ID: <580f7972-56d5-4968-9dcc-32adc31e0673@redhat.com>
Date: Mon, 13 Apr 2026 15:41:30 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] bluetooth-next 2026-04-13
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, davem@davemloft.net,
 kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
References: <20260413132247.320961-1-luiz.dentz@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260413132247.320961-1-luiz.dentz@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/13/26 3:22 PM, Luiz Augusto von Dentz wrote:
> The following changes since commit 42f9b4c6ef19e71d2c7d9bfd3c5037d4fe434ad7:
> 
>   tools: ynl: tests: fix leading space on Makefile target (2026-04-09 20:41:40 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git tags/for-net-next-2026-04-13
> 
> for you to fetch changes up to c347ca17d62a32c25564fee0ca3a2a7bc2d5fd6f:
> 
>   Bluetooth: hci_qca: Fix missing wakeup during SSR memdump handling (2026-04-13 09:19:42 -0400)
> 
> ----------------------------------------------------------------
> bluetooth-next pull request for net-next:

Net-next is closed for the merge window. I guess Jakub could still
consider merging this, but unless you want it very, very badly, I hope
it can just be postponed, as the PW queue is already long.

Thanks,

/P

