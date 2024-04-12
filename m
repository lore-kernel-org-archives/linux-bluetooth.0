Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BB453802
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Apr 2024 10:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712916228; cv=none; b=tfuEaSvyfQZOxcCv98djz99yYts8ci1twtiQIuytJB8DyoxMrnLo2uzgSn6vrtOmv+hdjL57iYs+hVs1JmVMDw85KDjiq9q3zJNd1uD7RYOY7vYbglnkAyq13TXUXj1wXZ8qGl40b5Bk8BQ6FSt0/cYGzody4JSj6aadzYdobbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712916228; c=relaxed/simple;
	bh=MwS+kulE4lW3yCqQg8Mh9oN+VmDPPvC9X/Nn8zL9C4s=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=T5zlqEsEovkv62pSW2g6EncUMvWgIPfsTZqoJTRH2OKth0YaAvmSEn+dvCK9j52HF356ZhxbS3MdCQ5tL7D8nLDaAQoJM5pb/nIxH7eE13/Hs/9zEw8W1NxO67zGgzDZLcCGn7wCYURqGwdUwulQINQeIBlpzcHnBz+iWQTK/ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MUXPDjsH; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MUXPDjsH"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1e40042c13eso5623515ad.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Apr 2024 03:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712916225; x=1713521025; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6wQYI43e8n7TrT/RfzyN77J0hbxXc9o/c0PzavTdqX4=;
        b=MUXPDjsHLg8/d4kLgxz9OtLA6BZ9HBUMWVQjeflcgCXQYP8tBLt98yAhwAlCCqL6Dw
         RQA/iOYA9hnYIcnvLmnaTqKoDFwMrctXZQYPaORNW9Scuo8Ag5r3aAyMtlj/pvC5UHqP
         01I4tVFf13H0ysBLdXRhtnESAhoNRFAnOrPJWppMYPpXr59KhzucplI01yiTTjn7B+wn
         HOX53/zC5HwY89LIj0G50wJPIGTAluhZ+gWoKuay9+XyOjkxlQdsvT1ysQaBnF9HM+oF
         6kehxzatVlo9A6bQb6h65ZMkkgw222/82ljy/PDjVFcldhyebYGgzZ/tlX6teJaj2D+K
         Us+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712916225; x=1713521025;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6wQYI43e8n7TrT/RfzyN77J0hbxXc9o/c0PzavTdqX4=;
        b=Q3ABy5jAivmkeXpP+va/JiUHuP5mjP/4s/wF4Lj8BTbp2E8rZt2PwSlksNvBHwfdsp
         1XbB1dCLA513+Z+stS0yd8Qkc88l6/9fxsImDQPPvjzDAhbMI4mDlJuvhqW4QpWXUMWK
         0tRlg3O7z6SWmMqCTXyTxK4lXElDGWBm4x9t6aqEO3MwLm6pLGTAhGsNTT3TFnjKQ319
         NwrvG9RgnDlCG8+LnfSwMw04R00Y+SZb4nT48FpR/E7lDoToG7xlzd0tmtNbKvnW27fx
         Pj+qGaAQ9gQIHZ/bPSjeSG9dhNGn4HM5g12oSQHszvONU43nNb3woBRd12Ww6gWvnS4I
         LKsQ==
X-Gm-Message-State: AOJu0YyE3ngZtdAln12DO3OG/IWs5XnbawqEBuVGXINsDFRuyBUYxrvv
	vvYpAYIuwrbHH9pd7jj9viYyMR9w8D+Zk8pCFrcMxiekAhycQ/vPdbb79w==
X-Google-Smtp-Source: AGHT+IGqkrjK+kaydr643AGUwogmYycGw1Wc2YComTYhLKYwHoZHdJqq6R810J+VYsdazawzTR6vRg==
X-Received: by 2002:a17:902:b717:b0:1e1:1791:3681 with SMTP id d23-20020a170902b71700b001e117913681mr1679150pls.61.1712916225347;
        Fri, 12 Apr 2024 03:03:45 -0700 (PDT)
Received: from [172.17.0.2] ([20.172.2.101])
        by smtp.gmail.com with ESMTPSA id c6-20020a170903234600b001e0c91d448fsm1459905plh.112.2024.04.12.03.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 03:03:45 -0700 (PDT)
Message-ID: <66190701.170a0220.b0b88.49a1@mx.google.com>
Date: Fri, 12 Apr 2024 03:03:45 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2908216014736853274=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, arkadiusz.bokowy@gmail.com
Subject: RE: [BlueZ,v2] advertising: Do not crash in case of adv update failure
In-Reply-To: <20240412082351.930802-1-arkadiusz.bokowy@gmail.com>
References: <20240412082351.930802-1-arkadiusz.bokowy@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2908216014736853274==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=843919

---Test result---

Test Summary:
CheckPatch                    PASS      0.31 seconds
GitLint                       PASS      0.22 seconds
BuildEll                      PASS      24.27 seconds
BluezMake                     PASS      1679.26 seconds
MakeCheck                     PASS      12.80 seconds
MakeDistcheck                 PASS      179.41 seconds
CheckValgrind                 PASS      248.75 seconds
CheckSmatch                   PASS      349.07 seconds
bluezmakeextell               PASS      118.00 seconds
IncrementalBuild              PASS      1422.69 seconds
ScanBuild                     PASS      1037.22 seconds



---
Regards,
Linux Bluetooth


--===============2908216014736853274==--
