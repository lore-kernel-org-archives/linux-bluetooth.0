Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795136128;
	b=eLYu7z+gpeHmlkMorTIrcNF4DT2jXpsELvG+u7HhGRR6QnYVJLzaUW6jjTurp7eBxFbG
	 P1oX1UDJteqQTjKJnDrrAizMFjJaukEVNJANk6xdmERStEPqVlwItU7Gc6g8VXkLO7sTY
	 XUadN6+qFrvgppaBzRtkOZx/gMFUyd1y3F4Dlb3Xp4mAXjomNrthx7HrITCg1XIBDZ1yk
	 WmH0G4IGO+lSbFO455aKsOzNhikzrjWRqcF99CvYeCPzBbWruZ3L/XZMIOFoPCmNXTqYe
	 gQgCIO1mLM4aU4UFfIIeeD6ajtJUX9C3KgMFRBM0Bbij482uXK7YPMH2heMIYG7A7vg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795136128;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=oOYIhjhLkfU0K2fgBvQpDiSVp2awBvBewma9lQ0hnt0=;
	b=MK6q9NbgpSHdpXdac1qqc390dPAXt+Kx0lQyltxqXSt5rsC9tlCBiWSGAwjxDahP8+vU
	 drvqhMqHkzP9+vxrpQPq/0UY1gTcerrb1OKjuSQy5BjytUoscaco9r1fkOwD5TVOVzDA7
	 rh8qMFbi5mcoJHCg6kBoMATAH8yV2Tjtbjv1MuOvQGSzf13/I06ca2/lgGTlsmkCRuzuJ
	 56P8k3qrzs2KTVzc+rjhBIEfC1C3DzU7GrPhZ7Ood6vNSZQzt0KLECzSKAAoHYIqY4bzs
	 DcXY2xvRUOeADAuUFBP7Cgg8S7dMvKKWh2fh96DEAnV0EUM82FMK5lSV0WFVaAshIJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LOOBNbWr;
	arc=none smtp.remote-ip=209.85.160.180
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A48C606A320
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 00:55:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A48C606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LOOBNbWr
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-55d30c054dfso4312421cf.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2026 16:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795136127; x=1795740927; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=oOYIhjhLkfU0K2fgBvQpDiSVp2awBvBewma9lQ0hnt0=;
        b=LOOBNbWrQ4pmp3/Nr85lgAr6bSFK+UyZ/+4/mxT+Lh8oWr/B+Bx1aIq5Dbl3flzjS/
         P+Gk4CpqINBryBCkMlj5+f4N284LJEkOZUiatTM+F/ybBUDlmEMiwf5yzOQc+SEC+uLj
         vSU1NZKWLufcPuNA1lLQKbDSTIqRs2mzcZoCz3Tk1403Z/8xlffkEmwkvu0RnYczgKk7
         doY/pyagQy8rKmxzwOEfSkOLwGvKLFIcILxOATq4tuczIB8qQbEmK+wnsekXz1ehRirM
         xt4L/dvyjj9Y9bEBSIh3SrAbPPqDVr24SrXC5Dlze6UEAMcFGPaXnwGcq2uAEMIDZ/xa
         C33Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795136127; x=1795740927;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=oOYIhjhLkfU0K2fgBvQpDiSVp2awBvBewma9lQ0hnt0=;
        b=Nz6m8R+8buyFcTHh31ESPl8oFs8Qk3xzVcSc+TeVjI4fx4zAJ2H4hQdihDGJ1Dngfv
         +wVtVvl2sloQA/IBHu+28V1YOVX8yK+KEgLTl+hnd1oerX7jDVPBXTFOjkWvqTfm992Y
         5WCHJxrfAQRhNJhVU3ETXd65FnL5Z6hYVuhAAFSetG08kHnxEKVRWIMm8abATk2wvRLe
         atFMFvmbovICtdDeRZl3ew4syap4dvDdzdZ1hoZwoMmdLR7LQOwNoHhPjfkePbUmJPIy
         sSsQpAcY7ye1+2X+Vz5mEQSoMhpjJ/Xy3EQLV9PcoZMQ/7wV/gVBfW2sQEc2zkqY3vtL
         noQg==
X-Gm-Message-State: APuU4Z88j5LjQHatV+5zZLsHZ5PdXYLoHXbhRc+VOCCrjBW/A+mEEwaI
	F/cMQMOEhFl/51r1rKNHNWGqjNvA2ozkAvjjil06ghw2BEAqPothaqIacPA80Q==
X-Gm-Gg: AZFdTZdSJboysJJvbLXIePKdFVStykBavJdrdXOExCjv//V+RPcq9SN8Pi1bej/9o84
	M3iOA8Fh91FeG4h7PnnCasv0/IYmBFeHT5rKYZ3GCRwbyH+Kb7mmzJmlO/ntOlv07BL/D68hS1M
	I+i0OqfR45CPvwq1a6DluEnWIhiGqE1SQ3wIkLs5g9pCPS/cxJ8n1829xar4Jjzlt3o1G82uSUO
	bJCTWbOiXi25j4Qru1kbITpI/0idbUHkAyBoAKf/6pL9S2pZ754KBFv6RSUJ0d3srL1T67CIK/e
	wo5/6u+Gv2kVu4MHg+Y3etaTw/Jtx1AS46QKVv+02mq0obFGpmZ4rMBWqPx/JaQPUI/4VsqD/bP
	zM4pXrfZxEUVihNX99vWbk5j3ZBdEHEsDFK9DeDC0aGJw+SCdFm8oyCf42ooeqiSNIhEl+m3M9j
	AIcdZFKe8iDyMr7zIDunabZmB0qLuflPZ9v7kAGzHtW8ZbLdwQM+IuUG/mZofFYhtItkj1lG2X8
	f94SxvD6UdxeyDoxS/Ot5FztKgmnnVxEuzfWA4HXbhR9ltSiu9qXxSt8Kk5xtAJrkGmqO2UW9q9
	bWezqHiM
X-Received: by 2002:ad4:5949:0:b0:91b:5d3b:4aca with SMTP id 6a1803df08f44-92134b4107cmr26499986d6.51.1795136127095;
        Thu, 19 Nov 2026 16:55:27 -0800 (PST)
Received: from [172.17.0.2] ([20.55.118.116])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-921349e602asm12011826d6.24.2026.11.19.16.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 16:55:26 -0800 (PST)
Message-ID: <6aff9a7e.b3f5340a.30e815.3956@mx.google.com>
Date: Thu, 19 Nov 2026 16:55:26 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5079824409792274074=="
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
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: Add tests for security of deferred setup
In-Reply-To: <20261119221520.1311381-2-luiz.dentz@gmail.com>
References: <20261119221520.1311381-2-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5079824409792274074==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1216712/

---Test result---

Test Summary:
CheckPatch                    PASS      1.87 seconds
GitLint                       PASS      1.06 seconds
BuildEll                      PASS      20.98 seconds
BluezMake                     PASS      316.62 seconds
CheckSmatch                   WARNING   323.58 seconds
bluezmakeextell               PASS      101.19 seconds
TestFunctional                PASS      1241.02 seconds
IncrementalBuild              PASS      330.08 seconds
ScanBuild                     PASS      1216.40 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
emulator/bthost.c:712:28: warning: Variable length array is used.emulator/bthost.c:713:32: warning: Variable length array is used.emulator/bthost.c:966:28: warning: Variable length array is used.emulator/bthost.c:1000:28: warning: Variable length array is used.emulator/bthost.c:1001:32: warning: Variable length array is used.


https://github.com/bluez/bluez/pull/2853

---
Regards,
Linux Bluetooth


--===============5079824409792274074==--
