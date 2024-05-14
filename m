Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CEB4139589
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 May 2024 14:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715696239; cv=none; b=k/tUYbAo4i4tKC7VMFNxN04TzKJU3t1gDeF9BX4ZVQGdLbIKW4asnU6L8nW3OJbihGD+LfFwC8rG7QIamu7WG8dkMK+DYHfTEF1Pz59Rnv3XiWWatIyUgNkoTVldfjI/lV6tf5qc1n4CBOuxFie3/SVqHx75WOA0h5Q9NI/gThY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715696239; c=relaxed/simple;
	bh=H3ICYss1CKDdn2Csif/9mqG3pCeo6vNx+s/gup47KOc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=mWyPNJPe+8czZvaZomw5pVqoHMNWtDTQ4MO4jd+/6Q36XWieqRbLHiKuWMC6nLxjiOuL5uYJdJaKF4dNp1FaIVaHIq2bN5Y7KU3Z8RuJrQDmJaYQbAVWy+55pmYLHkXG/vdV99ab9v5lhRjyjt1fAsrufpbZfiw6pOhtfPKfkao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nq+O+sWK; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nq+O+sWK"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-792b8c9046bso485374685a.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 May 2024 07:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715696237; x=1716301037; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=w4qBWCez/0D4/AOx34FB9RLqs0f0nWhL7JTaI5PSx+E=;
        b=Nq+O+sWK8KPxMIkTg+OHErySuqnEFBD4FAcoAOIZ5eq+jHf/5ko6mZkyOwQhyemxyy
         JIH4Izh/1SmzMMTsaVa4YIgDsAjNjLs2+sSNzi9pyVq8LHOPqecsB0p2Nhnt3scN5cZd
         NFfiFC+fbpKgLYxiJr7+Y3OjJCC1lM6V08YnQfKUaA8N5CMGW6pxwBEWDt33OclyRCzV
         Pmrw0S0A+kxhoAKvHBXY9aHAXEDeWIbATe1FrtWGXwbV4tUP8yKkLGbsJAhwk7LyE73d
         rVh953N+NHkCr+0VVsfIDHVbK6kNBv9Sh3mzg4EONCu30aihDkYj6btFO+RsxHXIMM9G
         RbMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715696237; x=1716301037;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w4qBWCez/0D4/AOx34FB9RLqs0f0nWhL7JTaI5PSx+E=;
        b=wuiAFcTiokeJfVkKpt73wGYdDKABN/4321po4/eH6La+L8d+lzZbuPejC82qk2bQJz
         IT1Sa/aLKQmvW2xcF482t85Mjh/ZHr1+Ck86+f2o5lWl6AvlJlY2cUGYdhaIT/mhQIX6
         +d0IB4EFXs2UfQMRA0+5ey2pSPeyN6cnQd+vVe+sGQOtgShUSfHVkyVT/UcT9jp8Gawq
         +xYvOOV38qR5b57aYI/eXj7gAjYiZAwIXo2IUEmpnPw+oklJLZ20hB7c9AM2K8t2GYxT
         8GDTZKFlbkIBeqUa01hIVZGJUx8Udkkv8K0uEINOKMNcsg5npBJMOz1QFnqDfF3iQy8V
         1U5Q==
X-Gm-Message-State: AOJu0YyKZTU4RT3J13HC9BveLTADbP/owM6pz0yoeH1LhjeNd2PFhXN8
	JqTHX6L7hrjfSNXqVW8Cga+QME0sBDCROo6REuywAaol8jIz6itoLP8+ug==
X-Google-Smtp-Source: AGHT+IEPe29FzlNdJ0fObTIZQa81iECXhA2CROX97hMPT0KcuIlDFMfIxlpaouZj0xK2nR9M919J8Q==
X-Received: by 2002:a05:620a:5631:b0:792:bc96:233b with SMTP id af79cd13be357-792c759856fmr1322198785a.21.1715696237325;
        Tue, 14 May 2024 07:17:17 -0700 (PDT)
Received: from [172.17.0.2] ([20.109.39.135])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-792bf1cd143sm570374185a.0.2024.05.14.07.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 07:17:17 -0700 (PDT)
Message-ID: <6643726d.050a0220.5f35d.1c83@mx.google.com>
Date: Tue, 14 May 2024 07:17:17 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2086616896142007882=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, andrei.istodorescu@nxp.com
Subject: RE: Create transports for matching BISes
In-Reply-To: <20240514113914.21048-2-andrei.istodorescu@nxp.com>
References: <20240514113914.21048-2-andrei.istodorescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2086616896142007882==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=853097

---Test result---

Test Summary:
CheckPatch                    PASS      1.24 seconds
GitLint                       PASS      0.65 seconds
BuildEll                      PASS      25.19 seconds
BluezMake                     PASS      1647.34 seconds
MakeCheck                     PASS      13.75 seconds
MakeDistcheck                 PASS      176.41 seconds
CheckValgrind                 PASS      246.00 seconds
CheckSmatch                   WARNING   354.24 seconds
bluezmakeextell               PASS      120.67 seconds
IncrementalBuild              PASS      3040.13 seconds
ScanBuild                     PASS      999.94 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/shared/bap.c:285:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:285:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:285:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:285:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:285:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:285:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structures


---
Regards,
Linux Bluetooth


--===============2086616896142007882==--
