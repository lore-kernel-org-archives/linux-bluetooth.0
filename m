Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795443352;
	b=kT1u2dNNtoq+1h8fMfVIoCCiNwGWcWLHIyXyiOaeofS4pbe9cLmidyqIIUBNCAzZCjuh
	 Y44z9WT02ZCohG2w4KG3yAZPqPZgs9SPnYk+ud4wdTbmu8pmYKn21Xlj5Qmb+iR+xk+Zr
	 r8Z+SPGP4H9z+OKjJ6swxVUI+A6WPp9yIKvhk5Bbo7lLPxbTWmKiCOY/aNBMudFBbikeW
	 stqfpRGPJ01MC6W+YkYFfdTQPUXaooGo9Fb1FAfP1ZgMg0t9MEyeYo1bGTMZ1K6Xr9Q91
	 mJKOWSl0YZYzQjawcpfQcrwo0p/TodcBP4cAqGU6q/kkbsFjLWs0g75Pv/GncASpvjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795443352;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=+njHrbEE883Rx6JDpzzpTZWhc6jc0zisv/tE1Oe34vI=;
	b=vfzRhYIiktx6QFSK8J2tJFTf9c0uI1aRjRzWuamlDlNFyQHMZ58yguyrC6QVOJXeIvMe
	 uHYgeKWr/uN9XmYZLEJACUSCrWlrymAsVoPFtelRVkpHSIbSrqycC+ZL9VVIXOsfmbM06
	 lsGsUPT4Yk2KNmjM7wcUfzFI8Awetv0VORouusZM4Uy7BHc5X75hiJbCihpZwfKrONTyy
	 e5oGpWFPVQFsCEgpDV/DBpHh7vAzXuirQxw/g3ISnOKsQuxN0FcvwzHeFSrGyIfmIbYjN
	 KHy1tN1R/9qPO3j3RRAbAzqQJl4f78MD3ajBM8TCGkQn6SyT++z1nRb/VdLPyUd3pug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rd2J4ItB;
	arc=none smtp.remote-ip=209.85.210.46
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7C1606A33B
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 14:15:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C7C1606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rd2J4ItB
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-862bb0a189aso1555934a34.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 06:15:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795443350; x=1796048150; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=+njHrbEE883Rx6JDpzzpTZWhc6jc0zisv/tE1Oe34vI=;
        b=rd2J4ItBdL1k2eONV/e+u5PbCrELOEa61kuvBK55avxHIbjgIJJov0Pgu1vjr62DeY
         KmarHSiXPxr7z9ZpNbwTbBwJrPJG3bXAG4qepVuRMLgfTJkBdY9DQTMTsY/6o+kdwj2v
         dwUB+pnMjjnU9x6+nNYsno/WE3aTlD0JbrI4+IwOaF8TCXQtQCwK0A49CCJI/leTNobS
         dMjY1xfnovlW8RCdNL4lj7UAd668Vg+6TkYR1AXcOb/yVakT5SpR15ufJzmorS3BnTLs
         U13cHznfmhtzo1vSMYxi2my5cUBGLs4s+ubbhk+epMaR+PyTOqTN7y5Rsc+SC0LbOakM
         Q6sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795443350; x=1796048150;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+njHrbEE883Rx6JDpzzpTZWhc6jc0zisv/tE1Oe34vI=;
        b=0W87zLCddHUrZqCVzmNwcBV/W1pcVRFLNbc77PPvJufmRIe2k+K88XGqFg4Va9tICq
         8Jn2j6ctOFwib0gFB2B1yqSSJKn6aOCxjupmJv00/JLEW2bGWJ97BCdEJOvOL2NXfNE+
         o7VVGnBtz90E3z79tDnNCfR0flZ6hfR048n0eeF6irNek8+vYpslR1u/IQoaTlRtvP1v
         YfU84hNs59/FlJUtOTfRHQ+TWuV3kqlpBEtWYngTfK7pNpHuI+YPzlbLRjlT17KkFbPO
         7Emf/aVrWb1nFQRhQnn8dkntoiJGkdStUKZrKckcUVWCT9qlegOVP+7Q8du2SEPpSbP3
         an6Q==
X-Gm-Message-State: APuU4Z+dbIMb9V5nwkwc7d7bgHZJJ9mEwQalB1Nm8ld/qJcv884izzjf
	f9Xs9RIHFBnkJOpAc+kYaLd7qSbVkmOL+tidrWFWp8AptRx1tlfZde3fG/aCZRzgWIc=
X-Gm-Gg: AZFdTZcYNfD0odvYl382NtvIjTIySO12KjwwHjHXfpnTONsSZBO6FxnIGPK2YR3T3Zf
	lyLN/T7+OSwJkssT2/4yUZ69QCwwkv5MtLAKXsAOMHprYVZLaYZaEubR4wkX1MS2/RfBuqmQ9HK
	DJ9VVkd3CfiMucGgoQHlhzYKfDIbNOIKvDnYufUBetVLEXpg5S+ygX1VbRqesxUgQ8tixKn0uja
	5Zu2t02fcL1CeiYN6bkK7spYxfEv/edXC6sNi1c3+dkfjeWGAGGVsQ61eN5FplIjsO3uR46Qyb0
	F0NG4m9MAn56EdaMgI0xZeA4QM+lYqxsBTddC9jz6lX0iM16/8L5TZH3jAJJb+LUV4PMmD/F9W1
	L8g6g4F6CyLSAohxmbSZYnuz9FOf5ooeEWtyRIoAkHoNkfnIdDbk/7p0CqCpPuqhF9HERZUJ64k
	xlWTrocZXN/fBvINej7iqwS4lLmnQvVom6/2/nAOI0D+PIcGMphi+00EWZy4AXhh0XvAatF1RfE
	MX0XPLehuSegL7Sey8fnHvF76VS2or/RrQ0RZjqcnf3uMs5+NP2dypZSpkoDW4=
X-Received: by 2002:a05:6830:640d:b0:7fa:ab72:9e04 with SMTP id 46e09a7af769-863159b2057mr13274082a34.28.1795443349938;
        Mon, 23 Nov 2026 06:15:49 -0800 (PST)
Received: from [172.17.0.2] ([130.131.214.0])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-863168f6d33sm8442123a34.18.2026.11.23.06.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 06:15:49 -0800 (PST)
Message-ID: <6b044a95.dff45fae.23ef3e.6892@mx.google.com>
Date: Mon, 23 Nov 2026 06:15:49 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0596990895474388318=="
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
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: monitor: Add an OBEX protocol decoder to btmon
In-Reply-To: <20261123102548.61362-2-frederic.danis@collabora.com>
References: <20261123102548.61362-2-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0596990895474388318==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1219437/

---Test result---

Test Summary:
CheckPatch                    PASS      2.70 seconds
GitLint                       FAIL      1.12 seconds
BuildEll                      PASS      18.68 seconds
BluezMake                     PASS      274.64 seconds
MakeCheck                     PASS      13.54 seconds
MakeDistcheck                 PASS      139.12 seconds
CheckValgrind                 PASS      338.32 seconds
CheckSmatch                   WARNING   250.09 seconds
bluezmakeextell               PASS      90.52 seconds
TestFunctional                FAIL      1145.47 seconds
IncrementalBuild              PASS      321.27 seconds
ScanBuild                     PASS      985.39 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,4/4] monitor: Reassemble L2CAP ERTM/Streaming SAR fragments before dissecting

1: T1 Title exceeds max length (84>80): "[BlueZ,4/4] monitor: Reassemble L2CAP ERTM/Streaming SAR fragments before dissecting"
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
monitor/packet.c:2293:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:4220:52: warning: array of flexible structuresmonitor/bt.h:4208:40: warning: array of flexible structures
##############################
Test: TestFunctional - FAIL
Desc: Run test-functional
Output:
FAIL functional.test_bap::test_bass_past_earbuds_transport_acquire[hosts11-vm3]: AssertionError: Failed to acquire: org.bluez.Error.Failed


https://github.com/bluez/bluez/pull/2880

---
Regards,
Linux Bluetooth


--===============0596990895474388318==--
