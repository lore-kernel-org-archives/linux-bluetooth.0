Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF5237C907
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Apr 2026 12:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776341447; cv=none; b=l1PcQFzXIEVLV0ruGxy587SpGjR1KUYaSKkfSe+X7emsKgzXub+iQUT/PiHhq0+qtLH00FROSmY0zipOHl/uiNzzVepEDq8k626HOg5m8mUQ3sYK6P3LxwTLlNcnCRlpVenOHsX8gML1CQXKFVxQ1dRxEzwj9LGd3DBw9aVWTsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776341447; c=relaxed/simple;
	bh=S2WXN4MOllveP5K04Ex+GYKmkY1u/jlneDo+qkfouCI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=XrXXPIRM5jdlzTYW+1bua71fDIk8wDTVIr5H/11Z234HU99lYZho9qM29nv9WX4dRuQdqtpz1sHqcIN8e63y3igzPF9IUQo9sTxGiXUmuQkHOVGsT24e6lYNq32BVqD9daWsVJiZo4DhJm+mk/6zEopK1uXHUaoGO8qc5xQha8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hHRHFq4b; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hHRHFq4b"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8c9f6b78ca4so935448785a.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Apr 2026 05:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776341445; x=1776946245; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3WxgR7EV2kOjnFAz88/xw04/jWsuQDtWeWDOGc3Z/ew=;
        b=hHRHFq4buamBL4zaPuV3TSAMWeHIMA+hmpP31ohGlBl/FgiLNlxueJoe9Fw0PIRgX4
         NBzRL91nmHjBR8b9jocrj0qlfmjP3nuWSUISybwmqRPF25n3Oz/FIQalb5yHYQtpj1Q/
         zsFl/+Eh5vV14p56bdwTLe9+yjgyKCrWoRLk8M+za2YH6d8SncvoBVhctIoMvogTuXWY
         0XBO8KUdb9nDPfPwK3ajpTF5HlY8EJHW4ECvO7J0iYShV2u7J1U9l9XjWpWKXPgz2D7C
         6i2THOJauBHHpou77EfvMf+Qtw+39/ctY23C38CoqMC4X4xSZV2qA9z4DP5Jt32ltJfW
         XfEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776341445; x=1776946245;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3WxgR7EV2kOjnFAz88/xw04/jWsuQDtWeWDOGc3Z/ew=;
        b=V3uq3+BgdihcjucFw2jSpwGZH6r6u7J/I74svxYQl3QaFw5Ma7CLaxC/UYXtoMPl1D
         hLg643zwXlp179KAnNd18Hz4ykQ/oLUePSbmlLNtBP3hih3dQ7xqPJcFjdwHa/AIIcnO
         gYQY1Wl8d7tW5QFF2bEUeevKFJpCPTwFgHTSzpAgMsN7zLQ3+PMiyHuohSf0esloLSLq
         eFIVBqbkECYJh7QlwmIyAeOYV5f84GAQK8n84kWPXA15uq1v3D/EgfvAC32Uy2FZdYUq
         UHELRhImItpNUrrmeVLKg89rU4jYqndAq7e/zWQLt4mxZyEpH9lq7dLHqV5sXRUP8a0T
         aEUQ==
X-Gm-Message-State: AOJu0YxthcSNbyo6HYO3ntZLwjZIET8qRPXGvEXMs+DuF++xI692OIlM
	4ZlHaVaW3GNBrnxmQcj/goE76pVcz8AN/10To/wgomh64kD86SpGqhSRoGS7Bw==
X-Gm-Gg: AeBDieuy+YWjVpDUgQcTth+vapDDvlF8xO0gIHIlJFOX4mIWZ9EcxZ5lJuywFPYskuv
	ZNz2uEN6yRMO6CgDX12FCFkITt9hNK+DpWbkloWZsdiAOkVBj2aqpYcKOR1IwDA8HqR1FVoAIb1
	Q3/MqOsTzuPKDmxTpyoFV9Yg1aRC/9UMpPcR29jGOGKfY48H3/vGLcYwAMlvc2mMJhCrBPW/LMV
	yQoE4SE3S4cOop9ctCoAByUZDa0cboimM/XCyxHJlVBBqToY1wWJTger9S9gXciLFSWtCLVyhGu
	C++tMbu2n+x0K03LcK2WkvyfGac8FrYzXW2NPVZVu/eqTTbSWFW/VbUgybZjOFyuJtvBhqRCA/t
	zY18f0eHVE7532TlW3CVYXqy+oYeeauHC/TQYqPO/WFcY9nEnpW/vqz3dZOg0OpO8bfKsHML6sa
	LMeiQo0N2WHYYBdQiJYypxWv/cH/vyKqMDl4bLCJA=
X-Received: by 2002:a05:620a:c43:b0:8cd:b315:7399 with SMTP id af79cd13be357-8ddcf6b69a0mr3679993185a.46.1776341444533;
        Thu, 16 Apr 2026 05:10:44 -0700 (PDT)
Received: from [172.17.0.2] ([20.81.159.35])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e4eed6ee52sm346504285a.7.2026.04.16.05.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 05:10:44 -0700 (PDT)
Message-ID: <69e0d1c4.050a0220.24508e.9e9a@mx.google.com>
Date: Thu, 16 Apr 2026 05:10:44 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5500641506055897987=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hadess@hadess.net
Subject: RE: [BlueZ,v2] doc: Add missing btmon-cs doc to btmon.rst
In-Reply-To: <20260416100323.3848182-1-hadess@hadess.net>
References: <20260416100323.3848182-1-hadess@hadess.net>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5500641506055897987==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1081970

---Test result---

Test Summary:
CheckPatch                    PASS      0.43 seconds
GitLint                       PASS      0.33 seconds
BuildEll                      PASS      20.51 seconds
BluezMake                     PASS      640.31 seconds
MakeCheck                     PASS      20.13 seconds
MakeDistcheck                 PASS      244.75 seconds
CheckValgrind                 PASS      293.05 seconds
CheckSmatch                   PASS      347.50 seconds
bluezmakeextell               PASS      181.64 seconds
IncrementalBuild              PASS      633.24 seconds
ScanBuild                     PASS      1020.82 seconds



https://github.com/bluez/bluez/pull/2045

---
Regards,
Linux Bluetooth


--===============5500641506055897987==--
