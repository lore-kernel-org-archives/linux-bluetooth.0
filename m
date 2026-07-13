Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BC53375D5
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jul 2026 16:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783960027; cv=none; b=uDvtgXZNBa1dj66eKWOuMJX1o4QkkXogRb9qm7pwpOPZUaaBC1ciVtBSWAEoElvSfTkCBhpMB1VMzp3ypuG/DZD0tq6JjK6X3YXzmXs24e2/DOlqFs6nvT3x6GeAG0yRMfwG4dEvBDk7sLWNalVJlRv9sKgzzgx6fma7RQ83PaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783960027; c=relaxed/simple;
	bh=pwuFte1eKleIDZjbwxK6/R603b0jYtgDSj1XF3d5BW8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=A3bjwTPU6TOIiHg7qVTKMwn7oEM35y7w6vmw4O6t+9qcLvBBdde6Xx3maWQgFZnNh8WzJO0CsP65AUJab+tLH4hDSEZdpooF3JSVU0gJpBpUXGHxij/ZPAZxmz80uquqSceU/TC5BMG4k33jsGrPj+i438so9J8HgPFn7S1BTxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bpcy+Mec; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bpcy+Mec"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-38dd55ad76cso55674a91.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jul 2026 09:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783960026; x=1784564826; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=k02vbZJFG6hi62mEH2UURFT2EcTQjhIY/jGY5ucd9Bg=;
        b=Bpcy+MecN8QGMrh1mU8KBA8naNPqOiGj3rD0BX0avMggUFg1PRMad+6/X8+p9YacUS
         I4ka2H3d5uOxpSi7BVWn23+wEcE1jD5a/9F/7uWe0FZXRxlUzdRUMzrdcW05rCYg57CS
         LmMNnsbGBWWLf+z5W1S3Prr0Wwebk9gejr6iNrgTpk0cbk0NdE3KkgXIC2rBhK4lJ4mY
         hYbKQY38Qo+nQfSmBTBlCaLHVPcW2+HFdjp1vFIw1Rlbus9w8rb8B0UcigLKoD/viSS1
         7yMC7PX0nYSkMT9CsK1Px9450lsNfKlYbwrGYfRgX+cQVLo4p+5cxIvNSHbcPtzB6kdW
         MiRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783960026; x=1784564826;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=k02vbZJFG6hi62mEH2UURFT2EcTQjhIY/jGY5ucd9Bg=;
        b=tEGsq1SioZqX3t7aUzAUiK6G3ckn1EYMan9DmzfIuks/37qpYax+EmBfDy+Vmf2uJI
         UAc3hzSD9XsFZ6f9HE4IiCW/Ok6Whsrvsz7B/Dha1jArFxt319W42tC5FLLDG1oUlTXY
         at5+wKmd0E9kWVR+leCtpAx1+F1kMfXInlshNubx44nF+S2lzdYgqDvhBomSl6RLPGEe
         UNNVgg9FwijMBXtEHXTq93s0pwkYr+UGtuiM7xMCFdWzQ5cziRVk6t2Pf9DpmmlzTXok
         alIyQPkCYNlfsoozr5LMC5XGTATyj7EnrKTwxphqK5aSt3sMJxUW7NqeVrSVYZu3eXFy
         0OKg==
X-Gm-Message-State: AOJu0Yw9dIYGR6BmUsO8e8SITXMyxJkAm7N6K2bJ7vX+dnnNFEhRTfpC
	F6aQRwdPc886CTU4DNpIL8Zxps9VdSwz0tFvbtUaNz0E3Aq693VleZhopIl6mQ==
X-Gm-Gg: AfdE7clSjvGTjXr7bmDgTTpzqu0MYSNlF2qX6vNttE7GhCZPPRvFLnExWrRtuFuMWL+
	wBBFKD82shdxaRwDOm6K2v6pu9fx4kPgunIS56YnxqjfEz+an+Lok9VOYd4VxLztMh80iXtFxkx
	TySG9Z6/1srML76p9KOylSIio8TntKvS8/QT7/14LT2Qy7qd+RS86KcJvOURtBnh/VjCFxJ1bAv
	Yc7q0qlmJgrEnhUWC8HYWNUeIIFtSFpaTkkVSV4mQnFw9uG1UIHLRnfha5ADI5TbS4NDqU55H8b
	2A1HoITUQ0gfGZF9MzJQhqXJGYIDNBA15Ylif1aKLxotmW1Z+0xNQyQsAeQyC64mHIIdq8OwGFf
	yZcN+scMPWpXsafZSiNtKqctbbTxgw1pCkBnyFMb2vLtGKbBURE99Sjb6IHbFK+evgs23HGWXG8
	TfUCEnG49P+b1HukTJ2w==
X-Received: by 2002:a17:90a:d2c4:b0:38d:d9a7:a4e9 with SMTP id 98e67ed59e1d1-38dd9a7aa3amr4817032a91.11.1783960025909;
        Mon, 13 Jul 2026 09:27:05 -0700 (PDT)
Received: from [172.17.0.2] ([13.83.161.83])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3119d5cf176sm47479740eec.12.2026.07.13.09.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 09:27:05 -0700 (PDT)
Message-ID: <6a5511d9.9edb5c9d.208698.c019@mx.google.com>
Date: Mon, 13 Jul 2026 09:27:05 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3003989331441430303=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ,1/4] tools/sco-tester: fix missing clear of io_id in callbacks
In-Reply-To: <acc2842d415b9bef95e60243695463fa7953bf71.1783950503.git.pav@iki.fi>
References: <acc2842d415b9bef95e60243695463fa7953bf71.1783950503.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3003989331441430303==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1126713

---Test result---

Test Summary:
CheckPatch                    PASS      1.18 seconds
GitLint                       PASS      0.83 seconds
BuildEll                      PASS      20.14 seconds
BluezMake                     PASS      528.98 seconds
CheckSmatch                   WARNING   306.73 seconds
bluezmakeextell               PASS      99.74 seconds
IncrementalBuild              PASS      530.68 seconds
ScanBuild                     PASS      945.67 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
tools/sco-tester.c: note: in included file:./lib/bluetooth/bluetooth.h:232:15: warning: array of flexible structures./lib/bluetooth/bluetooth.h:237:31: warning: array of flexible structures


https://github.com/bluez/bluez/pull/2303

---
Regards,
Linux Bluetooth


--===============3003989331441430303==--
