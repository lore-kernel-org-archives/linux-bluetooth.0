Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672734879B
	for <linux-bluetooth@vger.kernel.org>; Sat, 24 Feb 2024 20:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708805078; cv=none; b=KucJWAqPqmfG2jeWlZPSKBicCIcjaBfr6+DxF7oJau3xesO40jyEsMYsjnRk7QbNuZSGGBGcqHSuf9wDKmXvjjAlghWJJppkW1hbzn1NbyOwbnNSt+BTL2wWcHSFyQtXuIDNjRiCMa0vh5U91Iip1Jz9tpr7+Z90Fgq9Sv5V3pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708805078; c=relaxed/simple;
	bh=YgzcNko4uMB50X98OxfWhfxcPLlW0FI7x2ym6c5If7o=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=nhYzj8rp7OGzJ86vwramyCbrO943051BbdmeBjO7+n/ITnai2GhgiYttXggtv+EjEVXo1ulq2JwSM+O1q0s8Gq9dqhgcrEGelxoprRQgAoG5fXUuDFMJg1zG2Ij0G40FYvdnFtxT0h+qomwBxlHEs32ddMbMqym5HTCf2upndrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mwvX53zV; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mwvX53zV"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-787a843003eso130019585a.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 24 Feb 2024 12:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708805076; x=1709409876; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rGDtcbNZ/xDsACw/lant4+GghlowexllYNxl86Qgpsg=;
        b=mwvX53zVgJoivjxkh3ykdOCdbJ4of1XndKYN+jj40FJQeqqxH8CbuDcDuasdJpuSaA
         09WPggFbgfhCse4/QiAhGOWvBjmUGcKfJAZ6IK4zqCkbuCpOe9+wJS76G9MvTOPPUTl6
         6abQCbYGcXDVa2TGaNlOoGcnNCRyeb/iTwSdNQERv8Qn094J4H3Eu4neZbB2vJ3lA+MA
         fcM7jXoHf+twE13UnBMstW2z/UmzyC1qlDFAT1Ct2pyRGojibaYdUg6jgPc00C21eU23
         CKdyVGE5QppImZ4F/XMVGwTHG0AbYVgvljYavqF/FtXYMs2EgThvbciVO7dbzi/0XOny
         eOjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708805076; x=1709409876;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rGDtcbNZ/xDsACw/lant4+GghlowexllYNxl86Qgpsg=;
        b=IZk9yT5WTZXLn04FWh48I/GVCvsWggpWO3eC1+N2vtBxYB9hM80cROXFx4gAsR3TN2
         TOb5dfHvYrbQcRU2i5h3u5PiZTuSnIaRnWO/fSAS02IVlcjlv1K3HJInyHb5lh5v0Zgd
         lu25h73S427hJDQocacyg5pnYkaIglHJgb4WQXgY+P+FwzxqGft9T+nCr4h+ukmh2UZv
         0QWtmiC6Yuqm9FYzZKGM+cJoCb77P8OSaqJvkfpdvHdOyUqoGq+Aw5fldgj6LS7G+thq
         U1IACgRxykhTLD1L3kgJhwh7fky4uweNaON/wz67qm4Nn698zgSlg5Jv/JwfvzLqgx78
         H+Ug==
X-Gm-Message-State: AOJu0YxuI+M4UEttB2auv4y7zZo0w0IG4kB+ga/+PWp3hrOr/SlUGWQY
	9XIvpnq+N55hMD6cTQNqDFC1K6wz4DfTOufXXdhA/IgA42i57uyCR3KtzDc6
X-Google-Smtp-Source: AGHT+IGE6eMFJ3JXi9h+Q7e/NzBwhgaYL+0a6/95jRN9d6oFRpeK4ryZ35M8+AjlNhfZBjfVrNBd6Q==
X-Received: by 2002:a05:620a:1676:b0:785:a011:f542 with SMTP id d22-20020a05620a167600b00785a011f542mr3594738qko.34.1708805076093;
        Sat, 24 Feb 2024 12:04:36 -0800 (PST)
Received: from [172.17.0.2] ([20.109.38.145])
        by smtp.gmail.com with ESMTPSA id br37-20020a05620a462500b007874e54ab1esm878740qkb.20.2024.02.24.12.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Feb 2024 12:04:35 -0800 (PST)
Message-ID: <65da4bd3.050a0220.aecfc.26b6@mx.google.com>
Date: Sat, 24 Feb 2024 12:04:35 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5008385874567981074=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, Joakim.Tjernlund@infinera.com
Subject: RE: cups: Use pkg-config to find cups backend dir
In-Reply-To: <20240224183650.3571984-1-joakim.tjernlund@infinera.com>
References: <20240224183650.3571984-1-joakim.tjernlund@infinera.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5008385874567981074==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=829501

---Test result---

Test Summary:
CheckPatch                    PASS      0.42 seconds
GitLint                       PASS      0.31 seconds
BuildEll                      PASS      23.94 seconds
BluezMake                     PASS      723.49 seconds
MakeCheck                     PASS      11.79 seconds
MakeDistcheck                 PASS      164.00 seconds
CheckValgrind                 PASS      228.53 seconds
CheckSmatch                   PASS      332.63 seconds
bluezmakeextell               PASS      108.23 seconds
IncrementalBuild              PASS      672.66 seconds
ScanBuild                     PASS      966.78 seconds



---
Regards,
Linux Bluetooth


--===============5008385874567981074==--
