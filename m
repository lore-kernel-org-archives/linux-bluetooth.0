Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93DE577E26
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Sep 2026 15:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788969259; cv=none; b=qVkmrI3q+mjGncdd0lUHcHf0/7k2KKpnkdeponKe69LJyOoG/pHVttZQN8pLGCPRU7ZohXUsfFsfhdyitu6sfK9W8B37ndaOxhGFMbxRIW7J9BXGJWfp5M3ocoZpK4CDjdt5enE0XiBA+oUU3WIgdwXrGNouNneeodi0KgdFV94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788969259; c=relaxed/simple;
	bh=Sc6st67IpTOk30rb6eej/yE3G2KqQ6gQQRk0CmbX2mE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=HbFBQ9EKoSafqtl5oWt9eK+kOPJrNCvGOgegJmtHNObKKXDQFGTCMFWiY74lNKep7NHeBnQGiLy8m73QWJ5y0wv278wzjHZSXDGpSkO/S8aG4WpL6iHpembYnbbwt1DLkABui2q+ZTnb5U88rSaPif+hbJQlw7mTO0rRLJseSu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K7byiwNQ; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K7byiwNQ"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-92edb12cdf2so426278785a.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Sep 2026 08:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788969257; x=1789574057; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=CRhTrXNck3V7dxRmQzYdSIN86J0KhwXcRs42mM9jBs8=;
        b=K7byiwNQN+//vgWelp/9XX16WfqzEsnYDsMeFyHwhgiWoUrL/wLIK6/J3miCqWNQ7d
         A7YJl4ga8Bh0tiuPjJKyEJf2NpeSeCrnGOT9yqcN9GgKSuXH2ER5xIZjDKQ6iQ+b1RH/
         n1gdQyHE5rAWXcFmik5NjqDyjYa1zf5CJgBnvPD1jDy8Pfwrk2UItQyp32PsWyXrPnm/
         011HRefYnmLpvV1j8fvgkB/GIOkcs6TtCkxUBK08UAsv7DlDefdKRGaXtiXhWF9ACAo3
         kscw/bQgrcaIWA7LzjkbECBN5acgk+8hcTlPv5Z/3d+D5U9AY43LiZU3xq0p+elI+M/z
         J5LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788969257; x=1789574057;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=CRhTrXNck3V7dxRmQzYdSIN86J0KhwXcRs42mM9jBs8=;
        b=ncPX2nZqmi05kE7CbPyyqk+yi0Ul25ijSzKJH2FWzmN21m7Mf6ElBTC28Ttk1uPpfh
         24hNCtYO1V22bzeOQ8u6d7XXg8kfI3WmvDiS5qgI/aT/1Z4IYw+yoa2zpMCIJFsY+R1W
         WXco2Ok/RATTE3qu6gxJvQBeSlHiNp+8lwxKdzjR8juWDF6accuJGIIw3EE7/QBSneux
         TBT9IDLQWlM7IRSa5zx+BycXbt6z7EY3fLLnGa/JDazl/JkW/TQrRFUTLxkhf3NrsfSc
         LBNx+MWIYSZk3BZpkoUzCiDlwEj9mp5SUDo5Y6jBiURIrOpriqTVQuZMwZYZpwtOq84z
         NDIg==
X-Gm-Message-State: AFuF++k8xL2Si8wWn4HfShesL5dSz9Ly5iEOsCqYPHY3drPyVcKHNV5T
	40TJlSvqTr48PhmWOecXTPa/tkC5/F9lUZpvUSm0jHo9VUlq2P7IqS/uBB5pjQ==
X-Gm-Gg: AYBFou3REiNp9sKKYFL9II/LYQw+omBblSBLCqibOcWzjRYtOG6c3qvQZqm/gSVedUi
	60G2cNuDM6+gNRhsZ8bvzCiSpVof7CjQZire80cgtvCWJJ8w1Jb0Q6sReMHLgcez7bTFrli8yNr
	NR1n+NAYlKRwEnb89x1d0Kdc11FLgAdX7GOGFNNTLjJ/WBYXAOERMmq8M2CsffLDEwrxiXUlv79
	ar8I5C+xmzOW4ZdzxXKSLcZLhpHU4qro3AX9vdn4K6LjkBQnld0Kv4oQnlu5yXe5FBgRK7JVr+E
	oais/ja/uIRFj0M/729ad3DxoEnvl3nG2WBN1xK1dCKqgV0KE3FO0A0LaWUrLgIicixrU/RuzQG
	3Y5EHnI8u/ahGHBMF+v/tXUXrsm7k82xEjg5yvKjYlxGmyWo5b9HZWypOzRX6Vr/Jiaq0P3yg/n
	86ZMry4mHhv+QKuSYhilDmld01iXeE7rDaeFp/WMSq7zmHoGW8C5fJU2K3w1sQG+U8nMy0NYO60
	JU/I1Gb
X-Received: by 2002:a05:620a:3942:b0:939:b8d6:9b1c with SMTP id af79cd13be357-939b8d69ba7mr1642059185a.19.1788969256349;
        Wed, 09 Sep 2026 08:54:16 -0700 (PDT)
Received: from [172.17.0.2] ([172.174.198.168])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939cb4317bbsm228240285a.14.2026.09.09.08.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 08:54:15 -0700 (PDT)
Message-ID: <6aa18127.4b1543cb.2973ef.3ed5@mx.google.com>
Date: Wed, 09 Sep 2026 08:54:15 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8807381390107688142=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, chris.lu@mediatek.com
Subject: RE: Bluetooth: btmtk: Harden firmware parsing and improve logging
In-Reply-To: <20260909120011.1198001-2-chris.lu@mediatek.com>
References: <20260909120011.1198001-2-chris.lu@mediatek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8807381390107688142==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1161280/

---Test result---

Test Summary:
CheckPatch                    PASS      2.08 seconds
VerifyFixes                   PASS      0.12 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       FAIL      0.90 seconds
SubjectPrefix                 PASS      0.36 seconds
BuildKernel                   PASS      20.76 seconds
CheckAllWarning               PASS      22.68 seconds
CheckSparse                   PASS      22.12 seconds
BuildKernel32                 PASS      20.55 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      373.08 seconds
IncrementalBuild              PASS      25.94 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[2/3] Bluetooth: btmtk: Improve BT firmware logging

21: B1 Line exceeds max length (94>80): "  [  365.245951] Bluetooth: hci0: Loading BT firmware: mediatek/BT_RAM_CODE_MT7922_1_1_hdr.bin"
22: B1 Line exceeds max length (95>80): "  [  365.245956] Bluetooth: hci0: BT HW ver: 0x7922, SW ver: 0x008a, Build Time: 20260605203811"
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/727

---
Regards,
Linux Bluetooth


--===============8807381390107688142==--
