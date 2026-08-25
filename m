Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570063F327E
	for <linux-bluetooth@vger.kernel.org>; Tue, 25 Aug 2026 09:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787651589; cv=none; b=BJ5C21qJVPuLnGwIKlh8zqz/qEKEuF3HulUhcj0AW7ByQatyFiZkre042VCkBhDUmfc0XOTiyADr2VmRDpCCEojKm+EOBRT+iDAdZlbQ6KlmMlhPX5yBvpQjF/7BVk/elji4PxHOGCqT8EU8GAWlQdMrpYZBnGNpX15oRR0eNWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787651589; c=relaxed/simple;
	bh=UsFxllT2xkuxqVUzGLYvbZmztgphoXT4pSE+7IhHRdI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=cqvg4zyQLnjtPYMgMKkPvJLKBClC/8EC0STSw07EKefbJI+rA4UPi8yQDQXiQtvpubwkWWTczdtRTRGSch7ymnH+ORUDT09165BxvNjGGEdZi+3cwT34bCnh3iAngFmwC/anerghb6mce/VxY70XSW3MzMId4Ru8o36FB1l1964=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ClwtmUvv; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ClwtmUvv"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-52e1f9da948so12819951cf.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Aug 2026 02:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787651587; x=1788256387; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0DJqG8EUYDR8k/NODLA22zy5PCqpTjNAAkDkznP6Iuo=;
        b=ClwtmUvvmFR/DtDqk2MLwpAF5rYCLErRsfj0QrIHV8ZNnZel6XfYPu67KisdXuGIzZ
         eb4yK+GrqAbkOMNfZzzfro7+g+uk85gNu/3GZi5W9FSBx2apzJ3x7WfmSDhIhtj/IQuB
         QU+g4wdCPavB2sgaUIzf1F6A9gTZxyQH1NYrpT+djUs7xLdMf0SJQJoApkmrHB6TZzX4
         3EeJMqOXPs6aa7SKqsojf8aYWCL2oKCbscUf/nwc7pGXnV81EqYO3XlHbIb6qb8KVN/a
         LMnXbu7GoXFJAyUKSZiWjhkPI50LxymBuZxKPYMIkuj0uI3W8w5a17P0cyqDibKD1QHp
         4pbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787651587; x=1788256387;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0DJqG8EUYDR8k/NODLA22zy5PCqpTjNAAkDkznP6Iuo=;
        b=s4cXljQVZlsW1NreFmOpk3N2b4d5wA+UJPs7fVaZUPXd2ymqgyuZQ3TzzHWGkcm3Lz
         7P3vKGo/PUNi5z1E1tcLlXqqRFfoP0VR1tlb30B8DZ0eiPj1SSiIsclBkNOlhRj/7KwC
         cB+2MqnxyUSbwvXS5jVcVwfl2ElrR29RDGohL9hVgz9WPh2QXv366SqXp8B6CwJ4GPsS
         e64nleXF41o/RXsGEnfv47uszRlwotQTp7GLRv6u6enDMKR33IMmZxWIfvssayfBD94O
         JbrLk3BkeoVghy9kMeunnh0VY2dhBIiUNO6nl9F4HnbsRWG+J6fUhKa2gRzEYLF5c2ut
         HeqQ==
X-Gm-Message-State: AFuF++kEw/Jy5frDoVWkfff1FOpLdwRk8LFXVnjwOrFr+vryYPU7xgjP
	PVPvrpEHn80qlxnxB/JF5v/sCK7u8IbTS+/ZocO0XqeJeQVbm9FIQhs9DEYUwg==
X-Gm-Gg: AR+sD11mDFRx74SdKz75UgzLY7a3GkhRvRUH8zWMTmlmTpJds04F5unr8I8elvLVBw+
	iJYfmMiuiXwDprEceZuIVG/FeCzeb0PpyzuGQLR1c5tKy95zcw5u1/6hjKKWmx0eNwmwEl/IYu5
	mxuQwZVWueidJl4lYIC5uJ5QywTHFumxkkl+d/T85H5Cyy4nXBBubnNKgAu9r4DRCgLqtiheW0v
	fSHaVtimxPm3tJt2RyP2buI9/WO5LDN6visBIcF2t/J8oNrt9gaPQWwiY6bgT65hrBoy2f/jmsH
	9sBGo8g8vIBPKlG6hTtMHNo3ntVTAB/JQdgL3s5wvTN3n2eT2+CEX3kEYFO74vNjlj1CDlRVYLU
	RXdeSKpBOfchZ9KmXRzBH9OKsE6TE8t/a1CgprbGM7xXXvmpxNTL374eBTQ+fRcexjXOCBVRR2g
	ww42ztFE7WUpbYmEB5iybxl2Xf9oomYILilCyogqaiOPj1kBj5UT7b/2G3ADIDxX05s34WWshwS
	Z9ORf8=
X-Received: by 2002:a05:622a:148e:b0:51c:4dc:287b with SMTP id d75a77b69052e-52df56d9f79mr317506521cf.7.1787651587112;
        Tue, 25 Aug 2026 02:53:07 -0700 (PDT)
Received: from [172.17.0.2] ([135.119.235.87])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52e099c38c0sm64259401cf.13.2026.08.25.02.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 02:53:06 -0700 (PDT)
Message-ID: <6a8d6602.d1a89f1f.268970.364c@mx.google.com>
Date: Tue, 25 Aug 2026 02:53:06 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5628422857185973344=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hadess@hadess.net
Subject: RE: SECURITY: Add top-level security doc
In-Reply-To: <20260825085714.448937-2-hadess@hadess.net>
References: <20260825085714.448937-2-hadess@hadess.net>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5628422857185973344==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1151364

---Test result---

Test Summary:
CheckPatch                    PASS      0.85 seconds
GitLint                       PASS      0.64 seconds
BuildEll                      PASS      20.40 seconds
BluezMake                     PASS      572.76 seconds
MakeCheck                     PASS      19.86 seconds
MakeDistcheck                 PASS      154.00 seconds
CheckValgrind                 PASS      225.79 seconds
CheckSmatch                   PASS      303.88 seconds
bluezmakeextell               PASS      97.21 seconds
IncrementalBuild              PASS      547.55 seconds
ScanBuild                     PASS      893.78 seconds



https://github.com/bluez/bluez/pull/2433

---
Regards,
Linux Bluetooth


--===============5628422857185973344==--
