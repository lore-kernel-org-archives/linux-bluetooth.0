Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D735529D02
	for <linux-bluetooth@vger.kernel.org>; Fri, 29 Mar 2024 17:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711734185; cv=none; b=nAIH8OGcJfE9edlOE5mHHRK3j5ejtHTJTtoOepxID2EhRAqezNML8zlvxKOUAb3xg137w5pigkeRPHasTu8+ZWHRHqM8XXsyRqSx+KPpQxasyh7fGvMmj7uwyl+ur/69t9emMJ8f+BQub0+cG1/64zgDP1nYl294yvsoeX+Rzms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711734185; c=relaxed/simple;
	bh=iELl9NmUQ8NuOmxT6xCCWHmVD2tkpAXpI/VAjzchMSY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=PvMNlmK6Z8XpX/Fe+X0GqtuQdE8tInoG1EmUnIU9X7a0jPOdlJM29lz3jHw8VH9KRhmGYuBx3CUQDLvwcNcTY8LU+vY3Aq8gSsUA41VYRWFhk7UObR2SpmY0ioTTHCpApKnV+jcNaxtx7szaax5oKz/jGNKw744D+WWri1cuSwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NQhb2h7A; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NQhb2h7A"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6143542f74eso10164387b3.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 Mar 2024 10:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711734183; x=1712338983; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IVc++A6DQTedwHzB4D6c2tf7V9AWP+sTO7YA52LY4cM=;
        b=NQhb2h7A0UTRIrMbrpIxUnB6BdtFf/sop52YU5CSEzWRy63aNIDFF425aNfZwZGmA4
         U1VwpKSScN3xgxLVDdQg1eNm9Bf8J7JFYTqhPwBGDo2eYP3OYFhPQuKe0q3xai7GDlqw
         UsimP7Dano9buyK9MUsh3IAksnP7JNYorxen/MtXwL8rHgO5HwnJrS1aMDZGxnCvwpVo
         XXexNxWaaIW08rbtYz0s0QbOVv+U5vB7axOIVNsxk0NF4feGK+eksfBdDZ8O4STjVp6w
         fHhduqDI0d7Y3k61gWvcalkirjCkDpwkxmAovQQjjeHWQ+UF4t7cJIKR7rG6iuCWl1yA
         +FGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711734183; x=1712338983;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IVc++A6DQTedwHzB4D6c2tf7V9AWP+sTO7YA52LY4cM=;
        b=hmk/WGuRtrgNtkP28d7XlbP9bNedDX/InPNqbNCRDpGUzpnKem2IQLU8FdPxjBJMCq
         RTZHo5Qn5l11lN2odrWtfkbPRNSBJ25vANEsIZZKYYNWLXi3zgcg8pa2n4EeTrLWkQDu
         g0N2UpGh/TH3HFAPOrTfk44lGrCuZDDu7f4WtDZyIUhFO/26aEc9noW53QGwuueU/tuA
         U93259hJmZ3+RLdISqVqjX5uPHmvFy68HZxfG8JpELyC7HuE1VWG3t6U3wsuBt85VDzm
         EJB2J66aBNaov85/KGgvYQ1BVoD99PVaKVFzxqzI007w/oLkOe5HEl6TAaIUNkTTXa5C
         sPGQ==
X-Gm-Message-State: AOJu0Yw6PTQr+LNq2qqqny4vqcez1KlRB4QoDn7AwXaB+yZwEJJbUKL2
	ajI6jAlQjEvcTcekd3YM2wYv3Sd0Na6JBk+wArrx9Qp8iecmJFYUktaFHFHp
X-Google-Smtp-Source: AGHT+IEISgPaSvfhT61PsPo6Kim4IqTakq7AcNDIGYNqmdIrmndICtjtl33ZPMUGRDZIPhqxK2FyxA==
X-Received: by 2002:a81:6d45:0:b0:611:9f:f997 with SMTP id i66-20020a816d45000000b00611009ff997mr3379147ywc.40.1711734182739;
        Fri, 29 Mar 2024 10:43:02 -0700 (PDT)
Received: from [172.17.0.2] ([74.249.5.177])
        by smtp.gmail.com with ESMTPSA id x21-20020a05620a099500b0078a255927c0sm1515713qkx.41.2024.03.29.10.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 10:43:02 -0700 (PDT)
Message-ID: <6606fda6.050a0220.86f82.b578@mx.google.com>
Date: Fri, 29 Mar 2024 10:43:02 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1472018491488395308=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, vlad.pruteanu@nxp.com
Subject: RE: bap: Remove entry of deleted device from bcast_pa_requests queue
In-Reply-To: <20240329154000.6056-2-vlad.pruteanu@nxp.com>
References: <20240329154000.6056-2-vlad.pruteanu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1472018491488395308==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=839813

---Test result---

Test Summary:
CheckPatch                    PASS      0.46 seconds
GitLint                       PASS      0.33 seconds
BuildEll                      PASS      24.86 seconds
BluezMake                     PASS      1704.97 seconds
MakeCheck                     PASS      13.69 seconds
MakeDistcheck                 PASS      179.83 seconds
CheckValgrind                 PASS      250.94 seconds
CheckSmatch                   PASS      359.17 seconds
bluezmakeextell               PASS      121.78 seconds
IncrementalBuild              PASS      1491.25 seconds
ScanBuild                     PASS      1022.71 seconds



---
Regards,
Linux Bluetooth


--===============1472018491488395308==--
