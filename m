Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB0A383A5
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Feb 2025 06:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738910035; cv=none; b=OvHvO2wB174CE9nKWVcrBDKhVgkcVD/XfLAliBq02ICNxmptcr3XioAkrM26R7ob3P4i0MGceLE+J6nP70l5asUE6G1FxtGfe8hvmjFFM68s5pJjgT669cHxo0qO8Oa6ODp9qWMa5rMVLETZLxH+R+0i5XTzzihGreCEJVDhsUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738910035; c=relaxed/simple;
	bh=Hglv9O+N8ldN7I7FioZXQpHwiEqmo79eITx6/jsam3E=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=IpHJZ8NGFBYjrmYEHwaYb3jKgzum6m+Qom5lIJIF79MviQaowuuoHHvVZzL1ddx4YW77VHTC8yAmjsGKpEyxjelVwvJqTjIpb6N7oQYbNNlYVhYjYNv87bvLoJgXipcAOwZQvawL7j2BT97TjqWo9jWMGAMdMLODvP9kG2wtShQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kTJnSgF7; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kTJnSgF7"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7be3d681e74so157798385a.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 06 Feb 2025 22:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738910032; x=1739514832; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=G0ikW7gUn2TA5vWBHewg+FTvIXQKtDeARVQTOmjkN8E=;
        b=kTJnSgF7+izq2zOz+uwJvDcr75+M8xLSp8ESYyh2/104jyKKNpNIkbueikjG20RgFC
         9vih/8zCE9c+ChKQOB0412uaKY1KDSiOu/LvcNbcigE3cUIZLSJUDxZWgrN9AMxdt+Oe
         0l+UauZkzx80IiEvzOC8a9wm4Q3dJZsIJi6PhuL1MWxIeiMcbCOswU5M9jsInok3NLqP
         O38j/DPANsdM9FsGr+aEsR0OGHtwgMci8Oov93uDikZ/Vg4cfZGuuRN9v92VWScd/ukj
         AifKTfTXlhNf5NkdXDstwZrrYBPdqlRRUiEA2PC4+M2nrfIbluyGXedWpUne0zQMcap5
         W9Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738910032; x=1739514832;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G0ikW7gUn2TA5vWBHewg+FTvIXQKtDeARVQTOmjkN8E=;
        b=uv9bHO3ojLxkC6wfB14ulygLFmMw8xz4wkuTTuVfKNsGuoZgEpAoryhi3dnLcrzuTg
         MR4FVVLfKEA3pueTqmVNbfhntXNijRPo41oablNsG8UtSgs/YYTieycU6oIetshKQHyT
         u2eR3x+P7jxJcV5icqMHfQYo6fjHbkZ50NdwXtE0xtPeR7tJQ/grUkDSqpHwQNOd5J12
         p5KvAnjkFQvM7L4IxaIscz8U5Zlya6WhvmQ0jCgUTxhuqWNH9hMCa7XQkkI/mWjE4Y+X
         fX4NrgG5fndGqOXveQf7DZSUj3UvEYbwnNbSGofrvzW5UoaSKJ+OwxT4n2D/za1aW+Bz
         5fDg==
X-Gm-Message-State: AOJu0YxnH9+wGKBJm/kNg8XhOi/YVAFtLzJtXi9WnQVuD0RZo5HtLMzB
	7z4AyPJ7cXww0NiCevQC/CGrUb824ClvZiAiDWdz9vIKMZtMQNApRu2y+w==
X-Gm-Gg: ASbGncuFxROCCuxCof0eM2BuxAFraIDrGq7nx1zj39C9lpdqwpUX9f0lN8JXK84QMRw
	4zELbuxvNzzzEaVdFtkeszX0sSU8nPyH+o6qBB0jbIj3q873WbA2uiipYKAOemAM+jSFso77m1q
	u+QlUlalMBilLGtwrlIoVPH3S3VQ/KjEqCbZKdpP+bIl/kYUyGgkD2G2YmN7xArjiVIIZuLFmZc
	BvgKnBIaht4MmiSF5LWsQFssbNFzUUhCDGOk8RAf/9hsoAxdceY4kxMKT7x4VY86QHHrAaToiqp
	Gu/LaYLNe6TEsEOQ5hMj
X-Google-Smtp-Source: AGHT+IF//EKOHz3h1+EEWrpnd5VYk4I3zdqptqPxUNec8rcfCDi95j7gs9syxoOP50xjubh55xx3Sw==
X-Received: by 2002:a05:620a:2848:b0:7b6:6e7c:8efc with SMTP id af79cd13be357-7c047c78558mr304740185a.44.1738910032066;
        Thu, 06 Feb 2025 22:33:52 -0800 (PST)
Received: from [172.17.0.2] ([20.39.61.205])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c041ecf174sm151485385a.114.2025.02.06.22.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 22:33:51 -0800 (PST)
Message-ID: <67a5a94f.050a0220.134cba.6578@mx.google.com>
Date: Thu, 06 Feb 2025 22:33:51 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7154355429624513340=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ronan@rjp.ie
Subject: RE: [BlueZ] zsh: use the correct completion return value
In-Reply-To: <20250207052345.63368-1-ronan@rjp.ie>
References: <20250207052345.63368-1-ronan@rjp.ie>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7154355429624513340==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=931450

---Test result---

Test Summary:
CheckPatch                    PENDING   0.17 seconds
GitLint                       PENDING   0.19 seconds
BuildEll                      PASS      20.78 seconds
BluezMake                     PASS      1571.53 seconds
MakeCheck                     PASS      12.75 seconds
MakeDistcheck                 PASS      164.52 seconds
CheckValgrind                 PASS      221.28 seconds
CheckSmatch                   PASS      292.30 seconds
bluezmakeextell               PASS      101.14 seconds
IncrementalBuild              PENDING   0.24 seconds
ScanBuild                     PASS      882.01 seconds

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
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============7154355429624513340==--
