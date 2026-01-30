Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DC83612D5
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 22:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769810583; cv=none; b=UBMuutFWlEOCYGZNY+nAK0V35MnlVlAYaxCwwQQJFNDoDq+vnonvQa/jhzS+GhzPkowEiAed7WIRSdpL26iOa7Zx1YylwLpgcIDvVvz3rAx7+aHLskbeM+jQiFE0a6rFS7qxfB/SKNgrbZILwMjJxlAXL/mUFkmOje/uZW0saMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769810583; c=relaxed/simple;
	bh=r2AeauBkBwNG30W5Ly2CJqNTcsWtPETyuNPQW/3XGBg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kLWJzKWn+JoK9l+vDtgAgTbRGcOX95FlKmcltfDm6qY4RXfbuz/KGV31nZn0rsZ/zl+ztblA6L5WZbioDbBqfXbKCvAUKkoXdT2CSRsRW8hHGv+9AwKkH7izErtTpRU4WY4hZW9ptyFxQrOGgNzyLZ9KDEM9rtH+BjqO/gKpdvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AePDW6af; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AePDW6af"
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-56624fea96fso2424693e0c.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 14:03:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769810581; x=1770415381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+zE50WPGa+Mfsk2R9m1VuF007wPEgp9iph2qWa9KkcU=;
        b=AePDW6afqkC1axC/SSgcwjHKTMMb4v+7jopiR1jfWdvPn7nPCKUhMJIAWZ2AuV62vF
         9I9yPVi+abqkPAwsbSAekS2e+EDdoDhnr6Y6HW20DeoHOWTBImHDbg0/rGeA5eZoO9lj
         6HQnMhPZ7q6Zp0AwhCdSsd7r7YPIO3QEDySGaZ22bWhgIbPi9xrxHWx3YagBYSPlLUzE
         JoGiewo6hO3yJnvkAkHURYQ5DLn54I/KRwDuaDsae3jkHVCuLOafjf/5wYG2EiIS02Ts
         2Z63fvN6Npa5CyyuDNe3BDnoqrKSfD3nf2iq/5E5aJRF4KCD7gxjGQxVEGAQndhimq/r
         ObWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769810581; x=1770415381;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+zE50WPGa+Mfsk2R9m1VuF007wPEgp9iph2qWa9KkcU=;
        b=ZryF3YQUpPLk+Xvq1e4jEP/6kxOqFtSHeSTInLkxcdyvsM6iT7N7V8rPsr9OOcHNDI
         0uI8MkU86x3tmZM1U7BLYWSag3zIoLTH07fBAGx0DTScg2IhDDynkv7+TixqJiRvuYoT
         XfQUQg0n4KN/FmUEEoRFlCnHTYD1UP2iec10DgYb/Buioy15rZG3yK8LNZt2R6iThuyj
         Qjhjq1wN2125v2Z23GGNsEoYL43W100nPEwZnwXlME+qo47ZzzPG1Fvi4Rpifa2hxcUM
         AqVCP8eErrNohxwnl94DdZm1nlaYaEtvoCt3xnjvGVsQH8SCZXyLjXmwBSUqivSqBeAI
         wgng==
X-Gm-Message-State: AOJu0YyjbvB3sEijXQQp+524KUpGeN5LSJeu3ootPCe9CobbpgitmceW
	5lnOXh06IMdC3aGu3QWVtBKuqGs/ZRt5AGTOAow5FptdsWwxWADLTqr5T+iF4g==
X-Gm-Gg: AZuq6aKKEaV3ITwMoCssJ8oxDH8o6/fmaCE13hbgH++lRWZdngw2ZRRwFWCf/LDJPqr
	MWjC3nMHzDEKdI70Qr3/bWEP9nGv6EK5+yPeI+PkL8FTC7vkDKp179DvNR1E2vHIdnTFW0+t7Bw
	vjO0SszicSqreHbn6WLnwkgSj2EKif52in+NPfQSWHYlvsq4FS7p+CVw2MZZFT55wNL221vw4H7
	Re0uMD+SvABAXJ/5ceV5Dp2dn3/SjfyJVQ+cgZmKt5DeKmT6HCWTR5Vy7W1nSgXjdPPE7YbYxWN
	76bSO0XRyAjfgYMY9bZm15Pz3rhbb4fUA0TuMNn3Ci2VDjChb205dULT4ug1eK+YpvBr0fAR/xF
	g1z28wWtFJV8QBYaaYBVlHOteeFIyhHElrdxzthm10FthHJ67rYjKziPz/ZAhQJo9BEdgWxP0lU
	MLRrxwbLSI+9zsQox78cSI56I542I4PO+Nh6R4OBErqBbMejyuQf6c4dC5/88z3eseM2FGTfhf6
	XGQsA==
X-Received: by 2002:a05:6102:3747:b0:5f1:5be2:114b with SMTP id ada2fe7eead31-5f8cdc7b02dmr2636889137.20.1769810581268;
        Fri, 30 Jan 2026 14:03:01 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-948723adb7csm2404052241.2.2026.01.30.14.02.59
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 14:03:00 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 17/37] doc/org.bluez.AdminPolicySet: Add Used by reference and Examples
Date: Fri, 30 Jan 2026 17:02:08 -0500
Message-ID: <20260130220229.1346261-18-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260130220229.1346261-1-luiz.dentz@gmail.com>
References: <20260130220229.1346261-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Add :Used by: field linking to bluetoothctl-admin and Examples sections
showing corresponding bluetoothctl commands for D-Bus methods.
---
 doc/org.bluez.AdminPolicySet.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/doc/org.bluez.AdminPolicySet.rst b/doc/org.bluez.AdminPolicySet.rst
index ff4cdd2bae8a..db132b7de4cd 100644
--- a/doc/org.bluez.AdminPolicySet.rst
+++ b/doc/org.bluez.AdminPolicySet.rst
@@ -28,6 +28,7 @@ Interface
 :Service:	org.bluez
 :Interface:	org.bluez.AdminPolicySet1 [experimental]
 :Object path:	[variable prefix]/{hci0,hci1,...}
+:Used by:	**bluetoothctl-admin(1)**
 
 Methods
 -------
@@ -50,3 +51,7 @@ Possible errors:
 
 :org.bluez.Error.InvalidArguments:
 :org.bluez.Error.Failed:
+
+Examples:
+
+:bluetoothctl: > admin.allow [clear/uuid1 uuid2 ...]
-- 
2.52.0

