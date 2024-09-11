Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7310175A5
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Sep 2024 00:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726014697; cv=none; b=qgRt0FobxD2bkxbGPooi10QDYG42OFlmjBlZwcZUQ1+03DAc2SMOZHDe4d2N9xsh8kAzvPHIcv03fS2T/i30B3anD6cipokZrTdApcgipiYrMPeSOLy7l8xyN3VyinIaZAW0iQmIN8dLnsK13IohKWzKmVCaMyosu+AwagS+ftA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726014697; c=relaxed/simple;
	bh=EufhWAobgPcZyt1G9UGtcDH3X9ZAvqAvisZxi2aw1IM=;
	h=Message-ID:Date:From:To:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=uhgBdhUAjmwdI7wnMLXU0Z/ox7yGfEDC4y+sY19wb69oRcaSoMuhyHJgc3ySVsnWnNMHK8gW8LvdAyZpDTdqGEG9ddwiil+LQz23NURtUFh+xOa2nJSPoToSpHxSJeT3sIkTQ87nyEoLkP6Om59Ft/5NSOuxBhtCshrr1hncXo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=arsHBMoS; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="arsHBMoS"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2d86f713557so4035964a91.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Sep 2024 17:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726014695; x=1726619495; darn=vger.kernel.org;
        h=content-disposition:mime-version:subject:to:from:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cXT/wJv5z6y0uBC+ty7E3Hcr3/WJHAEE5h9ppmgre3M=;
        b=arsHBMoSO7bMA58hmMVzMcW/Q+AHeyLHO5IcLKkmcBGCT0y694Xa7sXEORKdqYfkW9
         wIFrSUSBPVDy2j675CxXG2FXYWG46yd3sf6sdFN6bMm0gHMc/wDZg/b9P7/Dob/KfaBA
         EtImo88GwQA3CLwWNxzjbklW4r7MQOHK27w41YLKIufkz5wUYWWW7zPy3TtjDUtnxJcV
         hWLHmbkpjyxTKmt1k7kNZgGlvdavIZgZRg9JO8j24CMsTzU294JqU5ctQ3SelED5HstM
         shTB/CMto52cVMGcpnLDM+n4SjH770pcNSOJOkI35qBMMvrkGZyyUaMrdq6Tm4LP4IVo
         LbhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726014695; x=1726619495;
        h=content-disposition:mime-version:subject:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cXT/wJv5z6y0uBC+ty7E3Hcr3/WJHAEE5h9ppmgre3M=;
        b=X1BWid8+f4bto/jZ/HkWxN1E16VRjIEmGrU8y4A1y7xT30+x05FZh+OiYzioOXh0HC
         FqJu2sEXLMG6x8vu3GoeGLPcKYL0urTg68vksKYZey3yuGECuSg7DLfafbg5qOStiRdo
         ltbTthacsJrnOt1MTwi0G4NFCHPYTadyQ469/fW/syWP8YOM7Sv72g3SFQ9l/Iql+J9m
         g9DpfxL8OFSI3Ruw9eRwJdYl5R0K8fwumeTG4GG96LUb1L1g77qdPc9CUnyluCPpbcPH
         j50+qtZpmwU4DboFEuXrSBGyKPd+4cmR9zDOMYE3R71Lz1ScEOnzJkPzW1nwAM6cKWUh
         HsGA==
X-Gm-Message-State: AOJu0YyNbS7MbFBtJalLHma9j2umQcudhBjG1xOWVDlHQQZm8ESby6Kd
	Epop4GKvePGswNkYePD52pwnuT6Nh8L2e7akgYZIVH6pm4duVKmDLFuqZQ==
X-Google-Smtp-Source: AGHT+IHmBc9fwEULVluQSTKUw2Qu/soV8H1og1ni784IM9/z1q/6j57HIhV+QYptfcy7MhCXRxT+Tw==
X-Received: by 2002:a17:90b:4a0b:b0:2d3:d414:4511 with SMTP id 98e67ed59e1d1-2dad5022bc3mr19660549a91.24.1726014694532;
        Tue, 10 Sep 2024 17:31:34 -0700 (PDT)
Received: from JUNHO-NEOSTACK. ([221.154.134.3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dadc03d0ecsm9120465a91.23.2024.09.10.17.31.33
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 17:31:34 -0700 (PDT)
Message-ID: <66e0e4e6.170a0220.de5c1.1970@mx.google.com>
X-Google-Original-Message-ID: <ZuDk49QEQ6b/vIt2@JUNHO-NEOSTACK.>
Date: Wed, 11 Sep 2024 09:31:31 +0900
From: Junho Lee <tot0roprog@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] mesh: Add config for provisioning algorithms
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This added the Algorithms config of provisioning capabilities to the
mesh conf file.
---
 mesh/mesh-main.conf | 7 +++++++
 mesh/mesh.c         | 5 ++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/mesh/mesh-main.conf b/mesh/mesh-main.conf
index aca9e6fa5..58fbb9840 100644
--- a/mesh/mesh-main.conf
+++ b/mesh/mesh-main.conf
@@ -41,3 +41,10 @@
 # Setting this value to zero means there's no timeout.
 # Defaults to 60.
 #ProvTimeout = 60
+
+# Bitmask of supported provisioning security algorithms.
+# Bit 0: BTM_ECDH_P256_CMAC_AES128_AES_CCM
+# Bit 1: BTM_ECDH_P256_HMAC_SHA256_AES_CCM
+# Valid range: 0-65535
+# Defaults to 1.
+#Algorithms = 1
diff --git a/mesh/mesh.c b/mesh/mesh.c
index 91cf25175..7b670e40a 100644
--- a/mesh/mesh.c
+++ b/mesh/mesh.c
@@ -245,6 +245,10 @@ static void parse_settings(const char *mesh_conf_fname)
 	if (l_settings_get_uint(settings, "General", "ProvTimeout", &value))
 		mesh.prov_timeout = value;
 
+	if (l_settings_get_uint(settings, "General", "Algorithms", &value) &&
+								value <= 65535)
+		mesh.algorithms = value;
+
 done:
 	l_settings_free(settings);
 }
@@ -262,7 +266,6 @@ bool mesh_init(const char *config_dir, const char *mesh_conf_fname,
 	mesh_model_init();
 	mesh_agent_init();
 
-	/* TODO: read mesh.conf */
 	mesh.prov_timeout = DEFAULT_PROV_TIMEOUT;
 	mesh.algorithms = DEFAULT_ALGORITHMS;
 
-- 
2.34.1

