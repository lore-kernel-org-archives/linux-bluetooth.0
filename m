Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E33173347
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Jul 2024 10:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720003479; cv=none; b=hKlJsi+pqOZXk7zGg/Rom50+KC+DYYZOyQa7jSDBzk9zwY9gzKDv46agBsFTG34w6G6w+hgQSuEuTj4ax3VExyrU6IP+qwjEy0wjyKBxfkVdgg3qpfqWDqUYsjoD2L09+SHd4wJ8cr+SGDTQLHXg7mzEEDAEqnCNYl5e6M06cAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720003479; c=relaxed/simple;
	bh=q+l7k+mxu6rO9qBVtON/p2zSC9er1jyR1NsRLA1weiM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=qgVhRRTL8h3DikZO9x0zpVm8Ki20V3GvrlMRfN3B/RRaaagagNaE0DNhefjeFS6xiC32C28ZZZZtxmLPYWOwOZgzzjMY8b/Lla35tn16UI0OjAllLWtW88/QjuTSH1gYv2La92A4kqoLgX/n/IOgp0Aa5+s5yONXtw4qqjAM5Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ff1aeRNp; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ff1aeRNp"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-44651f094adso23749941cf.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Jul 2024 03:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720003477; x=1720608277; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YvvoxJI9iuXjjssdKy9grkWHuMNiB6wCwLB7lGtRXRo=;
        b=Ff1aeRNpxKWiGVhCX9i0IIa1AFCVc9vH1m2/7no+uvY+NEAIy7QnzP1A4UFjge/mHP
         FjkwxnYBXf6rM1efci/w3jrVSAUERFw9BCR2oDc4sCB2B8hG7JqW7ZoONGTnsi4YKuBV
         H3VzbuFCi1VwYwHlNy7D6gtWJXe4LydCT0C9/SzkbUwg/wFJ2KeXjvfA+Dgw6RfvD/SO
         e/Hs6lxvlJC9/bU6Dpx1o07I7gmYMK1Vatlc0XoSK3BD+3SpBF9Fe1e+wg5DXiJDXzQR
         WG6Gx29feLQSf2REykfWtnL8yOj4zACmzE07dNNhQexPiEhgqra6aTddiaUw2A9fQIDW
         XKLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720003477; x=1720608277;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YvvoxJI9iuXjjssdKy9grkWHuMNiB6wCwLB7lGtRXRo=;
        b=u1ZFaR2Lq5JavmF+mke2hgGKn9VjPTIU1Vh3uwH0BK/UOMx+hDN3bVAdX6QHoXKS0n
         XJ40EPP4W6Ig/A3Wems46rl5ZSbj+ojaFDCj9bNvDbFzMCVEdneCWeww15Sx8tLQ2pPv
         fxgexCmkbvBvgmzxszcVIWyLBVDaOvljEtMEi1W514hc5iLzjlceOGkDGFxknY+pBmZB
         sDUuHxV7RH9iYGnUy89qFkvfwOzvzTeIEaqJ+cVDqbyFbFqygG8ht9sJUXOcyJGEFbNV
         49Xl/4qIRyB7ois6vcWcHYyST3YvjJTYGRHA/Q+bW9+K/bMXfhGSbpgbcoc5R59C6sYW
         Nnqw==
X-Gm-Message-State: AOJu0YxOPfe8ZdUHHC+hN7uBppzb/h03g14xDq9mm70uj1hylKb4NG8G
	3RNDUnam7qT9/jOTeaqY74g/izdwfyO2xfz+c+FqAAoIbxGiVFZKHELptA==
X-Google-Smtp-Source: AGHT+IEOnHI9li6O9fKylTrR7SyxiBTwHGs3m97GZiD2Wo7Koe/M6TSYZIhV/2hP6W8badU8e3qepQ==
X-Received: by 2002:a05:622a:15c4:b0:440:ec00:fff6 with SMTP id d75a77b69052e-44662e5a323mr150193171cf.41.1720003477161;
        Wed, 03 Jul 2024 03:44:37 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.154.98])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-446513d3601sm49059061cf.17.2024.07.03.03.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 03:44:36 -0700 (PDT)
Message-ID: <66852b94.c80a0220.859f9.3d2a@mx.google.com>
Date: Wed, 03 Jul 2024 03:44:36 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7636039406028994207=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_prathm@quicinc.com
Subject: RE: [BlueZ] Set BREDR not supported bit in AD Flag when discoverable is off
In-Reply-To: <20240703090549.6702-1-quic_prathm@quicinc.com>
References: <20240703090549.6702-1-quic_prathm@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7636039406028994207==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=867894

---Test result---

Test Summary:
CheckPatch                    PASS      1.54 seconds
GitLint                       PASS      0.35 seconds
BuildEll                      PASS      24.81 seconds
BluezMake                     PASS      1719.44 seconds
MakeCheck                     PASS      13.50 seconds
MakeDistcheck                 PASS      180.56 seconds
CheckValgrind                 PASS      256.32 seconds
CheckSmatch                   PASS      365.05 seconds
bluezmakeextell               PASS      124.99 seconds
IncrementalBuild              PASS      1564.80 seconds
ScanBuild                     PASS      1030.41 seconds



---
Regards,
Linux Bluetooth


--===============7636039406028994207==--
