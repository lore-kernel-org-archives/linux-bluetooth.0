Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B693ACF02
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jun 2026 21:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782249986; cv=none; b=DO/89HLKMXKfSr+557DRAvKMRCDPJvCLgIN15wRu8zpg6UiGmp/jltbhFACWOA/C+0rFCbGJ4qz2FYv1rtimWeKlyB9P8UIWedG5WRUACbkVNq00o3+xC6WxGdal71WD5aKVyXSv0VCQl6N+NsOzBkenG2AfLCF9wsV3nliJSJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782249986; c=relaxed/simple;
	bh=nnvb/Dyp6T0pRr9E+XGD66AUOccaxwAEIpBLRnolFQA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=FHJIwdn/QxdpPk11t00Vn3srAyXGMlEQYMLYOnGT0MHGRUR0ExgbMpP+dABIev+w13GnlekFNLit5ZHkJTiazhFwhVCw4/utTm6LEdB4rm4zcNb2NS1JNcsxp6WqEeYdlElE84snFLRYtASnmVKkpmqC39vKipOEOaBFEigb5pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JrKiVNtT; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JrKiVNtT"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-8ddd7bad263so3521956d6.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jun 2026 14:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782249984; x=1782854784; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HE+Ow4ja9C4EMy+Jf2tthTxvzEwaydu6UXtxKdBB0+M=;
        b=JrKiVNtTjRcy1Cz5htu0cClDBcgLASnrh1JjLwOYl2ZNNPyhffe+fwdn8Tywl664aN
         8Sy+Pl1GIJ/XLZwquvvnlwmg5QE3b3PLcoDTdJYn5mrDZtv9RWD1XBH4k41qg9FADL+h
         XPyeMGG/fVT5tjTJ8WRDQ7mGE/4EgJxqTELhMKvS0b+HPYimfsGUDKkLTCTFcd8oyUri
         ObgMx9KjtWXxCHgmLtTFIOSIXxnCnMuqWLgn5Ao/yP/12T/8Vz0nPwIjZ0tSOBAkxiqk
         YK/ys11C9QrPggG+weE2SDJu8yh20kRlAOxsnKCGis6CV72vI/f2neb5Rn4bXIl+45wF
         rSqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782249984; x=1782854784;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HE+Ow4ja9C4EMy+Jf2tthTxvzEwaydu6UXtxKdBB0+M=;
        b=UbhS8nyz05WAhLQJQqhYVuwBBdfuWfnAXGRhHrxdx9asJfOiuJbO7spC34zmUF8clv
         T42fKNAE0yLLyc+xQYKPbQIp4NDJ4VhWPK5xtcHQukQtX1hvCPAHiwEmmSFk7/IRRRGV
         DquEERO4GCewB5GwCJuV4q6Qe6jFi7Xwh3FxVd32dLxDRNopFZ8OK+svRoUiRZgxASa5
         mYq05aAs4Zy3WB3Sr0kE1XoEQhrdfC6vPP+cuZd5Z1cxcbuDvFx/Jo9XFxwwdwxQdjuC
         4duLvt/yv8WpIZLg1BjZ6SnRKZLSUhJVYdZaP76mCZvLE8u5O12oelaHiEl7xNmeVtph
         4UwQ==
X-Gm-Message-State: AOJu0YyjGtuhegqySHSbqFHUpk5sKVh1cVi3iRHX1vlkqwseIj2iT+2G
	q+brOeKtNzsMoq514f/QXJYAmKj78mu/GbQBbtkTJnSrvuBhehJfvBb0qapaFg==
X-Gm-Gg: AfdE7cmZUMupn3bYdS0IAkWMKTa/3s0AwMrE4raJ13G3Xd1I6NZdZsBsWVS/YGMXIW2
	la4F2uqiiWxao/8ReRtZQbCSADJhm9NOZdcXhZf6ezRY/Jj2Q7Lg95FNrtS9Xy6HjktwU0kl3/q
	ACmnoPdSMJUgWqRhb/qQpilTa9raKbAAQwStFEQ+csK3eyO2swiELElUXjU1XnDWqx5zBRIfVH2
	UTr7gAfDmTia/HJGBd56RBXWnHOCDdUUcJifxGmDQ9IAIqibPpPQIcmnoKfkYmQMFHx8VvwvZH8
	xIMj9ZSDbSCaThu2igrFFzjprkTvbpJibLs/KROZX8z1GzsEw2UalpjiPvXrc4wv2MPIJtpAOY/
	wVjtHir1AETPGgIdEAqY5n0QeWZRPFHi4SMfS8E4NwL3uGoBULh27bf1QzXv5xQZbGw+6z/r3L2
	SLTN5O+JfhVT3ehDW2pVA=
X-Received: by 2002:a05:6214:448f:b0:8ce:aace:eaf8 with SMTP id 6a1803df08f44-8e4042b8ec7mr79245556d6.43.1782249984195;
        Tue, 23 Jun 2026 14:26:24 -0700 (PDT)
Received: from [172.17.0.2] ([64.236.144.96])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8df81cdeebbsm141821476d6.29.2026.06.23.14.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 14:26:15 -0700 (PDT)
Message-ID: <6a3af9f7.9338f4ca.137dfe.f3c7@mx.google.com>
Date: Tue, 23 Jun 2026 14:26:15 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6434665571056737218=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1,1/3] bass: Fix possible crash on bass_update_bis_sync
In-Reply-To: <20260623191432.270241-1-luiz.dentz@gmail.com>
References: <20260623191432.270241-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6434665571056737218==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1115551

---Test result---

Test Summary:
CheckPatch                    PASS      2.77 seconds
GitLint                       PASS      1.47 seconds
BuildEll                      PASS      20.57 seconds
BluezMake                     PASS      658.38 seconds
MakeCheck                     PASS      14.89 seconds
MakeDistcheck                 PASS      249.54 seconds
CheckValgrind                 PASS      278.40 seconds
CheckSmatch                   WARNING   354.17 seconds
bluezmakeextell               PASS      184.03 seconds
IncrementalBuild              PASS      701.98 seconds
ScanBuild                     PASS      1032.34 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structures


https://github.com/bluez/bluez/pull/2253

---
Regards,
Linux Bluetooth


--===============6434665571056737218==--
