Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC061B4247
	for <linux-bluetooth@vger.kernel.org>; Mon,  3 Mar 2025 21:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741036314; cv=none; b=GFyLc/Ah3a/USXWuVViJheZOcQE4yUCKseQxJ6+p4IEK/r+55AUfWdKkwGWyzOKq8qBA4x74OOfv/andKa2bDS1MoeXss9N4kMcj4aFI6KOwP7HcX9mjkxEFBAeesnZCygCw/yjH+x5IsQymTzkjYmM+C1MJChJOOMQybMTzElE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741036314; c=relaxed/simple;
	bh=VY5N+NJhofp0WTWWFx8YL6Jk4pqAWjAj1S5M2yXdg1U=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=PiBkLXOXB2PK9jEG/XfwlF/VKNgsCUD2W+ezPPar0+bxABuOzppPriBr4hMQ8lsKD9k4TvTX0joM0KsQsyBv9VGb1NdpLm9H9ueQCMcJVeZ/dOQyCMgqOpe8cenU3C2jkV0MBpmxJrQbz3cmaD1RYpOs71Vo0gh6vG+42FojsRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B9c2eFv5; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B9c2eFv5"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7c0a974d433so552861685a.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 03 Mar 2025 13:11:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741036312; x=1741641112; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lFkmLcaWQ07MYyJW+42l9UaUuQfyKenAjZknR9/nwSA=;
        b=B9c2eFv5H5QhzIv+faxznj34HEb0ScN8zIqScnRAvl9C7C3HHxcMtwR/TK99VOBZ9x
         Wd6opr7SkLDkwlygndVSjpfbxKKRmWRMwMMDry186PoJi6o2kFPmqhcJmhgZ0drGlUQK
         8VnUqKp/+yvYLgCQ1qMrYNYaP36UpphIF8FPDXHt9IUwAyhJRhCXi1auKxf5XuZkZU5J
         1KRk1bx22R/6DymHMvdOmagGFQ4Yf4TUAOiX8YKQfBHg7Wpo9hWesnFPXSOs46kbsqwV
         DcP5xUOIvW5kgd+XF1gzD+v9Xd6HQOwihGRFIWCNsMH6PwEufiZF7H9tCx1r2x9ZKUVN
         1ZTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741036312; x=1741641112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lFkmLcaWQ07MYyJW+42l9UaUuQfyKenAjZknR9/nwSA=;
        b=Z/iARPole51ZzjmmzOjZjuUCuxI1VVj9Bf4Ztc0jWq2sfU8mb4UDvMtLqNFiecnDIS
         kjHB/jqB/GGIfvu1FA8Gd0oh2GfaBtVra5RFsnGAhKJgqs/JFYLoz+PDIUETpeglN7ou
         6LhIJaHYTcKqDKm2AYJOi3PzjNo6/RvfWvLKeX8Gg/64WRgJJcY+w7ueXWoE58zJDvQC
         mkY4TII0gc60wYNna955fIUI8x2EPWkqSQjGdE588Rva5I7Sh53l2eGACXz1APwk447J
         xJgqF6pKduUdhHMzSeVV3wsO2uurxwcJdD2+S8c+ArXMahkRYeuriUwONFj8gZKG+sLq
         LafA==
X-Gm-Message-State: AOJu0Yy2xLEunl52Bv54jYtyTDW8VOO5EWqFwB1IGfFDlj+wGw8+v9A2
	rKf2KUuEQDpnkmOCElLXaBvelaAgdUPhtMRuG0RarAIXopupLL+ZajOqaw==
X-Gm-Gg: ASbGncs0ec7JW95GZHClNG7UBNBOC8qyKLCI3Dwax/POC3POiLiWzm5sCuYhPjvA+7F
	sK8uEUWiDpBM4tYkTKa6LD8ZXLZ4pXplGpGfZLVGPKvcKMtK6tNc8JIpp+RaAhb0Zk++rOSb9rE
	v03CI6DEdD2kzb+9V9zXBEIvh1qdGhMPjqz29ZVyv25WK7VblkDU8zdze0IeJ9mEEIm6Y0zEfPZ
	pFegX+E5ss8vGeqOkKnq8DFrGm/QJo3IkO/d8jDMwaw9OtPVDhkDYukoY/NsvB9iTQdo6qJSu1K
	hUAQ80W8hhnSeP+j67mcbpDn/8/S7By0CRYnztGMCKopgh4ZI7M=
X-Google-Smtp-Source: AGHT+IHz7eTWt4VuJR3jEMn8bg7KHwDHv4pgsN6nrjapJA4+7O2Otu1IOMATfuU5XH1jOWz0FRHImw==
X-Received: by 2002:a05:620a:6601:b0:7c3:9cc2:7825 with SMTP id af79cd13be357-7c3cc308772mr134913685a.4.1741036311780;
        Mon, 03 Mar 2025 13:11:51 -0800 (PST)
Received: from [172.17.0.2] ([68.154.30.148])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c36fee9d22sm646791785a.21.2025.03.03.13.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 13:11:51 -0800 (PST)
Message-ID: <67c61b17.050a0220.2dc98f.6f8e@mx.google.com>
Date: Mon, 03 Mar 2025 13:11:51 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============9141915838490917909=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, arkadiusz.bokowy@gmail.com
Subject: RE: [BlueZ] doc: Fix typo in the copyright header
In-Reply-To: <20250303195557.31190-1-arkadiusz.bokowy@gmail.com>
References: <20250303195557.31190-1-arkadiusz.bokowy@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============9141915838490917909==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=939746

---Test result---

Test Summary:
CheckPatch                    PENDING   0.22 seconds
GitLint                       PENDING   0.25 seconds
BuildEll                      PASS      20.33 seconds
BluezMake                     PASS      1478.16 seconds
MakeCheck                     PASS      12.83 seconds
MakeDistcheck                 PASS      160.31 seconds
CheckValgrind                 PASS      215.43 seconds
CheckSmatch                   PASS      287.18 seconds
bluezmakeextell               PASS      98.88 seconds
IncrementalBuild              PENDING   0.26 seconds
ScanBuild                     PASS      864.54 seconds

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


--===============9141915838490917909==--
