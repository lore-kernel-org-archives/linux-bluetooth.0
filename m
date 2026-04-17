Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFED6377574
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Apr 2026 08:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776414975; cv=none; b=F4sOUXLZQuu7WDbc2aHIviFplgPctO3oRUpzrm1IjSt2fZzX3zbKQK/qgjW5METMiiZLsznFkLJ9KudzsY3fJoDFe92CEt8mxHWLRym9r0GG0P09bTUp5XPInjUt2MMou7jwQLLCDvNwUaKJ38DcYN6Vc5WIClbjPGk443skiIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776414975; c=relaxed/simple;
	bh=YyucVnWQ1vRx97Jj9KSqp+RP4B1boKqwOojIPLyj4wc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=FmEWE3tPh3BIH8/mTrL49pUBH6oVi2Kru9lgbamHJZnrMcT9n+Zj/FzD1ABIkiQdGMjM110J9VuUCnFOo4n4NaCzGYnj9ipdO5H+3zxBFj2QrsFgdpCcP1SQhlAMG8rX8VhTDJZcbG9ALBcpy9CERR9i4ls5hU9u+LwcYOp3C08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DBABO/6M; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DBABO/6M"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-50d6b9bca48so6609771cf.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Apr 2026 01:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776414972; x=1777019772; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nSJRiOZ15T4wgo6rcbLnltCc4uxJ/xLkoaE+6jntElc=;
        b=DBABO/6MANZVxngGODsVEg6RZcUei5bgj31XGPf+aRIBw2sDtce1qtl059NurJjzSp
         Yj+4GEKxyrhGVYlswYKRWYJlbQ7D8Qez5TTXfodeji3P+4wYkXYIqUS8oNAq3Aceq9T2
         DGHqjAG95Es5E3duVaNbio9G+Mb7M4EGX7PKO6ND/p+PiArADZIwBCcS+NbauaLVDxS6
         OJa7PFGODTzfI9PaRPy7QeiR3fMIjoIwbWqNoTmnrrmp+qliJq5SEIpB9aoHQBz/lKm/
         wIuBFwY3f/0krpnhX4Rzo+6mCOK/rT7ct24x5AsrzGmNnz9Liloykkrja5NYUdwKFEqD
         h+hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776414972; x=1777019772;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nSJRiOZ15T4wgo6rcbLnltCc4uxJ/xLkoaE+6jntElc=;
        b=W0tDgbkhSx4jt/YAbW335WmPs5vsfolqhrSitH+pZU1gstG7dQSYI3D6MthWRkxiT9
         vPCf5N5b8y4Iv2KMxRjnIJNGPirWMlM4LuXnkLOmw5tLO0xacynsdfg9TlkSqgvPSuvq
         tJGEJUbbifIJXa9br3dljYkf38y2JYR69Tuqt70ygR8sF7NnGjpUF8I9muHQBYJnr5uq
         UCg893oqoAVArWwJhXpK68vRIq0vufrp0jZLSeA63MZUn2puDKS9nCbDXRqV2NHkDS+M
         9wpC8MX3ltOI6yx7aXizUPeNk7VMs4mJ3jx2DJzWv0/ByXGy6XQ9XxztsPHvJZ/54tWg
         0uJw==
X-Gm-Message-State: AOJu0YwQzSmscIc2kWQY5Gjzf4bqrriLgugTNUhg1TfAvtFHQNeq32rO
	yMYMUcStNKuYD3XiSROTd04huXF0XcO0XKxSk8l/ASN1Tv7PxMwNnEilWKzexA==
X-Gm-Gg: AeBDies1SMyd1xQqvqjk9IXWJb6YHaXwbQ5vmXSeSVq5RGkT6XhX8/J8+DeNBhdn57r
	g1qnRcBp6Y6bbz5eS1BbGMdK3VH5crN5ZfHbqVPJGgPLUqx+Mv7tD5Vzj2hKUixf6OPQpuLW0FM
	6SOsnsjB+jCKpOx8Y42HO+hGDEwkV89BkiJ7Im3OCXvC48n583bP5B7lKCH1dnOFwiL4Bj3uS8Z
	8OrXISIOZcLLY8TxUJQdKY/L7waJNFouE2hX4U99lio5iAGZa7Bk0emtDXDb68WSyVSuaKTezED
	eyIFLeFALTi6/iEHBUZ01yhrAkEKm2poAjXOSNhsoavxlrDC7Y9D2232bk3/pFIo6BirIYY/ArH
	Pb5mYG5J/VKvcWrjqgOFFeEGXZ5WO+DoxKpgRlmTTlSaoDlQIxAEZsyzY2wUL+pebsZ5VqKlPz+
	MKvW76PuGvLrp3mgDjH8XjP3D332+xQTvIC+mTpmXXPQ==
X-Received: by 2002:a05:622a:345:b0:50d:a8f5:1bf6 with SMTP id d75a77b69052e-50e36c906b8mr24700801cf.52.1776414972512;
        Fri, 17 Apr 2026 01:36:12 -0700 (PDT)
Received: from [172.17.0.2] ([48.217.107.116])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02ac4260bsm6013766d6.4.2026.04.17.01.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 01:36:11 -0700 (PDT)
Message-ID: <69e1f0fb.050a0220.2e8946.d615@mx.google.com>
Date: Fri, 17 Apr 2026 01:36:11 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5244642990549735307=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pengpeng@iscas.ac.cn
Subject: RE: Bluetooth: RFCOMM: require a credit byte before consuming it
In-Reply-To: <20260417073446.95494-1-pengpeng@iscas.ac.cn>
References: <20260417073446.95494-1-pengpeng@iscas.ac.cn>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5244642990549735307==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1082376

---Test result---

Test Summary:
CheckPatch                    PASS      0.78 seconds
GitLint                       PASS      0.34 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      24.95 seconds
CheckAllWarning               PASS      27.68 seconds
CheckSparse                   PASS      26.20 seconds
BuildKernel32                 PASS      24.60 seconds
TestRunnerSetup               PASS      517.52 seconds
TestRunner_rfcomm-tester      PASS      9.45 seconds
IncrementalBuild              PASS      23.60 seconds



https://github.com/bluez/bluetooth-next/pull/97

---
Regards,
Linux Bluetooth


--===============5244642990549735307==--
