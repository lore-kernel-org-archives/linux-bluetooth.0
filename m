Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B6B4908D3
	for <linux-bluetooth@vger.kernel.org>; Fri, 14 Aug 2026 17:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786727714; cv=none; b=A1eMsUngXanshmn/YE8NoBHigXx1XA48Sn1SjcoiuNNV2v3ktg5ZRKyXysjvSeGY7WEvnsKtiZJSvI0oWZ1IXTTSyyw8UV11qlK5ubIJiRf/ULSKByNIghtJFdzLj0ZzY+p+gCJwwx1b61Tmd5jcxGJNbpUvWSq9lZ6ues8Pam4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786727714; c=relaxed/simple;
	bh=cfNdoi/AqbEIVL76btp+PnG/b1pUWqSOkrGjxL5ZOBg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q542sSq/nqbKtXAC6WT+4SnBe/jxAazQOqQCwArFOz2JCGFhUVXaWX+Wke8bsLfiT3NpZXI3xq6uRXwA4SqkelKCwRhzMhIN7rb30MxzOlAHM9u2SIlIbNtWVHbWRP/PznnAgwbensl/QNkhwWRXMnXiNH+GK9F9a0EC8BXN9ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BpN+FNqd; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BpN+FNqd"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2d004f135b1so17583625ad.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Aug 2026 10:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786727711; x=1787332511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eKznlJprVtfE3nfFItk+Tbwr9vjYBvhEz5q6vw5jWcA=;
        b=BpN+FNqdSwKB/udnSuiQ5QR22t7NI+5WpZYaMi/vgQ5WTG2XMMj/a/UxeQ6SOkJEGf
         qD/6rN3wctArCTnZhuJNsKXlRaohDjn0DM2kmMv3fY0tn+DXxvhg+ZRKnwIh13OebfNs
         38bJJsUnQVGy3CKYByWB3DLcCrq1Xm1lN1aOLSkpldDdABtJMc6hFFUNyTNbPaip61rN
         4Av0Wfnph4XCQCPzZHHbokPJKUnvq8txzoE2aABiFqDgzXmo8r/cxT/lFAbD1zQR1vXY
         +WOnetCNgR3T/1EB/3ceHO+TmfbLlP668g5pttGKfR2cBkKtWHH+8g7h62bpEa8eDRl1
         c/sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786727711; x=1787332511;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eKznlJprVtfE3nfFItk+Tbwr9vjYBvhEz5q6vw5jWcA=;
        b=loci7BvwrTPyh/Tawvs//k+Ytyo8Hj5tVTeopwVLqfebCBZtRILCUgbJKADpJaB8tQ
         BncahvJAMq76CYn8BSl5Bh/KQS69z5hncrrNc0VdOtXcIykYJlsfHyHoc8PWJJHxKV5p
         SAau1tvGOeJT+rzSQ3C8CoUY48UwyJXSe6DMvwkH6cxdw80FgSx7t3+k3vVNiRg3wQ7U
         tniMAQBWiTQtPuDLZ7AuntT7B8cglDF51JyqUuDb9DbJhYtWLxUJmhgDVealP14wTmWX
         6DPwawlChsSvofH47xagDKfYqV5STTp9Fa6oUQlb/2liDD75gXqBB8e4y0FJXvuHelVN
         Vucg==
X-Gm-Message-State: AOJu0Yz7oCMUwbi7HKuV1OILz0BEx0ZtyEcMVeeH8+s2mU4BIfh4XUmX
	5CaFEz9IRor6yvogjD/jb9h/WbFvpc6jqllvMysVqFUvyDlhZM3mNEXGfoXUpt3+
X-Gm-Gg: AR+sD130m5+crQKGStXglT4pV2hb9HkE4vxC6/d9gA5qp1TsrgLZVpDZWCK3XC0yUhZ
	aCvd72Yp/iZ8XSvNvNj/X5BlG1weTM7nonVrHxxDL1WuuZ1i9gre/H1lCVKhPYi5k0q/EOhpCXM
	z188tUSGJGxfGyjldcGkUQLPfwmeo7oL03GwS/eD3nV/bSOfgmn6eINzrgsfJp2343QKZV7I/J6
	d0VYl6d6S/Urc8UMb3WXEsVLhNdW9HQjo512MCQxLCLHxQXOZSH2bhzs4wmCnkJDslAFC5pdfNY
	pIR/FeJAdkl44Hn8oVI4Kbwp5qokWT3YESTvo1d2tJXZ+YlW2tjdmGexlDYcYEH/0cpn6SXaNAE
	EdQK4bTUGoiZPSTN2xdhu2h81VRK0cA9PFinvC7K9TWyZVHkIUrszezduD3Qei5UpFKIX+k+hcR
	olaHkCoD3R7czpYASM/tRjm6oDec3ARjcPDz/r2CiICGHTRcRnqGjhwddvB70SVK3kque7ePYlh
	nmRNEVkucNn1qCyXaSxPNdzL6DBfAsBruVGVfh8RvRgCcM3PRR8oYWaVw+wRGG2tahLJVu/S8yE
	VtuAe8GFd8+IziMG3P7ahvDJUKFd/ix76wz4BGpvXMc2Ik2+LWAfWRKmWDWSobktgQdhMRGJPJ5
	wHp6KgJrra4K0rUx9oNBrxlmrsj50QzUOuNyrz7+BL1+8eHMw
X-Received: by 2002:a17:903:2305:b0:2cf:4c0f:5129 with SMTP id d9443c01a7336-2d3b0cd91a1mr81765805ad.17.1786727711423;
        Fri, 14 Aug 2026 10:15:11 -0700 (PDT)
Received: from localhost.localdomain ([101.251.7.10])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-320ea2f787fsm6182234eec.20.2026.08.14.10.15.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 14 Aug 2026 10:15:10 -0700 (PDT)
From: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-kernel@vger.kernel.org,
	ali@iusegentoo.com,
	raghuram.hegde@intel.com,
	kiraank@gmail.com,
	kiran.k@intel.com,
	ravishankar.srivatsa@intel.com,
	amit.k.bag@intel.com
Subject: [PATCH v2 0/3] Bluetooth: btintel: harden version TLV parsing
Date: Fri, 14 Aug 2026 23:00:00 +0545
Message-ID: <20260814171503.42684-1-acharyalaxman8848@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Malformed Intel version TLVs can make btintel_parse_version_tlv() read
beyond the received response. Validate the minimum value length for each
known fixed-size TLV and bound the firmware ID conversion by the TLV's
advertised length. Propagate parser failures to the setup path in a
separate patch.

The two bounds fixes are kept separate because they were introduced by
different commits and apply to different stable trees. The parser error
propagation is also separate because it changes setup behavior.

Changes in v2:
- split the minimum-length validation and firmware ID bounds fix
- use the appropriate Fixes tag for each bounds fix
- keep parser error propagation as a separate behavioral change
- add Ali's Reviewed-by tag to the two bounds fixes

Laxman Acharya Padhya (3):
  Bluetooth: btintel: validate version TLV value lengths
  Bluetooth: btintel: bound firmware ID by TLV length
  Bluetooth: btintel: propagate version TLV parsing errors

 drivers/bluetooth/btintel.c | 44 +++++++++++++++++++++++++++++++++----
 1 file changed, 40 insertions(+), 4 deletions(-)

-- 
2.51.2
