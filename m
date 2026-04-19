Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1262330328
	for <linux-bluetooth@vger.kernel.org>; Sun, 19 Apr 2026 09:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776591263; cv=none; b=foC80mvOR5DF+iYQ+hRJttkZW2wAVV8XKatB/5bBnQ/NigcoTQLY1DEhTmSG+aR55nBKKjq5iFKhq8swmi2pen37pbMAXEMTAn0n8cUDRke9+i5TErmZoYhLgF4Q91TZlczSRv1Ymly0KZK/pQZxWq6bZ1EnB67Eyv7LMk2tAxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776591263; c=relaxed/simple;
	bh=eWvb/5oQN5bceGiEt6UCqMlyKFjGwgJQcRqqjYo4S/M=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=HHEJP6OQUhPKPzmnk+CdCyktnDDzTkIqszMkln6o1SIJGh7urmyKqxzyHHLQYAVT6F2SA11YrXmg1YQUtEmJ+6qos1M3hhe3GYJU6vcIyYARpKZYMR1aQpaVKYTl/1Om6fZkmEx4GCehLYLD+ovocexHkI2YStbwAepLW+pKc34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ezaB2gs0; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ezaB2gs0"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8d6d5e45c43so264028085a.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 19 Apr 2026 02:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776591261; x=1777196061; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4UZpy/OPIpsO871sEf/rViFXpbyv5mGASzXarOjEZ/c=;
        b=ezaB2gs05jwEWM8hHJvqkxQUThxuYbot85jltasyUgIYVXIbO4D7XR++oChVlGGaLI
         WojAxa4u6iTAottGWuHwtwl0P6GqxI9UnhorRZcrIwuoHKRnB/O/891xi0V/+9UaJTTe
         FLYwFUQDtQZWt9xoHwVNDzKwOXhsmsAJcfpSy3LNbQzGrmHhfsqiWmSiA2cEFobxRZ3f
         4jKLRmCgX/oyKb1A2B7WFIX3a1jKHnBn/ldgDQ7gkxaMNzr3NrdqqrvM6SSy2sFDDOyg
         JzbL1b5Wmddy3//BqCA9eEkIXSBPYlstsvL+ZZgJGfmAXoQvkVScDcacvzq4smu7Xjrt
         Yz9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776591261; x=1777196061;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4UZpy/OPIpsO871sEf/rViFXpbyv5mGASzXarOjEZ/c=;
        b=YAAoyNAYU5VXUzGDjj2UDx7VuSRxGkf9mSgLiUcrNkMVlOzTYnpXON6aKIW6u0muH6
         3FMsZxWmvIOnC/F2i1kZ15CitlTJHdS8a8ons3YvqoHR77cuUZlQWJdvq3L61h9u4Zin
         xFFyfNmifffA3acTUFP7hRK40SoeC5IO0MHzMaCUeaD1pBbiMy4T7MSMSOYXc/jxm9Ag
         lKcB6qDpw/9w5YJNFbRtzih7Rn0NjHXKGucL8hCwVl+ByOfW/JKZZ6uNBb1IYp0unsdS
         pyaFgWHtTbLFn846iXSvyc6mJS/NnVbTb2BTTk0/+yePPUQy5gXD+c3qxUgmdlBcO+DM
         7N5w==
X-Gm-Message-State: AOJu0YwJ+b6/bymajLGYvZYtaX8DoANmvgMhK6m5uwMFqUX2P5U4/Aq4
	jEq7PjL1PkWzg9IXeCHyRK+oWlupP5EmfgUu/OL3tUtd1lJ/V0kLMiaquffofQ==
X-Gm-Gg: AeBDiev1kCUuN7mQoD3mSxWHBUP3NAzwgTnzuk3FZVudHwxAv9qJmIPej6XW8BNSBrs
	n+aEkvb1DMbxkpaQS9Riv1nXTtCwEqFUQ+0cI2rquB/4hzgPzbhVv0ycQpifU+rPFu7ZkJATw00
	cYv38IDBCSZd3nhJBuo3YITmNd6a1aPafp5Yb+aKxA7rTlK5BmG9SxN4ZRA+kRRGj3VfpOVJG0E
	gc2h1QnI7B/AzfqUHgcfwJth/69Qpb65R8Y/4pCbDifzn0jr+wWgMAZn9Y8KNWJsCg69i691FPO
	jdZHo7QWLp5VuCHyVrpfyEmUnlHROcA7jTOdY8WaDn2cothY+T2VmJlA78Q2qmaa2Kq5qO8A/mA
	AFrGEwrv7L3D6j/6wqaqX878pLlF3ZMa743HccQQo/aC3oF9FF8shXbpCRm+TpWSk0qP0eWCEa8
	9+omb3O67eXk7joFlX8woni7RkHwDm9MWz6nn3Gwbo
X-Received: by 2002:a05:622a:1ba2:b0:50d:9175:34e0 with SMTP id d75a77b69052e-50e36c394aamr137112051cf.40.1776591260675;
        Sun, 19 Apr 2026 02:34:20 -0700 (PDT)
Received: from [172.17.0.2] ([40.116.73.179])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50e393ffb40sm66478921cf.15.2026.04.19.02.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 02:34:20 -0700 (PDT)
Message-ID: <69e4a19c.050a0220.299899.9e88@mx.google.com>
Date: Sun, 19 Apr 2026 02:34:20 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1059889445981405776=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v1] Bluetooth: btintel_pcie: treat boot stage bit 12 as warning
In-Reply-To: <20260419083345.894658-1-kiran.k@intel.com>
References: <20260419083345.894658-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1059889445981405776==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1082909

---Test result---

Test Summary:
CheckPatch                    PASS      0.88 seconds
GitLint                       PASS      0.30 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      26.86 seconds
CheckAllWarning               PASS      28.20 seconds
CheckSparse                   PASS      27.12 seconds
BuildKernel32                 PASS      25.09 seconds
TestRunnerSetup               PASS      562.87 seconds
IncrementalBuild              PASS      24.45 seconds



https://github.com/bluez/bluetooth-next/pull/105

---
Regards,
Linux Bluetooth


--===============1059889445981405776==--
