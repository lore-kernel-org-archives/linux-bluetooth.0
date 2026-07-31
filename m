Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3196147DD43
	for <linux-bluetooth@vger.kernel.org>; Fri, 31 Jul 2026 18:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785523969; cv=none; b=tNJA7cBsxf5pS3lNGCW0h0Fef/Xequ73Dvm6QRnejbh4g2G+glMBK35mdv2qcKxBzHbjfbRxR2Hb9pM7fhJfVfC7o7WVWJ0ds0gFVjEP9iPtlHfPXuX0IKpo2/RxNt/VTYiKxhGnFjKVV4oSD+1Y3fgzYJCp4zggXMi6ANXHndo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785523969; c=relaxed/simple;
	bh=2l13kwnHyuQmPvLqxp+PkGG3DysjEhzCki/OcbFBYzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z/mDDyY8BV4+rFh8lse1K1zbSfkJtq0+ud6BrzvMxAq2iTdCEnrIBz1vD/+8gzs41KvMdKjtJJf1LVCkWPDlRFBUkLJKFMjXS20QMVQ0UkD4UANCRwisikOJlHaChtYUQISJzJp0jCg+42L9wrzu0Tpzjl0E8qyBPtV3rpYCqyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lPK6flq6; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lPK6flq6"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cbb85186d43so667291a12.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 31 Jul 2026 11:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785523965; x=1786128765; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EdUk/9fNoAPKGyul4Lsecqk1JfbtoXZPx1UcmlbESJc=;
        b=lPK6flq6sbu8DP6U4WdEEnggUhxNkHwDl+oNIqVFOTJBMMOVgXpeTDobz9y3xR+2Jr
         BB2LefqlosrIcP5/Qaw/Jtc42yCcuZq8qlxchNk3Fn3Sjpn/6ezA13jXY8LSxQitkocv
         zziF7XX9Uxqjbg2mAg+dNMBETfXvYV+5q0Y0ayMZffrgCxj3eFGkTjB7SrpZPJ1Std4C
         LMbtW/q7ToDEf3NE1hTyzwqwdzMR8MKLkdShtWi63uTVzlD4oG4RlHhaHuqdv/aHmTZz
         TtDDhbGWGCXbeNp26yXTzU7cn3Lo+9eLbBauauCE3faM3NlZFvI23iT6nqu4q+zqfrBF
         mkMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785523965; x=1786128765;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EdUk/9fNoAPKGyul4Lsecqk1JfbtoXZPx1UcmlbESJc=;
        b=WmEHGumwkkPMAIrPDNsQ6/Ota83ZozrYMGIDwHgzrywvouhzRxJ9urIyzGMiNlRQjS
         Z07y5jjnIMnmH1cX4uehPw51D6gRjTx17sPhZB4E5I4LL8KdZCAVTAfuOHDCGrMBozQx
         2b+Cgv98p1Cwt8D76q8lWz8gfytZabkkRolZLf0KAVP6O48cQpScV5nUqLIIvLjKVa/X
         Q+nzj1XAqCWeeiUurYIuzS8U6CgkTr0aQQZMeS8awd/fGCo0ZrouD1YNUjxPjryEI7vo
         gNSx2+vOtDvYw56f0DsGtAVgoDeUO4Wdkdc4e+WXYTGA58D0PdAuoAtDT0AYa6bLQqv4
         hM/w==
X-Forwarded-Encrypted: i=1; AHgh+Rqvi2rlAHrOFzy4vMA7eSVU+kaYuujaJtUaX9H/jk+uzmjKiyRcUOghTPQn+kuj9rkxnUNYuAnrnV5REry2cQg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeyAqRjwiB5mwF0/nIBu7fatQKcbaEK8WuuRbFBaoZuN0Cxnrt
	omKTza68bTiqMmhiWIHH0OIv+QAp5z7TVtSayC7KOc5VJlT7j/KRhWk9
X-Gm-Gg: AR+sD13pKhoVeql0BHKNeIyUubK3Djm3A/d23O4mBM7PkE1CTN0lCVcVmz7dqsAjeCg
	BGu1KSSs41zwlWIC0ctnnWftLQ+bQyjoWlkz/ygZHI8iNeIVR7mR+fzWkKYQbQFiOaw3ks8NGFV
	z4t4CabmFV2dGQZopWeoWxa5oI2/MKPB8CzVx442J1BCO333ZlVM8GsfVKet1mZFeT53f48amHN
	v43HRUxWcvFpCmmmu86K9zywPR5XxV8vXkIYiCN40fHqEcuWhOzoNPnx02zn5k2Iy+KX2GBIvWo
	Rybq/avHxquLO9/nU2NAnq6NSn0770sm0go2xQs1bTBLVc/dAriULIEXykrU5+CnQjUIBFzURH/
	HcYtZ/mpIqWfwuEoqx25yGnPAEZxs0V3aYPhnkcJA7dFH+aQ91F7A4gQgWVfg64WXQM0Ljg+zR4
	vRwF8sJnT630d0Ad28zalZJdHIQJfa828qwNNQmBNDz2hfaiiGluECyQiFvGeLUSIASjFxsFJWf
	6xsTHlPeryA1QCswtuh9XFRqo9XZuLEepo40ZuS3cLoXagq/O6TonqNCSVTrZh+b6oYuprxhFWK
	uqm8VXSaP5anWbMrq0YNu+V1KY+g5A==
X-Received: by 2002:a05:6a21:a38c:b0:3bf:a489:1483 with SMTP id adf61e73a8af0-3c92a7b05b2mr889355637.33.1785523964667;
        Fri, 31 Jul 2026 11:52:44 -0700 (PDT)
Received: from localhost.localdomain ([2405:acc0:1306:9d5b:957e:789b:fa3a:55bf])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fab4fdb80sm4965450c88.15.2026.07.31.11.52.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 31 Jul 2026 11:52:44 -0700 (PDT)
From: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
To: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: btusb: validate QCA rampatch size
Date: Sat,  1 Aug 2026 00:37:38 +0545
Message-ID: <20260731185238.10533-1-acharyalaxman8848@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260730161820.11631-1-acharyalaxman8848@gmail.com>
References: <20260730161820.11631-1-acharyalaxman8848@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Luiz,

I have not yet received confirmation from a Qualcomm engineer.

Shuai, since you recently worked on this QCA rampatch path, could you
please confirm whether requiring the firmware to contain both the complete
device-specific rampatch header and the version structure at ver_offset is
the correct size validation for all entries in qca_devices_table[]?

The proposed minimum is:

	max_t(size_t, info->rampatch_hdr,
	      info->ver_offset + sizeof(struct qca_rampatch_version))

Thanks,
Laxman
