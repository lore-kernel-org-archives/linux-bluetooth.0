Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859DC38DE9
	for <linux-bluetooth@vger.kernel.org>; Mon, 24 Mar 2025 13:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742823684; cv=none; b=PVDRyzw1lIqdgUQaIpPkIXh4cc0wiCamd6oK2XAFs0Xfz35N2e7YQDCtMNYA+ewfo8uBrHJgpYHWPTct9leYMAjvwDwT2zNgYEJnXXxDcmQKweJ7B+1Vue2zttuwOCCy/FTiOWZDptinVUqG/ZA/3BIPXI7N/G/s1CZqZl9VxK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742823684; c=relaxed/simple;
	bh=BEugHfuWTTWwpom9bxqbBFACjK5cjiXEg+fSDceHnjE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=txP8g168hfw6Vh2BW806Nnhvshn6j/K9xDdq+5LLD1e3I4Hk0CtIwsEg5EzpuWPVIhGIa5cJtnjIHfLu3TXjhgsRH93xMqm/tHoIwuqHAbs4GyQ8NwYUg6+US6KxulDS32xCNKWnNU/7vpOwmncRTnDfHUDyEct+2tacyetfaNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YJ10T1sh; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YJ10T1sh"
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-86718c2c3b9so1897557241.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Mar 2025 06:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742823681; x=1743428481; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8yUFzEeP23ae02zx94YcHk+D3FSZrRH8pMWsZ4/dLsk=;
        b=YJ10T1shr1kzjFcC2WQ9PGOijBjI+G2VvbdNFZenakrnq5zekEuKVFdGWoQhcIOcyF
         wtlHiKF29ygIOOtK2bxnF8Pfvn7DfXhHbJb6/Oy8NhGStUy+lZ23ZKzA4+jC3gnDjtem
         6HDZK4bUZA3vDTKnvbM/mv/iFow8hRMnLR/NS8iiJVcyA8w7oNfd9IKN7vQR7/HODsOr
         WDEOFVam7yGqMHcV3/59h9N0hEZynJ8E6tZAKPxFUlWRuJcSGJLeQQDJ2VR9dY9wrHbw
         +MpkAseebGKQcVzbQt4QVa50kDY2WmMZihxIpoiBf4itYr7gEOyvMMvgFcVBPGBK5/p1
         JaUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742823681; x=1743428481;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8yUFzEeP23ae02zx94YcHk+D3FSZrRH8pMWsZ4/dLsk=;
        b=iTg0QuRXrJ2Uul8gmSeZXpg/ep5R42MZ/SarOzYgoHSjiir6EJpAynijDNVVP6XZ9p
         RdVxm6SJiR4d0LQNiH1n1lGb+9/Ni5K+n1pGkjwn5eypDuKjPSbzQrZC8uwL2elBgge9
         4qTcTgWskWtuVDiuLjIoFJtDaOLQCpgqCiv+j1dwUiHQ5mAZ+1Nph7M+RnQV40tKslX2
         KuV/QcqY4I0Z30RXrtu1bRq3KxncMyIpa0Qq4btuY8mlfRV/p12QVFs8zY1nCCOxF8ra
         9FUMK2uxxEi4Sf2Dn5dzirlvprN7B4RUJbwDq1ljd/YNCcIKIcPMWFXOJXuOErigl2df
         Cxxg==
X-Gm-Message-State: AOJu0YzfMRZGTLddo7NdM3xWhoTiAOdVuqg+jYJ8ZV1CzcPHP1EO1DtP
	tuo3NzjqljzvrWxQ0GWaaqtq/lEVN3LQd2pbjwuMUHLVh81Tiv7fcf7/Zh/R
X-Gm-Gg: ASbGncvf5QvJBE6ro1NXs7iNNzthqwpTezwzuRFsCjJOHEiRDPG4cvzIGGKXXgGxT9D
	rOJbCw4u+qNTZZS54hf6rLkClRL+uw2GtsWzmCjmI5GhFQ1ykJp97QIn7NqOQYqXoiZbol039WX
	oDmeYm0+hKAayAlzX23j++M0d3Xxmbd9rdorabqilFaTCPudzYLzpx07iLhI4Zuys1BoFtFKt6t
	/L9kHmgwk8NEm1QmTCgGr2iXfheWQDpLmgJhYYNLyVVK3MfFcjA3Euu+3vswfrhJze2Qj9uywRq
	ANYuW4NMUVj316PZfvVYtChIf0Fcu0C5Yhvf+AEmQ4Psq7bMkiIdreNrXuG2LvEazaupaR7Eo52
	Cyim+8eszel+NZxq98j3bU28G
X-Google-Smtp-Source: AGHT+IGg6UIRLM5KtN5iy6/lV9enHwuDTYPBgmDnS6oUBaQefJsFp29/rHyuV6vN//JbDgy9o+jcGA==
X-Received: by 2002:a05:6102:e10:b0:4c1:9695:c7c with SMTP id ada2fe7eead31-4c50d645bbamr9618365137.24.1742823680542;
        Mon, 24 Mar 2025 06:41:20 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4c50bc11d7asm1564850137.12.2025.03.24.06.41.17
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 06:41:19 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 2/5] mgmt-api: Add LL Privacy setting
Date: Mon, 24 Mar 2025 09:41:09 -0400
Message-ID: <20250324134112.2108216-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250324134112.2108216-1-luiz.dentz@gmail.com>
References: <20250324134112.2108216-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds LL Privacy (bit 22) to Read Controller Information so it can
be propagated to the likes of bluetoothd.
---
 doc/mgmt-api.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index 3181607d94fa..2fe8ca22b9b5 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -336,6 +336,7 @@ Read Controller Information Command
 		19	Connected Isochronous Stream - Peripheral
 		20	Isochronous Broadcaster
 		21	Synchronized Receiver
+		22	LL Privacy
 
 	This command generates a Command Complete event on success or
 	a Command Status event on failure.
-- 
2.48.1

