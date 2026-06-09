Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F5D35E936
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 21:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781040669; cv=none; b=TnPWuKn/i9zKX73/iF6jVHJ1uvTyP99iG9w/dmTnknGanr1DTqSKi7YtSjTo2ILS/Y5HbJ65XiD5U1wL72we901kwyLcgKuSO54hLNe6xvMty0zjU+Ak8mOm7PGhy25AH2AVqaNFZuZzuP5g/uQLBd6tzkzP69qRT5YicmTJxTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781040669; c=relaxed/simple;
	bh=DNTprSwLhiyJm1PYpfpugE8gbnNOtGSueD8hJjrwkms=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=gFwVI3PbV3eU7/Nvemld5Mpk3h6I6kt2pS125/yg/6wuQZRpw9Q+OaRJHGOzPKw6707fwH1RfThR0nQu8XI+niJDzW4h8M2rPji+/3LOjllpycm3HPo3aQZMMfAbGETsJsSJmlcOpxFlrNP3gERk6RnVtM6Qta3ZtLSOYcjyBZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OCjprXW3; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OCjprXW3"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-1382533d428so2055768c88.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Jun 2026 14:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781040667; x=1781645467; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tENV4kntqzdUlive2hv1iHHq2H9xGQEYwzAuNBFnfv8=;
        b=OCjprXW39aRgsD5LY4nZF0sBy7q8NJw6JwCOUalznIujyY5Ypo1wxXWkkpLazi4y2X
         HU8s6yVbNV27A2loMRDFff/hfuDLzC+q0/PVE1r+YfPdox30Ybe/zNfP+pYjeEyrJ5Tg
         tXp8XcFYKlSgueg3S0qaoWzbOYM3fD1kOuLQsC+rytIkFrhJIn01AG8F9vUSiqyNeqpZ
         Hr75nmE2qtO81PG35QTkY9lG0Sxvb8iRj3NsIRmMO5NxswNkYMCN8McDNgdY24eUTzIX
         aYtMn0uw6GESIzfC/X3jfRoVTBJeI9sv6en++Y0S3S/Mlb5Lyiz/qRmqCoPLdfMNNg8Y
         LYkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781040667; x=1781645467;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tENV4kntqzdUlive2hv1iHHq2H9xGQEYwzAuNBFnfv8=;
        b=SjCkICwEG8SVKbPufWlQ101jmFlCo3S+ns4SYUlr/Mnn7CMuPC/417D2FOqfjQ/8zq
         RM+V3jDNv9YmxWvfyaGB23E2WWm5SWlxZ+X9L1ojfPLcaVFFXaRI/OnVhXO689YV22Tz
         7ePvM9u0iQCTV0BhqhFprB37RzFmII3SCbwMaMM/NrFeZl679w5+4ykREpidlSAja/h7
         GBNYXwzoTHMr8ifcrsWnUdmfkXLSHhkInQmqk7aLfsJa+kxhkYDLMc6MWYljlE1DmXQk
         4y8T96FEc3dXoehz6zYKhA1DAIypn7zkutdH6cZwyXIq/1Bp/w7HPdpEobjnVvv3nhYy
         QzoQ==
X-Gm-Message-State: AOJu0YwwhF9V1pirjCr8gpM+tkOZrYaFNqA/j7ttWDc5dw/p+Dmg1XSm
	w4lwO6FicSv8jmLY5Xzh9k7pQaucmGdpRdRVks+blQItKjbsbQ42ugGokJMdrA==
X-Gm-Gg: Acq92OEQn/LH1bi1OUxIt2745iNpaDKT4b2x9UfPW5/g31lIcpE6ndUgvJSkfHvRrtR
	8py2TmNSsTp/5Io+cwWy/nRVXKehfk5C5SBkHSPw51nkeDgEjLkTqzz7tyoJW/efVIT4KlIe4Gc
	K6Ni5TL2uYVGmVCuYbrNQkG0zeF0vKKR3TIL+73JD5I0WQXU9HhjYNm7wRXuQZIE+jgCO/cxYxP
	rkGAPjmNyGy7znkZwtNj8stZDmCyRoqghRwLsRNBIqqlPqHYa0FHmwcKZVgSMHSMGDCDcWDvfqp
	JNVZ3xi9e2d66r5dyLVcYctif6pLMH3MGwTBxoOrzLRQpCaZLwkfhVDQhpiXjuUfVxgWi3dGtfp
	Xbi90HToTz1J3o3raE1MrDht0XbUj1V/PGh/A127562qeDEmTReqLxjnbruiI4VtEhOj7pVDqwI
	G4OrksixfClFFyUmgpFxSbIL1EtXpDHIVncHSP4dw=
X-Received: by 2002:a05:7300:534f:b0:307:3a6c:ecf4 with SMTP id 5a478bee46e88-3077aed86f9mr14420660eec.9.1781040667066;
        Tue, 09 Jun 2026 14:31:07 -0700 (PDT)
Received: from [172.17.0.2] ([40.65.58.133])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074db56697sm23614857eec.2.2026.06.09.14.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 14:31:06 -0700 (PDT)
Message-ID: <6a28861a.de8afdfd.21d06c.6227@mx.google.com>
Date: Tue, 09 Jun 2026 14:31:06 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5927343409012454692=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v2,1/4] btio: Handle EOPNOTSUPP from accept() to prevent busy loop
In-Reply-To: <20260609185313.155105-1-luiz.dentz@gmail.com>
References: <20260609185313.155105-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5927343409012454692==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1108786

---Test result---

Test Summary:
CheckPatch                    PASS      1.22 seconds
GitLint                       PASS      0.78 seconds
BuildEll                      PASS      20.04 seconds
BluezMake                     PASS      656.72 seconds
MakeCheck                     PASS      18.90 seconds
MakeDistcheck                 PASS      249.96 seconds
CheckValgrind                 PASS      295.94 seconds
CheckSmatch                   PASS      350.89 seconds
bluezmakeextell               PASS      181.16 seconds
IncrementalBuild              PASS      673.06 seconds
ScanBuild                     WARNING   1036.74 seconds

Details
##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
1 warning generated.
tools/btgatt-client.c:1822:2: warning: Value stored to 'argv' is never read
tools/check-selftest.c:42:3: warning: Value stored to 'ptr' is never read
        argv += optind;
                ptr = fgets(result, sizeof(result), fp);
        ^       ~~~~~~
                ^     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
1 warning generated.



https://github.com/bluez/bluez/pull/2206

---
Regards,
Linux Bluetooth


--===============5927343409012454692==--
