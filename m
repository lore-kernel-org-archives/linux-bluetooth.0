Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0144274666
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 Aug 2025 09:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755595719; cv=none; b=HazDO5tvOiZ74AT9jwr0AViQrxDqllp5hHPzG88MXMyVxE75dDs8YR370zhTLo0/nKsuw9i2SKo/MOSB5QWn95g7Ad6T4RhVL2nbaSfQCf66VtRyL6Lvg7LnB7CTOiWFgaUfFzI6vMDXGWel3tlazfoDA3h96+OQHZ31OEDOPPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755595719; c=relaxed/simple;
	bh=0ekusLztYHXI40R+AZlkfpbGH2v/+YGiuusf1QF+Y9s=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=uSsLTV5vZzT8FJ+n7/O9vAUhE/BoTINFsT+Z52wWOpJLuhnavCjS/C9tdTQo1ELBoDW2Jhmi9JLXFzX4Zr0zHxkn3WXtGwGXoji9VfzB0s8Tf5hqG81IUpfM3Vi/zwS9ZpqYvmLCvHfyZhZRuKl8Wn0IAzUuyCCccBBGknItwEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZV4q4l/Q; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZV4q4l/Q"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7e8706ac44eso764392185a.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Aug 2025 02:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755595716; x=1756200516; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MCmt38OObu01iiA2x+pas5lk3vu/VV4Za2gNI/aTeO8=;
        b=ZV4q4l/Q9qf8m+vFxcXFuavhq8g7ktBlQTETVh48FlmFzH56GmJHOMSEOMin9/NYTh
         aIkKLjaidAQ8Qez0oRIdb4igreT8sRTG6znA/bJLtZ3Bvl1zW2okEyGKb+wbMBs5ACHf
         NHoyuQrknm9QADlw2I7Y6UzNIFVAjRnsGooqpwBDCXI0a8uv7/EbLMEVKdnvKxXEGN0e
         Wzlyhsv7sAVW+8uZkQUpaKbYKZJ1m5N0crJMLz58M1X7CB1c3xWgyeYC4nOWTvKR/Clu
         QeVH8QkkscNxxxLNBM2aBEYdXMdYddabZUNEOzRi8qWhbHsGhQvZwSyfEsJDdYY+bub6
         eOpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755595716; x=1756200516;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MCmt38OObu01iiA2x+pas5lk3vu/VV4Za2gNI/aTeO8=;
        b=ChsiXcXFUN8L8ob2RS3cUdXrrJAUzMfcfzsftnZQbVMenMAN3iDeoCmtEZDn56ATk2
         fc2atWE4BYDA0P5jYNaB2chABYTKYiEqil8pY6MDXHJzQzzq/TXPERrnrra/XXa0DkZe
         E9tFra1vR+2+JSwmUyPBMVgOx+B4qEdqLzKppoXIZDuzXL3xViZerytRgyYo0voAVS8V
         tJfsqokXJtVQHhsPeqybV7IHH7Ya5QjFRw58uW4I67D3klQi3HeHhhMvhdsfv7jo5h5M
         bYUesVtY9+5OtKvND9mkvgvsCbWzl0OdYvOqWickfzdayO85k9UpJMDeeCdF/U92FoPt
         2P0Q==
X-Gm-Message-State: AOJu0YzdIreCS5rXguyhVFr0YOkPS7ZLAi0Nw0Jxpf3J18ZS7ByHm750
	5xWe/UrPu3RVMe0LmgzfGtJpw1kG7/IqCdCWeQCJRwse4L9up9itF19IPDXhSA==
X-Gm-Gg: ASbGncvjmjF1scSyzIgRJNpsNqcGzNOhWlKomGH+ygngmLMABba5thlN3m+xpdmKAVT
	ppsTbWah4OmKNbYJKRcZd2OvP5OaETsgeG8A4dLAJ7X9rdh2876eXWHA0t+2k2UPnvu7NQoYzxq
	91wzfycI8nsKZE3ript2Sd1WvI+N/O8hhgJOp29S/uVHQSVjJLhFLLd5H3t8csCSORjmzXASmsI
	VPlFxF0Q+zwHQKeB9ZdlR4uf1DvAL+BVi8n5ojGho/AeL9fyKqHNQiPygalfOnb3htathQW30gG
	91b56zlw4uYbUinrODSF0JB94WBexBPJFfkj0GpAK+uGgNqnroswBhvCQMdiro7SkWkecFw9vz4
	8R5dl6nHhTA2VeSriV09khzt9QVvXXSBaavqUkfQ=
X-Google-Smtp-Source: AGHT+IGq40f2rG5qMuTtsWjDwNuNy0thjrbjk8wzNp851nyhBsIxoPNwnqibk6RXjCHLGMc8sXU8Xg==
X-Received: by 2002:a05:620a:4804:b0:7e9:f81f:ce8e with SMTP id af79cd13be357-7e9f81fd3c5mr48594685a.80.1755595716245;
        Tue, 19 Aug 2025 02:28:36 -0700 (PDT)
Received: from [172.17.0.2] ([172.174.165.6])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e9ed158f39sm233091885a.15.2025.08.19.02.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 02:28:35 -0700 (PDT)
Message-ID: <68a443c3.050a0220.14154f.b3ee@mx.google.com>
Date: Tue, 19 Aug 2025 02:28:35 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4570530821430605812=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ye.he@amlogic.com
Subject: RE: [bluez] bap: Fix setup double free with bis sink
In-Reply-To: <20250819-bap-setup-double-free-v1-1-a7c64be0d807@amlogic.com>
References: <20250819-bap-setup-double-free-v1-1-a7c64be0d807@amlogic.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4570530821430605812==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=992906

---Test result---

Test Summary:
CheckPatch                    PENDING   0.26 seconds
GitLint                       PENDING   0.27 seconds
BuildEll                      PASS      19.91 seconds
BluezMake                     PASS      2683.26 seconds
MakeCheck                     PASS      20.54 seconds
MakeDistcheck                 PASS      182.13 seconds
CheckValgrind                 PASS      233.10 seconds
CheckSmatch                   PASS      304.97 seconds
bluezmakeextell               PASS      127.21 seconds
IncrementalBuild              PENDING   0.37 seconds
ScanBuild                     PASS      904.12 seconds

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


--===============4570530821430605812==--
