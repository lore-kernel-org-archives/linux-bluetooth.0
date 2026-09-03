Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432853A4513
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Sep 2026 11:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788436772; cv=none; b=urPg8khATFmU/giboLvigFM428x/bamw9davsDvtuL7agq63B+hgf1RBy52CDrdrJYWZYw6KjvszSUIuENiRsGvWB7bn2qGFZngScFEOZNAcAxtu9PfTY+f6+wBBdfEf1rk64T4oKvU45PZ7rxcIk+stxUdUTpxr19+vb+EdSuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788436772; c=relaxed/simple;
	bh=HCPpeGskjO3yF3CD5WVE01LhUIFh969je5vgI1bDbAY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=HybRXw3fsKr5xtZ+nr7+BAahv/aZ2E6iA2zYPUw+j30hHVhOXRdK0jwN/OR3/3c+ot1ZF9c+OX8i6UttBp5ssmyx4Ha2iKSiDF/POcHFEhiDiUu36ZmXexanJgqS+9eAZ8gqr6yTJLWK0yx1j0mrow0DFYsUlDRzEyc3A8teRNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZxUaAwHy; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZxUaAwHy"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38759bcd877so2740282a91.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 03 Sep 2026 04:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788436771; x=1789041571; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=pkUAAcee/M4He0FlQjpilt3CPqPQiDhpHen6oSgcVwc=;
        b=ZxUaAwHyDh0BXE62rzo1WV3JZRQZIGOvrHOay7Pj2xPCpbjlq/vUCERqqMZGXEe+78
         xg6VxebFZVAMZQPOyulcdb2rzA+Cs7dwqFoS7OC3alRGC6hhbhpviD+a7rm3yv1WZ+4M
         NFKz6CvCiBJDYdXz8i9rtgFc6f6ZPRSIM4zihWhpNeLnvuOQq2A8fZ7s25rZtNfq+t98
         6ZHSu5uM3jC3+6o7PYcqXQ5znLRYEtF9K0mLPkZmCYU2V7wWasLVuh3KyVOJ6NQQQ8dn
         TyfnCLD2jq1SpdJnBuJO+Xd4K6a0DzfI19GfEw1H84UC6x5y0g3gGO/ihmOE3F3gTHUo
         jHzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788436771; x=1789041571;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pkUAAcee/M4He0FlQjpilt3CPqPQiDhpHen6oSgcVwc=;
        b=A0a3oiKkZv8Sbchb7LeCd4wH3/+q3qGVYQvo4cKJZ35Ffd7S8mexR4hs5eCQZe26Hw
         Fx08uuAyjEziNFTYHMWqTOMsSVkn4lhFUBPX4ulST5KzFVtEWFMRxqO/ip1Dkuw/9U8U
         PHmeD8s/PhbUTo5mLbvFWhnhOTE9zUf/qMH5qfhd+eMTlQgu5+Ua2ML0E53Mq4917Ez+
         epU/87AykBmzljhPh99gikmwTsIFZCLOds6HKY60tVCKW7Nam/vBOad44M+plKOmqB2c
         QfIZA24KL3qsa1eeTe/t4MLJTXWo2e1H9SDCiSqgyxep3gEJbnRA5xZaK6NWuCy2hS02
         I3fQ==
X-Gm-Message-State: AFuF++m8+jOkT/as/UcVAShgf/MHwR8zdDwsfzgNEbUltpNMh/rTpobf
	Pe3FYBW/earv8vxHAgESRmwEmZXXkZH1njt5JhaoCTxxV1OKNUFuE2QP/r7vPw==
X-Gm-Gg: AYBFou1/pPyf0p3jrJQW3dh1KPs6V3/akZk0+6T4sIKGBZ9kRRvLBVtDRHKbmzI0qfc
	6liwAmBO/np/Aa5m8n7WRLAOQpnW6LGo2JXo+ewDLFMRXzjAzTUJWPLWSFv/M0EoVnENuTtWaSP
	QT3vWAyDpuxnFuxNfzVHIoaCrV9yjhBknAats0Yl+nlyyD/gD15J7MDsuY0iZeWG29hpNigKUvv
	mFfcDPGGyNtH9+2YurlZOE2g2vYsJ1uJPS9OwU1O5GNb0M92Oqj17uz4y0QYma4ZiSQ3ec5/hDM
	gjW9WWjvFGJVT0aM+pzTFLvVQsPycQt+TQqAOFRDJ/zZ0uDlgDO48e0MnVkOzoEAoExr23bHkyU
	nvfWqaPrRqvWLze+od89aIO4caOsAw9fghVnPVJ9KDKtdZmPAuLTqBZ9jV76DbmPsvxskcRF8Wj
	eFdlL3jrqyd1QhkOMGvzLXZnk14c9VkG0se33R1T5UuQHY5MoI9pbJGJv71rK4plD1St8=
X-Received: by 2002:a17:90b:4a4d:b0:380:540:d499 with SMTP id 98e67ed59e1d1-39aedf75c71mr15901678a91.6.1788436770532;
        Thu, 03 Sep 2026 04:59:30 -0700 (PDT)
Received: from [172.17.0.2] ([20.125.46.144])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b07b197a9sm4983863a91.0.2026.09.03.04.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 04:59:29 -0700 (PDT)
Message-ID: <6a996121.8f0cbdd2.1fadcd.81d6@mx.google.com>
Date: Thu, 03 Sep 2026 04:59:29 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7036661515279871333=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, nithibert@gmail.com
Subject: RE: [BlueZ,v2] adapter/advertising: fix mgmt endian bug
In-Reply-To: <20260903091059.161705-1-nithibert@gmail.com>
References: <20260903091059.161705-1-nithibert@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7036661515279871333==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1156908

---Test result---

Test Summary:
CheckPatch                    PASS      0.28 seconds
GitLint                       PASS      0.20 seconds
BuildEll                      PASS      20.82 seconds
BluezMake                     PASS      619.17 seconds
CheckSmatch                   WARNING   324.39 seconds
bluezmakeextell               PASS      105.83 seconds
IncrementalBuild              PASS      614.67 seconds
ScanBuild                     PASS      1034.60 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/advertising.c: note: in included file:./src/shared/mgmt.h:95:25: error: redefinition of unsigned int enum mgmt_io_capabilitysrc/advertising.c: note: in included file:./src/shared/mgmt.h:95:25: error: redefinition of unsigned int enum mgmt_io_capability


https://github.com/bluez/bluez/pull/2478

---
Regards,
Linux Bluetooth


--===============7036661515279871333==--
