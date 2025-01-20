Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC251922F5
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jan 2025 08:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737361538; cv=none; b=hdF/ctZ+A8lKoXQhAwd1Pwubc33R23SdZql3NRwBWF6dD8SN+vOkq9UoYcVGwmMAWpM7vgVylajLQ1vFNv9SthAmC5RymiyEQSa+oKruDv9x9xPOM5tUQASrBPwuWzS8tAQ26tChXfUV03PyE5RTJYwd1hoXKkStAP6QjApM0s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737361538; c=relaxed/simple;
	bh=ajbnyzqX/MSzpjtRn80K8bc6H6SVeFpCy/NdYLCLUVo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=cf2nnGY7UWtmeMX4Xt+tis4k8vNQD10GsgInAJnOc05FnTTarF/UhRLDZlDqlWLEjis+BmXoQol2FxBgbdJIEqbqlmJjsiYGVK0GyGXQRMkXgEND5U2u0qJFnFtBeBIecdU45Uz8s7q9gLAYEVa3BKEw6+sIdtbAOcrytLRTBRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--chharry.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JCnCeg8Q; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--chharry.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JCnCeg8Q"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2178115051dso79172995ad.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jan 2025 00:25:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737361536; x=1737966336; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vbGLyyaU2vbk67XPJfrtjVNcrB5t9VYHrGDJTopmCu4=;
        b=JCnCeg8QdjcZDEjDms8F+t9r82itz1PIq3uWM++sWIdGqy0cEiIUaDuhAy9ps3/A2y
         XJv+LqN8eQb7+bSl2sL6OUwfVcl/8Iuvz5sQy7ZuR2j20sOCewRoKL0ajuHz+PtnCYpw
         QRsCf9K35ODnn9o9QqM7htsDeFQEXRjXnexKFKTFbunUr48hRmy4Xiz4tssoMnjKa4GD
         mar+VEK+6UTV0kaxVkeHeRYg0AnRUnE0cTBGABi8ECUdZODsUTQtYzicU8xKH3x63x5O
         kDVmzC8IlDlTCcbKm7gx35dAViiNuLvNNywRhc38XKbq9Aol6ZI0XoMo7+4q2rWKmmrK
         m/Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737361536; x=1737966336;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vbGLyyaU2vbk67XPJfrtjVNcrB5t9VYHrGDJTopmCu4=;
        b=uUoG3PEo4UqCkzdho28V0B51r5IjwlUiTqsLZl4DIEgWjIYrvuTWOd53QiIvpUzaf7
         onw4/ADFcNQBqC5NTvYw9mnp0eLK8wt+mDOV/5byRN0gpYJ4ONdNVizXwpdCRsYDzRd+
         T4PzjMOE/z++Q22X0In8pcZ2/5HhSASixcxLS0D3wZlFnO48VPRAgFeD54f3a88BenzS
         p7zNDkOE5Oa6yU+Rdlta9IB0ervPug+WZUzFau1GQBlplP1njXmaQi1DIIvIHsMj1053
         m2dchXTCBLqQaPOJRwETFTfCUJE2qwzT5G5JcjlzWIRtdebVNu0kvbbZ6s9ZP/9jgE3o
         rJ2Q==
X-Gm-Message-State: AOJu0YwQwdQ9gZL1VDrxjEdiLyVcgt2qRAnM0k3GSE4U9rvZBo/t/iXE
	prgo/0QA8qn+Bg7g9/yfYHNBl1CIVw1RY5CE6OFb2G9o3DIQTNs0hiEFL7ZpVSTqxq5ahaUoj1E
	Chfkaf3KAqWaqFlBwAb9n29Od37bcVwS6/Scxfz0Y+qqcYRURYLLuvX9u8V9uCFYIcSJ5L4zuyT
	Bqy9y9snAYdlXzsp7VE0A5n6PNU/+tyQAnlrq7lNomzyjxNSXD1Q==
X-Google-Smtp-Source: AGHT+IGy4N6E7qLheR9bj/xGb5/xEmgqHpmWlqK2+3FgjV2DDUJBp8/kxz/vs6utvGD3M+X/WwejuDW9bZWS
X-Received: from plgp14.prod.google.com ([2002:a17:902:ebce:b0:206:892c:1d5b])
 (user=chharry job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:703:b0:216:31aa:1308
 with SMTP id d9443c01a7336-21c355e35c9mr145794085ad.34.1737361536287; Mon, 20
 Jan 2025 00:25:36 -0800 (PST)
Date: Mon, 20 Jan 2025 16:24:59 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.0.rc2.279.g1de40edade-goog
Message-ID: <20250120162456.1.I2524c9a7d322be04b38b29bde3d7d1e578229cca@changeid>
Subject: [PATCH] Bluetooth: Add ABI doc for sysfs reset
From: Hsin-chen Chuang <chharry@google.com>
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc: chromeos-bluetooth-upstreaming@chromium.org, 
	Hsin-chen Chuang <chharry@chromium.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	Marcel Holtmann <marcel@holtmann.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Hsin-chen Chuang <chharry@chromium.org>

The functionality was implemented in commit 0f8a00137411 ("Bluetooth:
Allow reset via sysfs")

Signed-off-by: Hsin-chen Chuang <chharry@chromium.org>
---

 Documentation/ABI/stable/sysfs-class-bluetooth | 9 +++++++++
 MAINTAINERS                                    | 1 +
 2 files changed, 10 insertions(+)
 create mode 100644 Documentation/ABI/stable/sysfs-class-bluetooth

diff --git a/Documentation/ABI/stable/sysfs-class-bluetooth b/Documentation/ABI/stable/sysfs-class-bluetooth
new file mode 100644
index 000000000000..e794ce706582
--- /dev/null
+++ b/Documentation/ABI/stable/sysfs-class-bluetooth
@@ -0,0 +1,9 @@
+What: 		/sys/class/bluetooth/hci<index>/reset
+Date:		14-Jan-2025
+KernelVersion:	6.13
+Contact:	linux-bluetooth@vger.kernel.org
+Description: 	This write-only attribute allows users to trigger the vendor reset
+		method on the Bluetooth device when an arbitrary data is written.
+		The reset may or may not be done through the device transport
+		(e.g., UART/USB), and can through an out-of-band approach such as
+		GPIO.
diff --git a/MAINTAINERS b/MAINTAINERS
index 797e94ba74f7..e949c3ac7846 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4058,6 +4058,7 @@ S:	Supported
 W:	http://www.bluez.org/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git
+F:	Documentation/ABI/stable/sysfs-class-bluetooth
 F:	include/net/bluetooth/
 F:	net/bluetooth/
 
-- 
2.48.0.rc2.279.g1de40edade-goog

