Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C437B337B97
	for <linux-bluetooth@vger.kernel.org>; Sun, 17 May 2026 11:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779017829; cv=none; b=I5N8aTQroHJt7i28E/pDVAanLAggLK2rUvgeHX40IKi6J/Mwvpgewi3l69bsGRExEzWxzOCLNQ57cGFP94njlcGmiHcWm0Qd1jRjFnYK/ws1AsXYARu6gWqfOaNNhBrfnBMVVFbespDxELJ1Q4QNIZ7ZI/IzrqZ249Cs7MMclTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779017829; c=relaxed/simple;
	bh=secDqwrcOP/p+f5wyZDYva+VYYTmp8byCSsyRdXRTpg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Mpj8XfLQa9gRRMavrwCOzn/ZwXbU4rCliNN8nbCWDTk2UDQwqUT4zyfkjJ9q+VFs1G9SVpD7Zg5bXUcacBTij8iA+ExTm/9gCLrUuKACnEq0BxEGq/QzUidpQ9d2GXz3TJqgRpqTorlaFs0Po8NySjm8zLZ8OLgY+40F7LhG1qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dHcK9OTK; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dHcK9OTK"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2f36da5c8fbso1035102eec.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 17 May 2026 04:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779017826; x=1779622626; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=O0F+5cBOgIiP1dEKHNznC5g8o8EjuVWXpvOg4WaExnk=;
        b=dHcK9OTKvtJDRZcytaq/Sr5xmsKk+iOVYCmyUnvhwwoWL8VG2BtewC1KlCyJF+oMT7
         hJpxT+nFzr2C2kd7sV4zFjkYCVK2Rhge9THOOf7vl0qkgkBO6V/eKBIWUnHcrKFcyTTV
         7U4c6q4MyL6HqLh+vMLqerNNeP8BLss93rhETkLqeUDbFd+5wVARGpEj93mdVCOT0ryM
         P4k8kURkS/ypwLKqStOW5JM7EOlIEgOid9Hk+8oKSNDH9Jnnh9qcnPqvhXNOXgAU2A9Q
         6t4R+7icVVLdysq4tnbVd3CV5/OqSoB3FYjaALRnaaYO5QKZsV0Ff+vAJ1cOvp9bmqVA
         oEBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779017826; x=1779622626;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O0F+5cBOgIiP1dEKHNznC5g8o8EjuVWXpvOg4WaExnk=;
        b=QTpZPc69migut4GN8mRq1i/1JAnIOIy/0DG4ZxYvbk+j5fgRHQasOrcy4Ao7ubkwnw
         8ybrRQZBfAqwyqF18sN71s76c5xjgstCAQBZSIbIDyjYV8wTeWxcNhTGwTkfVhL1/dbb
         UAH5qy813ppH0k876PLYd8n5gL4sLf7zVgBed2vBwPwhheBsEZTfTJ29FI2fkMeQLKAR
         gh4RPvA3Gr0nSeibj4g7aywoC0WD96rvRm+jEJKVQWcAtNoaHfJQGmmX9bwFhZqxqKBJ
         kbQg0SdCOIjjjM9QJvKtMpw/6hrohBWLRoD+y9n4o+mjQJ6tvFwKJZdUwAs/zJafz7k5
         LORg==
X-Gm-Message-State: AOJu0Ywf1TYKd/Gg1qmBZOE8eFFQvvIfbV1mwatk26/lCjwr4ND0sWsF
	b5ruLmOIVYPPVi6H2m4YCjRIw43G3JKqZpPMvJ8H5gW5x0XN9+8mBG1hT7VejQ==
X-Gm-Gg: Acq92OEj8/W24sMuLkrpncRuoYpdlHvDkf/mdYE7S7QJTkYz5PxabQcUeUUtJlVbt6W
	/rl9Zqbc8YAwH+LsA419XTcAdrLgCOxd6WSuhgu4u2NmL2Cf6PgHeu1jv9u5dwFVeGINLbe8jVD
	a9KUTS+v6PdS77cR+AQoMvxcTYeA3Ut7C89rMdbyahBdtkc2Qxl8TiLb3CzUCwd0W3LiCwRDL8m
	f7jWkCkEbD6O6Kbx3UFT7YwUO8FUtooDvX/5leaGhxrUKEit25VmdzF9ExRnnOeCLhuD7DAGAXF
	CeSMXUQAUWD3DsA/nvA7X54+FxB+JrprY2lAQ6uqJKtTMNKuQNjNeyp+F8o9cijZQ+SkLQvtTjG
	PzP9IYtJxpaszeo7u1elxCtL48UCGSmFB9I5tiJS5rJJVhF7Qou57fjA19TA7H0/ZdbeZZNeNOo
	Uh7gTQQNE8dK4Ne05PJ1m7VRe1oQLB3nc=
X-Received: by 2002:a05:7301:2907:b0:2d3:2983:c87c with SMTP id 5a478bee46e88-303981710b6mr5018816eec.1.1779017826401;
        Sun, 17 May 2026 04:37:06 -0700 (PDT)
Received: from [172.17.0.2] ([52.159.226.243])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30296dcb6f6sm14500224eec.17.2026.05.17.04.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 04:37:05 -0700 (PDT)
Message-ID: <6a09a861.d08db960.4b0d5.cde1@mx.google.com>
Date: Sun, 17 May 2026 04:37:05 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1350611134424868676=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ] media: use custom DBus timeouts only when remote side is waiting
In-Reply-To: <60b9da865b9beb482f914818c31866ebb00960f7.1779011736.git.pav@iki.fi>
References: <60b9da865b9beb482f914818c31866ebb00960f7.1779011736.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1350611134424868676==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1096011

---Test result---

Test Summary:
CheckPatch                    PASS      0.32 seconds
GitLint                       PASS      0.20 seconds
BuildEll                      PASS      20.21 seconds
BluezMake                     PASS      660.37 seconds
MakeCheck                     PASS      3.56 seconds
MakeDistcheck                 FAIL      230.19 seconds
CheckValgrind                 PASS      225.47 seconds
CheckSmatch                   PASS      351.66 seconds
bluezmakeextell               PASS      182.49 seconds
IncrementalBuild              PASS      670.58 seconds
ScanBuild                     PASS      1032.73 seconds

Details
##############################
Test: MakeDistcheck - FAIL
Desc: Run Bluez Make Distcheck
Output:

make[4]: *** [Makefile:10239: test-suite.log] Error 1
make[3]: *** [Makefile:10347: check-TESTS] Error 2
make[2]: *** [Makefile:10818: check-am] Error 2
make[1]: *** [Makefile:10820: check] Error 2
make: *** [Makefile:10741: distcheck] Error 1


https://github.com/bluez/bluez/pull/2129

---
Regards,
Linux Bluetooth


--===============1350611134424868676==--
