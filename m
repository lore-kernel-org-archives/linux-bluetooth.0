Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01BB52BE3E
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 20:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791922771; cv=none; b=RaOzc3DHob4sPuvZscIiJhmuSbTvJEhrOEiJD/R76MqUKXIVRyJPROYlYiR5DD+pKN31kAhDosugiBf8GLJ5cmGGdarzA0oLWJPirAEsGnu1S0wekkQqZyy2UFs84xibxCcMXVA9qwakeIeZO0dNaUwqKMfu8hScppWmCtRdCl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791922771; c=relaxed/simple;
	bh=j/TBzxmo6NsCNpg/f0pcfKoXBZSfU+h9uu1FjViyDVQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=bjyW2K4SP1kuszAwyShfI8+SkgjLaf+tWCxnFOtrNsZuWRsQRTzJnw5v9199rY/5wneywWWlhoaMuVvpsYbO9vQo1V6v97c4LTOyiUyfI1AjyvbmFjaxF44703z94AWEF8Ug1jLgwRtU9syPwDP36zD9c+PoC7XszBC5+0kg0to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iB1IHwhx; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iB1IHwhx"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-170135e43c7so718085c88.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 13:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791922768; x=1792527568; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=LY8JsdsX6XOL89ZPq9OyF4Qx8lA2ULAeaKkaLlw9uHg=;
        b=iB1IHwhx5dJ6fDVhULKJZMjqUxB3MXfTAgJD36VJddTS3avOaErohAZByoRqq6klQj
         DGqAAondYF84GGy5ei8d8EUxHynLcl7RIELXBlB0X+D/jztOx2zJecKfDm9Ng5d9IwlU
         fliFxGjpzqrukj06khk5O84SWUPnux3XKlAuJ+Af9A5jYVJunplA0uYyoyYes9ci0plH
         ZRqCeX8+sDyL4M6OuCKPwtCYOGNIQsmvk7iCpFVwOWq2r3AecJj091ADzulzWaNjNsBn
         +OXP25n8u24YaBXw64pZDeuCKLE7S1UFMnN/Xqm7OvLxubWSA3uKmKnStLXVmezhAE+l
         8PiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791922768; x=1792527568;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LY8JsdsX6XOL89ZPq9OyF4Qx8lA2ULAeaKkaLlw9uHg=;
        b=o5Nkzoi6L42Xe6KW31069kvOKlE8nntdUF+9EZ1nz1G3SawtRmo2vDoXo077e7LPVO
         IYSc47xCfkmZTLOTmL9UfzFLqlP9Y6MIPgQk/5SMLV11KcFdIEdRGbAHmNfVTSrk2kN3
         yi0RUCHY6u/OL773cAoKCuffcZGHB9eSY8QdQDgB7fc5wekD90nkYBGSOP66c2h4tL7N
         uccsqJOqSli0JX9GpbPyB5R9+23Lz5CGvzQWzbC6qhybxIB92VNLOmQfqKkBggEw9SqB
         j2gC7OATYouhuvlZ3SF4mzeg4zJ0FkAd6ZoCGoFWK46vUTAVkZDYmi00ylqDEtc3UfDP
         heyw==
X-Gm-Message-State: AFq9FYImjExLqT2EyjOTV1tTqE5AoOuqBtcq/uNbm36kSfjhSddnI8Oe
	hGkaeDERUFJoahS5MXqhlQX77LuHvSWOowIs+VDqCqCTtZ1WpoUhe02Trxvqjw==
X-Gm-Gg: AYBFou2z9642FtXjkMSOeshoKJQi7kW3PlNJfEAnPZWKfc79+YQwHtQMaIM1DP9fsJU
	+1dzTjLelK5AqQA8NGXNLMRT6AmyQLcK7j6haeT0W5HfOEcd0wVcsStIN/nwXqXjCFYmPhVPsU4
	nyPIzwDKDOtR3HF09O6oqq1DhSon6zyu6dXOG6Tva/xMaGiu8i7vGgAuSo1qULodn0GLtBFeY5w
	Z+OI05kpSemh5Ix/m/idAOch2/eHNxRndknVnFKlhNn7Uit5E7n6YvgZSZv7r1WBEtn9BzqoxRk
	jEaOtL8g/ZcmPYVK8AeBtKEdfzVKG4j14Z5YrvqdGXCmHlNWHjcJZhjTOg0M7U/XSRsx0eANCNI
	l+dQLLt4hSPBZ7fkATxzcIKpYR0lo+V4gEbcCuVQ7w6S9BJ4h6BLpXp3dSIKvOmgMsCOTcGHvLA
	zxCo6QMfrh2C0Fw2kcGyebF+SzItRUvEC5t1NIFT7LdsMPXWS+sSpdUHO3tTAC8qYrOSG8OQqT8
	mR/jQf0
X-Received: by 2002:a05:701b:240a:b0:160:8d8e:7e3b with SMTP id a92af1059eb24-16a6169584amr22446619c88.10.1791922768175;
        Tue, 13 Oct 2026 13:19:28 -0700 (PDT)
Received: from [172.17.0.2] ([172.184.211.165])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a4429603sm38473435c88.17.2026.10.13.13.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 13:19:27 -0700 (PDT)
Message-ID: <6ace924f.14693a91.2cb03e.a9bb@mx.google.com>
Date: Tue, 13 Oct 2026 13:19:27 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6789915892670762282=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zzzccc427@gmail.com
Subject: RE: Bluetooth: MGMT: Serialize power-on with power-off completion
In-Reply-To: <pm-bluetooth-objects-candidate-0063-v7-35a6680c94a332fea155@gmail.com>
References: <pm-bluetooth-objects-candidate-0063-v7-35a6680c94a332fea155@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6789915892670762282==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1184931/

---Test result---

Test Summary:
CheckPatch                    PASS      0.60 seconds
VerifyFixes                   PASS      0.06 seconds
VerifySignedoff               PASS      0.06 seconds
GitLint                       PASS      11.67 seconds
SubjectPrefix                 PASS      1.12 seconds
BuildKernel                   PASS      30.33 seconds
CheckAllWarning               PASS      35.37 seconds
CheckSparse                   PASS      37.26 seconds
BuildKernel32                 PASS      29.76 seconds
CheckKernelLLVM               FAIL      23.97 seconds
TestRunnerSetup               PASS      729.63 seconds
TestRunner_mgmt-tester        PASS      87.68 seconds
TestRunner_mesh-tester        PASS      5.48 seconds
IncrementalBuild              PASS      27.87 seconds

Details
##############################
Test: CheckKernelLLVM - FAIL
Desc: Build kernel with LLVM + context analysis
Output:

net/bluetooth/mgmt.c:1418:2: error: mutex 'hdev->req_lock' is not held on every path through here [-Werror,-Wthread-safety-analysis]
 1418 |         hci_dev_lock(hdev);
      |         ^
./include/net/bluetooth/hci_core.h:1799:26: note: expanded from macro 'hci_dev_lock'
 1799 | #define hci_dev_lock(d)         mutex_lock(&d->lock)
      |                                 ^
net/bluetooth/mgmt.c:1416:3: note: mutex acquired here
 1416 |                 hci_req_sync_lock(hdev);
      |                 ^
./include/net/bluetooth/hci_sync.h:15:35: note: expanded from macro 'hci_req_sync_lock'
   15 | #define hci_req_sync_lock(hdev)   mutex_lock(&hdev->req_lock)
      |                                   ^
net/bluetooth/mgmt.c:1462:3: error: releasing mutex 'hdev->req_lock' that was not held [-Werror,-Wthread-safety-analysis]
 1462 |                 hci_req_sync_unlock(hdev);
      |                 ^
./include/net/bluetooth/hci_sync.h:16:35: note: expanded from macro 'hci_req_sync_unlock'
   16 | #define hci_req_sync_unlock(hdev) mutex_unlock(&hdev->req_lock)
      |                                   ^
2 errors generated.
make[4]: *** [scripts/Makefile.build:290: net/bluetooth/mgmt.o] Error 1
make[4]: *** Waiting for unfinished jobs....
make[3]: *** [scripts/Makefile.build:551: net/bluetooth] Error 2
make[2]: *** [scripts/Makefile.build:551: net] Error 2
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/home/runner/work/bluetooth-next/bluetooth-next/src/src/Makefile:2229: .] Error 2
make: *** [Makefile:248: __sub-make] Error 2


https://github.com/bluez/bluetooth-next/pull/922

---
Regards,
Linux Bluetooth


--===============6789915892670762282==--
