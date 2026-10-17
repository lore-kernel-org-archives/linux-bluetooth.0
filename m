Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB86A2472AA
	for <linux-bluetooth@vger.kernel.org>; Sat, 17 Oct 2026 21:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792273566; cv=none; b=kNi/81FKyi+l1DeyyhTqbwWeljiQBBZoDXHzu6/bT29HrJFSAvgybV+MoQPeV5QVs4JaJHP7Y27fgL+0XWkqh2JMqsBWIHoAPUAyQO1fXC1e8ujLsWIENpn1nnxNn7bplrnrbu2vrgrUf7zEJPvu73p3GYj9qrleQNDFuYPL0vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792273566; c=relaxed/simple;
	bh=MkUWPKus5b7OuNj2dFL9Yh7C+07B3gCAmos851+5D+4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=prj3Iu8fIwdGq+gxpKPivyJCYnCj/dEqKVjc3fX77xT+FifQ0sSPVqHMFIiTu9ba4diQIhbmUnDpY3SBLg/eu0wvYlfpqUtMe1ns2YN9/b5GCVwMoRLgmzIGNPK09/M0JJg2OaIc8pgzVqcJ1Unb1ex37xW0s1v71AFOJbqrdnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=APnpM/Ca; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="APnpM/Ca"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-70059e4dab6so716464eaf.3
        for <linux-bluetooth@vger.kernel.org>; Sat, 17 Oct 2026 14:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792273563; x=1792878363; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=wd6LqSkP2OX2kmXhZRa7aQAvR6Xs5v/rS78ErL/6768=;
        b=APnpM/CaicdGY9FpgLRbIQH5KAc2IWaWmxvlkuUBnwXUHgq0rFMh4Xay4sele8gkXm
         iaWlgs37DFhrnpZRP4kDIuwpxBXQcSXdl6PAebTqdGRTQY2eJH8iKQoyLSRG2l3zFsqp
         DMv9Reh/RTlT14PmM5ddvYkxuMXaz2mHzJ9G7q5kVePo6h/jvVgGdlUQ8lKUVIU5aB6h
         XaJdX4Y7OAfFL+ztDYH+G07Q6IgFG/vBpryS+M0IL1N0aldVwMZmvqEUqqy7LsDVmtsl
         /xXnxon4YYbfI0dLxDfEdbegQkfQTgLs5UusMDctain3Q1/MEOdIokikxbTovrgrgDCF
         wHAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792273563; x=1792878363;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wd6LqSkP2OX2kmXhZRa7aQAvR6Xs5v/rS78ErL/6768=;
        b=sHRsV9oVd1wIvBJfsKZaklNUHlKMelKMoWgKhY9GDQR/Ce64mExkFvNochwqwHS1Wd
         ItVa4WRAT+Z2Ez54XJj5jhc1y1AJ7MTj9ze3Pz8bbZo9fBIs9Z4d5bVKQR5lRDFTUa1p
         orJKSL0AM7djL5mgpmH0zCJfHq0rrYxjE2jWxFn3usQtXwYNKD6hVvFZwLckEV1kuIOh
         2pRYOax062TWo0P7qeMJZjs5d7szIQnSMV5YizujE9Hjj4rrk6Hq6/VyVc/A01mI4Hup
         9UZmdU5uKR2E363XcHCLDJhF+KL8mhkBrD8JqwZTzqy3YHIUpIywUTS+Do3CBx4oi3e+
         R1lw==
X-Gm-Message-State: AFq9FYJcjOROfrCp2miiU7Yy+sLINe83k6AEMHAVvVwA4uGYey7V3Hg6
	K+xL7ufumPRgJB7+SXpgPAvDgdwPCJ3mpYQ6+aC/3/Yu+784w/IKyqE2zQrM3/UG
X-Gm-Gg: AYBFou1AhhusFMgaqit8AfCSmZDl6f9DnTTzW1XP8e13OEoIWX7Q0piSa3bjDN9S3ia
	GHEVFdc/7bhStq8dXiJ43FMrm2Yiv/iT44HmFVg1FUuM0tv8hRq6z+IF7w5jdmm+XfCTEVwuXZ5
	v8I0x/4vHClsw54bpBekRLKbr7VV8p2tlMzE5TXVHGEWQZN47zM0Mpn8oLFGuL7s3bUfnZcBTck
	FlGJjtE36Vn48WPHzGBaiow4NE/QJ1ER8eWE+j1oUC3cFvl/IPZPU1AzE7kKzEHyvXjz6YOBd8R
	QUsxYffzcajfoVTkD1weuzWDOdUWhz5DI8VYKZL36A7/rfCfSkJl/IdugyPqUDNGkXr4eWnBdxq
	79ekE6c56pcPVKIiIOZtIbofOb7eHbYB4347XVUibKFA3wWbpmPJL65R34yS0YFY0cXs3d9jZxg
	0P5E6MLrFRcmAO4XV8alDskpDPWypw2zhMhtAaa8uPSu3zAP+jhs2I22fpLzfy9dYjPmGj7dJHJ
	wjbPH0DcSAiS0xGlHSl
X-Received: by 2002:a05:6820:168e:b0:6f4:87df:79b1 with SMTP id 006d021491bc7-7035598d0bbmr2189498eaf.21.1792273563140;
        Sat, 17 Oct 2026 14:46:03 -0700 (PDT)
Received: from [172.17.0.2] ([172.169.254.169])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-7018fd92933sm4955165eaf.9.2026.10.17.14.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 14:46:02 -0700 (PDT)
Message-ID: <6ad3ec9a.00622f29.22d26.4dfb@mx.google.com>
Date: Sat, 17 Oct 2026 14:46:02 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5940350233847460899=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,vRFC,1/7] monitor: Add audio quality statistics for ISO streams
In-Reply-To: <20261002192759.3071262-1-luiz.dentz@gmail.com>
References: <20261002192759.3071262-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5940350233847460899==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

This series was picked up by the CI more than 2 weeks ago and the pull
request created for it is still open, which means the series was never
applied to the tree.

   Series:       [BlueZ,vRFC,1/7] monitor: Add audio quality statistics for ISO streams
   Pull Request: https://github.com/bluez/bluez/pull/2623
   Created:      2026-10-02 21:01:59+00:00

The pull request has been closed and no further action is taken on this
series.

If the change should still be considered, it must be resent to the Linux
Bluetooth mailing list (linux-bluetooth@vger.kernel.org) so that it is
picked up again.

---
Regards,
Linux Bluetooth

--===============5940350233847460899==--
