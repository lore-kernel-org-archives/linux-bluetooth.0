Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535F6271443
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 May 2026 08:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778746685; cv=none; b=q4gPRPkf/Dh9zFEr7LJ+t6clhv2NXoKH/xRsmDk1lHxVjpCodaEAwaehBb1D5DBOwbRvkTYUn1f8DsNajSsWiP8dzc7Vhxg/YjqQLxTm9TufPKGw+2ZzzhQ7hGoqXPHkfc30S2Wpy8dLR+K3xuo2gYlUSBAYl7nlCiNYtBUNCQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778746685; c=relaxed/simple;
	bh=RdkmwNTiK0xcFkKsipashTBsOb9pvPC/BthcPaycyaI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=fiae53w2rTh7Ro8NEFALlCxD4qlmrq1HF6kLJy3F7/oVe2iiqbRmZZ9I5D05/WHzq2mOnRAxxYr9wJo7FAJBJsO05+vuDQ60OdmmQspYhbNyHX059OwaYkywOznlYzhSNNB2WHOOVrbkoh1EJYgjdPXSygU+Lr8dXY8rBbLgLE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cb3/B86U; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cb3/B86U"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-50e63771d91so76526621cf.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 May 2026 01:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778746683; x=1779351483; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Tio36dJt7Nz90SfGFNaCuu5S/WegumNCCVwXZyTH3Wk=;
        b=Cb3/B86UZLxhFJeU4H+ZlrtO78tYOgP5LotCU2usfnRJ2XLQ0vygNUaau0oXVB+Ptp
         ARtF9JjwWxPZptr29Zws9PW9Z6uukyFkkduXyZn2FkASSivD6u62uqIVN7MRxFSuu9d0
         KK3pG39LaobGRI910HFaBGqYCwEB7jOQuR+sBJgreH5x0n1dXJ/Xw5xGfBNWErzCvX6k
         TEG6OpZVzJpgs+6OmGkIWWH63h4jzo1jE3WMqKOUHY8cNFDAox+Mdb6202oHf7EVtzj8
         SB4JbpgshTW1oUFUAhYoaRETneiehaET7iU/yfw/J130opMH/0WaJP7u26SXwjrkr7Sr
         I6mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778746683; x=1779351483;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tio36dJt7Nz90SfGFNaCuu5S/WegumNCCVwXZyTH3Wk=;
        b=ltUeYSwwHvDHmqXvjF3OrvCmRk1CTVgRrM1VRkU8P/ZE7U12rLOEq4jPi/lR/RaN2N
         qolf4ELdC95JDN05Bed2yBzFiiPY+a6BiHI7uJr9lWS+qKgHzu4Zn8ELb01linqKswep
         JvHIIDxxE7/NPnlTSnk4ANI9luE5h6o5mmdfnqr6O+uWmHkc7KBpMJ+RlGr2Ej4c9yYD
         YG/25h6pTEUXstzf7dhjzSRF3LN2guFYv+iiSI/9lRL1Mb0bkMVqIdgkoqB9zsQchdbO
         CUlX1koiBenB/nGIy82mXajVDO0G7Qk34KKR84n+xorrgTVIZYRtsdKdweckRm5aRqsD
         84iw==
X-Gm-Message-State: AOJu0YxOD1ApybKxXpWq69/keW3jcuDbm6Dg0Y9YG7B9BwqG8UTeTXjJ
	GtAS57faZEbelJcVpYlXzFcgR0TGETnV4W+BOGGoyMlyHP/VFjxjFa5RLbr8ow==
X-Gm-Gg: Acq92OFO5Fr5DjWOCGc5MMTuyUFl+pAG9HwoUsH+X2C0HeDDzmW6jbUtI0NwOmInIhR
	0pmHFb0YQ0teZ48i+dv02AlwiDOrCwD4iGv4zcRSesYYYeJdieFbzadaqy8fKVK9V73+Lb4wBrq
	UJHrAS7zghFc1K99Q2rQzqUzCQ3GjfzwiVXSk0ai7d6TJrLwp2DKFlxzcX1WUZXzfiWofDQTWlc
	40rkRCz7iavCRzXFe0+VkbKr2JMGbqckil4j0BWvu31VXpJ7BoZrXIecccJUTLLZOjai/JvL3BL
	Q1dMWRpgU06alMeJDD3YKOs6sE4T8jYUYlVMvqOrJ7O/7L7RrENzw/WIa6Wzy+t3SffyQzKDjgP
	fNdZSmIxudc8TGQ9ihSzk63VXewjM3/2qca5Zn/EtE79TRV7i0eR5Rf4GPubhTri+Danqza3Dim
	aTYBZ5fze4kytihAa4JQbV588F4+v5uw==
X-Received: by 2002:a05:622a:110f:b0:50f:bb54:d3d2 with SMTP id d75a77b69052e-5162f64f8c7mr94003791cf.51.1778746683088;
        Thu, 14 May 2026 01:18:03 -0700 (PDT)
Received: from [172.17.0.2] ([52.179.93.132])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8c908562f0bsm18677796d6.5.2026.05.14.01.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 01:18:02 -0700 (PDT)
Message-ID: <6a05853a.19430d44.3be2b.c8ca@mx.google.com>
Date: Thu, 14 May 2026 01:18:02 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0059379746437914842=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, winter91@foxmail.com
Subject: RE: bluetooth: btnxpuart: Fix use-after-free in probe error path
In-Reply-To: <tencent_05373BA21CEEB5195F2ECCED0C77D0C57108@qq.com>
References: <tencent_05373BA21CEEB5195F2ECCED0C77D0C57108@qq.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0059379746437914842==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1094596

---Test result---

Test Summary:
CheckPatch                    PASS      0.73 seconds
GitLint                       PASS      0.34 seconds
SubjectPrefix                 FAIL      0.13 seconds
BuildKernel                   PASS      25.79 seconds
CheckAllWarning               PASS      28.12 seconds
CheckSparse                   PASS      26.37 seconds
BuildKernel32                 PASS      25.28 seconds
TestRunnerSetup               PASS      535.46 seconds
IncrementalBuild              PASS      24.70 seconds

Details
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject


https://github.com/bluez/bluetooth-next/pull/187

---
Regards,
Linux Bluetooth


--===============0059379746437914842==--
