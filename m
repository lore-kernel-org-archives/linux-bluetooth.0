Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D6147279B
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jun 2026 16:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782835704; cv=none; b=YWl6lV0JwcbggkY9QwhzBCQBz19WUhhJ+zG1z7XMg5CSLdIc9px602RyY7djmFiXCg+klU5pFyMzvt+wwsfqP65cFHBiw4pTdYmACT0LPtvhZ5R0cUqhNK9w8+gmQ+8MOLJBon7FH2F2GzniLMyKFeisSGS3RNw/zUdwIYVnyDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782835704; c=relaxed/simple;
	bh=/PtKEpSdABX28KdrGsYhS2HxJyA9oqajGS8GHGK1pGE=;
	h=Message-ID:Date:MIME-Version:To:From:Cc:Subject:Content-Type; b=X2RLKH9foAqPSKW8oUaNEAkrYP3F6ofRKXf76KU2bHa1e4MD6ifxm8JNUE+9LBVe7qbstdK5OGTVO7OV/4wOwqzGDd/DINZo+9ruFy4w1MP3fiX+QMZO3gOLeuPZummPAbFFOfqm+xqSfXvF65XguKh7DEhVXYXsIGJOCQi3Ekk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EyLeG/lb; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EyLeG/lb"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-493bc8fda98so7415365e9.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jun 2026 09:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1782835700; x=1783440500; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:cc:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4uGackNachXr9CJmce2JFDS9DD30/nGR6xPB0TsXzoY=;
        b=EyLeG/lbxPsa15KzXCfVJIopVbLooXTWj/258qQXic0BVLqHGi8BkN7hPbZ9dpfp0d
         vXVXseUYTeR+X2HlHDgTdgk9acnd9PtimvFfINqr2OFfhZtpkZwacZnWez1PcRCqHa4r
         8DrEtTo1pYRPdoStNBws2rrM3xnuYcHbNzRCGqB6PaZbLOABIASOZCsv54jwLcVqHRrK
         GGl86eJ9tiu//9nT6WFOvP9ilC1L5WO5DBCizrqKEOR53gplAFp1DDC8b5KdEpwOaLDR
         dXcxSx2joyvFDsOJl7HhetRoapQnAiC4qjNKWY4Ibsb89mKhyC3D/nN/9/gC3YxhvQ2P
         E1IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782835700; x=1783440500;
        h=content-transfer-encoding:subject:cc:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4uGackNachXr9CJmce2JFDS9DD30/nGR6xPB0TsXzoY=;
        b=XnBbP8fX7EW5N2i7cduaAtKQvdAHlZ6NXZHIZ77mxWXz/JYbwo1myL8/ucVeIL30fN
         LLDjpU1hyqgm/PhMpARfy9hAQQOXRNBgQm0FbsxIaKTgR/cyGGXkcCYbvYXmrKXIzrTS
         bu+ubB76GO4K4GuQ0vIxmbslJN/2CHcUTEBKZvrzvLS77N1INz9crzBd/IvCfAOpuKhd
         YpsYztwueDRrCrVKXAKSKBtZb97WvYJBduHV9ncRVI7VgQ8vRgzMhQBId5zFlzwIeNB1
         MlEvjKsc96HraR3FTVlq+J0buH/C6WDs6mulNcvKUXSE23F5KOvUUFuL3uE2sZY6H4Pw
         pzrQ==
X-Forwarded-Encrypted: i=1; AFNElJ91EjdMdCHOQCYZOOUXC/uhLIe66cCdYbdlO6hH192IvySq7RA/8ZPpHavbFdmL/DTu7nHNX7APBmSi7bEe3gw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfcuRPmyEuMPZVGkIz80W8dOOH4W3xyafmMNKHJFpXG/u2jcXL
	vm2jUzR+aEmBU+W3dOqXJzCFmq8gXclyMyp5qt8nvDP6xMqEWTrAJXLZbmTGwXHh6A8=
X-Gm-Gg: AfdE7cn+5bA/F3QLoSo4jVPWYaz13Q2b9r/oEOU/6dulapg9RUPsjS5T8iV/ijoMZrg
	vO/ius+jcFNc86besFi3NAyTTP6Ik9v+j1eUsNB7xB9p+E1AIROoK43vlpeuC3xhEugxMz0LP72
	FladxKH+qp2kwUgdZVYE7moYa0fWb8ryNqkLom4mHr1/QnL6YGufleP8f3Rds2Zh9R+DvKqHbY+
	OadU/YZ1nagWXHohv3otqyc8oFzhcZxu+/ihC9GdVT0hDnjf5y0Xp4J2n1r2WhcwIjfEJNOm3rL
	UH4QfsdnLILe4CPnU7j+VvbD9FtNE9iViwQehY4jEuDCYjr4aNXhoYfkFFlb2+3jFdRCo+K0egg
	IfnTk2ziuFuhww/Vg+PnZNrwqE9aJ0jLBZ7psetN6LuYjAZWvmFP0BKl53BcHtKzZn2IcqCv+Gg
	5NbO6W+DcCncoLmygUWAHO+/O8LtLMbRbIE+xfYqXllnaYaEpegxOPCw==
X-Received: by 2002:a05:600c:3b24:b0:493:b729:3a9 with SMTP id 5b1f17b1804b1-493b82bc0a8mr71097075e9.27.1782835699272;
        Tue, 30 Jun 2026 09:08:19 -0700 (PDT)
Received: from ?IPV6:2001:a61:132d:c801:c809:2b5d:889:7ff0? ([2001:a61:132d:c801:c809:2b5d:889:7ff0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47563d194bbsm8017558f8f.3.2026.06.30.09.08.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 09:08:17 -0700 (PDT)
Message-ID: <af7483bd-7ad8-4c53-9923-d88201dfb9d9@suse.com>
Date: Tue, 30 Jun 2026 18:08:17 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
From: Oliver Neukum <oneukum@suse.com>
Cc: Hyunwoo Kim <imv4bel@gmail.com>, linux-bluetooth@vger.kernel.org
Subject: locking in ab4eedb790cae ("Bluetooth: L2CAP: Fix corrupted list in
 hci_chan_del")
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I am looking at l2cap_conn_del().
00fdebbbc557a has shifted disabling
the works info_timer and id_addr_timer outside
the lock becausing they are taking the lock, but
cancelling

cancel_work_sync(&conn->pending_rx_work);

stays where it was. However, pending_rx_work is also
taking the lock since ab4eedb790cae.
Is there some deeper reason this is OK, or is that
an oversight and I should make a patch?

	Regards
		Oliver

