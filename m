Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62473D8911
	for <linux-bluetooth@vger.kernel.org>; Tue,  5 May 2026 20:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778014054; cv=none; b=R1A8IP6MwHI338hr9MydhzzL1+jjcW5YHEJezZZeDK9WwBFM/TOMuIlt8fCNogjP3bZ3Er3Ba2Z4xYbYBEPNhcEndQuQPe44I6d5Lr9EjOJnNGVJVDXxxvQPIZk5cE2V6qJnQhNWAAxMbo7D7JBfuiTcZPpg+ac2+l9BOFBPJis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778014054; c=relaxed/simple;
	bh=PVfmVbg+HmVxxPLfNEFxVOP+Hg2k1/B24k/AUJAmtEk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qQlhtwRpDp+Dv0zOw9wo5YGoTI8LU7osn7AHCsS5i0uyMPC/ggM3R2JXpwWTOeE0pQeTrfe4kuWKnrgwtmWQoTqjIT6BDvKyqdGCoYLs+ZpJwUehLFhljz57zvP4jsKIQMV9BW3VwItK41pcmKL8LoQeqLezXiaG5gfoNvnP/ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fxaCgZQl; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fxaCgZQl"
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-62f404636f3so871517137.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 05 May 2026 13:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778014051; x=1778618851; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pTJjxFqzNk0pnuhtKSBaUq1YT+6H5kwAqX5rotkzaPA=;
        b=fxaCgZQlT+6ZEUlpg4JkImhkp7AoEI5UlYGcrG5Kh+tL7I1i/YnfEC3YVD14J2Td56
         Tq2zE+Go3kG7+uxwDJPulkA7aK7F/rjdYVgUEJBv/R56riuYK2Pt3nPli39chVGaiRV/
         AE64Ez1FiJtvj2EVAq++LegmWFpKICLrXKmgVzLmspACgaC8W1zUXQdyELyQU0YY4uF0
         a87/27Wfj6gRcnCevYq0OjghvhT6AEqkU6mOTSzMCN1LbQy+ezi6KE4LwB+JYLf6mwkr
         NTCQgeZvJihQ7+Cl9oFuSs8NwMRDFN/rDrALArnIwBiFcNX9i3qvQuFmP+8fPBdE+Gbb
         aIAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778014051; x=1778618851;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pTJjxFqzNk0pnuhtKSBaUq1YT+6H5kwAqX5rotkzaPA=;
        b=G4oniYhU7VIM4X+cj4WVwXhrmikTiXm/aYzZj5YezLy0AnhWNkAe0zNYdkO0BvIMcn
         2X3VaUloyJrUFRiAdBycLQ8zM0HMTMjs4SfB/jACFPRLgba0IiNwacQLeXt//drmd4Fy
         PSuhtV+pRAJNkFYWdibu7yRCMON3ssKTiFckXsQVObSiGRXCj4M1hG3P0ZBsnpamLiyT
         lOp1PW1ErbMWRs1+0oFeXofVXBBAfgCUjX39H/F1SQnmpfDr7E5OgeM1Gc90rvyB5BSd
         +geFHkNLt/ZZ6CT/gvNjkANINRMhO1Zc7HN2x/tQ07Cs3MK58qtoOKEMdgcqBlbpICtL
         lhIw==
X-Gm-Message-State: AOJu0Yy4MbOGPPaL7ORHtlbTCfcMcI2Kg1kon+GHX+D3sISja77g4NLK
	lOwWnyvSxoZ58n+7Z5qOOwiJbM4CetfBxUZ+21WWIYe6D0CL6BX4Xe7CodBqsKfT
X-Gm-Gg: AeBDieuFRRhU9V2SI9k/7xNLZGUPU/LK6ihUIhOJqvlEx/33TIYu1fYT6Mu0owLyMxy
	0ogBy88dSfLKRdaFVI17bkXubXr8aXhb8hBzdO1VS7O9oODIgdRIEvBCx51dYnZak46Eupwt8BG
	bEuxDFWB8W4tqlUtGypkKv4uk3uvp7wROBcQIsnC1AuhFxP6yxqW6z3tau7a7eAygotZek1MX9I
	VMG2csCUNZGSSa0vOEINyE8k/wN/NzcHarZXX65pbTyOOGzpXDyl2mVKSA+GSAgUHfSGaw/50GF
	ODgRgqC0bB4T/4yGgzCX9OQ3HsPCdVXRkd/u4P5yQV/jZHq2DwXKfW091uwlaqPtsJo1gOwbCJA
	cdUfgposetIP/2JVPAuLqPAQzKyERhevQktvz8o6LJdMPPXYxDNbfsapIz27QhO7nJhQC+wYKxi
	0bWIQkjZjaXvP+y8pwWayBpQx5JfHCw78U98YcklPfyHhAQkweZy2iJhwvtyO7dVS6eHnEj9klO
	opR4nC5DPPntXYcF4FoOgHlvbuTkO0Aqr5nul8=
X-Received: by 2002:a05:6102:4420:b0:608:1b6e:f4dc with SMTP id ada2fe7eead31-630f8ee9c5dmr174490137.11.1778014051526;
        Tue, 05 May 2026 13:47:31 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-62bfb14f1aasm8006629137.2.2026.05.05.13.47.30
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 13:47:30 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 4/4] tools/userchan-tester: Enable hciemu debug output
Date: Tue,  5 May 2026 16:47:19 -0400
Message-ID: <20260505204719.1348473-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260505204719.1348473-1-luiz.dentz@gmail.com>
References: <20260505204719.1348473-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Call hciemu_set_debug when debug output is enabled so that hciemu error
paths are visible during test runs.
---
 tools/userchan-tester.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/userchan-tester.c b/tools/userchan-tester.c
index 168b757c6ae8..f61d2779ed26 100644
--- a/tools/userchan-tester.c
+++ b/tools/userchan-tester.c
@@ -158,6 +158,9 @@ static void read_index_list_callback(uint8_t status, uint16_t length,
 		tester_pre_setup_failed();
 	}
 
+	if (tester_use_debug())
+		hciemu_set_debug(data->hciemu, mgmt_debug, "hciemu: ", NULL);
+
 	tester_print("New hciemu instance created");
 }
 
-- 
2.53.0

