Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5F61AC45E
	for <linux-bluetooth@vger.kernel.org>; Wed, 31 Jul 2024 11:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722424368; cv=none; b=JagAPARkjRqx1Dg1Zcfhh28dPoOPhc4nES2O/q6FkZxNiql7RamxsiVxZJQN+oIETAfCt6/yB5ewywzoaF4Yy88zskVlyvC2Htlb4+LfAJm3v2hRiH/3uXICcC3F/g9Bf7LwhzrwjXdsTYywZEth7g0RZ1Dq9MTKa/xtYgVd3Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722424368; c=relaxed/simple;
	bh=yA1AZAZG8Sqx8acAe6ggEpcRbdk1exkKYvVTQy1kS80=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=J18elNyRRueDJeQQ8/Ph8HBLPh1p8n3h7EgK+lw+EdAbyxJQ15STTinJ2zLw28/7jp9zCu/IfWLfoNS3zbAzChrG+pF/xIxBt0+nRYR4mCGJIZt9hfehr0IMCn8WgolWF73Tpb8j6RAbcu6Xc1zWNmfJ1YBZHyx1FNe5AaVzfvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VRzlMDJS; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VRzlMDJS"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-79ef72bb8c8so234158985a.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 31 Jul 2024 04:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722424365; x=1723029165; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2VvjfnviXIvkEZ7BFllUKUc3FA5uu3KMYARJEJwezk0=;
        b=VRzlMDJSVGNu61dgudiSP8zZi0b22uq6ur2SXStkSxJhS24SGQfamdi2h16crM7T1g
         pZOdIQB1N4OU7RecHLE/CamYP6F/j9AlqzAbCxOnKmIDFjNb/wxgVQ5AFTccGJpnzBKV
         IpOmRBzarxrmzoNzX0AcO9D59K25JqPn0BouG5B/PpP5++wQJ+U2q9gEetBGWSR6Th+n
         isrDIgRPGAZtXQIonGiqYe/XcbyhvBQIkcKaAqdBloliyN1zSFX44YwHsUNwYe2Jf7Ea
         sK5OpEFyPp+7ww2otEHFVy6XM/bNA97VydUuFa/GXADWkGFAHmo99BHavojudu0Eqou2
         g51g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722424365; x=1723029165;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2VvjfnviXIvkEZ7BFllUKUc3FA5uu3KMYARJEJwezk0=;
        b=K4u3jCo/PNRo7sGeu00JheE1vA6qGBQnxWZ6JoTQ1eEqBW/Myz6CzTBRY7YWOr5J8j
         i4WbQmJ2qLzbQLmSyAlsmt+0180v3S6rRfQIEGJIyp8EjlCslKWRczFkPntX3jqqKXWe
         vYuZtJDpWyAaWKFJO7YOQHrE5wvpxPZLyvqYQrbvmrTXARc+ALi5dachCDrBpHsmtJ62
         7djukOPrvL/uD3uFnlV3IC0hL0dcacTAVPRRB1e43eRWDSuYd/+vsNdfpUAfhoI4ipNg
         mmjRfG7M0QfBTQ+HITC1OK+0Ep/pUp4CZgPvcRYU7f8obuvm5JGYrU2GkR0m92iCvuop
         dJhw==
X-Gm-Message-State: AOJu0YzXLItshWeBLVe02hDAlUEDaOXOPT0wU525fdHVZO20CWnVEhgE
	Vei1VZsjTxIE6+Hlez9+Wbzscd4runBJDTzYul07s4dj0maqgDCXH8TyHQ==
X-Google-Smtp-Source: AGHT+IEYnRbOTtlpKVaOUI06/718f3KeqPSOkZr7TviArSwv8d5lJCMSd3JjmrK0e2e185LFBTpWeQ==
X-Received: by 2002:a05:620a:4156:b0:7a1:dcaa:5c9d with SMTP id af79cd13be357-7a1e52c9886mr1740193685a.56.1722424365091;
        Wed, 31 Jul 2024 04:12:45 -0700 (PDT)
Received: from [172.17.0.2] ([40.67.133.145])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a1d7f221f7sm719981685a.19.2024.07.31.04.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 04:12:44 -0700 (PDT)
Message-ID: <66aa1c2c.050a0220.2a60b6.691e@mx.google.com>
Date: Wed, 31 Jul 2024 04:12:44 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4533955635663115658=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, vlad.pruteanu@nxp.com
Subject: RE: Add 'broadcasting' state
In-Reply-To: <20240731061713.435586-2-vlad.pruteanu@nxp.com>
References: <20240731061713.435586-2-vlad.pruteanu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4533955635663115658==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=875317

---Test result---

Test Summary:
CheckPatch                    FAIL      3.86 seconds
GitLint                       PASS      2.45 seconds
BuildEll                      PASS      24.94 seconds
BluezMake                     PASS      1679.68 seconds
MakeCheck                     PASS      12.88 seconds
MakeDistcheck                 PASS      179.69 seconds
CheckValgrind                 PASS      253.70 seconds
CheckSmatch                   PASS      359.35 seconds
bluezmakeextell               PASS      136.78 seconds
IncrementalBuild              PASS      12881.18 seconds
ScanBuild                     PASS      1021.66 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v5,3/8] transport: Add 'Select' method
ERROR:SPACING: need consistent spacing around '*' (ctx:WxV)
#128: FILE: profiles/audio/transport.c:975:
+static DBusMessage *select_transport(DBusConnection *conn, DBusMessage *msg,
                    ^

ERROR:SPACING: need consistent spacing around '*' (ctx:WxV)
#128: FILE: profiles/audio/transport.c:975:
+static DBusMessage *select_transport(DBusConnection *conn, DBusMessage *msg,
                                                     ^

ERROR:SPACING: need consistent spacing around '*' (ctx:WxV)
#128: FILE: profiles/audio/transport.c:975:
+static DBusMessage *select_transport(DBusConnection *conn, DBusMessage *msg,
                                                                        ^

/github/workspace/src/src/13748132.patch total: 3 errors, 0 warnings, 42 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13748132.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============4533955635663115658==--
