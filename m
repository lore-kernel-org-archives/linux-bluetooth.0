Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795390835;
	b=3JSDnwQGxw6OuaN31T1RP92Lku9U9hVHw5sqT7If02eapdMfkLM/5DET/s5KZD146fVc
	 +OeOj3oBmsyYAYlMQhZXKHfFGMpkTOlkPCSDD9PtC/DnbZ5eWmHhbAWdSRUJdAJFD6DaR
	 BKXLf2z5Pq7FRQAxvX7k3D2L97keJilG1Nz6IVzK19whZYNkq5qcEPChQTHu2I6vX7yPN
	 USDHMEEI9g9alfGWibXbD9/sAAHAvXlmY9/Xoh+vGi1EAiBpRIwgbMVHMpK96PCmGJlmr
	 hRTLuWNbalbGZHaFtxzVg01xFGvu7uhSN5boYtlexF6M6KxNPzu5Ktq1lKCh7MWBVGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795390835;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=n7xSZSEcKyAJvrxMxLhlwUsElCNIJeECTnj/W0hFXlQ=;
	b=tVIFUN79tHPDiG7co76c2RyoxaCuTgDwBaB96zlq/b1/d5wQQuYYwplp3BwysChgHj8r
	 qgafOF3QJxfuckGuT9L3sxtOcTdaigqzzRweiZW5BXN4iJMvvl5tjvmHrcLFOCQnOowwG
	 vH3LzMPUVk1dmgjugDQH9RgXELGOPwOhU4Gq2QmpxVIFQe6g3cKO5pqpSdJ9NyKjCq4sx
	 Gn7LC+fAfvVogPukZAtRRJ9VlBXKAKOOXgzNVTcPrChQzodJlIqUMdb4TK1o+j72/bSkq
	 jSsatnVGSI2J6d/sqY5MYDSLfnrLhCTjjPMTlBOdiZ2BgL6bnlaH0Qu1xWMGEs6VgEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mkpGNVkT;
	arc=none smtp.remote-ip=209.85.216.43
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D585D606A31A
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 23:40:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D585D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mkpGNVkT
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3ae691283ecso1238302a91.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 15:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795390834; x=1795995634; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=n7xSZSEcKyAJvrxMxLhlwUsElCNIJeECTnj/W0hFXlQ=;
        b=mkpGNVkTd0BwNBMvXVSOk1PJpUiX/EWQfkU8ksCxam91v/yOUz6aMJJZb2tPOG/ojd
         ffOOEOgU8iGrdYaFL6mxD2Mp1PpT3ni/fOvcXt2IK5z4jC+dNchhR63eDt8PcsvsUaLI
         dHaXnl7ZVYY9IDtD0QFo1pL2lsl+P1O5Ni9FUwCKv8PKncfUwdeqQiQWb2gnWy5NYpBL
         W1twgXO361ileKY9+EHUSUL087JPeo1GaYVDS60dpqFDLIY29QY88hPNuhCDSV4yJ0l3
         2mADpc5eOZcvRO1alm/i0eYjcZoqvHGauvnBfBF9o3MMkVvYay+Cjf/Jb311WWNV30Hp
         s7dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795390834; x=1795995634;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=n7xSZSEcKyAJvrxMxLhlwUsElCNIJeECTnj/W0hFXlQ=;
        b=1zyXBJKUMmvNSGKKI/BkIyCa/Ti+v6CPCkDHtaDxMl3AeCaUZBWKZVNlX5+S0mF0yA
         XctLjsS8K93yOFBNwyTCevPb439kfkA7yc15t8Tk6MrT90uKHPUfFC6DxPRnorKCfzMb
         n+juCs+6CKLLQPHV9b8MP5rwmvVsDpiwpHWs6vy1FFJNgKnAVk20Lnw7xV0glgwseuNW
         aYHH2AQcWzrLPIBnX3QCT4vI+KGNGohwLxXXKheCkOuBMHJnujf+pDE59Oqo7ZRgEeFw
         sLiA97/QohSjSxNyBrl3oO3IkT9rsLL8HFLN+NBTSWjW8F4prb3jXUs4rgvBStlQX8sB
         5pPw==
X-Gm-Message-State: APuU4Z/UUSlVLTw3gvrnybUMU4F9SedVsIJ1NPaCnmmVRU8clAf9bgbH
	V6qhnENT/e0tvqv53It33GT0Lo7iYTtrUpceECT7EYv+EAZvWvL9GzL0TUXY1g==
X-Gm-Gg: AZFdTZd+coU9l5T7KBt/WEHYQhtq/IvutQuzY6ZXkUpVCDAk/sV6xmPveinLHUkZXVr
	NnYEbjt6+7ynoVUUcjxDjtfUl88zdrBhGtvLGXvRk6PwxdUeejBH5fLevvWh+0szeWwXjvpik06
	mgEJGW+8aJwKkmUfjwPvCPTelnV5AJS/5DHlg2Ze/XyV4T46T/DyGaXbb/Pz62kuQyvW8EIgGpc
	yVefoYxDG2pd988SmvnKpsmM82PqXRXWlbICMU6REhecyy9W+7v1H/3Yho8/tVOpLQliqberhJ3
	cIkhmoFeluaF1aAi+Kl5+Ug5s+NJ3YGTaaXUwen0IUTcrH092hUz6ux9qRS24Q+Muznbuxhy+gu
	wtaoxZU/9gKGn9o4DF+2rj79WNNcO3MX7eGW17WfM66qxPA0QCdzoQNNuf/RMRTkRyYjFiJsVXe
	BznP3JyvoNt0WswwfIa0Ej7MQG3J472FSMGaI4HS53eEG8q9e5p15Ws9lhcAeZJFDQpWWWxo2HO
	FHqHWiDUXRcXows0fyf80dwAYdKbmQFcpum0yWFOOOlFlye3lX/48BT1E+PdhRlkTFZA5BDTosv
	LagQyfeTcEJR2mPMl+/yGKGUOrAxE73eS1TqnrI=
X-Received: by 2002:a17:90a:e54a:b0:3b0:9310:b255 with SMTP id 98e67ed59e1d1-3b41c961506mr4129497a91.36.1795390834207;
        Sun, 22 Nov 2026 15:40:34 -0800 (PST)
Received: from [172.17.0.2] (ec2-3-42-157-95.us-west-2.compute.amazonaws.com. [3.42.157.95])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad0b2c4sm14581156a91.4.2026.11.22.15.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 15:40:33 -0800 (PST)
Message-ID: <6b037d71.59d373f3.3ce46b.9ab4@mx.google.com>
Date: Sun, 22 Nov 2026 15:40:33 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2944513505057467740=="
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, simon.mikuda@streamunlimited.com
Subject: RE: [BlueZ,v2,1/4] shared/bap: Remove broadcast sink PACs in bt_bap_remove_pac()
In-Reply-To: <20261122193347.2366500-1-simon.mikuda@streamunlimited.com>
References: <20261122193347.2366500-1-simon.mikuda@streamunlimited.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2944513505057467740==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1218934/

---Test result---

Test Summary:
CheckPatch                    PASS      0.89 seconds
GitLint                       PASS      0.67 seconds
BuildEll                      PASS      13.71 seconds
BluezMake                     PASS      207.89 seconds
MakeCheck                     PASS      12.85 seconds
MakeDistcheck                 PASS      106.71 seconds
CheckValgrind                 PASS      254.73 seconds
CheckSmatch                   WARNING   183.83 seconds
bluezmakeextell               PASS      66.09 seconds
TestFunctional                FAIL      964.96 seconds
IncrementalBuild              PASS      235.19 seconds
ScanBuild                     PASS      718.77 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structures
##############################
Test: TestFunctional - FAIL
Desc: Run test-functional
Output:
FAIL functional.test_bap::test_bass_past_earbuds_transport_acquire[hosts11-vm3]: AssertionError: Failed to acquire: org.bluez.Error.Failed


https://github.com/bluez/bluez/pull/2878

---
Regards,
Linux Bluetooth


--===============2944513505057467740==--
