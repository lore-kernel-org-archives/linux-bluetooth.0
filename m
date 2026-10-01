Received: from mail-dy2-f42.google.com (mail-dy2-f42.google.com [74.125.229.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CD94968EB
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 Oct 2026 16:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790873302; cv=none; b=CY35teuyrEoRmBhE1XAqENxZL0e0X74ByDvjKLiBW+Iy3hBJFPxfrMRVrerzs/T8ZpPbWd8Gjma985WN5H7sCobSKENVbYDGt3LCvXlUL+RbreRNc5NxXx+to6vrzsz12B0wEOm65LKFtJ95pPZXbtv2SwzoIK/+DxX0TMboMKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790873302; c=relaxed/simple;
	bh=uenJCEBoEB/xIgCf/CW1o1NhjWZQcoa60gq1qPh9YM8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=llY4ZjSSgIc6BKnbbNoqJGpvJWM2wmt1UwTF1r3vUm5GY4yIjTZbEtKcKtiOJZFOBufC8xhp+EMd5RHPcrud6JvPfitz2QcTsrfQke1Ypdb4WCzPZEDJE1kR2uzdYkNrd5tVS7Q7wHRcW6t7kSxxb2ysVZBruU5xiZAcxLhid3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ondnbFJ+; arc=none smtp.client-ip=74.125.229.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ondnbFJ+"
Received: by mail-dy2-f42.google.com with SMTP id 5a478bee46e88-3411e0ace58so8490950eec.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Oct 2026 09:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790873298; x=1791478098; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=uRDHXb5O3MHCFliTurP3ph1VYXjscRpGLR6HIsDq/OY=;
        b=ondnbFJ+UNg2/1LRQRYQrJlop9PUT1PQbDAdVzXlqAsohC/0/BxWLXAgnFrqQfkDfO
         +CYe04NKi0uSwIJ3rsaQ7VuL95dmMArf/HFWjl3dD/kRLvEHeHeIi8qt30coMKztCmj/
         VdI99OGHkDiwENlR7eo2JwheU9ajH0hY09zTqLq1VNaSE5AjhX3SqJvQzrFXGJEC3+jp
         OqwtQodb7x9tgwyisJl+vBfs+yQcniwDDUyMGvrnhkSyoMpgrI3OkXPsVIKmns8IQd53
         Rx11wxXLExRGEtl7vWlisXOzNebN1rjr2dt+7okAnCJW7EeFVb+o2p5QkTvg69yGoF9d
         U98w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790873298; x=1791478098;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=uRDHXb5O3MHCFliTurP3ph1VYXjscRpGLR6HIsDq/OY=;
        b=zJufpLBbJ+gsCnfXWfTx+AUOnakGTT2KXaYF+UdF6k4v6V6TbykALfxdx6B/ff49XV
         8yPB53xcqnZOrwFnBwfd/0o4/53W1fQThZuvIOvoKyZGROWBUhy/LmaUWnSnCFqQRasy
         lDKW1BBovqQ8qkmwSUjvlGCEmTYALwPQfAVaXeujeReidYovPOZ+0xU0Hawuq6HyiqON
         cp8DMygBBhZY4is9Sr1OjTQgn3YP6LXtwqtGzruzn9FBdOTPyxCrUWLuCiXqhY7AHlDP
         yEU0ass6SXbTHS9tccpa4cEugwhv+tyyxTHl2zT1u5h6pQ1bNAP3xtMb5L8CnDM0URuR
         fH/Q==
X-Gm-Message-State: AFuF++kShn0q4/ADqAqeAp+NOKVIKwM4lFEeFYPKs3bTYnJgTNCVVYmq
	WWAN3N0QRXZXMCE7UztffT3yc2BF0pTEp3LQjR2mOF0M5q4k3lvyfTy79uzLFA==
X-Gm-Gg: AYBFou26q+nIGg3aD8pgkGa3RqhsuSwtbPwjBQ8l2/vob9VBpl6jJahcnkS/TjBJA1L
	Gwpi+xHPVapMUjfq6JYigh9GoMpFX6Tu0YXoJ272QMff+vY2kCNIIzb4jwgh7sXw3Y33f04m/RD
	1FT7TZp/udNP/KJzqEnhy7tmxkiTLO+vT2et4U+KA0e+NBi1XU+XdbUWOBOh4WqdEj/jLLSIsyJ
	F+Wmf3dYIwXyg9nUaN2MS2iwENBcsBlhetjpHqAgMJYlSVX8QNe1/8UbgDGylvuK0w3m5L/Uq+v
	QoqNPUfxlfNVwCLE3lGo51JFatQ+QKm9izvNSSHhXnChzJ/kiJlDU/pJtlxpN1TJFrl8DXXoa7C
	FWLCdJBTsCZpxuseN8uiAY6QNlt2Zyv+i8P7JHd3xtX6Bb0GAbahgD6tmXqX4cFcZeMK7gvW41H
	1eGEXA3giSgU1QIlIVQCvlIXICSMIWWYRVeTpiQwBdxVvmHT1MXseHcOhfo7kFRVxDZKs7s0w3f
	RCGegjEmA==
X-Received: by 2002:a05:7300:bd03:b0:33b:e842:d272 with SMTP id 5a478bee46e88-34cd937558dmr7500398eec.5.1790873297697;
        Thu, 01 Oct 2026 09:48:17 -0700 (PDT)
Received: from [172.17.0.2] ([172.215.216.218])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14f265d30c4sm471678c88.5.2026.10.01.09.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 09:48:17 -0700 (PDT)
Message-ID: <6abe8ed1.c02443da.13027d.c687@mx.google.com>
Date: Thu, 01 Oct 2026 09:48:17 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6678527432504938477=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, eduardoalves8006@gmail.com
Subject: RE: a2dp: Fix crashes around pending SetConfiguration
In-Reply-To: <20261001143436.230557-2-eduardoalves8006@gmail.com>
References: <20261001143436.230557-2-eduardoalves8006@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6678527432504938477==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1177732/

---Test result---

Test Summary:
CheckPatch                    PASS      0.83 seconds
GitLint                       PASS      0.53 seconds
BuildEll                      PASS      19.12 seconds
BluezMake                     PASS      370.55 seconds
MakeCheck                     PASS      3.46 seconds
MakeDistcheck                 PASS      138.68 seconds
CheckValgrind                 PASS      148.29 seconds
CheckSmatch                   PASS      286.00 seconds
bluezmakeextell               PASS      92.75 seconds
TestFunctional                PASS      1105.32 seconds
IncrementalBuild              PASS      382.22 seconds
ScanBuild                     PASS      1102.19 seconds



https://github.com/bluez/bluez/pull/2618

---
Regards,
Linux Bluetooth


--===============6678527432504938477==--
