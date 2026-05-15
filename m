Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461CD3FF1A3
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 May 2026 15:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778860013; cv=none; b=kFvWD7r5/+iJfZufueL5zSYU5u9N7UVfsJLP6HBghhwecftNFtporaF+5My7MGAQEu+yPdATka6RU3ryQ0R7rFCkoqQ8ueZvtAFk+z7vOMMCaJQI8/tojk1eNDu5PoF0W/m7CVOmu4KPO3JAF1pQcI/eO49FJRJL9gbU6yFAY1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778860013; c=relaxed/simple;
	bh=wTnyL0vMmhiAuk413OxJDXQ2zy59+1d2Gh43dttSjZI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=IprCnsEi+SY/9z07PQ3rCbi3aD7f6vBqQb8i/npbjDrEtMsFbh8JqWGv0L546tUP9wBTydaIb9Sk0J1S7iOimBFHt2LF8+X2Zgy/rA90eJudsHfACcJYqs2Njc5ISBy0X01kbaT/Vj73OMAlN3cB7VBcf5L3+8GL03Au5aH8Xb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U2M67D91; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U2M67D91"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1329507c387so9106975c88.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 May 2026 08:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778860011; x=1779464811; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QTztv2Sv1z0w9fMAfvR/Divne9JfVnGcJEqitkbvLsQ=;
        b=U2M67D91OqoQZ+pzbi2x/CX8uPislbwIQfONhZk5l0XTn9g4p7bWxGP7yQ3uPVD3aQ
         TKwA/wLPtQGz6rFMehW5g07K/f3F6THMiOKsq9uQTHxuLrYo3UBYOE+VDkj7qopbEVNw
         HFdCkN9uBCSVvcZVyqe6btFdZIluY67ljsmEkHVDss6gZL8tjRDbQkB/Q3bOcppJc6lI
         G1bkvaOJwHs4uIOYWk99T/8EQwzbep9RukuOj57J5MuHzgC/dKl6+UaQ96S/HFsopVjm
         NFW96AhRxvHLxvwah7ixzu79b1CR2MUG9x9enOLMDVMT8kqE1vNlpjtXfHXhq5dSmWrn
         wyig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778860011; x=1779464811;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QTztv2Sv1z0w9fMAfvR/Divne9JfVnGcJEqitkbvLsQ=;
        b=B/F58eiNZVmiwAK9iGd45WcI8fbnq2U8yLH8W95XgYgeNWhCoHWM7spSF8754AAjEZ
         2QpQtXLCfvI+1Md1nvre2rF3o7OouF14BfLYESJ/OYt+R1yYmaKR/RyEUO+dWmjaB+pR
         G2SLMCkYHUL/SiQauML7VeIERJlHjfNsPrWD1K6k86mfBsfRjFjgt3adnJk2gBJpUlMk
         6+hwdgVUAKtPOkPSH0wKxuWGPOnzfY/oSRLQZ2vFisoRXoMlMPR9w5DIz/65l7yZFvcU
         sbzQSCtW76C/07mDdF71UvejtWY7biBt0uhyH/iJLyFk6BzfwOQmjqRK8HQont2kA5vD
         R7/A==
X-Gm-Message-State: AOJu0YzVUnv1cV9QTp9sSK/iqmKH9vC+tvZa1wjKPDnTluIkJR24Xh97
	EexJlLTT+czEfGukkDCXdC+/oUs4Z6uhO8+gRelk7yi5oCe/UuxlwIa4QqgUwQ==
X-Gm-Gg: Acq92OG+d8yeyQ4esWQ30Cx9gKZHTGL14TVg8AcafJ0BlaCLuqxwsU/iw3+c3gttBQX
	FbW8yx5HGlRznKLaVDM3Nrd2sfHi80IlHDlrCFSdnPNAz8mxcqIyf4MShKTXYhzhpp7u7ls+IZm
	q9XajR/2clZrIx/BXuY0Y1OIr+SyLlQzLzFXuRL3Wl1jnJHaN/nX9YJ3dNIbG/DsOmrf3B7j0zb
	norb7gVRErWiPBEUh2KEsFdQer8/NP5eWBjPvZPl+GcyBtreV7gIoqa3X+9tLwI1SNrLCX2ezrT
	GNKg7btLFg+ncxnlXrAOC1b64E0L78vF1esx5zGaCFkWevvjqK1eoTReYTH7yldaSj0MIaEix2g
	0NuuyqKTpKVXx7ejf5lX6ICVwuUoPnASQQSzURHeKt9GgU19cjCDGucdbT9uO+7Qff702KGIBFV
	TYFjVv4bFrp5O/gGt5ynPihdeSCCW11is=
X-Received: by 2002:a05:7022:699b:b0:132:d182:3dd6 with SMTP id a92af1059eb24-13504515a28mr2309949c88.16.1778860010919;
        Fri, 15 May 2026 08:46:50 -0700 (PDT)
Received: from [172.17.0.2] ([20.168.110.182])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cc2351d9sm10721363c88.9.2026.05.15.08.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 08:46:50 -0700 (PDT)
Message-ID: <6a073fea.c37665c9.44de2.a175@mx.google.com>
Date: Fri, 15 May 2026 08:46:50 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0249728170689907785=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, michael.bommarito@gmail.com
Subject: RE: Bluetooth: MGMT: validate Add Extended Advertising Data length
In-Reply-To: <20260515143819.1157807-1-michael.bommarito@gmail.com>
References: <20260515143819.1157807-1-michael.bommarito@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0249728170689907785==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1095484

---Test result---

Test Summary:
CheckPatch                    PASS      0.53 seconds
GitLint                       PASS      0.22 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      24.24 seconds
CheckAllWarning               PASS      26.60 seconds
CheckSparse                   PASS      25.46 seconds
BuildKernel32                 PASS      23.27 seconds
TestRunnerSetup               PASS      519.32 seconds
TestRunner_mgmt-tester        PASS      2022.40 seconds
TestRunner_mesh-tester        PASS      59.05 seconds
IncrementalBuild              PASS      22.61 seconds



https://github.com/bluez/bluetooth-next/pull/197

---
Regards,
Linux Bluetooth


--===============0249728170689907785==--
