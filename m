Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795082004;
	b=zhDSFOf/Ld5q1FZF2OK/AYLgvqOW50BgVTQVgDTrfQ1pQ8Tomx28ELdt5FiVtH2ynMJt
	 k2dB7H0u6oIy9pqlqfXJ8tWslb/6tlZaFeBjo1Hd6ZJU3Z3LLcd/TuE6usMk1UiEo/CYu
	 46OPenf3e/r56CupyBWtrArrqD4djSSLGgQAMWRYlRnmSrdsF5b2l+dNHSvi4QOvsgU/P
	 DXAFxN/OzzkL+brDc1huq4jXA66yZ3urNsN6UwrXBRZwHwLU4BFX5/Mnj51nNG6Kl2k7m
	 DDSxr+a6tOPX1Gbe3GeC5Uoy9B9d0UrwhjnzyP0izHtfJhQru5fNdPUKv7g3LhrZ7/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795082004;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=zG7lTaLffEZ/6+ubnOfLHZCzR5MkMiLtOn5a0wljbRk=;
	b=Eyk0gbckta1d/b1V2pjO3uGpAgYFQ+U8LGpmRXChcD18Sn5fIx3zcXOZWLS+AQOriLgB
	 FH4dQ6Uc3AkMF9Durgni3OLoLz6TKo1c2gIixgAfniYbhb4vJMo6Pf8cFGBQrSrL6WUGI
	 TTWLFeLt/abCHeS8ZsJvbfK+eQne3207WgdcuOhPx3aWG9yAfuWtAaZNkq+UKkupqk3MQ
	 1bu7JXKnQsQjt1bxIbTu8dzAv43fdwG2YdMFdfoEqZuWcHQh/hSs3ikjLr+J/Gz2GzLB/
	 pPrLGaJZ0mvJ/V3s8fn+uoCzacl6V9raDNkISV3JOmULxQTVwoR7MQqsGZkJb2NXIAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rEESrO8k;
	arc=none smtp.remote-ip=74.125.82.42
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059E9606A320
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2026 09:53:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 059E9606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rEESrO8k
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1ae58d17cd9so1796280c88.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2026 01:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795082003; x=1795686803; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=zG7lTaLffEZ/6+ubnOfLHZCzR5MkMiLtOn5a0wljbRk=;
        b=rEESrO8kOmt+tO4dcGPHE3LchTkPNbexra5Jitzzbypj+lqbnCJZ3L/jwpZKR4w3qm
         7/7iwz6MLwx4RWJeKcZlZ+dFPHLex6Ew74TlZv02Oa3+YoDPr6K6FKbQviQDELULoZOz
         aIDz7t5Rr/VYU9hfCOJ0R3Q4MpOEF3IN6Pmng1d894PdjfYD4nq2uAHnTz+UJQ1g2GSa
         bdJmLrs8uewIEdfbipZt9R8+QV3J9GvPXDWfgrpA3Pet2SVKxnsces5hJ8LY1r/of7Dt
         IU/hsDtberE1rVJALIAdQ04oz7HIXcw+9xRB7u2tv1r3kuJNM5Hi+7WGd7sGpxgayOg1
         tLZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795082003; x=1795686803;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zG7lTaLffEZ/6+ubnOfLHZCzR5MkMiLtOn5a0wljbRk=;
        b=M73lkHGnGmFwzBREYiSfLehFCbIcfjUQgAkkxHOvnjrwkdSrqPNSj9sekK5v8jtuof
         gAGHr4jw4c8dU5t8LXpMEys0ilzJDNwm6CUa8CdMfdge6jyfBVDkHbZiN8G79PmI77TH
         J/qpGtxSr3TqKrqZYph3kXZmMrRXWQrxhB+Weww3DlI94iiW2yF2l4ThGl2dzqq8ezlu
         tu16TOnxQesZveGsFHpItrakZlIdewaDdQ7NGugyyT9AQUVHDY6rD/CuIjcaseQpvsom
         zhIevTmxJlW5WXmURlLz/vA4bAJmMohBaFpITcsGGgVf8J7iVHrvEiqqvP3p6F8+sPTQ
         S9fg==
X-Gm-Message-State: APuU4Z9HkgrpELWc8vErAo6i8CvlW6z5z0hDR/lrn38hZpx9GVXlTxTW
	oM7lMmU/d7Ok0wgL3rcpzmg+XL4X3kfcne15Z2sN18XVzwrJz/4llAzJb/DFjQ==
X-Gm-Gg: AYBFou1Tp/qhCL9jArXWRyPtJxRKxVMPJm50E59nUzBW506a9dTJroanZlY+mwfA8Ua
	OTaSm2Cc2d9OnDMkjaokaQ+Q+igwxiBQwhtZoljNC7dqPfYeq8U5mKbVnm4utOjZFzz9qtcSnYc
	jjMFmZ68T2FTIRwkBv6wSDy9M4WUcs1enXmi1Ay78sbHwXYbeasT/S6r4oK1Cyw8HY39w2PIrDI
	b42ll9hgtv3ULgsx0gYpPrtYimNV53dVs3tK8Dwxw72RjJxCTRXPTiE8TcHUGuhvJtcMLPaalm1
	rdkNXwd4INLDCPxxL9s+7ENNWYNan994tTbvCSvm9HHA0pjMqGs3/+Ush/f5z0dgL0qji7NEjZL
	71q1cVo9FR7B9KtvIYrtCpF+XM+xZdN1lnYaohbGBq/yHUjTfn2dRDR8ASPDVJkcOYsFTPchgMv
	KsLxEx5cmoxV4Hbhb0PzazbUcwzYFwptIdHgkWchgJRdaj22cS+ZqhWVIEZ4Sdni8vHRRp74fzs
	FNrbEcGnRj80FKBNFb/vtnSuVjpnd2yP6RFqSj8H9aLmXThSNE/0Hmn7uUIvk4=
X-Received: by 2002:a05:701b:4558:10b0:14a:5284:1bf5 with SMTP id a92af1059eb24-1b543cb3ebcmr4844730c88.13.1795082002985;
        Thu, 19 Nov 2026 01:53:22 -0800 (PST)
Received: from [172.17.0.2] ([13.71.233.244])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5446f954dsm13221042c88.2.2026.11.19.01.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 01:53:22 -0800 (PST)
Message-ID: <6afec712.fa539071.24a76e.28b0@mx.google.com>
Date: Thu, 19 Nov 2026 01:53:22 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============9153083191390458713=="
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
Subject: RE: monitor: Decode Periodic Advertising with Responses
In-Reply-To: <20261119081621.112623-2-rolandschober1968@gmail.com>
References: <20261119081621.112623-2-rolandschober1968@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============9153083191390458713==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1215867/

---Test result---

Test Summary:
CheckPatch                    PASS      4.08 seconds
GitLint                       PASS      2.47 seconds
BuildEll                      PASS      20.35 seconds
BluezMake                     PASS      296.33 seconds
MakeCheck                     PASS      0.98 seconds
MakeDistcheck                 PASS      148.62 seconds
CheckValgrind                 PASS      151.59 seconds
CheckSmatch                   WARNING   303.02 seconds
bluezmakeextell               PASS      96.75 seconds
TestFunctional                PASS      1185.61 seconds
IncrementalBuild              PASS      476.21 seconds
ScanBuild                     PASS      1092.29 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
monitor/packet.c: note: in included file:monitor/bt.h:4530:47: warning: array of flexible structuresmonitor/packet.c:2300:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:4530:47: warning: array of flexible structuresmonitor/packet.c:2300:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:4530:47: warning: array of flexible structuresmonitor/packet.c:2300:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:4530:47: warning: array of flexible structuresmonitor/packet.c:2300:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:4530:47: warning: array of flexible structuresmonitor/packet.c:2300:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:4530:47: warning: array of flexible structuresmonitor/packet.c:2300:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:4530:47: warning: array of flexible structuresmonitor/packet.c:2300:26: warning: Variable length array is used.monitor/bt.h:4304:52: warning: array of flexible structuresmonitor/bt.h:4292:40: warning: array of flexible structuresmonitor/bt.h:3048:52: warning: array of flexible structuresmonitor/packet.c: note: in included file:monitor/bt.h:4530:47: warning: array of flexible structuresmonitor/packet.c:2300:26: warning: Variable length array is used.monitor/bt.h:4304:52: warning: array of flexible structuresmonitor/bt.h:4292:40: warning: array of flexible structuresmonitor/bt.h:3048:52: warning: array of flexible structuresmonitor/packet.c: note: in included file:monitor/bt.h:4530:47: warning: array of flexible structuresmonitor/packet.c:2300:26: warning: Variable length array is used.


https://github.com/bluez/bluez/pull/2849

---
Regards,
Linux Bluetooth


--===============9153083191390458713==--
