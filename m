Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4048521FF5D
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 Aug 2025 16:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755188703; cv=none; b=darOHR10itfOMcDTO3nPByL03+EkixbdhrAAQC1Ar2lFIV/NfMI/Vwdl/ibxO2HTUzLewGLSrFTn7YxOB0Je1OiOJqVVnfRuRe8hfYy19J7aEqDt5/KMb0c+MttB232iAfB1HwatDsHGIWSl2H3GDG7qUsbipqxOJD6e+S7G4mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755188703; c=relaxed/simple;
	bh=MT8xvdaIY20Ms2DT+vDRxtXsp45mTeF9YoY1VyjLb6k=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mUVtEaiXayovl9a1B9YhoAnTlQ/Etjkq5pBKSsxUoj7egYNiKPz8NIo83+i3ULS1ZeIGVpfG5gveMGeh6bH4O3OqZC3s99uby5OFPn5tRS4X8se7a2luE4Avn+1tJGLeezrE7vptfTRSRfNepZ7uaLOUQFIHo9nmClf4xpORtb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mmCjzyHX; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mmCjzyHX"
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-89018fd51a1so668891241.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Aug 2025 09:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755188700; x=1755793500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FNVUNG0anKLL9MaNJxCOyBzxn64Jsy4pBR+ZvgcnMGg=;
        b=mmCjzyHX5psDXK7NCPNv3LD9RhdK+ZOqjw4SJwsgggkYeS1vgeC4L1izpTWgJ7EB5D
         xxHKn1k8VYG9W4qjA0SZ4CSGuiwz32+fG3dAm+yu0f+q+0HOiHYJPiqBLxRjrQIXvv+9
         ImplTwlmF1EP4pJHwV17sEiwyMvm2dpPHgD7dCrYX8yAmBPNRAoztkFen9nEPxhcbHAb
         wIw/6Y44+SheLCQQshWIMNMhPwhkqtC/g5oLrFsClJTtt3uPnqIJi4D5yub3j97Den91
         uqBt7jndoq6OKtOVSnm7fGq3/eeFPX4G9QEolxR+zUvbICjzd4h/fu/9TNRQNgCIEZZ5
         78wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755188700; x=1755793500;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FNVUNG0anKLL9MaNJxCOyBzxn64Jsy4pBR+ZvgcnMGg=;
        b=L9kiBJzRSx8d/j9A9cxeMwID9BLY3mQosbZmrt7uOQBFE7LSMsDBb+x20We0qIaPv4
         lFG5CAuvLpoRrn08hFPOFu4kPcOgaunPsmP1+ChHDZA89ktzDfSI4COTXxCv+PqpiJIf
         fIpC5wI+u1x7iSBVfAY3ZYVmpouMETqnS7lODx7fNyfGPOaxZPF9nBFWfi9YmeEYk9zL
         Og7Iy9NnW6mte0oh7n8dOreaNjBKqx980NuA2++MU13Q3api3e90lK2jnSrgnxn5b87p
         a6Ylb1sRMoiZx3IE28KChw7PAem1gLJ7Mq+dMSW+I0pLyp9RfbZ28netuU8bjhdjavsp
         xO2Q==
X-Gm-Message-State: AOJu0Yz+F8rTs2JfcrFOVaWzbIyvNtcDD4rkCHzFuOTFJDvp+VdBMNt2
	VXfDv1dYHR1yOryMTuwTdOc3wJZERCD/i5a2RfRVljknBNBPg72hv0bRAHTf8mzE
X-Gm-Gg: ASbGnctTFroW1hHxyG4wt7mBTG3L5gkICLCLzAfYRIJXVtFo9M4Y498JROQrJaaxvNV
	PB9t7043IAo3/AvLsMN2EuADpeFdSXyMzT9rUxpmUUSVIrdipsIr21NU6IZHyAKJ08E3FhBdHPg
	S5tnzSs0UFjT9oAGx5v2Aq4eNlDAE076yWG9Jmfiea+2ll7rC5l4OWIEyC4BgZhBd5bjM71z4y+
	GQ3d7RwoXrvLJjSDoJqaKnQAeZY3vlGmGVGi5HX8Ek+nD/VjAScOGTFH9kxst3cC9azKWpWwNZw
	bOAMiYSvw8LIoSlvQQy9VbzGCfXpmDscA08Ez2zIO8DRB45quPZX2dJ2ZnXEyHu3EBgqaFOa0dH
	X6U+6We+4l+fxe4D2e8qgKkKg0hcpv6Xdn3wYXadoFys13p9oJ7pFwnMoZXk6ADn+
X-Google-Smtp-Source: AGHT+IEPAmyOUiG9PzzaBwVxVso6VB7cqt684g7iyZWgSsJExhxqtQaaRDMXEpf1BB1bvwKENcob7w==
X-Received: by 2002:a05:6102:3f9f:b0:4dc:81b7:f031 with SMTP id ada2fe7eead31-50fd311615dmr2024655137.0.1755188700403;
        Thu, 14 Aug 2025 09:25:00 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-88e57924cb0sm969037241.8.2025.08.14.09.24.58
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 09:24:59 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 2/6] Bluetooth: ISO: Don't initiate CIS connections if there are no buffers
Date: Thu, 14 Aug 2025 12:24:44 -0400
Message-ID: <20250814162448.124616-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250814162448.124616-1-luiz.dentz@gmail.com>
References: <20250814162448.124616-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If the controller has no buffers left return -ENOBUFF to indicate that
iso_cnt might be out of sync.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/iso.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 5ce823ca3aaf..ac6e83313b9b 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -458,6 +458,13 @@ static int iso_connect_cis(struct sock *sk)
 		goto unlock;
 	}
 
+	/* Check if there are available buffers for output/TX. */
+	if (iso_pi(sk)->qos.ucast.out.sdu && !hci_iso_count(hdev) &&
+	    (hdev->iso_pkts && !hdev->iso_cnt)) {
+		err = -ENOBUFS;
+		goto unlock;
+	}
+
 	/* Just bind if DEFER_SETUP has been set */
 	if (test_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags)) {
 		hcon = hci_bind_cis(hdev, &iso_pi(sk)->dst,
-- 
2.50.1

