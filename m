Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE7514F9F
	for <linux-bluetooth@vger.kernel.org>; Sun, 12 Nov 2023 17:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YZyQ9C5J"
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F573259A
	for <linux-bluetooth@vger.kernel.org>; Sun, 12 Nov 2023 09:26:03 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-77bac408851so393809185a.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 12 Nov 2023 09:26:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699809962; x=1700414762; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OAhcLodK/B+bjinJGZZbbbEtJgFy/8USlkD053i0YLo=;
        b=YZyQ9C5JvP4xQNYebYcU8dCec6T5uw5VsS8t+uTY42JdH8vJJbPzlw6ZoOT/NuJcci
         4kPmJGr7WnubGdYuOKqqlI49pSwj+yX22zEJdZJyz+y9hUVehS0BAQT5U1kaVAa+7dIi
         PfrR8MUoBa6nUYflkbERPyPqc0Yhe0/co6mj2A+GbZcmKPVUfeot1zyOV1VpSfsPyQFT
         BrBPpXQF0Bm4IBs0GMvHPuj3fLD+9JyiKS7PXu1VOAk2aO+GYAiRwnoPUoI++gB5ZvL8
         I+/U2D62Qt3x0DaLlLNOSv5ixZyQPMBfJO9yp0BS/rCc3zp2Q0V6TQmW8TZhCMAuh5oa
         +opQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699809962; x=1700414762;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OAhcLodK/B+bjinJGZZbbbEtJgFy/8USlkD053i0YLo=;
        b=fjBcVZsWCDkjgjE6530c43DRTj+4Vciyh1l0OmIT1n0w0h8iuKKijyUs45RIdPXVkn
         kEeO+jfhpaFiu5dIaLqgUcXuraaZEctIotEKwHMwUHgAICrAlromgiv3JjByrU9E+YMI
         2t1lZG2b2PRDa9wlG9iIceuxp+mDR1hMISMWCT8HDNec/k0OMtnH+5/MHpeG5S2tIk5P
         7FYJVEx5kF8/yOS1AEkQMHEpspp83EsYLA66LVrx++v3gAASzrzCFwi4psxmYs6/0v8b
         VPyTRB46cmD7sL11UO4GrAmHQAXHMZnWJ2xppeUlWNP9sRSxewrE+NOXGxsL3LrTUuah
         tVVw==
X-Gm-Message-State: AOJu0YwDYZ0gTdATDMzcljFJs1+hRFfCAQ1/xbtNACRjUjnzvEZpW1Lb
	tx6cdv5mtyTRvPQNR+Ix3w3959+fvBw+ZA==
X-Google-Smtp-Source: AGHT+IFLYxkyLzwiUHLPgOabOV9Zg/kyZu2CtHdcsXbW9gPfyFpVryrsPqHMEznay/UgZqPvijE8lQ==
X-Received: by 2002:ad4:46d5:0:b0:671:560f:3306 with SMTP id pm21-20020ad446d5000000b00671560f3306mr8249599qvb.4.1699809962215;
        Sun, 12 Nov 2023 09:26:02 -0800 (PST)
Received: from [172.17.0.2] ([20.97.191.176])
        by smtp.gmail.com with ESMTPSA id q11-20020a0cfa0b000000b0066d1e71e515sm1394121qvn.113.2023.11.12.09.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Nov 2023 09:26:01 -0800 (PST)
Message-ID: <65510aa9.0c0a0220.84fe5.38ae@mx.google.com>
Date: Sun, 12 Nov 2023 09:26:01 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0964375655498957443=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ,1/4] shared/bap: add bt_bap_stream_config_update for updating QoS choice
In-Reply-To: <b48261aeab5a4f5927c9da5296b2ffb079bee375.1699802164.git.pav@iki.fi>
References: <b48261aeab5a4f5927c9da5296b2ffb079bee375.1699802164.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0964375655498957443==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=800489

---Test result---

Test Summary:
CheckPatch                    PASS      1.97 seconds
GitLint                       FAIL      1.46 seconds
BuildEll                      PASS      23.84 seconds
BluezMake                     PASS      544.63 seconds
MakeCheck                     PASS      10.81 seconds
MakeDistcheck                 PASS      146.51 seconds
CheckValgrind                 PASS      207.82 seconds
CheckSmatch                   PASS      311.76 seconds
bluezmakeextell               PASS      95.34 seconds
IncrementalBuild              PASS      1990.39 seconds
ScanBuild                     PASS      886.44 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,2/4] shared/bap: move bcast configure finish out from set_user_data

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
14: B2 Line has trailing whitespace: "    "


---
Regards,
Linux Bluetooth


--===============0964375655498957443==--
