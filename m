Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFEE43F4AF
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Sep 2026 11:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788867587; cv=none; b=kHo7F9TEJQbKE0LrH8MVOVOWmzecgjplfALKjY2qwqAckFfjjUvV10ZmxNqi2FLDy1fLiBgKNSjBvlA3Z86bhHGaH4fmlGA6VercMkKlLhJC8c5DTMHJ6SfHAAeuTXNuRrfwmsGg8CXxQZhYpr3LvjyAJlhatdtQBO8iq3yXvjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788867587; c=relaxed/simple;
	bh=Wl2bUenRqkWaT0DnjfAWf1eONXGdBV2JN+hoZfgVnEg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ZABKA0kZJXdeRG5Xb9O4i5ZZpq7Nyblu4OsySCHL9KB9cGdhKRg26X7H5XXI4W4qK8z9o6peW+EhHs37nhrnbACvBv2DgO/hAeoD/h+pMBIrG/GknElWWn4KnxP3QUeQvg7KvCx5vSQAlxTBYHf1ZcxXqTe0KWbwfWTob2z3QnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fAgG2gdB; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fAgG2gdB"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-939adff838bso129503485a.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Sep 2026 04:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788867580; x=1789472380; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Wl2bUenRqkWaT0DnjfAWf1eONXGdBV2JN+hoZfgVnEg=;
        b=fAgG2gdBB5vd7qrYtvRUv2+TJOL13l5UfHld1xejgm5sAzrRKm9lEJrAfuC7g08WRO
         TsTJN6X4VcHpqXs2kEi3iIJmg85SQKLHI2h9WbQnR7+rqKknJ35b2TKcjkWhvEktwld4
         piXtePnKSvGwDlW3Kr0AiZ65/7knAjp3Z3S6xtlWhYSYzbG1BU4vp1vJIeDnpk6sjes0
         Q6HLvul2Sj4Eefkeu58j9Um2ybD7V/rXPB5bG56IhauWaQvvNJQ4C0TmqWLY3imbmxaC
         ldUSrJmh1h0I1x7gguM1xWo781+WU/BAZYdjibX/hci5yHOpjC7AXsCWxIAtzKJp9bid
         B7oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788867580; x=1789472380;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Wl2bUenRqkWaT0DnjfAWf1eONXGdBV2JN+hoZfgVnEg=;
        b=nLOar/aDYJXUkAbWtd4wVNBECR6Lk+Vn6DOMQT1HloYP9Ce9wtirGqu8nvAkyCv+vF
         W704W+K4JW9CPZ095KUteYdArjRyqJoDVduWivM0Fo8K/iJttCZvC71epZMBrsaBn3ca
         VWWUA6RLGPQ141G7FCyjL9HPpYRykPA/JYHIYYs4RHB8R9iwvueqFvLvCE462cpVgBYh
         R3F7Fq7Zf1IHibRWPWLYN3gCzofIv65W/v+tPjaUwheGVGWX1KiH3ISzMqO04Fu2RDGH
         06OKjUxNXEzTW9Q69haLsXbJQ413VFyYD5Tr1h1Nldsi0I5Xm8IgnSbgVhNMJydoyeyq
         ZueQ==
X-Gm-Message-State: AFuF++nfY13zcrzyNKNGsEApQckzhz4kmwATLgURm6IkGyOOTSBsMoWP
	W2de9QBHBciXSWAmOVyjeR7N+VjFQ55fLMPd+l5+YTJ4nTRnO/Rt87DHXhDc5A==
X-Gm-Gg: AYBFou2Q9lt+eK+YStLLChM0m+AYplYU4N0faiA2vghWq3TlMN0iUdJQis46vvbH8Cj
	Jl9gFzxuhY0EKaN5lsHTQg4wGUuM8t6RKZEqm+OvKH8JFw+MbuvfFu/1H19T59vgGbt8PJzxqKD
	4jG7MP/TBq2HEWsfL1xxa1mUoRDBDPjO4teOM5D5LKPMqJ4T9t2tYlbaxgoroiMPb36so3ltQeY
	RjaEqB7mUNu1nm7zOR/aKFfweUjieQ3BAY+b6lFmX3XsR7YPy1e3NiM+/6aScoFw5iQ2ggfMq3u
	ZHSpFl7/eAqYIMdBoKhJ4lFePSGC6dZaLYcD8GFd1epXVAohmmjykCjKqzzUkTGJRMl0OslZSuS
	OL+XK5EiyKM2gv0m+7451ThnovN1/5/XrF5+nn0kDK4BA3orXwyIsPUIzZXiR3WNHzXh+d63h/h
	bE15NImleTdWxxMHZMrtULK2TxlkvyW0xfeHbuRvqAJoAd68iy809w1LoCYqdE9EtQU4I=
X-Received: by 2002:a05:620a:4010:b0:931:18e:8642 with SMTP id af79cd13be357-93980324520mr3092012385a.2.1788867579934;
        Tue, 08 Sep 2026 04:39:39 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.91.50])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9397f9ee9fbsm1120108785a.1.2026.09.08.04.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 04:39:39 -0700 (PDT)
Message-ID: <6a9ff3fb.27211789.12030e.e803@mx.google.com>
Date: Tue, 08 Sep 2026 04:39:39 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6752004203058343197=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zhangxuhua@kylinsec.com.cn
Subject: RE: Bluetooth: hci_bcsp: Use the shared CRC-CCITT byte helper
In-Reply-To: <D667F392AF7221D8+20260907151015.13522-1-zhangxuhua@kylinsec.com.cn>
References: <D667F392AF7221D8+20260907151015.13522-1-zhangxuhua@kylinsec.com.cn>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6752004203058343197==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----


Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============6752004203058343197==--
