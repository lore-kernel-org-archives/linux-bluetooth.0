Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FC142BE8E
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jul 2026 09:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784800684; cv=none; b=n7EnWLVkxF+PwPmGUxtfKBorzw8Kb/Rcal6JPdRm0UZZ7DiacJmFiMIdPgayPG0WTt7G61n1jEjfxEKnssT2fxgTMhz4YpPkcUbZWlSl4g06nbcfL7EhFES4dy6IuMzFD2TbSJJwswQkSR1q7ou5SSBkFixi0xi9gpQ+WI2RWp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784800684; c=relaxed/simple;
	bh=Sq6f6yGw7SUPnpZ74/ZoCg5e+zQGX4QQ5+Cy3XXTWNU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=UDOcB6B1rNEQl1Kqe/Ckcqg5Ol0SKBXXgZmZ9xavvspy0JxJm7H9TvPNmWmqt3RsQlPkOBruVuIOxI+JKpH8N8Zkr0LbSGqKVeenyYW3h0i3JV/L+rvf5Iqg+YCi5whOzpAGi6zfojLZRpp/6KChal0/cz275MR3JxTUzHfMB3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=heu95BVH; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="heu95BVH"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-51c2149571dso3254151cf.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jul 2026 02:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784800681; x=1785405481; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=kSkGJJvx2+t6ND7Xrn0RtlwhBa8Bvm5OR8UCExXR/Ls=;
        b=heu95BVHc4aq5d8kDwOe58f3ktXlyP+9WJ9QOnHrNHAHpd+Z6EAUbE23h3YX4DOpKA
         cQl8F3hoPVfM4/czN3T1rEVHiP+qvFCDJ6f4tLp8iEIFnVpwBi3PN0h7vGrX+aWrbVXH
         GfoMSrXXibFAk3jCK/H9A5Sqg5lRpYUywqQFIsyMC/rCFvg2y1715Vtv8FK+gMavJ83r
         4GUTVLiU5tSiqYro/nw6F6ZdvTGmdFQ2hpBoV4Ji1TYARJJkGMku6ahfUmn6T/xqdHS6
         y6TZ6cc2/KlzLLgHwjVzrgUfA0LxoVC4HDnivJVi/MWc3pQecvRFuG8jFkGpONiTRcW1
         o3vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784800681; x=1785405481;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=kSkGJJvx2+t6ND7Xrn0RtlwhBa8Bvm5OR8UCExXR/Ls=;
        b=oM5whiSnTCvNwlahT245DbUlfrjUd/46Kn1zoMmFc1RZST567YugMNPpiITRK3SlxT
         BpmBsOj5pz/NyyinNQZ7HVoZztw/nGseujx3LIzEz5p0+88/6XmIvLGYyvK3wMuD2XdI
         +FNVtf9L+ifxNPtkoarrkTa1MEFrCqVX40CzjACodTYbTL7aS7aTov5vMDrpVKkoT6dj
         mkDRwWQl4/SA3kTLCDWNv0xpcmIL8jMDnumKHJk0WBCu9sHXWDLofEXVDi8WqQsvspNg
         Cr5yzQUWcf5G03DnCsI2sOu6fnYuSVz16nwLNr0iryDriyzowRNev8JlHXpgZIJuiK8G
         hV/A==
X-Gm-Message-State: AOJu0YzWwsaGidDq8SLutyL1HO8qFNPaJX1brtwH/rGWoqwofcHK5xCA
	IPxEMbQQRf1xLlVG+utNtlOn/2DS1VPKUdJg1L2KOVLkgWEQLHLbhfla9aEAVA==
X-Gm-Gg: AR+sD10YefagIkM6xew8gVTfLqy+bjCwcf0SIAS5ZWlUAmW78D8uY3hT8c/ij/VB+pR
	CoyTAjumLO1sIMERi9zUF1anz+5PoO45Bi3YREUn9YCrMH613jhWpTULeBGN1TZ5z10tJoKqq1t
	MLwhnvtL0mSXUxdhq2fA3a1EeQhd08QQBIg1CSLeVT4B6kMnEBvblnINouRI3RIkoBqtU47iy2E
	B8qTLPuql1Z1/YzJFHGj6BJWG4q/L/sK1vI/EZPVuy4yy6qZxaWxmBl/MQ+eoi88Elw0LdHZMzY
	RDthIYGTovLnEwsyB5kgJvGPzv9OF9MfUBlpHGLkgBK4/KjH2vlHmqom0lX5X3/P1wiFtkc4ffc
	a4Hp9sDLnFMs2LH6SMRv2QLv/ooy1fZRNKVWd63OiXlVBuB3cKHY2jefrxH6pffaJQtP0cS7MjE
	ngoO7g037Vhg==
X-Received: by 2002:ac8:5741:0:b0:51a:8c97:fb90 with SMTP id d75a77b69052e-5283df4fe92mr19029061cf.57.1784800681267;
        Thu, 23 Jul 2026 02:58:01 -0700 (PDT)
Received: from [172.17.0.2] ([52.162.137.104])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-527d3b3f66dsm31518121cf.27.2026.07.23.02.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 02:58:00 -0700 (PDT)
Message-ID: <6a61e5a8.3e3849ba.57e62.9471@mx.google.com>
Date: Thu, 23 Jul 2026 02:58:00 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============9026740846183621294=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zuohongsheng@kylinos.cn
Subject: RE: [BlueZ] gatt-server: Fix integer overflow
In-Reply-To: <20260723084231.93626-1-zuohongsheng@kylinos.cn>
References: <20260723084231.93626-1-zuohongsheng@kylinos.cn>
Reply-To: linux-bluetooth@vger.kernel.org

--===============9026740846183621294==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1133054

---Test result---

Test Summary:
CheckPatch                    FAIL      0.42 seconds
GitLint                       PASS      0.30 seconds
BuildEll                      PASS      20.28 seconds
BluezMake                     PASS      490.77 seconds
MakeCheck                     PASS      1.10 seconds
MakeDistcheck                 PASS      150.84 seconds
CheckValgrind                 PASS      147.90 seconds
CheckSmatch                   WARNING   291.15 seconds
bluezmakeextell               PASS      93.95 seconds
IncrementalBuild              PASS      495.99 seconds
ScanBuild                     PASS      863.79 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ] gatt-server: Fix integer overflow
WARNING:BRACES: braces {} are not necessary for single statement blocks
#106: FILE: src/shared/gatt-server.c:1192:
+	if (len > UINT16_MAX) {
+		return false;
+	}

/github/workspace/src/patch/14705742.patch total: 0 errors, 1 warnings, 26 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14705742.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/shared/gatt-server.c:271:25: warning: Variable length array is used.src/shared/gatt-server.c:614:25: warning: Variable length array is used.src/shared/gatt-server.c:712:25: warning: Variable length array is used.src/shared/gatt-server.c:271:25: warning: Variable length array is used.src/shared/gatt-server.c:614:25: warning: Variable length array is used.src/shared/gatt-server.c:712:25: warning: Variable length array is used.src/shared/gatt-server.c:271:25: warning: Variable length array is used.src/shared/gatt-server.c:614:25: warning: Variable length array is used.src/shared/gatt-server.c:712:25: warning: Variable length array is used.


https://github.com/bluez/bluez/pull/2343

---
Regards,
Linux Bluetooth


--===============9026740846183621294==--
