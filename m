Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795485438;
	b=h9N4UKZh3UYQ45sxltuDo/EoY5bJShQOaFKiX1QwsjWSv386rE1l4ikhVlZkJ1v3Du8x
	 V3ZF4x6f1sJWFqZRVn9gu8obo1D/URV0EbsWfcPgN3TV2UKV/cGUAQSm8+JjibZhesqdd
	 UCpud4XBTRRtVGvdBD2tBi3mqKB/scekLOoYisdtK6oStcFNT0G3TXLhkFZHw4YKeXMKO
	 YelxqYU1p1UmmpYvjl7HhylkcoKj42buJoxCkUIzSVlxOe3h1gbqbEAIz0HhoIMfiCcLz
	 cz+STOq40DsdoJgScpEb0ep0fcNE5hZ+077bvh6/ZlqvN6hKiwdXGoY+pSvhcIzIKtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795485438;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=xFuWp8AElyvETuDA8orAfUhCsyiguh77bSH7f2EHJQo=;
	b=bnPCSYxdmSeOUDUVG4nqslI/nIPz0FpzQnISRH5MyQbdufH5IP3qhHl3r8vbmBPQdKQr
	 R6XAHDwgjAVG3TTkrUPm5xfP7N507HCeqQfHaolobA9ZGafp7rERD1UJCdSV6s1cvmRgt
	 SfkaLqvgQ7DBG7nmde0yd0AtfJ4S+xLsb5Bij5SOvbKZQDTgiSjOOAAH/RV2QvboElR7K
	 2bvoq581OVlxRI+PPYPUcHhF8ZxmLi52N/PLXgj/HWbQ68vbSazh6JzchCak93lkB7z5s
	 7Xu3DrSpEHGh+/s0HJwsdjtPzH4vqr8QZoANhhzouWxA5DyLRFoz3RZd6W626pAk+7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DkLcLVUL;
	arc=none smtp.remote-ip=74.125.224.44
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CC4606A31E
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 01:57:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6CC4606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DkLcLVUL
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-675617e81f9so4405440d50.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 17:57:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795485437; x=1796090237; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=xFuWp8AElyvETuDA8orAfUhCsyiguh77bSH7f2EHJQo=;
        b=DkLcLVULf7xUs3o1TcCLALoqh/95mawiEV2rD2NeDdzHoMusi9VhgThT4NXywr81I3
         mF9jYzYWT4x/Svq78pFMK9BtejH0d0cuJL2Dnd7QXWmcRpk/pFjfaPLaDYrIjn39rQfY
         ee7B+8/zUNL1+VeQVtVrRycfeqQ0iYxM6jXHdkD3O+0Nc5WXFy/K3qB/UMNCgndtZEOB
         CXJtoWc8EZz5QBduPp/OiKm8WSNNfFwhQO2o1mgmm39JgEJTrsoxc0ptyqpoV0UwOVm8
         2aFFmyXZECb9f3r+QRT/SH8Bi18z8O6jsTxdXixs5bq6nU93/CkZYf1g5veH448dse5M
         8Lww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795485437; x=1796090237;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xFuWp8AElyvETuDA8orAfUhCsyiguh77bSH7f2EHJQo=;
        b=IEJGavouEWXr6ITHmkNjlJ8WGu5g2kYtqlKZuN10VDAdpSgukg64D2rJ9ccKOpS2O5
         bS6qRdBoezWsDevZXGme/bIcRAHp75iNQZhvaSskh3A1F89RJKKON14KFF5+WD/LG6C/
         opL09FJ6LD+WJVXx9EemuvxlqD1Kr3/bBix15vougHMqGHIozgw5o7PcZiWeyPQLoBMw
         jGkp6ppG7ZLirXy0b8V7L631QYvj2rCA8Hysb8zw9z75Jbn0oC7p7yQ6N4Y+a49jkedQ
         oAYQaWRvAvwZSaFTjbQDHWdy4iI1UXi0qpb/jbtJDmPhnddxnvi8uzw8geTA/ZgzRnCe
         shLA==
X-Gm-Message-State: APuU4Z8J/4paLqDGo0hGA5QIe57KGM6UxKDjPc4kJQFaMWbLHOKkbXiJ
	784eYWBd3eR7bX9KxJFMc70yN0KEmRTqJOPTTvBtXhJJ3JI4pb0oT4JCO9QAaA==
X-Gm-Gg: AZFdTZeutdJkEStleXaIpVVG0oZDLe3Q+i6PsVaxq8sOxW4HJ0STp0wzgkFA5sWY1Qx
	G7xBEx5ttkEEoL7fNQnqIFHLf0xz+uV6c5svI90AJd6dSnUwjdXIuulxJ5qnEhvCRISaxCxJ07B
	V/qIhba4I1W1LaFWbVdWkJO8IX6D0wAuggglD7Js8vdoC4Lwt5i+chbRwncS6PZaJDnbGgadWeJ
	wP7UzWrhzEMMDsmUGqwhTXwnwokIGpKUdWZkRcaOqhULTYShDqXLebJGXdJJp48I9x7lrFGK1K7
	jPX+Y4W6u2vxNdyDgq4k5ah1xCn+33razIjhbV18E008jMYD4lPGm3QuKcTHbvnUy44JqkF1yNC
	70clacDJgPlIGqb8185Yc8XD2Zn4q57e3v7ph1i16BkKclnNAcw51yYBTnW4u3zJivJJFblBq/T
	cDtj1hkTJFZdxbZ/Kp+Co1IA6E5feB+6pbiw5NjS80/dkPk83IdGQktVOv1QluG0f+F6sxLjBIQ
	s8+Vs1SmI4Zd1al71cQL7eVfSo+TEdXTk9WdCTGWgXjz/TJYiiDXm2fUgj1Ug==
X-Received: by 2002:a05:690e:1243:b0:67d:babd:b806 with SMTP id 956f58d0204a3-67df43ce30dmr7087848d50.32.1795485437014;
        Mon, 23 Nov 2026 17:57:17 -0800 (PST)
Received: from [172.17.0.2] ([51.57.155.49])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67df338e8fesm6371404d50.16.2026.11.23.17.57.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 17:57:16 -0800 (PST)
Message-ID: <6b04eefc.c507b2b3.385ae8.2556@mx.google.com>
Date: Mon, 23 Nov 2026 17:57:16 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5869770764217362368=="
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
To: linux-bluetooth@vger.kernel.org, rolandschober1968@gmail.com
Subject: RE: monitor: Fix reads beyond advertising data
In-Reply-To: <20261123222315.223450-2-rolandschober1968@gmail.com>
References: <20261123222315.223450-2-rolandschober1968@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5869770764217362368==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1220153/

---Test result---

Test Summary:
CheckPatch                    PASS      2.62 seconds
GitLint                       PASS      1.83 seconds
BuildEll                      PASS      17.83 seconds
BluezMake                     PASS      267.66 seconds
MakeCheck                     PASS      12.32 seconds
MakeDistcheck                 PASS      136.21 seconds
CheckValgrind                 PASS      307.60 seconds
CheckSmatch                   WARNING   243.81 seconds
bluezmakeextell               PASS      89.05 seconds
TestFunctional                PASS      1095.63 seconds
IncrementalBuild              PASS      328.34 seconds
ScanBuild                     PASS      945.89 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
monitor/packet.c:2292:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:4220:52: warning: array of flexible structuresmonitor/bt.h:4208:40: warning: array of flexible structuresmonitor/packet.c:2292:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:4220:52: warning: array of flexible structuresmonitor/bt.h:4208:40: warning: array of flexible structuresmonitor/packet.c:2292:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:4220:52: warning: array of flexible structuresmonitor/bt.h:4208:40: warning: array of flexible structuresmonitor/packet.c:2292:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:4220:52: warning: array of flexible structuresmonitor/bt.h:4208:40: warning: array of flexible structuresmonitor/packet.c:2292:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:4220:52: warning: array of flexible structuresmonitor/bt.h:4208:40: warning: array of flexible structures


https://github.com/bluez/bluez/pull/2890

---
Regards,
Linux Bluetooth


--===============5869770764217362368==--
