Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF207383BD
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 Mar 2024 10:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710326384; cv=none; b=FD3O3ukLp+s0UMaoJHpBJNARLtkPDCyJ3ZePOjyeUzWiAFr2z6lS/d9txXM0tZs0L023sIa4Kg1e0q4Bt0XwJ0kPIpfUc+TDtNHDAY7NI7k5HeNlahwHvBbTkRUPIKwu1OeERlSGI5dxI/kkTVZcrYBtn0oyJopki2XgA6aLaIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710326384; c=relaxed/simple;
	bh=nh1rcf3vmuU8FKa93vAIB9neNMipdrFP/Sc5DJy6PCk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=OA77LTFXz/RnKkkgUrHICWd7UvCvz1xPjTC/HxqPJY+RS3HKoORNlWRuX9Sa5TTX8kqNNR+B9su9e6suGEzkyD/CIcGbtK5/GjS+AZuz2zB/Ss70zkAw9RV7yESRaDtxkXk1cTegKDhNcJqXYy2qB9T48++oeB8k+nxbAHKfELU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GOIhx67l; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GOIhx67l"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-42a029c8e76so6325091cf.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Mar 2024 03:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710326381; x=1710931181; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9pDJ82hBhXAGhb4krbzyHCnzB/fbuN3ibqXs3jgoku4=;
        b=GOIhx67lQjDV7oUzHwcN/NwSqkpuI/IQgMZ/YhCKLXPidbD/QRkCMMbfqXbHCMIu4V
         ycWB9+U15A7Xfl/hnItAxx2fH9no8oYviLkxooOneCm7IlIQ3NcM9aEfNWvmKg0mQ0qD
         KatG4nQIFZ5AvHK/BN7CnCdWbRcKutIWrKqiYjR2LAErzza5tHDLcsCGu8boAIz16N+y
         bCulNFGBBs6nwqvZhVZ0LyGWjB1A62ErsGxLmCPprPUGVqCN/w3ctrNuuLgJfBF6yRLf
         Y5e7yroD/91PXP52dWxom5Y22rbLPW7ZdcRI70LC26LRLlmQEBHO8gobq/52z2LP1HoG
         gppw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710326382; x=1710931182;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9pDJ82hBhXAGhb4krbzyHCnzB/fbuN3ibqXs3jgoku4=;
        b=deERZoUqXkbu+mmMjQZpBp09TJu0WFiG0Wipy/25LKNIJdU0+nQIOA0gRMEGzB0nOe
         1neOEHbFmQSRA6OfVsxNob6iuTHuRN11WdUffuOBkLCAcYXQItKCN9XHmSZkVWna+K+7
         Cwdvu4cwkSI9NxvNaGF9RNY1eV6adjpbzU24A/5d1U1ev+oUghvuDYUZtyK3HXsvdVAa
         3cpN03KkvJ9e4PVVZJQM476Ys3EhwlQlgGnOByEHsI/Td49T3jFxLcwIufcbjEidQ6DZ
         GBxINgbkOt0PHKARgnYB50g56u0kx6UhOEhgViVGbNzQ6xwYfVXBSW21hF/RDSp8uhZd
         MINg==
X-Gm-Message-State: AOJu0Yw3OZAnDo67HRFA82fah/USkxOhn1PTPlscnU9Ws0zftUcMVWaD
	Z9doXyw7runAFgyxaTPs6m0/OCyXkpdWD4WvL02uMz/+dAJUUoGpktgLvTak
X-Google-Smtp-Source: AGHT+IGBG6oTsx8NTdSEsI/lpI0FIX/rmgFk2mZOmZRwMPGRaA+3iV0KKBWPw3KB3WQByCt3Lc4QQA==
X-Received: by 2002:a05:622a:1822:b0:42f:2128:100d with SMTP id t34-20020a05622a182200b0042f2128100dmr7686461qtc.65.1710326381615;
        Wed, 13 Mar 2024 03:39:41 -0700 (PDT)
Received: from [172.17.0.2] ([20.51.198.147])
        by smtp.gmail.com with ESMTPSA id s14-20020a05622a1a8e00b004309220d87csm390455qtc.0.2024.03.13.03.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 03:39:41 -0700 (PDT)
Message-ID: <65f1826d.050a0220.74a16.0aac@mx.google.com>
Date: Wed, 13 Mar 2024 03:39:41 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0910742551404816437=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, vlad.pruteanu@nxp.com
Subject: RE: client/player: Update minimum LC3 SDU size to accommodate 8_1 config
In-Reply-To: <20240313090359.164196-2-vlad.pruteanu@nxp.com>
References: <20240313090359.164196-2-vlad.pruteanu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0910742551404816437==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=834885

---Test result---

Test Summary:
CheckPatch                    PASS      0.44 seconds
GitLint                       PASS      0.31 seconds
BuildEll                      PASS      24.21 seconds
BluezMake                     PASS      1698.32 seconds
MakeCheck                     PASS      13.17 seconds
MakeDistcheck                 PASS      176.84 seconds
CheckValgrind                 PASS      247.68 seconds
CheckSmatch                   PASS      350.18 seconds
bluezmakeextell               PASS      119.81 seconds
IncrementalBuild              PASS      1458.97 seconds
ScanBuild                     PASS      1010.77 seconds



---
Regards,
Linux Bluetooth


--===============0910742551404816437==--
