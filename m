Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795017562;
	b=a1/JiuPoC6mJDdPflQEIr3kt45dXBCiGRdXQ+ZuCeCWjx4HhDVcFYcGnOhff8Qruk4UD
	 sFbEI2Qr7Zw0o6EY0gKtyiBigTMTfGYRmQ+mIDwMekPEFt/jUOnBEFN/SD+obFMrvxsMa
	 0iv7bPne2o+FaMX3/T3pLnCd7B8KhxCYvwyudfamaOTP0EWA8ApXxj1p3SUSDv6ACZ1yk
	 r+uh9mH022BDy0QGdORDeS8X+y/ely1uIY4HhA8CVoSGlj1v/4A9Tw4RmsrSkATnd1/gy
	 CjzYwn+Kb6AgeFfGvFGSRE/GLXhjbOistUzQXstlkC5D7NiCjhZCOZncB6EB9yl8lhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795017562;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=u3bgwvMTpuj3L74/b7gj9opF2Rxh5Ms6OYbjAz3EnU0=;
	b=OJei2E4Oe8R4IWi/gIyiW1ZGU4Cr4SG0alaxwkCHHV5LD9hvXpS/7eZ0sFyaYQxcqIPw
	 2Nd4lSdves9h7uVWEKOfPvoG9vl0UfGIIsfFqDAFXrdcs8rlB/x3/NR6sf9944i+XY0GJ
	 +6sqOKcx0h9IU/WsvADBLkbNVlvWhIRbAgAdCJWGfLb2ySM2MK5qyltmaOKr8q6DfdUKD
	 KFbwvIv5+8dsjl+W6bDHTk89VX8vEzido05+j+cAMtG0mirIgmlrFOkmiY33B06KsHdUP
	 noz4qZNph524sx2FbbMJCPA+gnVDLSenUW4rDZ8dSMbhu2gWixCorOI+u1A2OnzdPug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hXS3loSh;
	arc=none smtp.remote-ip=209.85.222.49
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96AED606A333
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 15:59:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96AED606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hXS3loSh
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-9851592ada1so332027241.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 07:59:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795017561; x=1795622361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=u3bgwvMTpuj3L74/b7gj9opF2Rxh5Ms6OYbjAz3EnU0=;
        b=hXS3loSh0NMDtDlSOH/J1zYWi/IWQOEiqFwSkkcDKk6wkfjSxmcrheoYlOd/SvlFff
         X1x9ztM8M/cgpNYfo/0PJCXDNUL5KlYouwdIHs6pix8+xR2h3e6huXh4CYPfPaXww2Qb
         Oj28mqI3byxQcCdFYsO1G7Me9/G/gR272gxyjfdbjDF+SM3W6WHQk0DHmucSsxTkjZ9o
         rI27+zT8hx6C40P3NUd0KNkf7Tsm6RXVFl72aUS2xjUzLbGdTjDHgf5Y14+fGQ0+c3Pg
         Xr2ZL1OXKytarZX1xR8Uw4RTPQKpX5t9ZPDU99ZTq9FlPbe6YpZKiEyJFDcPRe5rxNYt
         aYNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795017561; x=1795622361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=u3bgwvMTpuj3L74/b7gj9opF2Rxh5Ms6OYbjAz3EnU0=;
        b=naK/J+/RBz2+VmA+3GEG4HBqcqLf4jI5HmUumTPm34vbGPtT2BdW3z/+aJ1Ip8kDU/
         TP0rQvOs+6OSLSrMTZAuKsWYzCCFZsxa/nw6GpxtaeoE5a9Bct8OuTdDQpM8tzBNC2+a
         eBhhlkkpPjxMITK5kKTWVNhkScQKkN0LYyTgmROM7vB6uALxvtS2SKor2xFXSCs9U9nc
         Z64+SV12jt7g7cNEt+ExYoKy4iPdcYG7dUcuWyFdU4KRi0Ig+WFj737c92M+8a/5pHXt
         wT1xp+P35c5QOu11cKxuezAioGm54wiOeKGPHEdI3M/TZDVtn3tK8PRpW+s45w18Q6lA
         z62w==
X-Gm-Message-State: APuU4Z+bnvkDpyF1deyynl7aNOqJyPoj8erlVKoDgsE53n+bZflOb24K
	IrFc3hNZyhafDOxGLxVB2kltLmiHYUY6gW3uWfdkMtLWJqj0s5IpcZgqkaVQPlEA
X-Gm-Gg: AYBFou3NFbHslwMwMgKR6zEPjVfAPR6bmZ5Rj9nlQem+WkgS+8p/86aPfDJqvSLKAfG
	7Meb2o5FSKM5NT8RqBNvywKJYzmnvYqXGcaFTIP5AnkPVdqFkMYT12GORk9rNcIs2NG6EeWFLkh
	djOH5DkF2jizlaWlZsFN3pkSPKneRQW3VM2DYTtNiCEYoNvQMiGEsCKqtPDlH7JHmS0OzFYq3xL
	YCXmEtJ33pwcpeRXT5Zg8sQ9HY7A+ZDtV0gZC6+bQQYNDbnLpkDdeOiH5M7ShUbngvdrkzI+gC4
	zinEP7D7wJRJ+AyPNlixDLVmZvaGlnVSdoKkbaeipAFvU/Pl1/R6eWeK7AXTbUnSig3IgrSbuli
	egFpFAviKrPNiR41JlsKPmJ3OnihTyO0zdO9FIR5TKy66gPF18lUqUnMQLMAJc+MZZhAOpsdt2/
	15w5C+WWFvFOTEaJsW+tRsjGJHNPNQ+8Df8ycGsGgenG4Y5xqgji9nIw51niv3vskMcqHdX/70B
	7fePaqjv16XJmKl4Zx/rw54Z5pJEd+EHwWko6eWIfBxWAaAO1VLj4L6ucYykqHhBan/nkHBMHNv
	LFsOKP1z2BzD8VoLR4qqBlnQnzzTAnwouGIYlFTYb2bdMl69ganbMZg9wHRLZLVKzqfLJTFXjBm
	/1mISaO5KaWvD1rc4JZcqYyIjqlKCdJAcs4F9hqDm3PjE5aiVH1LDLFcT9AUKAUGV1lQ/eSEeos
	Q+/go=
X-Received: by 2002:a05:6102:578b:b0:7ce:6474:7216 with SMTP id ada2fe7eead31-7d6ba496548mr1003874137.36.1795017561261;
        Wed, 18 Nov 2026 07:59:21 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee64e4dfe3sm1919266e0c.5.2026.11.18.07.59.20
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 07:59:20 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 06/17] Bluetooth: SMP: Check smp_data before using SMP_DEV()
Date: Wed, 18 Nov 2026 10:59:03 -0500
Message-ID: <20261118155914.178050-7-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261118155914.178050-1-luiz.dentz@gmail.com>
References: <20261118155914.178050-1-luiz.dentz@gmail.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

hdev->smp_data is NULL when the SMP channel could not be registered, so
receiving a Pairing Request/Response with the OOB flag set would
dereference NULL through SMP_DEV().

Reported-by: sashiko.dev (linux-9bc9da90-02a8-4a87-a603-87d0a4cf464c)
Fixes: 94f14e472812 ("Bluetooth: SMP: Fix trying to use non-existent local OOB data")
Assisted-by: OpenCode:claude-fable-5.2
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/smp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 88cd86f742a6..7e0be869cc74 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -1766,7 +1766,8 @@ static u8 smp_cmd_pairing_req(struct l2cap_conn *conn, struct sk_buff *skb)
 	 * successfully received our local OOB data - therefore set the
 	 * flag to indicate that local OOB is in use.
 	 */
-	if (req->oob_flag == SMP_OOB_PRESENT && SMP_DEV(hdev)->local_oob)
+	if (req->oob_flag == SMP_OOB_PRESENT && hdev->smp_data &&
+	    SMP_DEV(hdev)->local_oob)
 		set_bit(SMP_FLAG_LOCAL_OOB, &smp->flags);
 
 	/* SMP over BR/EDR requires special treatment */
@@ -1962,7 +1963,8 @@ static u8 smp_cmd_pairing_rsp(struct l2cap_conn *conn, struct sk_buff *skb)
 	 * successfully received our local OOB data - therefore set the
 	 * flag to indicate that local OOB is in use.
 	 */
-	if (rsp->oob_flag == SMP_OOB_PRESENT && SMP_DEV(hdev)->local_oob)
+	if (rsp->oob_flag == SMP_OOB_PRESENT && hdev->smp_data &&
+	    SMP_DEV(hdev)->local_oob)
 		set_bit(SMP_FLAG_LOCAL_OOB, &smp->flags);
 
 	smp->prsp[0] = SMP_CMD_PAIRING_RSP;
-- 
2.56.0

