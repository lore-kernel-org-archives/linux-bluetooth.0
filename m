Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794566664;
	b=3IiA5jQXSl5vMmtAcTwHf3lCKvo2zl/URuteV+R/WhSdM93IZdi3jSGp3jv/7CwlR7iI
	 YpQ3lwP6mmWmaa9bJfBWcW0EZzGljwqi3BI7P1jqMsvGG2uXIznWNUgmjI0RZpIsnTQOw
	 2c9px3aLVPAV7g8jE+QoERI91Yo/0kfl4pg5eKvZMpnpUfhtUWCUF8zt1Hno5qf62TOE3
	 H/UHyvpdIkSH76bK2hj6bSyM6MfM3V+asiCblno08he34WYHfwp8YhQS4cOzL15fGaXUo
	 ZpoG6sxHWUM0kNrmQjiL86xTS5riZ0GlJWqCnDh636zWHmuaA+2eWskLGPqoGmpAgTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794566664;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=pkkkulZhiwuEfTgVNOuoQi46HDKEcp+5pFbAQV0uMu0=;
	b=N0ceMXWKmuDOS9l1DCV4vE+zQsvSGD/uhw0A90pLdxsGvvZwJ0MpH41uehp2Gy2mVx9I
	 W2KkCLl4cJMuS7DUMcjeWTpdR62RUAVhNpmka86z6snBhyKZ0IKGEDcYl902ndMl6Hi5X
	 X7sQJda06upekmhe2wDXqFT9kZ8Idp0jWhfgTQJ5DQjtKVT9X+xuIPrgU3beNjEo6nijX
	 VaR2nq8JVCj9j0vvne2WCntfOzgF5Kp7UKBEjljmJJfSXFokRAXlfRzc+GHw/ru4vpd82
	 hf6e+jMW0u8FlDaAB9w3T/eMvUS0IB7U+1pyOBkgF+Sez1UncdTu/sFz8kxbZcjOO6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=z1NXCR3Y;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19F7606A31C
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Nov 2026 10:44:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C19F7606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=z1NXCR3Y
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso289266eec.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Nov 2026 02:44:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794566663; x=1795171463; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=pkkkulZhiwuEfTgVNOuoQi46HDKEcp+5pFbAQV0uMu0=;
        b=z1NXCR3YU+GcF2GYqpz6eY+Qi8ne0Ckj3anlBl4gNtRr/bjbDfhcf9hM7kr1DbzZDV
         As0QIBMGZy0fqLY1xlwG6Eecc+g9DCcSuql2MWDizaMQvejElP07/1GOejE6ypTJkB0N
         t8jTkpJI314xqNinpUIeHeYuJqeQozryZSoywonO0bX7yK4SSizqHT4Q4V34utfu1J1F
         kJCW2e3MmhcqUnuYxZfjo/gQgLopoSQTiT50XxSy08dUShqmRuO6hVtWLbRT3bupV4Po
         wvZtR+80NY+8GOGwurApMojhqGqa2Ajh8K9y+DFx9Zd9OxDHjRcD15js6EhxnQ+kmNnA
         d6aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794566663; x=1795171463;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pkkkulZhiwuEfTgVNOuoQi46HDKEcp+5pFbAQV0uMu0=;
        b=wac16fF0XQCnkqIZMQTQP8HeWfNrO1rONZ/nzTapvYVMUynY3/SQEgappbD4zXMfG0
         EiQn+/k7+XVEaraIQynDqdUe8pYyAIBU1SVX+taW3z9mJ3ArjblI9IfTZ1SX/6wV1RED
         nRTu+Pkb9nqy6kPiZGmFYfhPCzAkchMe0D94B32kCOfTOO53RQuuT84EGlQ/V9S7Uq3H
         VwukjMGL0L0QAL20CFucjIBL1+Edd97SH07yiR689wh0vmyAr/+acVFFK1EMA++07tTn
         UpSzDvZ4p4mdp9RNCZ6l5HN89PRHMdtw5PbiFs+gTthTz2uLvb+7ayKHQvK/xnN20ET4
         681g==
X-Gm-Message-State: APuU4Z/ZBO9urghUSoZnSI4lZ1bjcXT9hLDH/ZvtDVDNFdxOwqUlE1gj
	WZ16GnXqa/je0rN3Z5WhP+RSU8WVU05hosmST88cfeNe31ECKB+iRkiX67KqaA==
X-Gm-Gg: AYBFou0c+Z9n9kzGbm1TJRNI3NsDRB5n+PSEmZrF0hR7DNDusVmEXoIL4TSgXkfVfmX
	o/JmDt+K6VeZUVPvKGddOO7ajVZWuyHFNlBKdBXl2qScWQBIH9GtDpVP10mocB/iLwqn7rjuuES
	Pb0fNrAWmteWGWKo9XwouMugTpiOowAyK71qT5TRK6AldDW0XbCMYULzsPxuFixxL1+jywlP8pp
	21Jz+add/t4ihpSAOMGdFsg7I1pHks3loB02fYBeW3FSN82y/o3ZKNyIK28pfhZJIjuaG3ocHSS
	WdB+mdLIBnzQRo8b2uc/3xBzxTpM1MqEX6XZ6Id6bNQq/Qf8qaJ+6J/ymTs30dPaEBewhd0JWO4
	DCGqyvCB07tKsdxYRW1g2K5a41ag8WFOMs3NCMYottLndVUXieTlu61baC/OnlhI3XTGmxwPnhq
	XeN4nQV2G8VdhbLfJ49sWk5fPpF+H7nFuLVW84760Us5zy4E3qS5rPKRbQKBSVGFIsB77blHIDz
	TzgVx09gFfIsaVQ9ulMeuUw2obiSX+gjgQlEWsCwcULTl+cfoH6TaKWkNZz
X-Received: by 2002:a05:7301:1625:b0:36c:9f1a:30b8 with SMTP id 5a478bee46e88-37966c4a5fbmr1910119eec.31.1794566662756;
        Fri, 13 Nov 2026 02:44:22 -0800 (PST)
Received: from [172.17.0.2] ([57.154.31.55])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3795591f4f8sm6959743eec.13.2026.11.13.02.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:44:21 -0800 (PST)
Message-ID: <6af6ea05.8ee6fb5b.2840dc.3b71@mx.google.com>
Date: Fri, 13 Nov 2026 02:44:21 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2363044190985642596=="
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
To: linux-bluetooth@vger.kernel.org, kevin@simpleble.org
Subject: RE: Bearer.LE1: Add ReadRSSI
In-Reply-To: <20261113051438.75230-2-kevin@simpleble.org>
References: <20261113051438.75230-2-kevin@simpleble.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2363044190985642596==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1210165/

---Test result---

Test Summary:
CheckPatch                    PASS      1.24 seconds
GitLint                       PASS      0.91 seconds
BuildEll                      PASS      13.79 seconds
BluezMake                     PASS      182.37 seconds
MakeCheck                     PASS      12.80 seconds
MakeDistcheck                 PASS      103.53 seconds
CheckValgrind                 PASS      228.31 seconds
CheckSmatch                   PASS      180.57 seconds
bluezmakeextell               PASS      63.29 seconds
TestFunctional                PASS      841.13 seconds
IncrementalBuild              PASS      197.45 seconds
ScanBuild                     PASS      607.53 seconds



https://github.com/bluez/bluez/pull/2820

---
Regards,
Linux Bluetooth


--===============2363044190985642596==--
