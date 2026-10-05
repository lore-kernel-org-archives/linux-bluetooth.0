Received: from mail-dl2-f42.google.com (mail-dl2-f42.google.com [74.125.229.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8293905EA
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 Oct 2026 21:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791237411; cv=none; b=YBqDmihrKIky/6HzUSe1tOzZASOZnC+BBImbF8QYR6a2VZ3ujhvOFqz2eRU76OfR7EctZH8McilgIEgk6LVyz7xw/vEnxObvMLu/jiJs9NUsFRrFPXZsLvYxZisOwY4bbAzsGBzABDvQrXxtDqWp5hVQ7U/z6zKdUxv/6/Z1NN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791237411; c=relaxed/simple;
	bh=wC4eLSUWD+tVj0Z6drJZK56wsyAgoQYTDQSbqo1jABc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Eh3T97uCviULvSOyoeAlA3p+4NKq2zHD4ns6eBcQk/0LAMxTxLuV7KTBOpAJPUwXmCwODKm62RD2JeuS7uFMY5Rfl0QDiFqQLOkQGRAyAK+dBIp8dR1MoHCxfEDSk+KGHTB+xs5USrYJodJV3ApnTcWjG84T1z7Kd9+FDuugEI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YLwak8kT; arc=none smtp.client-ip=74.125.229.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YLwak8kT"
Received: by mail-dl2-f42.google.com with SMTP id a92af1059eb24-144f47a9b57so992951c88.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 05 Oct 2026 14:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791237409; x=1791842209; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=PB8XGXdpXNC3fMgWmbRtvbznEuZXtTnrFuKmCcNgXl0=;
        b=YLwak8kTF3bX9bKV1jrdVBRDqc3Zra4tHutD1Cs32JSFhKa23YXiycMD9DWR4+R526
         z8kJDWV/QA022K3aE7hruDekbww6wsYooKzbD5dZOzzwXs5U852MwW56TPtu0KII1wns
         AJHm6zHvDAwJ/fPUdNihEWya2OtE6bJLHYiIMFGfpB7qyUsHGUsIt1lTOIMpI1HdX8n4
         TkbduvPi32dBMaRNFpy9uOcmKRf6Zf9zJgsknMqNzYkIVMkwdTCWgsvftOeLgDjYTbOF
         1oQlC46gT0X5ZezSnrZQpvjGMA9E8uCt4LN3owCq+jeSKmelw+qXvzvnIzptO8k1BkTj
         IkFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791237409; x=1791842209;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PB8XGXdpXNC3fMgWmbRtvbznEuZXtTnrFuKmCcNgXl0=;
        b=Vavl3ePUPUj3TKjK89oifJLBGtqc83MwKNFAfnFg70SS0aveMWtMa1EjyiYrTUyKo0
         E6rVSj/3c3hcpJvs4iA/vMl47WLBTfVuJa3OBrymiPMizcUtca1y41ZiQKp90Vf64hWJ
         j320LyCrowNLJKMmj1Zc8lvgtSG0hmRDQpxOk4ij2Y2jIGbWuSWka2zpUrkjespSknxY
         zwLnK1AV0q1oD8PSBX4DFhRCOt5fxqvIcMZL8+0pDGKHKjNMCY4zPEmuxoCd+Qqaaktd
         Suj3CNFk8601NDPogBKUTq+u/S4QZ9lnki1zRWGfxahSbk7cYi1lnijm1DCg3Fi5crr5
         fWIw==
X-Gm-Message-State: AFuF++nn9k79N7yo6N9XqfFmgZvDD+YvisLcu1EYtT+wdd2UePe3m0WY
	ViAqhY6BQYQilzUQFBbEOlJjpiv74kmhrdK0l8+I2pJDtlTYjxtrxxpSYb0l87dk
X-Gm-Gg: AYBFou0+KaIHBSXS4wbKx5mB2uuplKbKDNHXH1c3ztk6PhjmhYk/SP0nrVX3ijABJKh
	0IZCrrj+aKnkyi0z2yT37aKHf4zpINI5c70PNxMFUgNgAtUdhXIoSUZIPrviozFBO2B68fa9m5N
	b7E9epq4JjN0XGoc0sWsl8/3voHqgMscXSvia8W4eoT1SfcZsEId/jy4vIy+HP9f7JU30k+XkLQ
	gTCB/bbswopebp6eM0GMkhLF3izvNga1j6McGESTW26LOx2aNmzbyijiXj/rQFFuWLBmVf1ZPV1
	Nw4NpridRoU7EZ5UP4pen+mMXxEs9YdLuNTZJ6HH4Qb1dBjsDd3JTjkXmGttZcFcpJqbBpckiSs
	NMmCvjMDArEaTrVJWL4MTP0E6zo3ALoRjrUTH5aN2dNkXRZI7WgT6I5Go7htGWSU4V0tBOollKS
	vOResKIkYAscK7vlySt/hTXDA2YXXZl+Vt7BZ5UYEmM7NMkXec8eyyu1CqOFnfobSje6QmwTdcY
	bQ=
X-Received: by 2002:a05:7023:902:b0:143:3d94:501c with SMTP id a92af1059eb24-14f5d2b268fmr17388545c88.38.1791237408675;
        Mon, 05 Oct 2026 14:56:48 -0700 (PDT)
Received: from [172.17.0.2] ([57.154.5.174])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-15d819cbed6sm2980017c88.4.2026.10.05.14.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 14:56:48 -0700 (PDT)
Message-ID: <6ac41d20.acba1091.c4cbd.c7cb@mx.google.com>
Date: Mon, 05 Oct 2026 14:56:48 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0700909853414636057=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: mgmt-tester: fix test failures + avoid hidden skipping
In-Reply-To: <0e4c18a987bae5d3729514e3e1bd383c7c8ed9aa.1789934710.git.pav@iki.fi>
References: <0e4c18a987bae5d3729514e3e1bd383c7c8ed9aa.1789934710.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0700909853414636057==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

This series was picked up by the CI more than 2 weeks ago and the pull
request created for it is still open, which means the series was never
applied to the tree.

   Series:       mgmt-tester: fix test failures + avoid hidden skipping
   Pull Request: https://github.com/bluez/bluez/pull/2556
   Created:      2026-09-20 21:50:39+00:00

The pull request has been closed and no further action is taken on this
series.

If the change should still be considered, it must be resent to the Linux
Bluetooth mailing list (linux-bluetooth@vger.kernel.org) so that it is
picked up again.

---
Regards,
Linux Bluetooth

--===============0700909853414636057==--
