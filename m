Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B756A17C8
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Jun 2024 00:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718584990; cv=none; b=lsyhhuQUviEFvqfakVFM82AzW3weyUaeEtyhB558xSd888UJgBy+GqGBGCRNeDk9FwAOrLuqlahYLAwci4+TB5ySU72n3D34+DLYkUJ6wkPPEiGBuUAe+RkWsPFfTNnU5kjIgDV289pYAc1xS6pGAqCePw59YQjvtpr83/OJ7co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718584990; c=relaxed/simple;
	bh=zkGctBeRQTCyUj8p2IXuAdevPlTaNtiyQONt4ebwNpY=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=X0SYZeZMbV9yflHmCZwSQCUO9s4O2c564bI6cWo6ezVzc/cqj0382ng3/1hO4rsdCQmYFW8dxQTBHDjLP2d7Pup1Md6oVhwp90FirqyDckQ09kjT8oGt1XlJUHkc2FzwYSsYXLt8iHKIOU7fdgNoZlYZ9mCayRePAhvePni8aoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S7Iq1d+k; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S7Iq1d+k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718584987;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UjOFvDVRsuk8lRi4NtL+oPBr0sQPDBRzkQ1MxteMWBI=;
	b=S7Iq1d+kBWFwN9KWcB58wuSHr/4Mnk7bcvM5Pdcg4Hy+THq0FnVnNnL3/CiQuAjuwIAzOS
	FUgrhO5+F/PtdYEIQawdbrzdP8SjPXpmHXzq/aeCUbQkqHPzNQHx+ifMDaIP11yYzMCiDI
	urEgH3MAIc5V5ETK5F+Y1FOyJp44Hsk=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-505-yPaTSQVgMTmh1_t8_Vqvqg-1; Sun, 16 Jun 2024 20:43:05 -0400
X-MC-Unique: yPaTSQVgMTmh1_t8_Vqvqg-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-44054f0bc43so46034231cf.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 16 Jun 2024 17:43:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718584984; x=1719189784;
        h=content-transfer-encoding:mime-version:user-agent:date:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UjOFvDVRsuk8lRi4NtL+oPBr0sQPDBRzkQ1MxteMWBI=;
        b=WSCjx1wm9PBPSBjatKjr/JurKTn3kAKJ9jteu6tFZ6I+dKbrWKmiXpj4YvsiT9kaZp
         g1pBZKnCN3PTCdTm7HTVqFp6KepwErkx8bNqsF9f2smz/6bY1jD25DscKaC6KMuppqy3
         Hr4e9W0Jk8uoTSJp+WY4KRuZiYHUnAW4qhgbSDz/Qmr+OTzgeNJBwhz+tipJHCThNOeV
         U5XWLXqdtkp7d+iGvUF1lmn40all1GYwvX3c8mxEH5Pu4XF/N4ZlTdiID2vXiXyTESIn
         9IHYMZVLCdwdv4MON4d+kizlGoRJXbqWEMSWpOfzOq7PCXAW2LK/LAv98hKbx1z537bv
         iFzg==
X-Gm-Message-State: AOJu0YzAgw/9JhRpxPgyFGEWjyNaXKb9mcq3CA82u4yWMP7snGb9PWdr
	dh9Ks+hKvSAtHP3sKx8DY7VOPwrRJgeJyroc7lsOhQNJPjnxU8UXu+ut0GmjOgy5WuicbdnNRHS
	xaJIMUjGieRLU1ZR3zIJTx97Q3I722C87ub36PHAKGAenByexNlB/gmFw1sGDet6/Lt70bEJ3Ea
	cQKI27AMSAEYbjAZxiXVksr7iOkkOr8F0h8rgWpRdbr1IUq4CaYw==
X-Received: by 2002:a05:622a:588:b0:441:592c:e77c with SMTP id d75a77b69052e-4421687bec4mr106523531cf.24.1718584984191;
        Sun, 16 Jun 2024 17:43:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/cbf4FAol+vZk+EuUO8ez/kCzS+Dz1F1pNrctUqbksW2UFluoj/n3gar9tXpO+rhDJGdK6A==
X-Received: by 2002:a05:622a:588:b0:441:592c:e77c with SMTP id d75a77b69052e-4421687bec4mr106523421cf.24.1718584983794;
        Sun, 16 Jun 2024 17:43:03 -0700 (PDT)
Received: from starship ([2607:fea8:fc01:7b7f:6adb:55ff:feaa:b156])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-441f2ffa08dsm41202071cf.84.2024.06.16.17.43.03
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jun 2024 17:43:03 -0700 (PDT)
Message-ID: <8bfdefacc2b609b7d4fc3808f29250e197f72182.camel@redhat.com>
Subject: Suport for 33fa:0010 - BARROT Bluetooth 5.4 USB adapter
From: Maxim Levitsky <mlevitsk@redhat.com>
To: linux-bluetooth@vger.kernel.org
Date: Sun, 16 Jun 2024 20:43:02 -0400
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Hi!

Mistakenly I bought this adapter (UGREEN bluetooth 5.4 adapter).

Looks like it is not supported under Linux:

https://forums.opensuse.org/t/bluetooth-5-4-usb-stick-connected-on-a-desktop-computer-with-opensuse-15-5-with-kde-not-working/173916/31

However I see that windows uses stock drivers for this device.

What do you think is needed to make this adapter work in Linux? I didn't notice windows downloading firmware for it,
since it just started to work out of box.

Best regards,
	Maxim Levitsky



