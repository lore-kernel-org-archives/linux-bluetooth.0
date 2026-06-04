Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E8038D3E3
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jun 2026 12:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780574820; cv=none; b=KYQWuqkpW93XCvecn36oqajy4D1h7F1AwOiuvbmgjNMMG5WpZDX9kIOC3Frhmt7IuZUa4oKfT1pVwTxmi6RrcBD8yNyKURKu9dIzN7HunyArjnvmWbjz8RhCSUh+VYEPKZesgCmXH2Js4ooKyg9AZ0y+uMzsNJB7kLcVXKE64Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780574820; c=relaxed/simple;
	bh=cekHG8EkppehritCzrLbDq5zOsI9BjORlfchwDPc9hU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=jG017d9qUQcCZg327F6ZbunsAUgy3pE1ev4xjfv9vC3twqU0yN0iLWsobUBvs680O03ed9fVpAVKCigyGBRK+l+ZvcZXtrLXXkUJJvRjzZsy5WjPv0sX2sgRQ5Bmp2o7fBU/v9+d7zXNB0cOn83ca+3NNUGY3b9+WAuroUKdkgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TVgqksxr; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TVgqksxr"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-3045c195251so485849eec.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 04 Jun 2026 05:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780574819; x=1781179619; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+Hich5kTwZGUmQnoOjGS68npVvsa06XAAMPENm5iH/Y=;
        b=TVgqksxr8Vw9uj7SycXQtdEh5EXiKuO5HZBN4eUCRwMpCPN3wo0vK5cjLbTlCNBh2q
         Ho3rcTs05hHxasq0m457yJB0IIgBSagoEVPyPrWVva//mds0OIpdP92FQjLF6faXSUM5
         vW3Oj9ipOEAJ2eOi8Jxr4sftZW/15/TG/ry433YknLg/7E4pMZjW4zkmZ+2Ux77W4/YD
         PLIJxKeVH4wCdzY2eh3aH5aP/5+Cr37F0n78Avrz23hDtsycbbeqmzsKEDBscMHQdDCj
         53Xf8v7hQnaustdqzhujNy8htEOlg9isKw4DeYKBgxfN/gWK2psq1B/z1816vSWkyOK9
         6Z5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780574819; x=1781179619;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Hich5kTwZGUmQnoOjGS68npVvsa06XAAMPENm5iH/Y=;
        b=chignWy4oeZZrzWj+XATVhJo3AzoMz3zsSxnZ5gI4skIdSVcmvsE4tuW0Q+X5MFX65
         PIY5OSICxdzBhF/QZsZ05taw+LBCA6cuBICw75dt/ByTZq2FUBNiClXLr/PzFpQsVpzz
         T85mlIH8tVb7TPyLP6Lut2+LmZ/GrzYC48W8l08NdcNwCa2TpMIC2FAVeJk1woyZTx+L
         x08xQImjTsj1fnYXqt0x3I/IMqBykp5qWlyyNJS1aMKROTsZfghDavm5pbFcbUC+I9g4
         ByTPvfoRH6n18xTtOIVwMiURCeLqcNEAwo6I2a3/EC86FiOdwCzNR9jcwIrhKvYD7h1E
         Shkg==
X-Gm-Message-State: AOJu0YyEoRgW6yY5bbs+n2ef5OBSx0BPt7xE5FPZ+vc7K7NPuXt5krCA
	vuqIideZe2dx6hv9nV5AmLph1Os7JiBXBgdKHnuGDPZ7qbEr3/zI1Rw75JtyTQ==
X-Gm-Gg: Acq92OE43psVy49OPd9i9DSTSQMwXyVS23DzqFAWvgg+iqqEJrJzicw1ewsCp+3pWeA
	sZABw9bI+onUlEddCL0i6P0qDGRPKHJppgKaEQdGFmERCJsrxR1EvvpdoPKR1vdbNFRLqxFIxqw
	HiRzjflG/645DPEJcXoZ3562IR3j4Ll1SNXpdx2CGxXyERY33yXT2SB0x7ulUinbOcmPjlsBDDJ
	439xOkSLI81PJ+62fbALCOTBUOjqx2zRY7qerZ+dToRvwKrwrj2jB3EStwrurAzevkumbFOdf+j
	SZNoSI+QMfrz6wyHKYBJh5RaOWKQXYemcQ3bJBCiz8EKbWbdCIz4QJls202MTwZVNXJvM21+pkd
	ypz8YM2hMTESkqBsWhzQnvujNLvLtkAiJbHdwLvyFa294yn404IXtteHK9hSGwaype96EOBioRI
	gL5ubjkTUZtsznYl9LYc36cSlP2OFvxLLnlq5hVWmi
X-Received: by 2002:a05:7300:e8a4:b0:304:b14:ec53 with SMTP id 5a478bee46e88-3074fbd4634mr3620217eec.27.1780574818626;
        Thu, 04 Jun 2026 05:06:58 -0700 (PDT)
Received: from [172.17.0.2] ([20.57.206.154])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074dea8e76sm4806330eec.18.2026.06.04.05.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 05:06:58 -0700 (PDT)
Message-ID: <6a216a62.d68db960.2a81fb.6947@mx.google.com>
Date: Thu, 04 Jun 2026 05:06:58 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6942832029936721184=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, prathibha.madugonde@oss.qualcomm.com
Subject: RE: [BlueZ] shared/rap: Add client ranging registration and notification parsing
In-Reply-To: <20260604085205.4135084-1-prathm@qti.qualcomm.com>
References: <20260604085205.4135084-1-prathm@qti.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6942832029936721184==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1105806

---Test result---

Test Summary:
CheckPatch                    PASS      0.67 seconds
GitLint                       PASS      0.19 seconds
BuildEll                      PASS      16.38 seconds
BluezMake                     PASS      497.78 seconds
MakeCheck                     PASS      0.76 seconds
MakeDistcheck                 PASS      184.57 seconds
CheckValgrind                 PASS      157.05 seconds
CheckSmatch                   PASS      250.35 seconds
bluezmakeextell               PASS      128.31 seconds
IncrementalBuild              PASS      502.61 seconds
ScanBuild                     PASS      727.00 seconds



https://github.com/bluez/bluez/pull/2175

---
Regards,
Linux Bluetooth


--===============6942832029936721184==--
