Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCCB3D51A
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 May 2024 22:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715640061; cv=none; b=OMVicuhtwCGoGQAuN/7xC0S4pZwXbGciR1Rh+nV4VQJTAFclttS7LLkANomlZKy/5ul8xoHXjBFc7t+qMH+OwHQzD5Uf86d1kE5ivShcBOscTKii0Yhi7axPnYrBWgf9geXZmOYDVQpGp/krlHoXzZSh6d6nwv4HnIQjLOrOZ/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715640061; c=relaxed/simple;
	bh=MP4wOFqYWQgBSPgAJELmR1WhAaBJG0e8te2hY8kIeVI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ID+yMaw6e3KPqPlXgVHLP3/ZIbHC1hF0O5zFh6/LysigpUtXQehNAFG+J7zgp7nzDcKehGZIU58U89OLMg4gRPJTvpDecmPr0LLOtSZ5hCiaoiapbZtg77s6d7p3omgbbUVJsqBQ4dYaKaJyKhJFWoXSDowtNdkkYTvFwFwiQ3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K+u2iKmo; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K+u2iKmo"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-61ae4743d36so49149497b3.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 May 2024 15:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715640058; x=1716244858; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Liu+qBC9j+Aq3erd5wqu1s2Oi3arspUUUw4QIotMW0U=;
        b=K+u2iKmoTLgcQsBtMytNEEY/yD4/0rWD+YIP3My91n7YBQVLitnZGNuOn0FIfreZjo
         zwRHazj+7Nnxms+sWfqzqhA3MWfGk4tq0PTlLZq3guLOLQFfyDP9xO5hxzTFOkO9XdhI
         E2Cz8JNHsVb/mwY8bHEHLLUSEcerTYhOWXHXXX/7ngGc+jrbgehdAqy04wkSvDewrMLa
         PzQpElqufh+3QOZayBZzwcdoZPIObCJBqMpsGa3e54InCjKLE6X3ZeSSx3oYTacn5tYs
         IpuPUJRGM+Hl9MYzYnX8z922B9swrT/nGOGbXe/WKVJJnpx/wmItWsJi1LIthntytMBE
         wuVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715640058; x=1716244858;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Liu+qBC9j+Aq3erd5wqu1s2Oi3arspUUUw4QIotMW0U=;
        b=r3tiFbpYr/3KrJSVwU4msDlyAng7yUGYjdGD9lj0VJYYRy4p+Vr5P9DjnNtEyhl/Hh
         uBCVSxtVOTyRv27B6owUi3PXItE9Q176i02gpPmzH1Q3LmOKDbMEhkQcFhH96jRLwm1o
         FWYPmfzltDC/wInaOQDlWYvMOpGMMm0iU1iGM8MapObzaNymzZDJyIwVrW3SOh32civh
         CRA687MZQ5rrCWo9jeoz1Q7wX30jTQHMVFIRGH78Gb1/NJdI5eQmN2+yqAjAGjpjeYAg
         C3axD+Fi6L0/4Gf+dz47U19VvGubZ+b4bfiJl/4V9LVXYIC3AeUq0p2+Yft/KehQOvDp
         H71g==
X-Gm-Message-State: AOJu0YyXaCFmhhSAdhK6WCaJc+gWwGK0uXbBG53gD+GB3akNepUfV4H3
	i4YeXkv1omXOJdPbOPKdjnTf8cR1tioF9wnu0jrrgik8VoMcWJi4WP4u3Q==
X-Google-Smtp-Source: AGHT+IEBLnB7OVpe+IwmaSit4difVSiRgM3zKYqWD5yJA0QVQtGVCVcex/TdZybuoAW1cIRXj8W+PA==
X-Received: by 2002:a05:690c:386:b0:61b:3402:805f with SMTP id 00721157ae682-622affc6370mr121338057b3.10.1715640058590;
        Mon, 13 May 2024 15:40:58 -0700 (PDT)
Received: from [172.17.0.2] ([20.51.207.129])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43e069a24basm41434411cf.67.2024.05.13.15.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 15:40:58 -0700 (PDT)
Message-ID: <664296fa.050a0220.bbac8.d9c8@mx.google.com>
Date: Mon, 13 May 2024 15:40:58 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8547033972397979563=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] mesh: Fix not setting rpl_dir as static
In-Reply-To: <20240513203732.435344-1-luiz.dentz@gmail.com>
References: <20240513203732.435344-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8547033972397979563==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=852915

---Test result---

Test Summary:
CheckPatch                    PASS      0.46 seconds
GitLint                       PASS      0.33 seconds
BuildEll                      PASS      24.69 seconds
BluezMake                     PASS      1678.68 seconds
MakeCheck                     PASS      13.11 seconds
MakeDistcheck                 PASS      176.37 seconds
CheckValgrind                 PASS      246.07 seconds
CheckSmatch                   PASS      352.98 seconds
bluezmakeextell               PASS      119.79 seconds
IncrementalBuild              PASS      1521.01 seconds
ScanBuild                     PASS      994.87 seconds



---
Regards,
Linux Bluetooth


--===============8547033972397979563==--
