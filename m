Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975A280BF2
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Feb 2024 19:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707505446; cv=none; b=JC4Ti7lh0uyE3QtJxXdfeKNMeMNW81TZYVJgb1aiw6h4ulSCpCz539251SYQXQgCKuwdhfpVTLLbkHGYV9qI0lbzkJWdLgwCcJ/BfvGIw81OWrQsFnaF3QX1uTSs+3YTa7i2wymTxKIW+j05RGRVWENjT6nzhAO+d3xaw/xDevE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707505446; c=relaxed/simple;
	bh=RDAuklXpuua8ScCPTkxe8O4+2+3uTd+QzsDy5cmAS1I=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=DrB58sUKitWxNmM04hXthZ56lykZ4hJyLsL8n7STfOy5kWXdWvS1Hf8k0eK85LOpn8Arwzd4Ie/B7weQwFRDVzodUjOPwcuSkpYYisPUt8ih933Rl0VHrH91hifKUF2tMshogblz5UJbw4K8z2l+970zpZMQc8HcdyzMonaXcsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mYv9DSEY; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mYv9DSEY"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6818f3cf00aso7334836d6.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 09 Feb 2024 11:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707505443; x=1708110243; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PDT+9GRCf/KHqovFSbTnz4BtOJtFMNaNTcfntMLbong=;
        b=mYv9DSEYaRej3wMO7dBQ0HTiHXXm9wyZ8mJyDaqIhNIVF+cIl0iCF+VQwu0IgpHHd1
         xnca8opbnj/ByifDiOYhmdU48NzgRAGsoawe2wqr+ZshrYCx7NnXrr3dKriUi2ykaWXP
         IwKwpUINVe4PwKFeaPoAgsfobYrCMHUNjWyh2zqlpQpTbNok0Ti8CdH3wGoSpggnqyuA
         UGg2F9vch810QcLmJufbKDuLhS8U8hQyXpByfIX9DEhSHTBELlkw5dkcVmYY8oHLtbpC
         7naIxoUTpdEV0sevCkIITIYwcGdsQ1eD0+/GjEBQ/EHXTDyLHiQe/+omYyjVmYNIpwWu
         qFfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707505443; x=1708110243;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PDT+9GRCf/KHqovFSbTnz4BtOJtFMNaNTcfntMLbong=;
        b=b0iza9WvW7MUVCX9gfnnIy+E05pWjldkqKl5HdI2jLpPwo6gVTYyjolNBgCR8g3bRx
         i/nipn6NK7MVylOg6Iz1Y7D2NKZxXX04TttTJZf8yJ9vkxHsmHUNw4CZE9Zzn2SyOjX8
         fZUvnQMQP/1rN6OiUpTOs6+KEoomsRepjUQg74pTMjBC5EMzZJ11O1rpij0Cwu+l0kLL
         1wCs4uoVs+y02RwJyUHWDUAvX+mDpmBgl3iBFLc7s5hhIWp+J6763BpmrsdqnM4yRbb4
         46r/WWgQzr7wtrzFD12UGKuB6gf5sUe6fPq4LqMdOEmOB5h9cvuWB2Ki51JED0ICzMba
         fFsg==
X-Gm-Message-State: AOJu0YxqxrG83jnrYWqmjbBBttQF/KMnK6jJWblwZ3wzsVpltf/X+KGF
	8p/BGFCtsrdEEyTk7fz1x5JDQ6Zn7qegD07Wtrj65mYffs3vx/wkLjiBhRpj
X-Google-Smtp-Source: AGHT+IHCHo7/+R+Mw6zs+jclFfdR5jEq0YKZwRca9qrqfh4QrM1+GAsNmodZGAISzWIFg8z5yVyo1g==
X-Received: by 2002:a0c:aa1a:0:b0:68c:48f5:31da with SMTP id d26-20020a0caa1a000000b0068c48f531damr30956qvb.34.1707505443445;
        Fri, 09 Feb 2024 11:04:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVnh9gxDjX1q9+yBe4uO3xS+Bg1rrg42LRz1Qz7++vpboX8LzXsUxvO2EDyF4RCA1+yhoMHoKsIUNPVNL6+54wmjC4s5NfYRyzr0w==
Received: from [172.17.0.2] ([20.81.159.99])
        by smtp.gmail.com with ESMTPSA id p16-20020a0cf550000000b0068cc75f7b3fsm1088640qvm.60.2024.02.09.11.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 11:04:03 -0800 (PST)
Message-ID: <65c67723.0c0a0220.1788a.76b3@mx.google.com>
Date: Fri, 09 Feb 2024 11:04:03 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4655028920736528418=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, andrei.istodorescu@nxp.com
Subject: RE: Update Sink BASE management
In-Reply-To: <20240209164630.92208-2-andrei.istodorescu@nxp.com>
References: <20240209164630.92208-2-andrei.istodorescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4655028920736528418==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=824726

---Test result---

Test Summary:
CheckPatch                    PASS      3.26 seconds
GitLint                       PASS      1.90 seconds
BuildEll                      PASS      24.66 seconds
BluezMake                     PASS      739.61 seconds
MakeCheck                     PASS      11.56 seconds
MakeDistcheck                 PASS      163.14 seconds
CheckValgrind                 PASS      226.47 seconds
CheckSmatch                   PASS      327.84 seconds
bluezmakeextell               PASS      107.34 seconds
IncrementalBuild              PASS      4127.57 seconds
ScanBuild                     WARNING   967.63 seconds

Details
##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
src/shared/bap.c:1117:2: warning: Use of memory after it is freed
        DBG(bap, "stream %p", stream);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
src/shared/bap.c:40:2: note: expanded from macro 'DBG'
        bap_debug(_bap, "%s:%s() " fmt, __FILE__, __func__, ## arg)
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
src/shared/bap.c:1130:2: warning: Use of memory after it is freed
        DBG(stream->bap, "stream %p", stream);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
src/shared/bap.c:40:2: note: expanded from macro 'DBG'
        bap_debug(_bap, "%s:%s() " fmt, __FILE__, __func__, ## arg)
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
src/shared/bap.c:1225:33: warning: Use of memory after it is freed
        for (entry = queue_get_entries(bap->state_cbs); entry;
                                       ^~~~~~~~~~~~~~
3 warnings generated.



---
Regards,
Linux Bluetooth


--===============4655028920736528418==--
