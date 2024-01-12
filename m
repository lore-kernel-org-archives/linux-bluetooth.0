Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0D873165
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Jan 2024 16:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LG119VjD"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-680d2ec3459so50820456d6.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Jan 2024 08:08:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705075687; x=1705680487; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4ZQIEvJIm0K4d2AOQoVoV8JDw824WeKMY4m9gG9RcvI=;
        b=LG119VjD4LtI6GWivFkf14VTsCSCitk/JToQRBb8P9VOtE9ALuF6n9EVNN8Ae2cF1Y
         vN7gbZwPyOoLmNV1j2INyuFdDACOxxvgzC7EyHsTxE6k8T2jIUUEsATmqaTcpK9twWL6
         uTYTELF1pQ0dnBvTftSAoNmJ834mxcn209zMPRKNUzbq76jGIlQYLGDuvWSjmw+b2Dpm
         cm6E+fK4RRtio6mu3cjyCVtBjB2X9WW3q0txOn+5QrhJ9B/43sPt0jdcl9tQSGEfcceD
         R+IAxkqpDOAM3snQG6Ozm9bxq9qC80fr3BXCiooo3WwF0+0Qy/ZwhdtRqep56Qjwz/qi
         TdMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705075687; x=1705680487;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4ZQIEvJIm0K4d2AOQoVoV8JDw824WeKMY4m9gG9RcvI=;
        b=CMkiJXpvr2kFBwv7juMjEvQJJZwQ+zjgsocYU1VYF8/tVMP/dfAttR8JLsp+0opGzT
         7W6zc/ZI4Mpi+3jxILysUV1UiRwqstYZRKdbVDJxGSzhk3cSiZ/DDPshlf/8UZlZEY3v
         mK7JrYT+QReio1/Ts8ixl8PMbXNhvrFnHYPVY2TUMT80jY8MVvflD/d5YlxpDA1IZZBm
         4znDfKVPY1jMAez+4cSMeo+EUr8uWQ6XVXv6iaaZp8cPaXPtgKZyrLNlrY9fN1cY2KDc
         JaJREymFEusU5ejJW0JZqx3xG1/o1wZMoBTYzFKqpF+m51bDwnkrmhyWWV6kYQ9GPLeX
         UMLw==
X-Gm-Message-State: AOJu0Yw06AFip8AklkRpGaKpeP+f/wADNyIWSeq75wDmTv6UVD/VBO6t
	EB/JQfjasuQ8jltREujWC6Lr1fkPVj4=
X-Google-Smtp-Source: AGHT+IGIehXlyJAPLxD4i+hsBzzIsJmVIgH7bXZoSrB90+bC7sy9argpnA6oDalUG1/OU/1ujwOtKA==
X-Received: by 2002:a0c:da88:0:b0:680:cd23:83f3 with SMTP id z8-20020a0cda88000000b00680cd2383f3mr1345219qvj.13.1705075686955;
        Fri, 12 Jan 2024 08:08:06 -0800 (PST)
Received: from [172.17.0.2] ([74.249.14.163])
        by smtp.gmail.com with ESMTPSA id k15-20020ad4420f000000b00680ce23bc29sm1126880qvp.71.2024.01.12.08.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 08:08:06 -0800 (PST)
Message-ID: <65a163e6.d40a0220.b819a.61fe@mx.google.com>
Date: Fri, 12 Jan 2024 08:08:06 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1342772248385696520=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, silviu.barbulescu@nxp.com
Subject: RE: Add code to support dynamically generated BASE
In-Reply-To: <20240112144044.58051-2-silviu.barbulescu@nxp.com>
References: <20240112144044.58051-2-silviu.barbulescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1342772248385696520==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=816538

---Test result---

Test Summary:
CheckPatch                    PASS      0.77 seconds
GitLint                       PASS      0.35 seconds
BuildEll                      PASS      24.05 seconds
BluezMake                     PASS      726.16 seconds
MakeCheck                     PASS      11.40 seconds
MakeDistcheck                 PASS      162.67 seconds
CheckValgrind                 PASS      224.48 seconds
CheckSmatch                   PASS      326.89 seconds
bluezmakeextell               PASS      107.03 seconds
IncrementalBuild              PASS      675.37 seconds
ScanBuild                     WARNING   967.02 seconds

Details
##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
src/shared/bap.c:4805:23: warning: Access to field 'type' results in a dereference of a null pointer (loaded from variable 'lpac')
                if (!match.rpac && (lpac->type != BT_BAP_BCAST_SOURCE))
                                    ^~~~~~~~~~
1 warning generated.



---
Regards,
Linux Bluetooth


--===============1342772248385696520==--
