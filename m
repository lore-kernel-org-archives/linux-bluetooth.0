Received: from mail-ot1-f65.google.com (mail-ot1-f65.google.com [209.85.210.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6756C4A02
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Dec 2025 14:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766501245; cv=none; b=UOiPbNWw2ZTX/U5IBzcmaxj/dihJaOIKE6+WWyk/5iivaM5sEj1M780eSqMD1Mz06e0TkyXRfSAlPeWyCXHwVQffST+zOn9MEB/hiCN+lnaysKypHqSD4U17IAg+OnAvpCNCQ+0c2OVmDqz6ItsofYrdNBiGAtXqWlV8n9iksTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766501245; c=relaxed/simple;
	bh=uFCCACWDZVgE6mHJslCqNJ+xiY5NDGRS4z28wnVj1mU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=uQn628UmSuFy7uNv9fU/f7xKQ/R8D1j6/PaY/ddLrdQLsRZjyPDcTMosctKbFPjI0fjH6d9sPuIoKAjO487B6VdaPlzcrS1mzQv7Ln1FfPuRdUTBgQk/i+Gz8JgaxEBbvV91CbPiqe9LDUYDYLZ52Gw0IMzBu3Ir0PsRZMZn1Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pg0u+QFQ; arc=none smtp.client-ip=209.85.210.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pg0u+QFQ"
Received: by mail-ot1-f65.google.com with SMTP id 46e09a7af769-7c77fc7c11bso5370278a34.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Dec 2025 06:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766501243; x=1767106043; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4bKMWdpWuhiO4AxvS5WqlRPSMFDq8bmmKZf0PsREmEU=;
        b=Pg0u+QFQhZy5Uqwwah4+rcjX0JwZgIPhrHyHN12Ojkn4QGYdQ1IbjseWKSqYxKpRvD
         FbnmbnThCGyKM+FCXFb1eFJ0rXlIr/o09JQBCE5mPXR5qSXY4mEJthbKSUlujGkjZwl4
         coSA7suSG0ictBgCXhZTBrMFF0TAK/ZO5Zi921d3Y2eNjOuTBBZXSo8DZgD6KmBNbyEc
         9nUaLM6BmWitNAfov/7t+W0Cx70Z8mNltDh9nVPRmPSAD+Ue/SZh1UTKqpQGpxNiZqsM
         KBNYxC35utycdbIqLOLi7Ay0s2nQOhMB9qO9XKtbn6iOsgkAty6omYbSU9xypXFFbzhJ
         d3Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766501243; x=1767106043;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4bKMWdpWuhiO4AxvS5WqlRPSMFDq8bmmKZf0PsREmEU=;
        b=i/qWS4vKIh4tgkPM89YMI4Bnvd2anHhsDQCVSxbWKsrFmPeAFj8puKANiZcnPR4y6o
         5NWFZkC27JuN82fU4vO6Q/C0v1+C1eL10gXL3hjWReHsRgbq3EQj4WswUyearO+X8fm2
         AEmvjpD6VLcDkqzJSbBVUyZO4k5QBs8GAVXwqDmRS61xE+ES4xY9bRKpQ3uWt+vhkhQc
         2RVKNJXclNt8PDQrVK7rUtrp/HKVGJsAD91dMCyeFolg7POazWqy7M+0KSuunm6p7wEN
         RDnvp23cXZ4yALRTs5nKg5ELDDEirWX5Z0TUeY/4PrOkXxoXuWGkPDhPyOckeESDu+JX
         9bqw==
X-Gm-Message-State: AOJu0YwFl6fMANTTr9nhvtve2EHAXRmJrFmMNuLiGjM61++8kC9cdAlt
	6H9Esnq1/ZG3yTRwDnIBl+XeFvEqei+5/Wi32RBZxAZWfFdOWLzugweVAf9zmyig
X-Gm-Gg: AY/fxX5U7vprhRZNNCp/Oj2HldXN5rhauugy4eu+trJj9ZMFtaxgNVIB2DIva2rNofJ
	akGphXeuMBz/Py7RKbkmO5OsAudEgGAehd6RRNGi5WE8PNNPVERx7cxDKKA6CuiI9leCy1tbkPV
	0o58zxYoUkzZa7U+8e8EoR67ObQjYeLA3LE4vWb55TkeCkO4b38S87itOXQtovGpj0vnilUHTLo
	PH45xf7l2v/B+90hTkTuPPwsUFvJMn28VzKK8Pw7sMB2YjLWbHXF1o5BKvleWJdOal+yjhXSy9C
	DNwUMU7nfU56dlSLx+SdJXE11wL7wlJ/gTPfVMS3BDO8jn4MLEHzah1GNSaPUxTqG5UOSjJAdpe
	f1JCRb7koQVTaonL2dUUP2W1gNYoWNCM2IxQPVKIuOWlcOVtqABTAOqSx8DjKeYuWwXVbF0lbdt
	vyYAnHfNtF3zIzEwp3eSU=
X-Google-Smtp-Source: AGHT+IFJ6myf4dHJ5eU5x2f7zMZ8gHy508yGWO1zlYyQsYeQbybxEElHL/btRHL/fEid6oBcuioRiw==
X-Received: by 2002:a05:6830:2a8b:b0:7c7:60d8:9d7c with SMTP id 46e09a7af769-7cc65e8f3d3mr8685278a34.16.1766501242955;
        Tue, 23 Dec 2025 06:47:22 -0800 (PST)
Received: from [172.17.0.2] ([172.212.163.226])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cc667284fdsm9525002a34.2.2025.12.23.06.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 06:47:22 -0800 (PST)
Message-ID: <694aab7a.050a0220.3405e4.3063@mx.google.com>
Date: Tue, 23 Dec 2025 06:47:22 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1620532590951217931=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, sarveshwar.bajaj@nxp.com
Subject: RE: Fix heap-use-after-free in setup_free()
In-Reply-To: <20251223135134.706-2-sarveshwar.bajaj@nxp.com>
References: <20251223135134.706-2-sarveshwar.bajaj@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1620532590951217931==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1036073

---Test result---

Test Summary:
CheckPatch                    PENDING   0.32 seconds
GitLint                       PENDING   0.32 seconds
BuildEll                      PASS      20.30 seconds
BluezMake                     PASS      647.14 seconds
MakeCheck                     PASS      22.21 seconds
MakeDistcheck                 PASS      246.80 seconds
CheckValgrind                 PASS      304.05 seconds
CheckSmatch                   PASS      353.96 seconds
bluezmakeextell               PASS      183.80 seconds
IncrementalBuild              PENDING   0.26 seconds
ScanBuild                     PASS      1055.46 seconds

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


--===============1620532590951217931==--
