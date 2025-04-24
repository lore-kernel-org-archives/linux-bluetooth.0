Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB9A27F742
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Apr 2025 17:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745514205; cv=none; b=e0alqQCpFqKv+odMEyt4wlaru1GM8eRGzQqatZQxtSHz30iopq81wL+3WrLfem8m+dzbPZz1XjPa6AeliF9xa32KGXGIPWC8qHDfkgkA9OLK5iVCCRuhBx9dOp1Vg4+KvPqmp1P8XL8C3HEE4sH+KaxYgj/K0jdjc5zQiSoSJhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745514205; c=relaxed/simple;
	bh=HLRa5Ska8UdeDbkE1eZUDtEbUsQpZ9epACTf8KxC574=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=tKKWO90a4+n7w5Isp/LMVB/3KBTvYs6yPQgueJNK/GeCHsSIaXTv8YUoKWQoIRev5vM58UilSrWvZ+SFbXYOCGcQHLdh8oRD5vWWkMI8/kZrVzwywFZarP5Uw7xPRqolOiR5omwpy/FfAVkrIEBN2tiKtC0qrdPtTOAKVVrF2aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Li/aAEaR; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Li/aAEaR"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4769b16d4fbso8374521cf.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Apr 2025 10:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745514203; x=1746119003; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=opj1hm0Es1S38R6tPAn2geIimC/7u6y1YnHGjwc2xwg=;
        b=Li/aAEaRXcqRIRP9EoqlrcOsU3ddzVL3HKyFnBpB/YRI2sA4vBm44y+Lefw50TTlc4
         a/4P21EQeVkyLyYb6hKKDHNonS34m6DchnFNwxfhLAeTCfjplAjYiydaBgfrtX2AwL0x
         zvETBh4+TZyQiUs4LzW2XLIq+mx1vE758vF1QI57BR2kV/wVzwwftpf6SqicZZKt477G
         ZZ1YI7wRF0Qz/fDLYCMKWlHosJnjyz4uAJQCi/LRYGlAqA405taD5KJR9mDJddfHpayy
         XvfI6SwKFXohHo+c5Da6Hj0C0WJk0fAKqXFiK8EPeBTsNCRMQV8JRU3X8LjVGnSpTeFC
         zqHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745514203; x=1746119003;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=opj1hm0Es1S38R6tPAn2geIimC/7u6y1YnHGjwc2xwg=;
        b=Sh+YsFDylXURliAYq2EiKob4JLhSRlEDtrP18CfyXSF8g//nlnmwK05dJoO3EIsrZ8
         6HtujI7egfkNtxKfAFmKeTBa76O3hk5bfJbYqcQ3REo8BNPG9tpd2hddQb3a9psoW+cS
         ZhaRERC0fqV9RmM/9bX4JF3UlbCLjlFMVp8Y+TmnneyqbD/VnwtysAMqXLnhpYtv3UeL
         6ewr6X83999YoBLlvOVF3jRMckEdc0alNC9GK/eFUR0ZsTWr9uexq3vK3+FssD2Pubct
         7GjWxOrHFs6u245OwtvhOPF/LJiXLXdXWzOqpkn3kD+b6nVyDzcGpPy4Dl4l7hN4HDRy
         LNNw==
X-Gm-Message-State: AOJu0YxYIUK1yg18acicKk9zjj+1ENg8wfB6s9iJPXrOzr4b//fCAenh
	4aGBlO/Uvp/0RgUuyH1n0+RwvlmdatrIrjq6QmC+ylE6C+Fx/UnwVXiQbg==
X-Gm-Gg: ASbGncurqEPg7J8GvOX4qX48/hVLTMeN2xnXU6pM5NRTkO5r9KYKmTa2049GQI8k98D
	3QdnEH4ErhYsXJ0/G80Efvyr0GOx0JUg9/Fi5G8tmRtgQh9QLrm0ZwSrIMsYDZQQKWMkn5i+suj
	RpZX9XrMpB6/eZ+qDu3EYd6vfEiRfKwdNVFWC7tTKoGRLquOxDnyClPe2Gb4yZp9IadAHDQJp/I
	ZhliGESQTMn7oMqEWXXV7EQtI3Cihoqf272U1CQVuhVKOmJHnm75PorM0CZiooiyTmIrn0Tbxwu
	frRF8xmZa62OcqVkMk1toW393ckKKrqCCIguZu/XJ1g=
X-Google-Smtp-Source: AGHT+IFAFELBYWLnQ1fAldEMQApGHrxJe6xMm7VjRl22CYo6MRP3B9fUYYRR3w30wYOy8G026Y98Hg==
X-Received: by 2002:a05:622a:14e:b0:476:c666:d003 with SMTP id d75a77b69052e-47fbbc48516mr6451191cf.43.1745514202772;
        Thu, 24 Apr 2025 10:03:22 -0700 (PDT)
Received: from [172.17.0.2] ([20.39.62.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47ea16932b3sm13751131cf.60.2025.04.24.10.03.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 10:03:22 -0700 (PDT)
Message-ID: <680a6eda.050a0220.271a5.6c94@mx.google.com>
Date: Thu, 24 Apr 2025 10:03:22 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0737992434839912482=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, yang.li@amlogic.com
Subject: RE: [BlueZ,bluez,v2] bass: Set the service connection flag when BASS connected
In-Reply-To: <20250403-bass-v2-1-7925bb16468a@amlogic.com>
References: <20250403-bass-v2-1-7925bb16468a@amlogic.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0737992434839912482==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=949647

---Test result---

Test Summary:
CheckPatch                    PENDING   0.25 seconds
GitLint                       PENDING   0.31 seconds
BuildEll                      PASS      21.06 seconds
BluezMake                     PASS      2790.87 seconds
MakeCheck                     PASS      20.59 seconds
MakeDistcheck                 PASS      200.68 seconds
CheckValgrind                 PASS      278.14 seconds
CheckSmatch                   PASS      303.24 seconds
bluezmakeextell               PASS      128.37 seconds
IncrementalBuild              PENDING   0.33 seconds
ScanBuild                     PASS      919.29 seconds

Details
##############################
Test: CheckPatch - PENDING
Desc: Run checkpatch.pl script
Output:

##############################
Test: GitLint - PENDING
Desc: Run gitlint
Output:

##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============0737992434839912482==--
