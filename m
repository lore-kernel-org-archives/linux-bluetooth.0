Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5061EF13
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 Mar 2024 18:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709837764; cv=none; b=m3baeaWy72uLhWH5uHCvpSATcTateH5K5kuPmeTsRL+YmwfCDq3hs3n9u1KgVdgq9ppxotW+blJP/qugHKpQ0208ZYZiktHObOR/opm/xXRcJuBCW6m1zMzr7MykClWrG/78vmFzMA0bx3HnL5I43nbwA/BtjSghAeBQizvi1RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709837764; c=relaxed/simple;
	bh=pLjM40/k6YU3Tn06U58NCuP1Gd11P+d5dBpDGN0nke8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=T8BmqMUAXY9dXatNEHZjY1O7CSss+qHVgh7NWeS9/RFbNQJFuFwCWNQtoKkBCxez41RrgebXTFVGNaPVRnMCUaJpAlug7HSTrLS7Y4txXcxna+xKIsjbUYZQwZQQ/AP5ZEJ+oLYOqKI5MRJ1ltAKbMbSMx0kBD97IQ7ErqSbE3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XhCEMmCz; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XhCEMmCz"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-42a0ba5098bso9157541cf.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 07 Mar 2024 10:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709837762; x=1710442562; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rylyeMlSrindvSA0ZR1grqgBZbkj8se2Ekg7QoCvv0Q=;
        b=XhCEMmCzOgneo+23JUSRNX8l0P2KEm2EjzrH0fl60mf/ynErWiTUfD1j96kdXZTKsg
         NxbyZBpNMRnHPUMxtxQMp8I9ZrM92Cwmfyx9KNDBIjJT2HRdQ6u+mGJ2LJ+qlvdIv6kC
         DGnbEh+WfStz+cON1wnlNzuCrVe6mbSzTVZgDl5VnrF2YfyddMoYFLYx9y7vysq3IaV5
         4Q5deVMZILREUxQDaWKdz99lERzM3uxxJ+5DPCf8GSJd9ohLTyr6cQ5OomMlp4wdA7fz
         PklsCT2wE3ORUiJ9V5tbckiiGW4Z0M8xS3XoPlD1pEbBNsnHFDSvdq/1E5AIQlvhCHh7
         ZTaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709837762; x=1710442562;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rylyeMlSrindvSA0ZR1grqgBZbkj8se2Ekg7QoCvv0Q=;
        b=Tz7Px7xty4DyMhayhweMlh0luOARobPuFX7/rtamNTdAUDM0huw+bbGOXp614ss/SS
         myGB1j80drEgMwuwZVhcq/04vOqNcs/CVial5FzW+vgBFku4M1921oue1J6JJm5igF0V
         2b7WFK5vcIKqwWtAB+/mRI3rC2zneWMoNtyC0WxWw7XPaSSxhGQkVhVVXXvtrbIPbK7U
         K8YdJYxUO4JAB6IXomyq4ZMMMQpeM4hL+0r+xetmnxI7jpfAQR9YzSMI1niCcRTl+Hi3
         TV3U+acguOFhBL6MPpY6Md6fDGXxufAdXySso2G+53/6i+GvTLCGwv/9BTpbjGjCUmPN
         L8bw==
X-Gm-Message-State: AOJu0YxH+n0ClH6Bv10JV+jg54OJHQeQkY+PrtS5qHWL4t5ed5H4JVlQ
	aNKrEMWIGKN4z4+cfrePj6aHV2fAytcXQVD/v+7+kztd8xOHGhW3GwTtvEPk
X-Google-Smtp-Source: AGHT+IEqK8xdw54wIJdWUtMcZHMtc8ZHDwsqf0uGMcZdgBzLfuEpnNNd7AMsPcSvnedE7YnqbI3PMg==
X-Received: by 2002:a05:622a:1792:b0:42e:ef63:352e with SMTP id s18-20020a05622a179200b0042eef63352emr9421178qtk.7.1709837762186;
        Thu, 07 Mar 2024 10:56:02 -0800 (PST)
Received: from [172.17.0.2] ([20.88.15.116])
        by smtp.gmail.com with ESMTPSA id c19-20020ac81113000000b0042eb713f8e1sm7790689qtj.95.2024.03.07.10.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 10:56:01 -0800 (PST)
Message-ID: <65ea0dc1.c80a0220.eed4f.24b4@mx.google.com>
Date: Thu, 07 Mar 2024 10:56:01 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4257767580929820142=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: client: Add scripts to start broadcast source/sink
In-Reply-To: <20240307155850.68395-2-iulia.tanasescu@nxp.com>
References: <20240307155850.68395-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4257767580929820142==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=833470

---Test result---

Test Summary:
CheckPatch                    PASS      1.68 seconds
GitLint                       PASS      1.18 seconds
BuildEll                      PASS      23.93 seconds
BluezMake                     PASS      1643.40 seconds
MakeCheck                     PASS      12.94 seconds
MakeDistcheck                 PASS      173.15 seconds
CheckValgrind                 PASS      242.04 seconds
CheckSmatch                   WARNING   345.94 seconds
bluezmakeextell               PASS      117.44 seconds
IncrementalBuild              PASS      6043.82 seconds
ScanBuild                     WARNING   975.67 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/shared/shell.c: note: in included file (through /usr/include/readline/readline.h):src/shared/shell.c: note: in included file (through /usr/include/readline/readline.h):src/shared/shell.c: note: in included file (through /usr/include/readline/readline.h):
##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
src/shared/shell.c:1243:13: warning: Access to field 'options' results in a dereference of a null pointer (loaded from variable 'opt')
                        if (c != opt->options[index - offset].val) {
                                 ^~~~~~~~~~~~
1 warning generated.



---
Regards,
Linux Bluetooth


--===============4257767580929820142==--
