Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148337D086
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Jun 2024 21:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718918000; cv=none; b=BI6S7xxnGDxqJS+fRFqICUssb/fcT/vqkTKWWjyNvmpEEoV5vWqBV67V0kfQYVBJ/Jf9ghHHNR/v3VID8p5ffQbPu/x6/YMioU1NM0/NtApOwIhpJNpJynLZubo6XzSe43GOkau6D4HLanJlCCj/CSYDJoSz80Do5k8UwTHlFV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718918000; c=relaxed/simple;
	bh=8ckDeIxAwnzo5kRakgUnDyZQGTgneYjyqoyhQm7BZlM=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SokufXG1UElAhcQV1lGyvpQEpDv+Oeqw4DGPuc2UKhTcilXcg7ukfSUBva1I5QIraB5QXp28DkZ6p5tcGgBpM/OI0sUqfkMaQxYNVRjrUKouHJ9ar3PrvitkbTUwXbWYMxhz9sPfHXdiBSMGUNM2vToXic+7En45gLLeNcngpy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZZv6aMpq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZZv6aMpq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718917997;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cASqOGhIIyq9NA4K7ASzMtw6E21NLw3jkPS/f6pzdOY=;
	b=ZZv6aMpqv9hmuK1S1fAMAo3fZeCKEkSm5VHeYEhLY2TQHc6eax5WhVZfEZyt+qAWYvlP4j
	IbKgqA3TjgRTE0Dj7HZXjXM9rbIh9jM8b5siIdEUnR8VLL3qgM60CZrIRYwY3Y6s4GKdPB
	jIwXyEHryUfBZ7mu4YDUK/UrQ8L+i9I=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-85-TkgPJy8pMfSdQ4Zijp9kRw-1; Thu, 20 Jun 2024 17:13:16 -0400
X-MC-Unique: TkgPJy8pMfSdQ4Zijp9kRw-1
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-25ca2237198so1674737fac.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Jun 2024 14:13:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718917995; x=1719522795;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cASqOGhIIyq9NA4K7ASzMtw6E21NLw3jkPS/f6pzdOY=;
        b=NKn87zynFighvXSSeh8XzSE0i+ustODUb2rd0oVpSPG7hipvB1Pj8iCt8JAkjDvw06
         YmvsXE31s36h/+r8MzPZQ+Pmsw4mA4xdwfrVR+0A2FKH/1aGCLLYyvDlVg+Kd+p8O3tn
         Eena9eIxwqtUl+1ZyVjmd1kDDBajJszrPmmkR1Om7YKh/OCYVynuS196tzB9rWUBMrH0
         pZdXXkxYZ7XR9hfc5oz3dYSiGpEtzxT1ucrgpiHl0ARatAv2ruB8G3h+FIljxFvz4E/N
         lqrtpFopsXkmlCSzVvuOckHPDmu7LcwrSX4siBn9xNicQqu0DKcH/i5J/jDsGtSV4G8i
         tWpQ==
X-Gm-Message-State: AOJu0YxSGXTW5f4Gc6cE0rkCzgA52Zv/xi5yZ9BrA0LRQJMKmmR+8JRD
	Et2Vg5ALT+PRl9rwv2bT5mgKlBavMIMLZD/2IIC0isE9m3tiyIyZOu+euNsP07mhP6AsrK1f1Hu
	ARaL5OniVMhhnsH/zuo7lpQ0YzUxU/UNGTtXfdnbpA/okBW8dnCBafL0GF67JtskN1wqYXcPkpl
	wL+KvQvp2jEr+uTucBkcuEw4w+RDRdLf2R651TA3uZY3WjSuyWLQ==
X-Received: by 2002:a05:6870:fba1:b0:254:cfd7:4f91 with SMTP id 586e51a60fabf-25c94e018d4mr7904453fac.45.1718917995301;
        Thu, 20 Jun 2024 14:13:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFozNsvchZL7zItAC6fhL4TY7+1tkQigSWOzls2Kn8uzWgE3C2479hbUP65dhtrOlsS3JJv1g==
X-Received: by 2002:a05:6870:fba1:b0:254:cfd7:4f91 with SMTP id 586e51a60fabf-25c94e018d4mr7904429fac.45.1718917994686;
        Thu, 20 Jun 2024 14:13:14 -0700 (PDT)
Received: from starship ([2607:fea8:fc01:7b7f:6adb:55ff:feaa:b156])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79bce89b332sm12572585a.4.2024.06.20.14.13.14
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 14:13:14 -0700 (PDT)
Message-ID: <69649c8fa57ad7609a0c5eee513a1de772794df1.camel@redhat.com>
Subject: Re: Suport for 33fa:0010 - BARROT Bluetooth 5.4 USB adapter
From: Maxim Levitsky <mlevitsk@redhat.com>
To: linux-bluetooth@vger.kernel.org
Date: Thu, 20 Jun 2024 17:13:13 -0400
In-Reply-To: <8bfdefacc2b609b7d4fc3808f29250e197f72182.camel@redhat.com>
References: <8bfdefacc2b609b7d4fc3808f29250e197f72182.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Sun, 2024-06-16 at 20:43 -0400, Maxim Levitsky wrote:
> Hi!
> 
> Mistakenly I bought this adapter (UGREEN bluetooth 5.4 adapter).
> 
> Looks like it is not supported under Linux:
> 
> https://forums.opensuse.org/t/bluetooth-5-4-usb-stick-connected-on-a-desktop-computer-with-opensuse-15-5-with-kde-not-working/173916/31
> 
> However I see that windows uses stock drivers for this device.
> 
> What do you think is needed to make this adapter work in Linux? I didn't notice windows downloading firmware for it,
> since it just started to work out of box.

Any update?

Best regards,
	Maxim Levitsky

> 
> Best regards,
> 	Maxim Levitsky
> 
> 
> 


