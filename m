Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BBB482D7
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Dec 2023 19:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KacMPg5l"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-77f2f492a43so407006785a.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Dec 2023 11:11:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703099497; x=1703704297; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uhymcLcr//1dxmsvlh5N2PxB+5bHJv5GHObegs7p/fo=;
        b=KacMPg5lbSxiSLZ0UpGokUgaMI++4o7VrotJdlsl4Ex/raBGI4KQMbYBffocc0ZS+f
         HOsouUNmvdhwVsXfFrICBAqg0VCx4ezodoixrLz/fruCia+hQqE4MgJMOYR6DdbclYdW
         XHnMxOFpe66FclEeSJvU3FcexKoH6Cy6cCOn7BOa7DQWZfOvDhsAiMck5+NjXJtsGltB
         Po9aBxUzPLSK6veszInILgMlebO71JZVWucEcPyR5fdAPCkcEfh2N9lttGldeo63yfkl
         5V1xJ1qXzPZF8DSpscn80dgBCLabuAdPMQKYNggo8eCe7hpKHrHJ1EzxcPNE6+G2xywD
         BurA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703099497; x=1703704297;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uhymcLcr//1dxmsvlh5N2PxB+5bHJv5GHObegs7p/fo=;
        b=B8HGFEmbkxNDNz44Y03oRXmKgJgbMIjUGpfNnCg+/gzkiPllkcbz3tdiAI+jaqeAv2
         KcRujfLmQsniLmyEP+byvX27G0BcjW6Z3381TYagjF5CyIKxJHz6DeuLWOyZUJeKfpLI
         BgCHNFX2ftQjQzWc01eOsmDj2d4Gvps/DbSTiRtjuGph9vJ7+/cj2hWcXt4d0TbKYkzm
         71Z+mmDKdZbxz09b+HcApkUqtWzUEiTSd9wASMA6BlWYhN7fT2ThYSh5drMWIYujRbU1
         oTnJQ6AdcmjRSgPt9g33LXX7BtegM5RoaRvdjmqGYAkJYthtOL2gCVrWB12v4au7VeBa
         zXIQ==
X-Gm-Message-State: AOJu0YyRahsd/47m3Rk619Co6LVaywNOgzQpA/+T3xx/UOVSD/ow/uRz
	vVPrnFTiT6T8HQQ0ehOJcBcQX1iCZvk=
X-Google-Smtp-Source: AGHT+IH5tC5V/A47hjtY4R9zwt31UUNttMG3M1DjujAayrOJauVmJtayNKPbjPzLrfUNGA5VY5Cx2g==
X-Received: by 2002:a05:620a:38e:b0:780:ed85:2c08 with SMTP id q14-20020a05620a038e00b00780ed852c08mr5157795qkm.2.1703099496995;
        Wed, 20 Dec 2023 11:11:36 -0800 (PST)
Received: from [172.17.0.2] ([40.76.119.106])
        by smtp.gmail.com with ESMTPSA id ay8-20020a05620a178800b0077f15eb3528sm132328qkb.70.2023.12.20.11.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 11:11:36 -0800 (PST)
Message-ID: <65833c68.050a0220.47e5a.12e9@mx.google.com>
Date: Wed, 20 Dec 2023 11:11:36 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0540683734945634102=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v2] adapter: Fix link key address type for old kernels
In-Reply-To: <20231220174042.2335819-1-luiz.dentz@gmail.com>
References: <20231220174042.2335819-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0540683734945634102==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=811910

---Test result---

Test Summary:
CheckPatch                    PASS      0.74 seconds
GitLint                       PASS      0.31 seconds
BuildEll                      PASS      24.93 seconds
BluezMake                     PASS      739.73 seconds
MakeCheck                     PASS      11.51 seconds
MakeDistcheck                 PASS      162.69 seconds
CheckValgrind                 PASS      224.54 seconds
CheckSmatch                   PASS      330.54 seconds
bluezmakeextell               PASS      107.30 seconds
IncrementalBuild              PASS      702.43 seconds
ScanBuild                     PASS      954.80 seconds



---
Regards,
Linux Bluetooth


--===============0540683734945634102==--
