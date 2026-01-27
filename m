Received: from mail-ot1-f68.google.com (mail-ot1-f68.google.com [209.85.210.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853652E11D2
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 18:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769537664; cv=none; b=ZAxZQ+LL+QqFoFbvc7gy94K/Zi/ULHLDkddgXTMoXaKt+4Wru5YMSCIUs+643OK3D3W2Q5/AISH45zyy0v91+8dEUgtihqWAv7y2RrFAN3R/+pZijuMTqZ6ZFP8AL2aSDrdFQvnGZuEZjHZspBZtrBrPqlqZsBQFv0Sp71PPywI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769537664; c=relaxed/simple;
	bh=0tsmvbWn17j7VAz+Mgmq7+R8knk7B/JD/YJUggd+TwY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=QWQVnvbfAb2m+hvsXbgZ6aYEkknGnk09SgCDnVDQJHuVt91UBtC6gS+xtXEy9AI+BBoF+SHVjIMj5iPx9gydKslyFo8JOVoCBiAqAoutXDHYhN+FQ7B+130aLC+DjSD51y5rK6Uw/axyuaJlDVmj7qPcNme1c2xPnZYmE2uyAjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iTXp/7q8; arc=none smtp.client-ip=209.85.210.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iTXp/7q8"
Received: by mail-ot1-f68.google.com with SMTP id 46e09a7af769-7cfdd3146deso2317420a34.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 10:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769537662; x=1770142462; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/OUdmY255/nSPKdA8fvengELyLM5pxWhZO07ULzuZbg=;
        b=iTXp/7q8d++y1J6xBfK10Lj/RvupyNOYRFPV68+vdQ4Haop8isQ2ASbDQ3/eJtdiCm
         LXDOcCZ2PBs9sOYJ4fb95O/iRE80t3i5Jsi28hQtru2KMJcD/V/iS1AWXfREo7AwYSOJ
         AL8sckRXaQxOeWB1+nPnTi0VaW2+gp/trstNRpWfn2Gbvz0GLLA87q1VzqWewAPzrCgK
         Dfxzf1KVXOlEf0XkmMfP0YvYsLHTlu11Ye1MIL2eWJ5syC/6z9ivb3+hGvt/QBhPGlQh
         Of2CLli05o4rg1SHbiOpOPcw0xrLOTI1IVHdqKR4wpcHoVIAe0WzcNzWe786IatVeRef
         mzxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769537662; x=1770142462;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/OUdmY255/nSPKdA8fvengELyLM5pxWhZO07ULzuZbg=;
        b=RA+NfBF7WGTKSV72l1pATPyV0FcEOkYlysQgqg2l9xzJ5CdkmjqiBPGz/Xwn+Poj6T
         vpp282Sr4eNPFDMgOsWN4fKiwhpykxKonenarV4bCJQLcPUSlUQw5RrO9ELmWxtLeh9P
         4n7TT+gyiApV7JlzgFeri0vJo1cDuKi4/HHoLJ9JnEn5jysb7KzxiC5Ojxm3qOZxA2dD
         TMd3dAM+AJc/HlFVP87eWfmfgwUfJDlBnt62uPVhUvgoWB0exm3CL0WPXQgsoF26GMO3
         woC8Z34Rd/9P1OdWRv5DzsSrE0omO7lrpH6hCfJpIcH09W3pBUkcYCkrgn7ep7Jrw+0P
         raaw==
X-Gm-Message-State: AOJu0YxnIo7C8bbx0RsrZI9GuUlq+gyTUvR2QDymalY6L/cxrrX6C1of
	p9zMMF2ABU9uavkVHL2GoJVSfvkHXWiJJJPIVnzBMb3cVXSiGlXO8wfzSRg2oIOS
X-Gm-Gg: AZuq6aIfMQ7fzWKu4fyUOPlMvmhrSO12mwfeaPwIg8+drx0wQahVRxIaskEVmEbeU0Y
	1WCjmcAHdV5tSaB63KztxXcglSRUB5A7UaQobsvE7czWkuZG0koRLYiuNN/qC91Q5qA0qeWtQJY
	3w0UHcyWCCnDOG0UkOcF8T+HoXQ909pdcmn0OrYEzA2P7jnmSt4um08RJ/XHquaa6APg+Uwax40
	ZmeW8yeKSoRliJJdYFxOv6yyZnxgQcqc+4sOvSHeBAoW0YS5CL5pt2dfoe5jrl8JQ4yk+6s0F8x
	zMBgs4nCsa6uso2L++d7gcb56LtXy+EEq67kMIn5z9pptQrQHoHsx4tSh66JFiTCxzoNwLCY4xt
	Kx3ornFr+W3LXdLd9Lz9TJrzF6Yt02Lo7kEkSBDQcOx8ppbRNG0UnRX1spd3hiJyc9dwUmL3/rV
	pCjbSHI1GO1gMiQZr4cuevaEg/ZhKv
X-Received: by 2002:a05:6830:3592:b0:7cf:d168:2120 with SMTP id 46e09a7af769-7d18513147amr1722310a34.34.1769537662069;
        Tue, 27 Jan 2026 10:14:22 -0800 (PST)
Received: from [172.17.0.2] ([52.154.130.214])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d18c670734sm279843a34.4.2026.01.27.10.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 10:14:21 -0800 (PST)
Message-ID: <6979007d.9d0a0220.220728.f829@mx.google.com>
Date: Tue, 27 Jan 2026 10:14:21 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6714137792977913610=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ] doc/qualification: Add PICS and howto for the GAVDP qualification
In-Reply-To: <20260127171133.151134-1-frederic.danis@collabora.com>
References: <20260127171133.151134-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6714137792977913610==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1047694

---Test result---

Test Summary:
CheckPatch                    PENDING   0.31 seconds
GitLint                       PENDING   0.29 seconds
BuildEll                      PASS      20.07 seconds
BluezMake                     PASS      655.90 seconds
MakeCheck                     PASS      18.41 seconds
MakeDistcheck                 PASS      245.62 seconds
CheckValgrind                 PASS      298.09 seconds
CheckSmatch                   PASS      357.01 seconds
bluezmakeextell               PASS      184.72 seconds
IncrementalBuild              PENDING   0.33 seconds
ScanBuild                     PASS      1055.18 seconds

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


--===============6714137792977913610==--
