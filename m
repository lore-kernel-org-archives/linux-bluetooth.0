Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794323886;
	b=5fuXLgtVpSytOhoEcj8QCl33jxDAc6pSuUFEelUcwLfjhh9U8X1JG7AMVYRRDHLWq1hp
	 B05IiAz5RRgAyGVuhj7u2IVSaMogQIpBxClLnjBqCJW7gTGz62SfCNa0Ha0GS6hjPTjZi
	 Mn8KOwecLINJ0v3Wm0TQGRm+tM7MoVdBC1fRu2KzZdH0TnB368SW52PeFvey6grI2fnAN
	 o2NlL1JNrVFBS9bfNrWBqU6FgrZtMghcKW+DxdCa0gyyJs9iBdJsR7VtJHWBp5eIJhwZO
	 zsJuGVlK1EV/j9UIW3/vjbCL1AJIjaTcr3kOYW7ux8EGvLK82Qnqm9Md7TM06wyyclA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794323886;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=L3kQPTS3phj7jLlQ4ZZ3/OMfYbP7U09YyoCw78CJLKw=;
	b=ky068ERZpWL9yUvEyzETitKV57jLOIVc+uM7EmvEeNc6vbjFlEM7ghLPukwN3Lk/f+aF
	 ib/fWyN0TL0hE754BKbOCPhfxaFNJmMWn9xv17vgkpJ81nq/JChX3h3LrgPVIuHpMpUu/
	 /8TR3a4iTu0QHq3epF5xGQ+8UyEvpBafPFsy30C262ShKSqs7571VuvFRkEK8HAbEog69
	 jiYEDsvP7Kkum+Pxn16c2egU7FLXuek2nWvpNifp80aXfmWNZougzSH0tPN8+yBfQdmJB
	 gUYMwB0WnbR5CkkM62Fjj2S85v1wm5U/cOFxgLQ3Bpgk6yJQQ8MGltfcH7dAKhovPEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sQ9Uryzs;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BD0606A336
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 15:18:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02BD0606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sQ9Uryzs
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-372bdb942dbso2822595eec.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 07:18:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794323885; x=1794928685; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L3kQPTS3phj7jLlQ4ZZ3/OMfYbP7U09YyoCw78CJLKw=;
        b=sQ9Uryzs12rgKDaldxuW7IKzbRnc8k4ZGPHfcD+fAMmJVqo8ujFReaZ0DaSNfcmlNn
         /gm0n7Y+V8Gy5lYvlT79PpVEdVGJxCmnqGAU6Il4pQS2n/saoMjhmJili77yJQK5xryU
         fHxfITXc1YcL6BNwr1BXGCSG3NqBmYVH8rXqXfJerB3MKceB8cDwGpTMg5dvbTB+qkCF
         6ETKwJXBXit4Gro+xyxCVlEGkxmykaRKUPz/GPOKTQbhLKWsEjHypZDCP/2urCo2/FTs
         qWvtdsjQoetF0Lwc+8Q5Pnp1Ym9fe/je4xC7ECGRZD7qEPoMWkhdRdYRDqxEwD30i0YB
         fnRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794323885; x=1794928685;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=L3kQPTS3phj7jLlQ4ZZ3/OMfYbP7U09YyoCw78CJLKw=;
        b=gas2IkW7COT/G8dccfTlFI2VlsT8Wl38R0bVwIqlLvD0Nl5KkCiX2ZQKpdUO8VEO4J
         5WFYcrUU6VTxELWJNbdy+acDDdsczX6K1YvcXtk0by37vPLcNJ+jhGFdOKP4Dt1VLrWe
         kgKtgNkVLL+TaHQ2kHJqgmHhk8FAMUyxnvTjhy5zcfKsxvr7e9s+pGp+k13BgYXxzMsV
         dL3V2VkrxsSjz6X1VmN6Tew4Z8s4lnmlSY053vcnb/tgQroANJyt0eJ2+dvaWgslXJBI
         v67v9Cv/Rx4bTfAg3G2lO4Qod18XMdaVFXrhssoz5SOuz6yqvf55t+IAAJI14m6T3RtM
         /uUQ==
X-Gm-Message-State: APuU4Z+fEcPq/URhiqBNX2MwnAuEYApHVDBokuOQEHBiM7bqJijMqFve
	jksu8+s9UdIrsQnIJnMZWpF8uqEFpiMRT3+RHApayQaKTSh2ELFkBN1oNEuV/p8/+MY=
X-Gm-Gg: AYBFou1kf6S2gYhvhxCdyDaBL4ieuXDCTNLuGanC0fYE6AlgKC+ZGYnt9ALYMULDeZl
	QzJXgEI3uazBZkHoA/N2t1n5vRjn6Dko74GxFJ07EX1src8ydsjpLdXrEObExwXdx4jC9jqfOsx
	/XhOiCjHnXydDu+1Eb/2fRcB61yhUstxY4MCebQc/yADTO9YfjuAbwFYjDta1RYzlHj/hs+bfH2
	WmRzaaTRNbKFWJ6iEPkveD+pBwHgSAMNycwIKzl8xx2fQaskjfq+NQIVjAIpD7XPnz5jB4zX045
	Xu2BggGxNLR3U5TGDBmgxEV2p+pNfZiZyddYGm6zQnhkOreNdv39HQx3DZX/OR5iUIqJFG8R8WI
	WmBHdpKXP+Nia0BXb0RpZ/d0/mgNUWoAOeS5uZ5+DotWVzupMidu8uWZq3pUm9ZUp7J39qaxBkk
	wq5Hbch02XNTR7dt4GvKgZLrVrKlnTYGfhc1MUoYAHkTrP7e1/dc8bNTtggT8NIYHxG2Sxufsu/
	i3Yh+YlVPQAn70Fn4roJTdQJqPoTp0YSkQQ4+/GjeUmQAeqrqZoW6qQ39CILQ2fobTiwZhOBlqG
	uXendwSDdN8eT0fQL4NdebftORf64WGJNzj88M+Z5nLQ1ijKV9dOzLJRU+KwnsFYn9B3iP/3VAU
	K
X-Received: by 2002:a05:693c:83d4:20b0:376:13e5:e8fe with SMTP id 5a478bee46e88-37613e5f3dbmr847588eec.3.1794323884949;
        Tue, 10 Nov 2026 07:18:04 -0800 (PST)
Received: from localhost.localdomain ([96.44.128.241])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3752060c4b6sm7932139eec.15.2026.11.10.07.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 07:18:04 -0800 (PST)
From: Weihong Guan <weihong.guan@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_sync: Use the advertising set handle, not the instance
Date: Tue, 10 Nov 2026 15:16:27 +0000
Message-ID: <20261110151627.625640-1-weihong.guan@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261023132421.1889022-1-weihong.guan@gmail.com>
References: <20261023132421.1889022-1-weihong.guan@gmail.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Luiz,

Gentle ping on this one. It still applies cleanly to bluetooth-next
(hunks offset by 10 lines), and both commands still send the instance
number as the advertising handle there, so a controller with a single
advertising set still can't start an instance that uses a random address,
or remove instance 1.

Happy to rework it if you'd rather handle the ownership of handle 0x00
differently, as noted below the cut in the patch.

Thanks,
Weihong
