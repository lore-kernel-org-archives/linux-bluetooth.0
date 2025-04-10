Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7801E3DED
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Apr 2025 07:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744270863; cv=none; b=R8GbvM7a7M5LqvbIo2Y46lr+QvnLH6T9Uzq/b6Gwz6K1gCE9g7o2gL8YXAY7oACLsfb/lZDQemIVDi1Mx4YApcNcrK/EKtUCXcUMvLBfa1B1OAhZK+u/ccU3W1O0WsSlNES+DlXZfAS4lMVgtBYi30el9JlQ8IoGE9KyfqVuUdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744270863; c=relaxed/simple;
	bh=bweMSk+LOcVGY3W8YeeeOJd379PrVRE25mBLaisXlrg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=O9/zeHWSsHJZO22Q3qi6xPwLoqpOF920HP6J/QY2W6cd78yQ2rh63SvnDHNKkQVhZCN3QjjH9AnnA8Clv2ZiCUmcziqFI6h++vs1TqG9PwydiTAyrFLPIVyLcWDao6lXfdAgItVTcPr5wETh9yy8CZ/QA7rG3uOJh1UPzc9XmoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HOKaFRFb; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HOKaFRFb"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7c5a88b34a6so55241985a.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Apr 2025 00:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744270860; x=1744875660; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rcN20Uynn2piQWLKbtdYAB/6Gn2cKafVtkGYGLonIcU=;
        b=HOKaFRFbRyXn76bZ/UDxKIBEhkfh51unHQmTBS01ObkzOLcptM3L0UwxV9GfGTqa1c
         N4kknMPVIoJ9XLmCj3lG7tLtZZMo1gYMKLjp3vBkUZRgbPFAodCGWxOaoPLuYBmRVpb2
         H9URILWsVTvn34FqvxLjvzQBTN+pwTkPz4fWThqlnXX5Ta2ueWndzFds9gS33MSmx6eD
         f2ZGLVRGtRiV8BPEZCKoiMx93mypGjdd3im+JwebhDLxZDyn1KRikXe+1Uw0KM/hIaa9
         2UTjZkqdFnX5xtUj6XYaPuSHdvdsacKJsdXbVPR5sUITz92RzgxnEutJiy1awI7umR7P
         tudA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744270860; x=1744875660;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rcN20Uynn2piQWLKbtdYAB/6Gn2cKafVtkGYGLonIcU=;
        b=LV+ChuAa/IS/OMxi4PJqhF1bv659URp0JbnN984yFmP3MwGFBo1nBfnamB681qrvBr
         tqXRjyx/UQot7DW+AlO1qSb5YJZyUJsSQ6xVn1GD1nccp1rKm2/tCdwoHxv/eY5UwLz9
         aBRT8JnlAgKHF6pNgWta0rMono35Crzc5uhGnYtmiCkmVoRlUGa/MeSa2ArVFFw9HIhO
         X4JfXqlAJg4KrX8EG4IMzm5S6lxng9lukKftv4c+eXGX8h8AG8wyluV/42euZf+gKCDq
         S4Ms7hUNOvqhx1hfNDfac9FPUijYXJZbPlcKep/Fdo24itwtFhvRazEEBwzHNIZW3pDz
         l4ig==
X-Gm-Message-State: AOJu0YxRYL4DabezN25XBrVUpQUoaYCyEOHi9xDqYq3Zn7ulrDQ8LWG5
	W7e5CvRMS5tWY9ZlDl/WwChbp8+qIW8Bf1NdEeTWbx3JKeUgUPDMmgTQxBHS
X-Gm-Gg: ASbGncv5LLgkFXIN/Ppa47uutjYMfMcWvwyfeoMdilmnbI0N3RDrL2W3z0d2LqN8i9Z
	LPXL4Z9sfdObcSvwLVXvM5XlahAmBF/jdtM1hbCXkpLZiphOJcu6apkkxi+9SLjdwoLVzBGfRkX
	O9zZpNKfs7rENh5k8j7VFFb4eJQritYvy2JYhGLm3Abbf0AcUSbMt7atxk2yBhqUjlSQUklJw6J
	jsPb0354909wFsCqx3vXIMREv26Kdk95OmR28hXj+9dmbnpD9wnulwv3zisNdFGm1Hx945diHKl
	aZYlNWr7glVh48YDQFugkiKqYloPdrODdI6T1tyfZD6SqQ==
X-Google-Smtp-Source: AGHT+IGpZcgTZXSzGDSHJn/zhz8/sVItlJWrYh/kY0Sf9G1KhwRT9aNVRgapUQd7ftyMlZyt5Z9Wsw==
X-Received: by 2002:a05:620a:2549:b0:7c5:56c0:a8 with SMTP id af79cd13be357-7c7a7659969mr230416785a.1.1744270860435;
        Thu, 10 Apr 2025 00:41:00 -0700 (PDT)
Received: from [172.17.0.2] ([20.161.62.33])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c7a89517e0sm51197385a.30.2025.04.10.00.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 00:41:00 -0700 (PDT)
Message-ID: <67f7760c.050a0220.2b0daa.0a91@mx.google.com>
Date: Thu, 10 Apr 2025 00:41:00 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2050346000226583679=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_amisjain@quicinc.com
Subject: RE: [v2] obex: Send response to client for Abort request
In-Reply-To: <20250410062057.1845550-1-quic_amisjain@quicinc.com>
References: <20250410062057.1845550-1-quic_amisjain@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2050346000226583679==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=951852

---Test result---

Test Summary:
CheckPatch                    PENDING   0.42 seconds
GitLint                       PENDING   1.77 seconds
BuildEll                      PASS      20.72 seconds
BluezMake                     PASS      2628.98 seconds
MakeCheck                     PASS      20.40 seconds
MakeDistcheck                 PASS      198.21 seconds
CheckValgrind                 PASS      274.92 seconds
CheckSmatch                   PASS      302.25 seconds
bluezmakeextell               PASS      128.34 seconds
IncrementalBuild              PENDING   0.33 seconds
ScanBuild                     PASS      898.88 seconds

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


--===============2050346000226583679==--
