Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795729122;
	b=5i7dLiHRGNeIR86nI+DXHR6EKQLV1SfeucysgvxtLGPfziW9tPkKc3ca/Ltz0JaxpHp8
	 jqnRBWKjx851HzyluFKyTrIIys0Xp3slGEYv2cwxdk71YBvAvME414pkBdmceIXI1fQq7
	 EXDCMVH3GwrqjxvY157bDhlwuGYvgPJagV8CpY0DTm6MSWZUPfPB10jmxymkx2EOfzKwR
	 lQ1BIIyiJ9RgL4QzmXmh6VKljWec5QKQdilRbYmh6WONQzr3PL4Y/4vIIgj04z84Nlxek
	 K0GuDgoWmnJmxRSo4ykV+KpZfhemr+Hi12lZSWbjLPVOqwDt0N8tYJKnvfjjim4+kDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795729122;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=a2dT6q8N85zwwiyFbmcx+eIvOlpsR+TpuQR47EIRt3o=;
	b=Z6cFbg5OoPEW8D3MDnGIHq/M2hWk8o/6szYPsyDf0mLP8MyZjMPh0eUQNXYpUPMNjMpt
	 Y/IoeaZWIjy+9rH4kOTbHl5lzY3JChYulSiYzKMuAKoQxLussLScSAhvm9ft4KIu4+QLm
	 StinY8mO60KN71zZCHcGzi3kEVK52zPHEkhVCY/fiuJxbVvu/y1JFkD73nbaHbFet6SCV
	 zFyR4gRSOMyECZXdWCDmMaJus3gdLhXH3hlh/HqECEHHFO3RrPu8Zq5JYxUJIxcpIdbrI
	 npcI9TDcC4J5LYjbbpzDXqXuSWp/WMs5MWvvQLp8WcK75BvRj63O6KkHjCT4rKgLJGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Th/Ncygg";
	arc=none smtp.remote-ip=209.85.210.42
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684EA606A31C
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Nov 2026 21:38:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 684EA606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Th/Ncygg
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-862bb0a189aso3429987a34.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Nov 2026 13:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795729120; x=1796333920; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=a2dT6q8N85zwwiyFbmcx+eIvOlpsR+TpuQR47EIRt3o=;
        b=Th/Ncyggz2D2cDdtMq93qD8OoN333CFCPOVD1w5SfepITiJPbvr1tTjwIs8I7cMShH
         5qmyBrY7T7//18QBhJlRQNL0mBcFokSuHCkgmnhxikkoRxbL/nEgaaNmrO1rNQAX59H5
         0Ic9Mwi1vpIr+iu1++Ks+PRy8DS8LWbduQl/oGWlbZAB5xlXncWQ+danfNox5kV5PaoF
         2Z0KO/LPtO57hPh4l+lNnpYTODZsVE/6/gVe+SK1S5rXfWNU/UVvNeStWeqfYQxqcMlf
         xCYnKVH7sH1lbEeQBX3aBOGapjZRk1x5EHrkDwqOyWSfK0gOT+1iVLkirwAXTQaMVoBl
         2exQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795729120; x=1796333920;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=a2dT6q8N85zwwiyFbmcx+eIvOlpsR+TpuQR47EIRt3o=;
        b=z9msLfwRnWJK+Hp5kKOTptjJXfOAzCkjE69NpGB80JfZ4z9XDjrhtAVRdJR7BIpLvG
         BNAGCh/rkX7k47LEYDA4gBq3D6fg5u3gDMTeO1+QrRMvgwqMiU2JlHL4q0DUDArHIsY1
         U6Q3CdXr5OvUbgJuXNC71Kyl4f6ltMjurJf+qVH8C3kU2fAM8Z8Ii453kViDF0z1UA7W
         mdDwFOYXuz5xFMR+PS+J3Kc4XqR8I7f3arhdGAhglZD/wzlbF3EgNSzFrBb1j2o9Zxe4
         maacMq1a66DCrD1KSYtpqF8FZe7N7poAk09rlftSE8Pkc5/ikStDs0VsynfKQ0K8EMp4
         LUZw==
X-Gm-Message-State: APuU4Z8/XDjsTXxsUkHN7AeomWpF7uWQdmN2jV9BpNGP9hBQcq8h1SVX
	DDqx1amNsuHce69ERha0rSCljC+VJjjqgC0IjoO43lyz5aCR1InzQJ/CNB5PKRmB
X-Gm-Gg: AZFdTZfTtZw9kVFOw1MUGd2tTW1V/uDoXR/Ykt2OBs+iEgk2BDTYUliShxIHnoxn2UE
	8kb9BP+VSlKTWdD00NGYdr1mLqlLZmFa1U+KYr366AeII8FlROp8Vd8z/jajnpBdhQCYqXa3tKW
	sH/jXSeuOUw2e8UphsMn9D7dF3I3a1xeBMA07nQ9pENFw2saOYUkOuOYZnIWv925CVTd9FGdWhr
	Yg0casMohdOee4HU+iShMVzoubeWzs6JmU7UdVacmOYSzBPIQGzNsQPcpD7oO3rO7p8cLFgQhaX
	Mp7P8jY/ElrigXw+pW1O4tpH2MwmtvLXedJ9o10F4D6syYClySJ1/YNzX9q01968R0w6X+P8J7c
	j3Mko8WI1dzRwRMIOJJn0xPyG7iMZikhp4oJipKX0BMHFTZ01RstpAwfEj0ZwglBAv8OtG/6g98
	v2n4BQJ4rM1k+cOcDXKFuf507HPb3rEugQHkTwxDC/Gb1MjtHd8vxedV0d9FhnofYhSwI6q+bjU
	En2aW2HtUrxOfRVF4esglOBNALE2KuIFHqAkrYi4LeceNKEybTayeLHzXSKpDV2
X-Received: by 2002:a05:6808:4f28:b0:568:d1f:5824 with SMTP id 5614622812f47-57a0c6b59b2mr23547620b6e.62.1795729120119;
        Thu, 26 Nov 2026 13:38:40 -0800 (PST)
Received: from [172.17.0.2] ([52.242.219.121])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-57a34252251sm17632950b6e.6.2026.11.26.13.38.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 13:38:39 -0800 (PST)
Message-ID: <6b08a6df.a8342903.a6b10.8b16@mx.google.com>
Date: Thu, 26 Nov 2026 13:38:39 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7175093775543773491=="
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, me@michaelmcallister.org
Subject: RE: Bluetooth: qca: Power off WCN3950 safely
In-Reply-To: <179571958165.81221.3058707179497995247.wcn3950-poweroff-v4-1@michaelmcallister.org>
References: <179571958165.81221.3058707179497995247.wcn3950-poweroff-v4-1@michaelmcallister.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7175093775543773491==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/bluetooth/hci_serdev.c:470
error: drivers/bluetooth/hci_serdev.c: patch does not apply
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config set advice.mergeConflict false"

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============7175093775543773491==--
