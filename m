Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793648586;
	b=Am5unkutsJkn8LRPhud5VTCmDYcxxam3IDuSpIn+2kyQz5NRXCBAaLXsiUnZ1V8FqPHL
	 HXk2HWd0HlJicLSemXVnCb3trKZSOlaxG11c85vawiQ6+s0PEbrE95h6eGPxXR1z6n1Lu
	 HjZNLiPRLD6UnyLGtX0Met8JhfhaU8s5xyq9fzkgQ7Up/MWT74qN8N+aR01ip4BrZPOg8
	 QBdLTtzcEwe1c9to7E7Ko7iU+xyz/kDoKfcL6n2wkX+JalJU0Xtqj8Xg168VoSJTZgGZG
	 AOK37UjluYcCko06LEAUHEoo+GQh3d4ZQSV4/P9+W7U+vdzaRv87nHC5nZEcwoGZxWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793648586;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=oPVwGLVKk1jiJg+50uksUlSq2lOcWr0c2GFxHeePTE0=;
	b=XgwQDkElSSp3vrFz+cUtSmCX9NW764QecxEzpCAsgJj3CGVDRbaXyZfZ5Z7J8YQpe4br
	 RIVMykQrl+/TT0dMRJCLc6Nc4iQw4wI83PbxM3GkQSwuJ6pNvOcABOOHAn4PddI7OY9fo
	 LtnvfqoYoML0vrvRdxigv8sUuMrKCF5x7AJfrTz3zsJ2askbz2Bd0ueRCbgD3I5p+e87a
	 OdszA6Jz94Io48snzkXFqaN10AKJKJunk1WJGA5XjObvpsQvW8R7UkRu6kUMv/Zg8J+rQ
	 ZrKPPE1cOPmorqu53kHXk2xlo6k/ED4d9yrmXn4hFAwwC/HDAqRV1sd9dtv8aMTlVgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dCMlmV73;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33F6606A327
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Nov 2026 19:43:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C33F6606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dCMlmV73
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-3282db206d3so5618385eec.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 Nov 2026 11:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793648585; x=1794253385; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=oPVwGLVKk1jiJg+50uksUlSq2lOcWr0c2GFxHeePTE0=;
        b=dCMlmV73ZVr9vyhbUUOW+vN7OqxoNnEQTLHEW3Wwpf07SYa2/yr8X6quNsGEMSj0rx
         15fmw11VSqbYInW75bBJGLVzHi6LueJv2ICoKNSxAQXT+9Eaixp6J0/vTs+VmyNH/iBI
         4IbV4oQY6N6Bcqq3O4WGG37xvtLKKdlTY2dso7kIIvmQ5owdeP6HzyO8DpTfCy9eW00k
         sEEdjzjfQjIwOgSnSBYPIfLHJWUzOw1Em+NcQdpav9jHBIPcqL4CXPNYNDASl8UBrzBd
         NKSjWV1ZDhrIktu/CTb33DpeM9IofDDzKn+YRDlLVYD9Mg3UEz0xB6iDoz/CJEvEHErJ
         VY+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793648585; x=1794253385;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=oPVwGLVKk1jiJg+50uksUlSq2lOcWr0c2GFxHeePTE0=;
        b=M1HtkoPgcBvgwp8Z1h+S1eIl42lPc9IJEblPLPZOzAF/34b//J9/0uayOUeX6BbAW1
         VBew7xoca0Dl+uHrjGl7zndiNYkwDrqQgIOaUBe+9Wu1Py7Qs/oLlIGCi7zpiC7lRcY1
         EboqYeu92WAHrEDSI69xMkWqB1iFaadT7qwXavRzfco5jv+uDgi2JvMfDoaSDnpUE0Qx
         Wt7BjtHYh9kgSfvhYBx3sHj3rIFU/w3yWdErRSVnj8XFe/wKWXYfFL2GBSAfobIpk4cg
         sKyfOSmu4WH6QBkztPwYOICiPWLNBe+HASYKky/Y5gpn3Furwcrf1kzWISdXC3g3bA3H
         VYLw==
X-Gm-Message-State: AFq9FYKYBGKIrh+tN7ZQ7rDRW+Di3K8DyVx1XV8+AIosJ+UDb0p56dIP
	gEyKYBJwhQlEFRjBMRCjl2Hk7QIXgG965YauAhvWw5CLWRsHB7Ad/MRytedLYA==
X-Gm-Gg: AYBFou1l+mxjwDvGfJfey0gfUwi70h6Oz2U0hr/FmpoTn2vzZgEIFVCkgU7gA5h8do8
	ONkUZZDl/CzZf7liQsXgCcZZSoI+3PWPE+mq/j1gTteTVMKEyV9AXoCxKl2Pkyey/AxqplBy0vT
	IqnacnADRH2AIte34j49P2WRFgnx97B7g1OEg6GBt9l1SdReL6Y8A8dauoigFxdgZ4O6e8aSi2o
	akUeWQL5d0wuJOH9A8W4iXdLybAWC/ACOSrF/Ric6VMZIDHlQ1lxG0AQuzAezgyZARXsM/GI+IR
	aYlkUDTVv6q/7FG8G/FBtRlhDs6cJYZmApwtq8bE5J2ipcqUxrrU96G0yfPDec/9d85cKCqLs7i
	C8NTOmUkcxUcW1l/MaoumKP1mbpAT0vPqe1wrNmPcM2rMC6NIWOf2FuuE5q+Z82dvbs4oP0UzQc
	1IEBfUHrVQX1He0FNaXe+KW346QE6qpM0ePnJ2lUPeu0evZEgch8sY8C5otgTPD4EvebG1+TfgR
	bbMhQqSeh0Is7xQy80SPhtdNEkneRi4UoucA05ghsiyhJsq5V1E5Vifd7BbR8VHxA==
X-Received: by 2002:a05:7301:7d1a:b0:343:fb75:a5f2 with SMTP id 5a478bee46e88-36a42340bd5mr16230693eec.9.1793648584825;
        Mon, 02 Nov 2026 11:43:04 -0800 (PST)
Received: from [172.17.0.2] ([172.184.219.157])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42a6f7f9sm46824411eec.25.2026.11.02.11.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 11:43:04 -0800 (PST)
Message-ID: <6ae8e7c8.4b6e150d.23dfc4.72fe@mx.google.com>
Date: Mon, 02 Nov 2026 11:43:04 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2695971739272645294=="
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: Fix linked transports of an ASE not enabled yet
In-Reply-To: <20261102181256.2321329-2-luiz.dentz@gmail.com>
References: <20261102181256.2321329-2-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2695971739272645294==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1199382/

---Test result---

Test Summary:
CheckPatch                    PASS      2.68 seconds
GitLint                       FAIL      1.33 seconds
BuildEll                      PASS      20.72 seconds
BluezMake                     PASS      301.89 seconds
MakeCheck                     PASS      14.36 seconds
MakeDistcheck                 PASS      145.70 seconds
CheckValgrind                 PASS      239.45 seconds
CheckSmatch                   WARNING   299.23 seconds
bluezmakeextell               PASS      98.84 seconds
TestFunctional                FAIL      1162.90 seconds
IncrementalBuild              PASS      347.69 seconds
ScanBuild                     PASS      1155.95 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v1,5/6] transport: Don't set linked transports pending before they are enabled

1: T1 Title exceeds max length (85>80): "[BlueZ,v1,5/6] transport: Don't set linked transports pending before they are enabled"
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/shared/bap.c:309:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:309:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:309:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structures
##############################
Test: TestFunctional - FAIL
Desc: Run test-functional
Output:
FAIL functional.test_bap::test_bap_unicast_desync[hosts6-vm2]: failed on setup with "NameError: name 'CONFIGURED' is not defined"
FAIL functional.test_bap::test_bap_unicast_duplex_enable_one[hosts6-vm2]: failed on setup with "NameError: name 'CONFIGURED' is not defined"


https://github.com/bluez/bluez/pull/2748

---
Regards,
Linux Bluetooth


--===============2695971739272645294==--
