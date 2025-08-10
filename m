Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD104690
	for <linux-bluetooth@vger.kernel.org>; Sun, 10 Aug 2025 19:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754855850; cv=none; b=GePzmRAfyha0GLCdi+MYmDXXaCS61jout5tt9epKsMSQE8rTdW704GQ4gHDcYCzQhxseo9Mqx79McxfQSoVLxMG/OxtF6gTRSPKCgw1O/+p2syLafAOecScdOmdqwK2+EJW7j6eKy/If9UHIRkE6PyDUdl3YBoaP3iMohc6Vd4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754855850; c=relaxed/simple;
	bh=USSTFAhfvU0GAGsrWNw7a/E7dBd+YYD5r5jNwB88jnU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=llUqC4QpuXDhY21rnl4DSeJQI9znJhQu6Eq4b/jWA2txvgZgR/PI+kcBdOZ01il9DpsNl9Es6pSqmDH1RKak7hFJgZN9U2WWCVVzNELAJYhyK/jF9oFPDrJXl/qJfz+u9zqNi0ouYcZko7EBaQbvWvrCcOjK7FxXwzJZARjOPtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aOmmNMSj; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aOmmNMSj"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7e699c5b110so396196385a.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 10 Aug 2025 12:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754855847; x=1755460647; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JXe07FNfxZ2MKTju+E6GXvysp5FfZvUWkVYA9WI9iDM=;
        b=aOmmNMSjUikE7kopOQcnZGzAHcpLPOFF0FhyB6+ufGKzqq3WNxkGDNLBqW9uQll9oK
         fWpgck79xIr+pPoFM28Iuf0Tb+GpIp+0liiScuJa9FEqAhd5H5yd+gYsksNX7A/D+fNw
         8EU1w+jp/Nb1ArP0+py34IMr+2/nqNLIMWOintkWehn/xwPNGY7yJn4XhGHsa+iuvQkD
         LNm57wFl3gUy4tm33PBU2RuuSU4RleArkndHJBdFUY44sKAczglh5LKqPrhk9sivqRsu
         fo/iKbI7P6BYQG8sP3bJ1GSrzzcVCmzK8kIYlGkcSEeye7Bc2U4gJufi9zoQQj2UbfIP
         r3xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754855847; x=1755460647;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JXe07FNfxZ2MKTju+E6GXvysp5FfZvUWkVYA9WI9iDM=;
        b=VxutI+5reZYrrYOttGzw70VYaFTbbwo0Gy/Uvk3cWpOIrO+w9y7zwEhXXFZ8vE5ODp
         bbs/vsNtoUd/S2VdFarFL0JGyTx/kibtxn4yLa10ZcCK7/CNmTpks4LhMZlWiTzhoJp8
         9qRHCJ+ocqbE+vLqfLAZo3A+ME3MEKZ9tn+JLgcFTbKkuCXZZn/T4KUOxl6I/h9ws0rU
         KzneAsupvmlzyH3zVmOj2QMrNaq79FmIsrEpEyULgB+y4J1/G8kLpk7HcGM0T9CA/996
         aUtuZHJqm98la+1g0l5+s7Mp4XFqnn3f8TUNBBVXvZdAwdQv8lwO2qjdbizOU8gd+Goz
         y7TA==
X-Gm-Message-State: AOJu0YxsuiwCUWkcS/YwC5l0qFymEP54xtFo+8z9o0xLPi5ZFnxkeDvL
	x0YYfxugnaCjh8gP8cxc3F5nMRinsZqmMj1gR6LG8KL8Mazqe1eCPHcCSM430w==
X-Gm-Gg: ASbGncvCNN4utM7FdRGMx7yoN0ii8SsoZr9Bv5T+drQ/yXeyYWDW/4GQsfbFDHQTQ/H
	50783OzpBrpC/mAp1PSMrCQJN7MwH846UOsMwxAksDhigO7qbuUYtqFP3XW1+MxSnucB+Xji7AR
	p+6wDpVJXAUVxgzkqVVgMvTOJnv1e/nG0rO8LWdFsYwaUBm1Ytq9cr0M1djNiPDFBr2qSPK9yNF
	Lx2T0y/sY9nDYy+9yJKiRs15gXZM5514Xxq/7EgHEc/dIbN4CiRca/n9WE8lxI4b4lnaYVSjVZI
	F9P2qEtWTylZDTeixlshq/8qkZamZEqfNjz7whzWvk6EzELDiZYVw9+695tCkyYNMYRoPxrHjTm
	/81ZEGMThLVZPMeFV6Lbm+28svANg
X-Google-Smtp-Source: AGHT+IGz02hYFhV3frK+fGtasY6V6l1cHG4wlXEXU04WzI4QDvuilSgdlwgbMmB1ZMUMn4mkAVY/tA==
X-Received: by 2002:a05:620a:1a9e:b0:7e6:3e26:63b6 with SMTP id af79cd13be357-7e81ff9ae91mr1734647585a.21.1754855847449;
        Sun, 10 Aug 2025 12:57:27 -0700 (PDT)
Received: from [172.17.0.2] ([74.235.126.84])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e806ad969dsm920175485a.78.2025.08.10.12.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 12:57:26 -0700 (PDT)
Message-ID: <6898f9a6.050a0220.5a1fc.64cd@mx.google.com>
Date: Sun, 10 Aug 2025 12:57:26 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5195458907903563314=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ] shared/bap: reset local ep states on bap session detach
In-Reply-To: <d31b0994cc4ffa178f044be156e95324bdc0e64b.1754849783.git.pav@iki.fi>
References: <d31b0994cc4ffa178f044be156e95324bdc0e64b.1754849783.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5195458907903563314==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=989741

---Test result---

Test Summary:
CheckPatch                    PENDING   0.31 seconds
GitLint                       PENDING   0.22 seconds
BuildEll                      PASS      20.03 seconds
BluezMake                     PASS      2566.34 seconds
MakeCheck                     PASS      20.42 seconds
MakeDistcheck                 PASS      183.99 seconds
CheckValgrind                 PASS      235.55 seconds
CheckSmatch                   WARNING   306.96 seconds
bluezmakeextell               PASS      127.71 seconds
IncrementalBuild              PENDING   0.22 seconds
ScanBuild                     PASS      912.75 seconds

Details
##############################
Test: CheckPatch - PENDING
Desc: Run checkpatch.pl script
Output:

##############################
Test: GitLint - PENDING
Desc: Run gitlint
Output:

##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structures
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============5195458907903563314==--
