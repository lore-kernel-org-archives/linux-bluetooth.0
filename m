Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C67178C90
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Apr 2024 16:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713199380; cv=none; b=lWZhg6RVSnrbw5fc7epHgnbtw8QWfP9XyFQHPqzvv9i5jgLjryUXgir+QKhPLaMgLKYn8OPywxQbJJdz/9DOv83RCFGeTNR/9c6RhZncjWQ6IvqZ+wAnr4oLAhFGxMgTfS2ZptV2slijGSbIr7AFXdmMGoNBGs1vlySLMid7XuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713199380; c=relaxed/simple;
	bh=NPPu+eNjbmyO9i92TnPkr8OpaYUcvfNFUplP8gEBP08=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ECma6aFNsCrPp4JtyociMgNtCDERJWeOZwDERufKyV563tmCS76QMRRC8C1oJNy6CuXAUGzlvJAegXpJzCFLp6d+z6JWLT92uujy4XofJTSpWExVrgWfkyWgzthYsCiYlka3V1AfZB1rz2+221PF/79BaTAweJwQFOZWqsWhJPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N7C0+xt8; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N7C0+xt8"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5aa3af24775so2597352eaf.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Apr 2024 09:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713199378; x=1713804178; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BvEooATo4JbmaHAxDrygD6QP7rEXfwEszsi1XEKxNU0=;
        b=N7C0+xt8Rt5NuA19STn7Zs+qLjn7hXH38s6GAzj+7+y0GY71GfcrKPqPFLtnZxJfoV
         D8Pf30sdI8TZQwEQh0U8SYero7nNSLMZgGn7rduovBTpSbHwnd+eCbEd4cbepxdFGeJE
         yDC4BmkW9La3co3T52KCzCR+1njAGl9+VeYpCyDxV2MCYvtU4on+qDswKzg0MNtOSCbb
         c2/jG8UAdRkn/vxT615sH5WVhYC07IRSLLsFWZ5Q9guA4S5ETcZR1RZxD3dD5BiWY5eq
         EYOCr8dH3Zv+6Yzg4WSIkG0TxtJdEaLoBhmzH1KTiV4k2aNlFRv7sTJgcosT2ofWNo2r
         7f9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713199378; x=1713804178;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BvEooATo4JbmaHAxDrygD6QP7rEXfwEszsi1XEKxNU0=;
        b=AW6Efz2nmk1lqR8uBsaR4rt6yUxmmR8Ouh/DKlms4lbkwugpMtBX12PNmlx7dNsgCL
         v+vBClnd/oJh2LS8ulz5wm7bO/3aaxjZlAw4Iak1SRtntl0MdHUn9sC3Xq1u2gE0iBxa
         zwZY6W4NOUM/iMxSlrAzYypRvNjj0zPKLjlwedGfvxfjYL6IBAy+T80l3BXZAnxAdoek
         TQidCdmb5SZEQqZ58Bpyf8AoZTUu8g+aC8JSjcnloqw7MUiO1kX99KiwUy/DsQHVHq/H
         u650PBjOrMu1ENHRGPbn9zehDMgdKTufMfJOwot32mWfTpJn8f2Fm5+7qOYfaEyiloYc
         UdMg==
X-Gm-Message-State: AOJu0YyopqHBKsZ04n6VoaLyuE6ruwzWfvZ4L0Q0g6IybVzdTQZoiEt5
	b9O48TqC3W0iwTcvC+bPlVlZw9vhqKYRpyRRPF2khbsuvUpKf9YO13S+og==
X-Google-Smtp-Source: AGHT+IH1Ef5lU8TQRocj0uzgjTpV5nPMDaPHdmnfyFzTyKHDTGjgn2nxoQ/9QszJzZd/QHQgkbJ/ww==
X-Received: by 2002:a05:6358:9617:b0:183:e72e:ce04 with SMTP id a23-20020a056358961700b00183e72ece04mr10908456rwb.16.1713199378419;
        Mon, 15 Apr 2024 09:42:58 -0700 (PDT)
Received: from [172.17.0.2] ([13.91.68.210])
        by smtp.gmail.com with ESMTPSA id h23-20020a656397000000b005e838b99c96sm6296304pgv.80.2024.04.15.09.42.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 09:42:58 -0700 (PDT)
Message-ID: <661d5912.650a0220.919bf.1152@mx.google.com>
Date: Mon, 15 Apr 2024 09:42:58 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3447701506021128218=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] shared/uhid: Fix crash if bt_uhid_destroy free replay structure
In-Reply-To: <20240415145444.857497-1-luiz.dentz@gmail.com>
References: <20240415145444.857497-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3447701506021128218==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=844685

---Test result---

Test Summary:
CheckPatch                    PASS      0.25 seconds
GitLint                       PASS      0.20 seconds
BuildEll                      PASS      25.20 seconds
BluezMake                     PASS      1763.91 seconds
MakeCheck                     PASS      12.94 seconds
MakeDistcheck                 PASS      181.38 seconds
CheckValgrind                 PASS      250.57 seconds
CheckSmatch                   PASS      357.15 seconds
bluezmakeextell               PASS      121.63 seconds
IncrementalBuild              PASS      1502.12 seconds
ScanBuild                     PASS      1039.94 seconds



---
Regards,
Linux Bluetooth


--===============3447701506021128218==--
