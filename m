Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148B22EA754
	for <linux-bluetooth@vger.kernel.org>; Sat, 15 Aug 2026 11:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786791693; cv=none; b=BtooG+tIn9ha8AMsr6ozdHFx4lBpA4X9/EsYII66AYaVv7w1wPXCsTzQYVDLNYL1ItFKXUYMTQ2Dz7CzH8htPe5dpdE6i+CgBYD3IgEH8ioQFF9+u9EDmv2CEobQaTUxsYrVYYZqbtNuoDoUuzdj3PrEJgOdF9hMcHfZ3uyGvVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786791693; c=relaxed/simple;
	bh=e3Qa6fFRrhGusC+79pOqhSDTQ9k7dhnThWmC/ID2T9c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y76cC/80ICVQGXMh8Mtq+qq8a739kC0h+eMhgWgApWjwPoRZvU9cf4eZFUj1hw19IIwTeV4Xi2BeQUp+GVZJ7AK+eXUer46d/OIMPsanMLgnXOd/01Ag9P9uo10IhJFOK6yZGQQfNNXcENrX6GcMA01SIVWGFzE6eiZFzI4f0fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XpARxfcb; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XpARxfcb"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4998e0916faso3984565e9.2
        for <linux-bluetooth@vger.kernel.org>; Sat, 15 Aug 2026 04:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786791690; x=1787396490; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JhpLH96yWQRLag1AzHDPgAFi9pZTcqqLwnfeJZRrbFc=;
        b=XpARxfcbOmNEe+aZJOU5abry/h/twk7n/MEsDC0NMZtSsRcD3+sWPuiBSEZjXyN9zv
         IsFlYLl8qumoAfjh479eJSJx78b0ZlFeBPyyfNJJlLrm401+DOyAFp/HDclOIK+8MKdR
         TXhV+RN3mv54dbDJkUTTvkULyAx+t6npV79qqJkXJynThHuxCcMJS/fR1UdgCZK8Xdmj
         AaWwJyN7y5KSqHHbQCrcn0dkrtklRm5EcBU2dSbUxUNssMt7lfcY8P2tQGpt5sczCiku
         KHL9ZhN1MyUaElY+XvlMXO5fY6EHle/Cp33gr1O4tjWnlgZmEPYI+vziWALuzr9umc7e
         oMvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786791690; x=1787396490;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JhpLH96yWQRLag1AzHDPgAFi9pZTcqqLwnfeJZRrbFc=;
        b=TSLZVOU5UF+umD/+ir5tJTzXd0y+wR8IwpfPlFwqM0dTHt3FRifi+H82l+fjqLBHgh
         mW8wym+VrSUhQbJ2rEmblnulgMz6URhG9wXg5ewqJ1M167ssC4JVLfyuS57hJ77dwxlt
         FrMpiLql2mwhdTTANkUT4QkNgv/5AKCnKmaQVmReQjJxq8jGtm1EQ7MocB8xXkB6LAEi
         ZryGV/mLxim8d+r7wVPQulWdWwU9U46aGTQ2Vx8UPNrSLWyoDDV+8Cxl6XOP98EQiPkY
         PijQirilcruEL44dRPh34EHMSze8uNZ7TLGdkx4p6ggVeGlimi9u1lRs98s4gnWMJVtM
         sYww==
X-Forwarded-Encrypted: i=1; AHgh+RpLDicJcHr0vZ+dAwdTnh+PPZArTr/HcXUtPGwljI3OTXI+4dffmq57nlAWHgI8NzPgZzbwfPX6EFPKhenkl7w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2lgVlACG9Xnn7ZoBB+gW9W79s27J5/Vs62IcKq1CBkSCTzIxs
	bdYvLc+Lusxa1SM+ir+BUiQOZRoE3fafnEYX8iy6YlnxRTk1lz1QHMsu
X-Gm-Gg: AR+sD11M/0/cBNTlpHfkE6vBMZhpIDCjcoyW8B7/wIwvO4oW+TORaXqM8GG8vLETLeP
	+U+eU640NuokFMyRdl9hf4SMbV4NA+WOAHxpAbzux1k0/qDzkUo1/ra3QoApOaPYN5v0ICGHWoy
	jIHafJUGWicsaEpd/yEKgc2/GYMb0qIawMfuzvWdYPoQXyqe/B7ab6oWnJgoqvERNMVSD5aptGD
	KERtOfd5r0mpcPt1VHeogfDadXmU93IGw4/L2ogseRYD1TpA8h+ABv6YdV64fOt9C5gJtUQY+f3
	Bng11+dMwcubpelmke0sGcW5eNWpUEaK86VcNmuyxELimILVQSoaThmaCIEImJ2E41kenCebqcC
	g8t/HGWcEHr0Ms93g/8FegBVWNfRBL8OT2wYPCxi/f3Iw9axVtmKaa+tgNFbZEYxkfuKluLTPIm
	tCKEgUSx0lkZbgtjdzBzjC2sSFHt0wLjPfta9K1wK8fdQEgEcmuqUyn66InLMy4ejXdByuvRA6d
	SWuK5vSksbDrA==
X-Received: by 2002:a05:600c:3485:b0:499:726a:a017 with SMTP id 5b1f17b1804b1-49987938e19mr184694055e9.1.1786791690107;
        Sat, 15 Aug 2026 04:01:30 -0700 (PDT)
Received: from archlinux.tailbe3ea7.ts.net ([185.19.153.11])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49988b1d8f4sm133728035e9.11.2026.08.15.04.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 04:01:28 -0700 (PDT)
From: Ismail Tarim <ismailtarim7@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Cc: Jing Cai <jing.cai@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Chris Lu <chris.lu@mediatek.com>,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Ismail Tarim <ismailtarim7@gmail.com>
Subject: [PATCH 0/2] Bluetooth: btmtk: fix subsystem reset error reporting
Date: Sat, 15 Aug 2026 14:01:17 +0300
Message-ID: <20260815110119.11301-1-ismailtarim7@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two bugs in btmtk_usb_subsys_reset() that make it report success to its
caller when the subsystem reset has actually failed.

Patch 1 covers the case where the post-reset chip id reads back as zero:
the function logs "Can't get device id, subsys reset fail." and then
returns the (zero) return value of the register read, i.e. success.

Patch 2 restores propagation of the MTK_BT_RST_DONE poll timeout, which
has been silently overwritten since commit 3dcb122b3064 ("Bluetooth:
btusb: mediatek: return error for failed reg access") started assigning
err at the chip id read.

Found while investigating an MT7902 [13d3:3579] whose controller firmware
asserts and never returns to the USB bus. Both patches only correct the
error reporting; neither changes the recovery behaviour or makes that
controller recoverable. They are a prerequisite for anything that wants
to react to a failed reset, since today the failure is not visible to
the caller.

Compile tested on x86_64 (W=1, no new warnings); checkpatch --strict clean.

Ismail Tarim (2):
  Bluetooth: btmtk: Fix btmtk_usb_subsys_reset() reporting success on
    failure
  Bluetooth: btmtk: Do not discard the subsystem reset timeout

 drivers/bluetooth/btmtk.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)


base-commit: 15ef2f78c49d20d53ec7c0f1c9b40b02e089f2d6
-- 
2.55.0

