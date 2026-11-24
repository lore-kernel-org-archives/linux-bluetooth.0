Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795520288;
	b=CHV7VY+QS+UAvaxycJPQ+unZRJbO6kzrXYeY3lYGOCH+A4VEz7En+JXEcSOvy629KoO7
	 EgOMPokTdYzYmTXgSfphwHY9Ahchz8vwLOYvZsNynlWmJ0oTw2tmL8s+sjWix6recw+1l
	 BbJTy3AIKMpO3oBQ43zWI5M5/iyXXDPftBGy7nhkdG6rSsN56GMv3sFK/b4LuzAKLy5nT
	 D8BLVEVIbtcNwhWzJ7kaINeGp4a1jlLf026RAsMchpDdAEEcZ8cPiPl+/FsVZg1tf2791
	 /y8x1bfzy/839plaZeV/vqC50hxcc129JE87FFXG+zYZGAjdd87+B7XCN+noxvv4LSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795520288;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=qKWxCZhrg8AEQTeYG7TEp5rnRMMmftgvUYp0sz1lK0k=;
	b=E+Im46hslOrOKlp9EpVl2A06A7ZljrXEgPy7sZ0rfzIzG4zuY4jJR3r4HLKHC2+Hdja5
	 2OQw2Osd7VpPGMWdlVpwjUfRAgdNfe9pbHsZLoEjy+dfX2/T6a3tDMGF9v8zJ6ucKRSim
	 RHSEvrb6A0rl0vDK25aZEqQMZ3LJ9iHeIY7odmnFpGZ+oxGfV80BIKP3TugvTvo+1NDkv
	 MXkbnJZAtVUmsryONlMqz85LSkU6Nmp3jygc4dKvWqzugbcW6/nO6fysWSOgkya1mzCs5
	 CNRdGQpdl9dYjIKBoFpXX6NvCwV/Lm0df0KIVi47riDvlafoGho1YrgEgEPTGEa8E/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Z8q3Q9N/";
	arc=none smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE912606A681
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 11:38:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE912606A681
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Z8q3Q9N/
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-15ea896ddc8so7351050c88.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 03:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795520287; x=1796125087; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=qKWxCZhrg8AEQTeYG7TEp5rnRMMmftgvUYp0sz1lK0k=;
        b=Z8q3Q9N/QO/WfibXNaEXK+EKZKqQ44d8se6erQON9k0FTn8UNZ0wIpGvIMk40/j8LW
         icE1eAnFDzFy73ZfDGWpq3uj3l2yiPb7WbVmzdxQpxnBpEcYzVeJ+fjzDWwTRK80Y2bf
         X4mTAZWOE6jYBIOsZejOKnRmZUZH7eNLkvz/zSAc1qLfBt8Ohn0d9CujN8Jn/jVr5HQq
         VZnWhK9iUJOfQMVs9vl+lHIu7xF8r8ns2xXkcBo75QM7pfI/JjNM1JX71xB+UtiHfgiR
         32vz494VNaMc0hC4t/5dvUglzeQ/f1X6I3GQaM4sNjCRtzM+En8+oTWce9AX+xOzvNHC
         5/NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795520287; x=1796125087;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qKWxCZhrg8AEQTeYG7TEp5rnRMMmftgvUYp0sz1lK0k=;
        b=ejqg0Q2/EgEwvmOJk12fGG3wgusy+Uh1HgLmmPdkPBTre9bUGf9sPDHYk8tYxn/B0E
         zhlNaKOxTgzucTuFaVqAxYk5cEJnrJoPyH+BYFQ9t/h3/LGLT0qX5uAyKo0wtatQ1xFn
         FMl5G8SknXtT9Txgh2NGMu3jNjNFBYlgzNzjjJpjyeuYhGMF2xocgf3VbokJ8mnlHIyn
         83E6jQrMa/DBUMCra+tilK1tHPt6BaLIkrXaEWyCy8vlHcq+iD0DTeQosSDkyLomzukq
         NJElDmXrx3wrmBPdbK0lO8NjFrQH6RgTW31PEW2JFy6L7xX5idC0AgWtldRKWEUCLTNE
         gwiw==
X-Gm-Message-State: APuU4Z8ANs+x6ztvLfbDCGEgatnWqHYIvwBGrJP+5+LlIdDGhmZ9pILx
	HjMK0Ec7GT8tUzRiCV4aQdSFeYTh38V13Uij/zpDJmIsYKB+jKwJA86PQUC3Og==
X-Gm-Gg: AZFdTZc2AZJaviZcINDhEi0asiqlgTERlPJnP3QLm4CVHD3X/fb8DORa7vwoxR94XQD
	yJku/I12fUbnWJpkAbAz+lhB3nGqxkfkDwx2umMRMdELWqANy5qIB7cELIPKK26hOmfCTmYTBsH
	phVWc96FaJJySOKnuY6I1bFJmu7bDPEl2ZOhq5Lq8XOqN76gOoIjYm+PdJ0TNOfBdrazoMXHKwX
	Ug5n4F6YR/g/ZATYrGMZ0ED4HVhXAs7bGVQKvTMuDGpDrSpLgfqmVOarVbCa/WHVyKea5gQcFj6
	LT08E0O6ckTBeKdMDH54DJCBId9+jcrlstIuzp9RBWKQ6FweJuJYDoEHHN8UTJ2XTkW9StKhO6M
	zvVEM4ttWsj7x+2GlcCDMLrC0z7xkR7X2gtMpSeqp96CDRuHy/eSI9dreUs5YmI/bwJOSrlGqbb
	c7Y5WgB2vdiJ529LOeFLEKXOrXDIDOAaxfw0FfhXc63yd5MAo35slygkkzH3KaV0CBRkmm8oUSV
	jLpNUUPtJlf2dE3ppZ3Ec0EUgIHbmegMmg3IWLEK/Tuji1xBO77BgFE27n0/Dw=
X-Received: by 2002:a05:7022:2218:b0:19a:20d3:a3d6 with SMTP id a92af1059eb24-1b57da14988mr3172450c88.1.1795520286710;
        Tue, 24 Nov 2026 03:38:06 -0800 (PST)
Received: from [172.17.0.2] ([68.220.61.210])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b56ef9fd16sm22941668c88.4.2026.11.24.03.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 03:38:06 -0800 (PST)
Message-ID: <6b05771e.a99d0424.24609b.d177@mx.google.com>
Date: Tue, 24 Nov 2026 03:38:06 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4453538387289910190=="
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
To: linux-bluetooth@vger.kernel.org, cochcoder@proton.me
Subject: RE: [RFC,BlueZ,v3] l2cap-tester: Check compatible interval preferences
In-Reply-To: <ee66ad17c264d1db6b42eb97d359f134817c6750.1795497229.git.cochcoder@proton.me>
References: <ee66ad17c264d1db6b42eb97d359f134817c6750.1795497229.git.cochcoder@proton.me>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4453538387289910190==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1220372/

---Test result---

Test Summary:
CheckPatch                    FAIL      0.48 seconds
GitLint                       PASS      0.22 seconds
BuildEll                      PASS      21.26 seconds
BluezMake                     PASS      310.82 seconds
CheckSmatch                   PASS      321.02 seconds
bluezmakeextell               PASS      101.39 seconds
TestFunctional                PASS      1264.25 seconds
IncrementalBuild              PASS      318.48 seconds
ScanBuild                     PASS      1211.34 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[RFC,BlueZ,v3] l2cap-tester: Check compatible interval preferences
WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#217: FILE: tools/l2cap-tester.c:4503:
+			get_le16(&cp->min_interval), get_le16(&cp->max_interval),

WARNING:LONG_LINE: line length of 82 exceeds 80 columns
#353: FILE: tools/l2cap-tester.c:4643:
+	test_l2cap_le("L2CAP Interval - Local range contained", &interval_data[6],

WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#355: FILE: tools/l2cap-tester.c:4645:
+	test_l2cap_le("L2CAP Interval - Peer range contained", &interval_data[7],

/home/runner/work/bluez/bluez/src/patch/15015318.patch total: 0 errors, 3 warnings, 235 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluez/bluez/src/patch/15015318.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




https://github.com/bluez/bluez/pull/2892

---
Regards,
Linux Bluetooth


--===============4453538387289910190==--
