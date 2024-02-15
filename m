Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0EA679E2
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Feb 2024 10:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707992560; cv=none; b=qBbR8tjsl3EA+WdKIQxrbpWLsSPCGpS4mpo4wjBy3zhjiaoO98WJ8QQvyLWI3pSzNkU7xZoks05WSKEeCZ9WHl5jhfZCalaaNJi5DbmdftF8TGvabjl6vhZdEIg5lrxQbu6QSTYBARpnBuseXP/W+MPCHtg986dJaEB+IrSP4XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707992560; c=relaxed/simple;
	bh=QRreCpXaDF5UpFmIIEjSK05293xjktMHDDuBdx3sGkw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=DXyo5jxlhQ6Fm+ztA1VAvg2RsoMMQ3DB2ElFFY5Vm5tCB3Om1POiL2EFluiFDIlDS4CJa2mLAT5bJAzkEjJpnUOtmNZoPI8KAiYwsiIwu7s9QsCfmFyOb3KhnaJfe9vFMNxIXVkgUBNfaZ4JwRH7MIkgd+NUj8iY34uvv6W3kMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PJByagfG; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PJByagfG"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-783f1fba0a8so31115885a.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Feb 2024 02:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707992558; x=1708597358; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Lv7PtFxqFZ43d66v1bicWDQsl1TZLDibU7GGqZwqJQs=;
        b=PJByagfGaGVGjIS0RGNRDYu60G6GR90N6zf5TyhdRLULdltVZ9rLzZKn/q4hx6xrxO
         CseggyZX175wkYkWfzBhnmZnCFLUjzu+H3Zfmt8zdBXH5v+YY7oQZUHTvMeErekRTITv
         gMgFt1dXtqat+sTlYkMf9BHO6Yo/ft4RLB7GtRrbrRyC3nZzj1zfiInl7TmA8LAam8mA
         CcM4iS/6ySo5VsGBBPoBdSwMcPkvwbvDYsZgX/YgltdZsF+iOoOZRmtp6hqUO+7wAV6F
         qYEgsRQ2VRbvQO+qrrV3kwW+R0b6hdOv3/8A7ubv2NKJMfqiXo4OHFe3gumtbLzllrEB
         Q1lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707992558; x=1708597358;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lv7PtFxqFZ43d66v1bicWDQsl1TZLDibU7GGqZwqJQs=;
        b=EO5m4BfWK8zfHQMQMxPetRpTPVKK//K5vjJ7b3CxG1X3EhErtKmAmzIDcG/QHE2MGe
         ieilSGhNwnTzgMEZ/gHFY35u1ifnbaKUCUfT3CH/p4Cz2AmcoX4YrY6opJPefrOH8e5v
         lyhXG140cR+felUlpiX0lQ8lANW1Y4Pkcw3PDUAUtQuM29lHEQPkeE4LpgBeWN3e2fqZ
         mGTjg7RFy9IjGw+hd5eQn78iJwflEqK7nbMnEgNixELuwXoAC6OMj53Hx1ACuEV1+fwK
         2CDbdrE+hJyzdqDxiE0kjhqRz8PX+ZgmGs+jMQGzZjwWCNugTnV7aEXtKN8Lf7N10nLo
         kxpA==
X-Gm-Message-State: AOJu0Yz8FhjdacCHrcPEgHFQxyHQv7bA6uuWzWI4r7OI1J2Yr1ap1Xtm
	f2UlyZ8NzqGUrwviWz89q+p+rWKtmqby2uipLMhJdrbE79Q7BOUlYVl48VIc
X-Google-Smtp-Source: AGHT+IGQOhBduOPfk18gnAtJZYcZMQoLlpptL9AY0LgjVn7WLeLU8kj1G+ApyUMDKSY4yu9RlC9+3Q==
X-Received: by 2002:a05:620a:4691:b0:785:404e:6cf3 with SMTP id bq17-20020a05620a469100b00785404e6cf3mr1870041qkb.68.1707992557715;
        Thu, 15 Feb 2024 02:22:37 -0800 (PST)
Received: from [172.17.0.2] ([20.109.36.209])
        by smtp.gmail.com with ESMTPSA id u10-20020ae9c00a000000b00787214b33fdsm475686qkk.128.2024.02.15.02.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 02:22:37 -0800 (PST)
Message-ID: <65cde5ed.e90a0220.f6974.106a@mx.google.com>
Date: Thu, 15 Feb 2024 02:22:37 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6418173650525204372=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, matthias.schiffer@ew.tq-group.com
Subject: RE: [BlueZ,1/2] tools/rfcomm: reset ignored signals after fork
In-Reply-To: <20240215083954.5233-1-matthias.schiffer@ew.tq-group.com>
References: <20240215083954.5233-1-matthias.schiffer@ew.tq-group.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6418173650525204372==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=826253

---Test result---

Test Summary:
CheckPatch                    PASS      0.92 seconds
GitLint                       PASS      0.65 seconds
BuildEll                      PASS      24.66 seconds
BluezMake                     PASS      734.12 seconds
MakeCheck                     PASS      12.14 seconds
MakeDistcheck                 PASS      167.46 seconds
CheckValgrind                 PASS      230.99 seconds
CheckSmatch                   PASS      334.58 seconds
bluezmakeextell               PASS      109.28 seconds
IncrementalBuild              PASS      1378.20 seconds
ScanBuild                     WARNING   985.95 seconds

Details
##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
tools/rfcomm.c:234:3: warning: Value stored to 'i' is never read
                i = execvp(cmdargv[0], cmdargv);
                ^   ~~~~~~~~~~~~~~~~~~~~~~~~~~~
tools/rfcomm.c:234:7: warning: Null pointer passed to 1st parameter expecting 'nonnull'
                i = execvp(cmdargv[0], cmdargv);
                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~
tools/rfcomm.c:354:8: warning: Although the value stored to 'fd' is used in the enclosing expression, the value is never actually read from 'fd'
                if ((fd = open(devname, O_RDONLY | O_NOCTTY)) < 0) {
                     ^    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
tools/rfcomm.c:497:14: warning: Assigned value is garbage or undefined
        req.channel = raddr.rc_channel;
                    ^ ~~~~~~~~~~~~~~~~
tools/rfcomm.c:515:8: warning: Although the value stored to 'fd' is used in the enclosing expression, the value is never actually read from 'fd'
                if ((fd = open(devname, O_RDONLY | O_NOCTTY)) < 0) {
                     ^    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
5 warnings generated.



---
Regards,
Linux Bluetooth


--===============6418173650525204372==--
