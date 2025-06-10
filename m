Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8321E8338
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Jun 2025 16:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749573509; cv=none; b=pMTQKDhRZKnoTRPNtOGn5bjA2Lzl1fTTNgm+NoadbbHk1gMYa2nm1IiWLNjclfeHla85Z703mhwvsFyXP7fqEOySo3/cNvT1Zc7OaZ0ue4oUTtMgmyHhp43QVzkG6YYuwh5QPbNerY5U35gzWFz3+BWrJBXnpfyfSjwcCcFxeco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749573509; c=relaxed/simple;
	bh=YQtzN84unq4JCLZcnDvAowSgNWGMHqGpbbNQKp1+bBA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=qhyDmCNJ0MIKiQiSq7Rb7emI2BbNX7eG3E0DoLdU8D/iJxpV6NfPe+lakcWdTtVZkDZdY2htNIR6gzoADjVrDxXDxv5FU8yAXQNg+fymgHapPZ5lWO4TQw35O6PefcwLwvSdILAZSWQBCzJGLOdCdoxN3l4Mgpi1kBfl5z3MSow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EBGUVQi/; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EBGUVQi/"
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3ddcbe64d0dso45236155ab.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Jun 2025 09:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749573507; x=1750178307; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=W1upPFhAHtFM53GU5dQVPpJct4QRCYkrA211AAYIkc8=;
        b=EBGUVQi/oCYij23Ub2vyK1HBIp6sJceGOKy0cBO2Cf4Ts0IoQfA6UC+cW4MxkrmE7b
         Wg6vEAxClzcdyIa7qDh+dJhHzIz3W9HpIUnYcL4UahnO9jEspEB/4rACarUbAsP0sHcG
         +mNyyMTrwTrcaEauGYdy4KXz/8xDB9SWXLA9iz4Zmr09WKAv4rGtNpSBtsAZgbX13tZb
         jxh1XnhJPKqFlF1xs0SDACQ0hLwiry/H1ClnI7bWjFKO4iOrSFs7i2VbdyTTagN/a+Cq
         fBPcpQbp5jjEmhu3mTDjc+kvOA4NKDG6mNYOLAe7GFXsTSSq+WK6Q3NYwWVTa7kwlddL
         ALCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749573507; x=1750178307;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W1upPFhAHtFM53GU5dQVPpJct4QRCYkrA211AAYIkc8=;
        b=EdHzoagtpW3iwkxq1lHZGa7svbciaBrWR/9XvdTpTppgqS3nq+ykG0Xa30OekwZxEc
         FNWf9xciJ9Z2bI375+CkB1yvrrAuZcgIcrN19WlmuJP1TRVbhGFFz+YdbPRfjNG33p86
         gHq4/RhvUdHkboHArSRPtTDk6GXpyfuewG+6EpcbuR50POVVf2idneJHj/pyOPZxT6mW
         4/TTXaX3hW9TA1A94Qvq9nC6pYucdu1/vdJfqxs52PSfyLLDtwmeuuxMy5UvKaJDRV94
         kteqV9ACOfhXT8tR2QO8xOnZss/LZkdET8Auo1UGunye5Th/+yBIYVAkwEYrMRoMh4Do
         soHw==
X-Gm-Message-State: AOJu0YwPRk/yzg/kM2Yvp3jtjrqz4E1cQxGjwdPJqmEbP4lR69PDRn74
	xkDURoHCki8+mJ6DMXrqLmY2shf5uLFAxVEaoa1lWuXu1VERBVIH5M/3XB68og==
X-Gm-Gg: ASbGncs1GBmNuG3POH3XTkpENx9mSRCclNlXljFeHyOa9sIFPkHK7NO8LgN1zzpR532
	fUYwBmEMtGrcR8tBbO1rWVOgeD2Cd5OBFddBQVdYpHIXrqqjoaL8TfEkWnaNRaUfLThUM3tmqvi
	/zlmBYzedB3bv74EThJfKm8BeP2Q43BI7hlKS2nU+gTj7bPxLCTGEsWrufrbdO5MXc1umJZZj/B
	Awurh7zqmfkLi8p85e7XcIMwxYHY0eb7EjryLRnYns+B1LUiG95jhjwoFvOjKlvJyGANiMJI+t0
	msWeNRNca4AjaZtLJkWKGMzOFMDb8espiggnK0aA1rUhfcpceh1l7aAnIo+QGPIYv5+SD2i8mMj
	yPg==
X-Google-Smtp-Source: AGHT+IHXypDqtRS4v+F9ezl4spozMlgwxDJ3OY90b3vAetgpGUSthRxFJ06ZDGICJ3wvlr2iRy/ZJQ==
X-Received: by 2002:a05:6e02:2513:b0:3dc:76c6:436f with SMTP id e9e14a558f8ab-3ddce49104cmr220375625ab.21.1749573507227;
        Tue, 10 Jun 2025 09:38:27 -0700 (PDT)
Received: from [172.17.0.2] ([40.83.48.116])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-500df3f64afsm2400248173.20.2025.06.10.09.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 09:38:26 -0700 (PDT)
Message-ID: <68485f82.050a0220.194384.31f4@mx.google.com>
Date: Tue, 10 Jun 2025 09:38:26 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7149111217401147410=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1,1/2] btdev: Fix not setting sid on BT_HCI_EVT_LE_PA_SYNC_ESTABLISHED
In-Reply-To: <20250610151138.1093270-1-luiz.dentz@gmail.com>
References: <20250610151138.1093270-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7149111217401147410==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=970417

---Test result---

Test Summary:
CheckPatch                    PENDING   0.35 seconds
GitLint                       PENDING   0.39 seconds
BuildEll                      PASS      20.37 seconds
BluezMake                     PASS      2803.72 seconds
MakeCheck                     PASS      19.86 seconds
MakeDistcheck                 PASS      201.50 seconds
CheckValgrind                 PASS      278.59 seconds
CheckSmatch                   WARNING   307.31 seconds
bluezmakeextell               PASS      129.15 seconds
IncrementalBuild              PENDING   0.23 seconds
ScanBuild                     PASS      922.86 seconds

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
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
emulator/btdev.c:456:29: warning: Variable length array is used.emulator/bthost.c:668:28: warning: Variable length array is used.emulator/bthost.c:669:32: warning: Variable length array is used.emulator/bthost.c:886:28: warning: Variable length array is used.emulator/bthost.c:920:28: warning: Variable length array is used.
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============7149111217401147410==--
