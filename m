Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE1D14A4D4
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Aug 2024 22:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724882593; cv=none; b=eFa4HV+3BesjFWbLeWbrnvmUPhgImOJ6jUKzG1BYMHk/O638bv69FNlIdRIzq2R6QVQ3OVFRP7PtuTAEdFBRKvL5Tx3trOXlEboLCK5dNTC5HSszkkNF2zQQrvE3dzzf5saykbljZygzMBDK+4EAgY6nTIV7Qmh5NC1+Q3oJxMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724882593; c=relaxed/simple;
	bh=6xRr5+s/uaCFn9h/cRAKE7KTkPhE8M1f1cb7N1MeHgs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=qjQ1LXVgtLZlqtpTr01dT4EouDbHQJMMeqqDtPzPGaAr9XLqaO7Y4I8d9yR+jCwSYgphn1TSK29anwKsMtxM/05ETrGUdNQYz4DD40+NR/93zxBqAr9O5J3eZs/25LrZ2NCeaXxreY7kL5nBlZK5Qj88PMAjopO0S4Hdz/LGUQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XEKaAmnQ; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XEKaAmnQ"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7a7fd79ff71so50962685a.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Aug 2024 15:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724882591; x=1725487391; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YGg+WhyiSymShH3cWkbAVpXegWlgstEWdsmAMp93ltM=;
        b=XEKaAmnQ9KfBXj9Hk1QWTp0XOfg7UeuChtqvRfzsEFhHh5rq+xZtvQbcQU2YXp0q4c
         NBJDCKoO7vXiJNdMgxQXqKZLo0ubH3xZC5rosupKY67YPN5fAN2tBfM0fCfcGFfSLiA3
         zv3DV/nU9/E4vJ4regL9+oVKOsnBnY/QcQ5CR+y53QQ9H6neJXPurJKEmdOClZDCJumF
         6IR3sN6NqyB/i4+bkjLUUixAFHAI+xFl5/MuZ1avoP+yaEzuWXuF0HUCl5b/JGD63ch1
         435ZuVTNo3eKbGdOy3PJn1QHTpfUQZSyRl3CWbEpgXBj8kWtlSgVGmwVrF/RiemlzGIS
         xxyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724882591; x=1725487391;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YGg+WhyiSymShH3cWkbAVpXegWlgstEWdsmAMp93ltM=;
        b=C3lkIxKGCCAgP7s2xC7l5Znkfp3qvGvTZtsafYn0FhC8BHpAEk8A0Yz+nGYJpJWpd3
         jldirwrWvUeL5p11z6aUWp2eJ4+BUwDd6DKq8xCs9FBNkq00AHGN9Hwc7KckDNTGsm2/
         2G58e0M2+EImLYaiBx3DXIu6MtGZhrgZiLHaKjZ9w2893UkGtFrJBV62rwyJ+9vNxPFM
         0forNRXhxqnzI9cd4cqjlRadjqAM6fv1ExCmGqb//L+86MYxpCb+pnm9/FQS6hmHIX4d
         JpJdpy9uEHTi9IiiUt2Dg2eIwlmt883T5HBAMZRMrxBsJzavSygCv/EyN75yrMrdr7F4
         mWRQ==
X-Gm-Message-State: AOJu0YwcB0qi/+14pDF7KacLN69KxSAj5bUqA4fIMpmTNvhOp3u7d3MW
	OsqY1P8cEHNYgsy5Cb9q2sev9kdlU1rNQNBj/tv6vrH1x81oVqL4Uhu/Yg==
X-Google-Smtp-Source: AGHT+IHvCRUaOxzEwz90Vt2boikF3jrWOnnCB4tdXzDhFPN+hTG8TMp4R3t/cszODdtGcIHJHQb2Zw==
X-Received: by 2002:a05:620a:430b:b0:79f:11a5:149b with SMTP id af79cd13be357-7a80425a1edmr73764185a.47.1724882590862;
        Wed, 28 Aug 2024 15:03:10 -0700 (PDT)
Received: from [172.17.0.2] ([40.76.254.131])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a67f3645efsm676278885a.69.2024.08.28.15.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 15:03:10 -0700 (PDT)
Message-ID: <66cf9e9e.050a0220.17dee9.c2df@mx.google.com>
Date: Wed, 28 Aug 2024 15:03:10 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8844141901611046770=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v2] shared/uhid: Fix unregistering UHID_START on bt_uhid_unregister_all
In-Reply-To: <20240828202949.924451-1-luiz.dentz@gmail.com>
References: <20240828202949.924451-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8844141901611046770==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=884452

---Test result---

Test Summary:
CheckPatch                    PASS      0.46 seconds
GitLint                       PASS      0.31 seconds
BuildEll                      PASS      24.52 seconds
BluezMake                     PASS      1696.14 seconds
MakeCheck                     PASS      13.96 seconds
MakeDistcheck                 PASS      178.71 seconds
CheckValgrind                 PASS      252.44 seconds
CheckSmatch                   PASS      356.46 seconds
bluezmakeextell               PASS      120.07 seconds
IncrementalBuild              PASS      1455.33 seconds
ScanBuild                     PASS      1009.01 seconds



---
Regards,
Linux Bluetooth


--===============8844141901611046770==--
