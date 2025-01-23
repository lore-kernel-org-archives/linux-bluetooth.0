Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF7F1C5F26
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jan 2025 22:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737670032; cv=none; b=jC7ZbTb9jvtRzgX0gol7g43rR8HiLL9ScncFw3JEfubXsGPCOWj/pcTZ1JrfPXIikWDvS4Er3y+ocbAIhDyeSRNALWllNRGL3m8jg00Bbm77Mv/Fj6EZYTYL0CJ0V2JeUcJ9zvBg0R0KXLQrgahcXZVXKRTppJgplh3iWnhrPq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737670032; c=relaxed/simple;
	bh=mLN8bBkzbh+PaplZzhlq67hg6xx9a4bvj+AFCy30V/E=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=bysbtlYUcr6VeYj56DUyCvsPj1QHa/81NFcscAJ4RT+sCozTFGRzYYB4C2sKcYBodcpySEiDX2iFcHFPeV5AFGxrtZs+FhP57UhDVCloQpzSXDcAwxTGMv4EluCKZJqluk3+jELhlOUJ02mF5GKDR10L1TnVMj6qc+SEEiRWDo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mZWVpAET; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mZWVpAET"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-218c8aca5f1so33181185ad.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jan 2025 14:07:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737670030; x=1738274830; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bE+OPA2FHa3VB732guH85WTrlOJ7CKqqQcC9g7O6K0M=;
        b=mZWVpAET12VAqgyA6Wv35gQMdndZcAs30Da7/mNcy5vRoCM0QEO3vI5/twHDsNtn9x
         12xkz68ULoDJ8Obv77Se/gY8VgscpfLy/jQ+3F4NqaMWhe3MffjrZzq60Mhy4dYIYK7y
         /i15QzB55tA2w2dmsjHGn9ODTEsZntgvQaCKyDlvRCtF4myDEo0W7+g0Gm0oWQV43Ea1
         TpvCmVtAiy2zMH/MZxqWQlrt8Islnd5G/D3+PRY5YeBtHV2pTJfWAb71GPbEl4VDZn+u
         gK1l4N2TmkKaptNl6u/J+Oojsf08c1AOLt3lq3p5EvOjPFeKXFUVH1RBfwAo0PMFe/vt
         +04w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737670030; x=1738274830;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bE+OPA2FHa3VB732guH85WTrlOJ7CKqqQcC9g7O6K0M=;
        b=INh8pTcPD1TzBxXTCR+OffBBZi+nO0SPiO1uwi2VGucdQRV8fVKk41lXv1V9ZXqNL3
         xhftUGGONui2StPTh2QbpWRE3gj+vkR4uOTNScK4z5mKbUmZ/ySra8eH2TsU1LW4oc6j
         31WpLpDn6qBRC8mdo9ZyiAcqa3Be4/BoMmSWATOhPJj55wHhHDxmAOvAnnx8ZQzhXqTS
         n0J4bklxNNLUbe+kUrYTfELRek9TUl4i9JZsSYUdHTm7p/sAPXGR2Dst4jOLh7yn7/lz
         pSf/JjP1hWaQ00FNmTT9L9seG6RTtuwsG2hU4U0Q8pMpw3AGo+ZOefhUItnCDXXsCqXW
         Unew==
X-Gm-Message-State: AOJu0YzTdcWAd/1jo4u2EaGCFBbfeDCzbgFTpn/Letu7js5olmJLlwZp
	PKwmK3naJX+OzblhEHG4L0MCoYRf6ShmF4kncycxWkJ7tL/60fWoDjyb1g==
X-Gm-Gg: ASbGncuS1iWI+y8IsV54So76wmX3tRFsgFgYLJb0B8SVxLyRyXwnXm0cseJBWz+vfNk
	kubcqWtVZiUMB0X3JUDpNZc8Rp5XAUZZydYoXx+zfzFGr9/irKc2t2tGwaKptXz7zReCMc33Bl2
	cq/dNNB+Vc1g+1xbJIeuWAwPLaEEe4jZwbm090J4lGBihW+RoGWjz6VFLsEVSMfich24hQWvq5Y
	jyk0KvhT4Df8adpNJEbJCWBlW6KJg+tooOX16MQ8OCoqdSA6xLhYj16ZXwDPCX3ytyNW0YVUzQH
	6EeGDt6gzQ==
X-Google-Smtp-Source: AGHT+IHMuhPyytl0SjUCvYRIBQVKh4eStqeViwMDbJkzEO05IUIlI4tH+2TsfCUMnBf1mKOO8KiYLw==
X-Received: by 2002:a05:6a20:7f96:b0:1d9:c78f:4207 with SMTP id adf61e73a8af0-1eb2147d3f9mr41008413637.11.1737670030009;
        Thu, 23 Jan 2025 14:07:10 -0800 (PST)
Received: from [172.17.0.2] ([52.234.42.83])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ac48f897f33sm376881a12.23.2025.01.23.14.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 14:07:09 -0800 (PST)
Message-ID: <6792bd8d.630a0220.0250.2ee7@mx.google.com>
Date: Thu, 23 Jan 2025 14:07:09 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1808606194000052842=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v2,1/2] org.bluez.MediaTransport: Allow Volume property to follow profile range
In-Reply-To: <20250123205411.369041-1-luiz.dentz@gmail.com>
References: <20250123205411.369041-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1808606194000052842==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=927943

---Test result---

Test Summary:
CheckPatch                    PENDING   0.31 seconds
GitLint                       PENDING   0.26 seconds
BuildEll                      PASS      20.26 seconds
BluezMake                     PASS      1460.19 seconds
MakeCheck                     PASS      13.52 seconds
MakeDistcheck                 PASS      158.25 seconds
CheckValgrind                 PASS      213.51 seconds
CheckSmatch                   PASS      269.96 seconds
bluezmakeextell               PASS      97.75 seconds
IncrementalBuild              PENDING   0.35 seconds
ScanBuild                     PASS      867.48 seconds

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


--===============1808606194000052842==--
