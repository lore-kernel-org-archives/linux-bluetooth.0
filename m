Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7772741B5
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jun 2026 15:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780934015; cv=none; b=KjhmdqFTixW+dlCzxHS/t+ILT8XM7+qA0/Rwubi9nDCAY+1g82VUrd9gHqZnHCrn21PnemEQSGnk5Te7SrdbIMcdM6COYPwIch145Jmz6h1QKfQnQ8j7qJh2/6xLtm7HEKyQkceETICPHZdXSLRJrJsGw/+vTJ+K+SLQEp0cOxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780934015; c=relaxed/simple;
	bh=NTed74wZ2SLo1rPG4Tz4BChugW0LtOPcnP1MWoNzQ4U=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=LF1wLUUY+wjvepOg9sBneB7dhMVxKffLFKJvGAyTz5SvtMOKhFoHJULb9IbJqxwWRc14JJzxmoHYZDLKr0VNnO51n1aXTNgEhDEp/hkr0t1dNAHdVPdiy8laZ9QT+1uArubFzoVoxIxbnPQgGSnFnzuxxxH6wTREW/YQvs701Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=av+4lDUc; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="av+4lDUc"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-9158fbaa4bbso502142885a.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Jun 2026 08:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780934014; x=1781538814; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Lg9XJJtjmdAzMzaMjPJF+rP+g0qf9GtWN7aiHXlETCo=;
        b=av+4lDUcE5AC0kb59GxUgu7JU+ih8miLPoOBfJzXnX32BCLs3GY+CigWQ0BkwBhiA3
         YbRqMakwJ6DmrOzDFg6ErZeY/AHx07WkVQyx6QHalAANuoJA9ckeG4Vj+aZ6nvAp+Al5
         IW7UUc9SmmDHN1r6yBW6T2epd1wzzpe0kmVNMO1jLUGYrIfWfCpJTOz6PTAVuDK1ZJeV
         WOj3X1zs7+Lw8YrCpV+Ck6ri7S9NUt/EOTJeKTvK+9OM67lH53cihhgRT36CnUSUJpwb
         YXfkuv1OHbZlaBV06IwsoVIP9SCqG5ruH3GuPffrjdEp0YkYJGtgpWp+h/8bVhl0z1o1
         RnAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780934014; x=1781538814;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lg9XJJtjmdAzMzaMjPJF+rP+g0qf9GtWN7aiHXlETCo=;
        b=R+XKv9v6p6+xFFci0zJ9DoKCs6X179Uy3Br64TTabeSnCG+AwJl21Y3g7Jys8yCMi7
         Bkw9VqC9F4isEQEhjk8zxsXPBnbQdDe5eNAEPXkgclYGH9zEnxs/R7cSmNIiNdTHTon7
         XPCZJ6TouYJuEZgUgUKQkGzaChaUU30K2bHkAFDpNyyFe6PYKRh7tiro55Bx68nPAbNq
         5JrJHwByd82JfbnJJ3l8zvsf5qG+LaC+Kkbm1Wyi1C8iinXywOsvsBCfs5ZwrauFr/lG
         noozqD7VyZ/mrglVtWB1fCVC6ODL7BGArNgCo4S0q/PTGbVB3+/0HdWgo4M7bAbKbdpz
         aDdA==
X-Gm-Message-State: AOJu0Yw4iIyxMiLrR9/vFBaRwtKR5v0rAxLKf8lrbrTN9H2rMkdGHUqY
	yYf8WqW9k2qGUx0QO6xBdzgH1Tp1hGmdMVTBBQg2nZKvkq6L/hW6urgAfJvMLw==
X-Gm-Gg: Acq92OFmVOoFeNwcLYNBP672OwvD7kN5dCVo0SwlwHyi7ga4fwXBBMDZieh7170usOa
	HAOAdebY+cDQtqk0NC+P7gBCRsnedrG8BRgdPwBmik+HFNsthEILKit5H3yMf8/g7a7dieqKNL6
	Bo846ChCtAVhosRPeqqAhm85L+yJxzhdy7oTL7LyJIle9zJ7x+21y+7nlra/8MMC8ju9aS+71Nu
	ziPng6onuEZRkjA5zjE7WC25M3VAqyeqCuVMr0X2+A85ESNP/phjfrjnMdKATE2NICkRJvXldJm
	ObbwXGD94Iw0BAAuTi3WbZ9uPhKIrRpB0FPztZnDO7fi2MTZgPCdrJeCwXiXLqRDuQsxD3fFQPb
	XlIsZ3Zq8nE0l2KVekEjtQRlBAjA7O8vR02J+ZQNDcRU/7McehouqtJ4LTXJE+f/PqvP4Dm9nhC
	B8xDHFdrcColQb8cAIjOwn1dr/BiFgBpyq+nJoNTV3BA==
X-Received: by 2002:a05:620a:2604:b0:915:87a8:3735 with SMTP id af79cd13be357-915a9d56623mr2792533985a.31.1780934013598;
        Mon, 08 Jun 2026 08:53:33 -0700 (PDT)
Received: from [172.17.0.2] ([20.106.191.118])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a3d2384sm1777722285a.39.2026.06.08.08.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 08:53:33 -0700 (PDT)
Message-ID: <6a26e57d.62b4ec9b.1eaf39.98a4@mx.google.com>
Date: Mon, 08 Jun 2026 08:53:33 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1488249505917333056=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, simon.mikuda@streamunlimited.com
Subject: RE: [BlueZ,1/2] avdtp: Fix GET_CONFIGURATION cmd
In-Reply-To: <20260608112923.3722754-1-simon.mikuda@streamunlimited.com>
References: <20260608112923.3722754-1-simon.mikuda@streamunlimited.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1488249505917333056==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1107789

---Test result---

Test Summary:
CheckPatch                    PASS      1.03 seconds
GitLint                       PASS      0.65 seconds
BuildEll                      PASS      20.54 seconds
BluezMake                     PASS      664.01 seconds
MakeCheck                     PASS      3.51 seconds
MakeDistcheck                 PASS      247.31 seconds
CheckValgrind                 PASS      226.51 seconds
CheckSmatch                   PASS      353.09 seconds
bluezmakeextell               PASS      182.98 seconds
IncrementalBuild              PASS      664.39 seconds
ScanBuild                     PASS      1049.89 seconds



https://github.com/bluez/bluez/pull/2192

---
Regards,
Linux Bluetooth


--===============1488249505917333056==--
