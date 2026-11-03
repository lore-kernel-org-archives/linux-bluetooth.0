Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793696177;
	b=Eg90e7btzT2i0OKX6KNkei/8XirVuG5deGksl5eXR43OAeITg/n4LTqR2gFWmQxptX6g
	 ioLbjfbvB/2W8GKKVO6cNkK/HIvfK6cjEfTZNj1tbBtsd0yT5r2Cbp+mT2T+JCxlVbHcG
	 rRLNoamvRVHZTOkxB17zwxfwn2iKjkRUWYJ1abDuXPk7ijyA2q/pJVrJ28Hgpdhhyzm6N
	 AHG72XWwttlzncgg+NVjzZXMNHMksyFWuJd4YBK+8L7dI63uwJq/1wxjK5Z9brc6Ui/A4
	 bbXxnFZLTLdgmki75MdRh5ojRgRcnm85GrD9nh+5chJpWRGxe2SMgBmHkzy7fElv8jg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793696177;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=AAxiZQI/29fQt7SvKlIy0gF9341oiQBXHK/Uxw4b3sE=;
	b=iV8QMKvx6tMV1HH5lfaFucSHhdri4x25O5RwWvNb/61uuRoS15kD606BiUaK/JZgm7Hd
	 KwBuN6OeQSD2x/qQbE1We0yQYvL43aTxqASA9vECi6k7R4dJWNFKv57rw3SaO6LrrQV0E
	 LOYBgHeycRLllc6gv2V252H9SiEId5gTCkX2spBCLYLo3MwIvgTeyoQZWI8ODQ6zhJU1a
	 UsTiPbmkVmNIi+/HwOMjzmd/7Tm/sIA+O/uzywCHfddJhp/TYcUz0nKh9z9nGZ/+2DIbC
	 QyTTQlTb7wdKXb5bidjlqnA51/j8JGoB+XI4pQgsbEkYcf0w1RRRbDt8XsKsAzl+WJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FKFQ2jum;
	arc=none smtp.remote-ip=209.85.210.42
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6FC3606A324
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Nov 2026 08:56:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6FC3606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FKFQ2jum
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-854e904005cso307490a34.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Nov 2026 00:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793696175; x=1794300975; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=AAxiZQI/29fQt7SvKlIy0gF9341oiQBXHK/Uxw4b3sE=;
        b=FKFQ2jumu1EjESKF/gh3b3W9pDYy3ES9KoVOseFxxaca8AvQzuc37ZCNJGNRp6+604
         bA+Yr4Kk5jzZBGUZvtQxmN2DRuKeNPPmtl2Jr0ldb9xOkIPrGF7YU6zZ7YTmXKF8NNnV
         aaWXQRR2i3IdYyHI0gnWkUAWp8AI2g7ND5UwTUiyPfGb3BauEGlRDJtbuscy56Z1W1bK
         bnM2OvWm1g4JU/XzFdPpL4R+BDFto7K7sw09xfeWye1wvUdWVbn0ObiAGmGQs6iZIzB/
         94yEB7J7XCNeTXxOdVIfEWcJYJ+8qB1YKfMBtW0EOOQJoOYfAJtEIYluvu3dBV+ngIe3
         w7ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793696175; x=1794300975;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=AAxiZQI/29fQt7SvKlIy0gF9341oiQBXHK/Uxw4b3sE=;
        b=o3+TxUnGsjGZ1moa6GOi7Gr+VHGhFWybUhkHhD94/zqLF2E/1GqRZyrtkSEhdWs7IH
         Ma9DPWVX120F0VP8rkfgIL89ZmkLdJeykRbx1tWjm/fNsvzk3dwx0dmbOsSnWumGAjiA
         ULNLRk0qXADsWoXNQsihkqcCY+TtA2UH+xa76wdqCikD+qDRJR30ESIwlvdlHEeHzh+k
         eKdqPA5iUUiXdbOzBFZrxDaCZe35kM2CK1vaYorNzfQ6TdVf8vpUe/kJjSnhgXVovp5v
         yb3BjmaIJvIxfFk4RqNzC6HRWW4SzNOgQ9X0pDGkIwxr6IdVSTvzoItGTRvKAy2Jfd+f
         gnLA==
X-Gm-Message-State: APuU4Z+7k3f2RPPUbnVsYGEFteozCxnsLDag76qNEtbxTKPrIEMjHN7Z
	3a4Ydfn5/Fh3/fLC9D7fP+mRPBxvkup58OON0RQRl1FIDQgv2Pb3UJv7pmk7Aw==
X-Gm-Gg: AYBFou3b/EttpmA9+CDilOQC+pAOPHzm8kGE2D0OwCBfDzOGlv4t6/PJ+iDCrcKdvZr
	l7bjt62nAmqNUVMuVPryrsdhQF9pvJHWWw+wWFnkW6PMEJ2xSaA03gfK0hVPGbTixO+kVg9f4F9
	7lAEEmn9ilrqFeXrABT8Fo23JuBK/WLBX25zc0hKJtOiWy/BieEd05u0Z5UXfX5jKVnx2ze2QPK
	GAxQ5WEEMRrDx1dcWQzeCyNHVMXlqKZwZ0GxCy7TNBrEJmawojOMCea1wS5hBocYiLbDgpzzBwY
	oh1/wj8CAeY3pc1dR84sivhp5o58QCeeOdY4OMyPLyFREUyQ/B9tKB4hQhzxmrmMTXu8+M6/jx9
	KFa9SA723Dpegak3rNVUw6SCVNQYLjZpUOzOHjv7B1X8/WreL54bsx2asWliJUo/EJzOA4Y4Fs8
	0Fq9FBZZJB0K06ernhsVWP6lQvj5dC2KJqNAW1CfdIWsYsUGihWysidIz6r9p304rYAcl9F2cUf
	vSNU951CNunlruvB2yrLs8o5X4RXppEJLxsKUv+GbaczRGIXCehpQESt/XiUUOv
X-Received: by 2002:a05:6808:1512:b0:4af:aaca:7be3 with SMTP id 5614622812f47-563ef93c42emr7197539b6e.12.1793696175467;
        Tue, 03 Nov 2026 00:56:15 -0800 (PST)
Received: from [172.17.0.2] ([132.196.80.145])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5640fe37923sm9733771b6e.14.2026.11.03.00.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 00:56:14 -0800 (PST)
Message-ID: <6ae9a1ae.321a4155.69a6a.762d@mx.google.com>
Date: Tue, 03 Nov 2026 00:56:14 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7843592762571355460=="
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
To: linux-bluetooth@vger.kernel.org, kevin@simpleble.org
Subject: RE: Add LE connection parameters to org.bluez.Bearer.LE1
In-Reply-To: <20261103072749.50979-2-kevin@simpleble.org>
References: <20261103072749.50979-2-kevin@simpleble.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7843592762571355460==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1199871/

---Test result---

Test Summary:
CheckPatch                    PASS      2.65 seconds
GitLint                       PASS      1.42 seconds
BuildEll                      PASS      18.70 seconds
BluezMake                     PASS      270.41 seconds
MakeCheck                     PASS      13.99 seconds
MakeDistcheck                 PASS      137.94 seconds
CheckValgrind                 PASS      225.99 seconds
CheckSmatch                   PASS      237.40 seconds
bluezmakeextell               PASS      90.37 seconds
TestFunctional                FAIL      1102.51 seconds
IncrementalBuild              PASS      304.24 seconds
ScanBuild                     PASS      944.67 seconds

Details
##############################
Test: TestFunctional - FAIL
Desc: Run test-functional
Output:
FAIL functional.test_bluetoothctl::test_bluetoothctl_pair_bredr[hosts16-vm2]: pytest_bluezenv.rpc.RemoteError: <pexpect.popen_spawn.PopenSpawn object at 0x7f0ba9926510>
    searcher: searcher_re:
        0: re.compile(b'Changing pairable on succeeded')
    <pexpect.popen_spawn.PopenSpawn object at 0x7f0ba9926510>
    searcher: searcher_re:
        0: re.compile(b'Changing pairable on succeeded')
    Remote traceback:
        Traceback (most recent call last):
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/rpc.py", line 102, in server_stream
            result = method(*msg["a"], **msg["kw"])
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/env.py", line 256, in call_plugin
            return getattr(self.plugins[name], method)(*a, **kw)
                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/host_plugins.py", line 502, in expect
            ret = self.ctl.expect(*a, **kw)
          File "/usr/lib/python3/dist-packages/pexpect/spawnbase.py", line 354, in expect
            return self.expect_list(compiled_pattern_list,
                   ~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^
                    timeout, searchwindowsize, async_)
                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
          File "/usr/lib/python3/dist-packages/pexpect/spawnbase.py", line 383, in expect_list
            return exp.expect_loop(timeout)
                   ~~~~~~~~~~~~~~~^^^^^^^^^
          File "/usr/lib/python3/dist-packages/pexpect/expect.py", line 181, in expect_loop
            return self.timeout(e)
                   ~~~~~~~~~~~~^^^
          File "/usr/lib/python3/dist-packages/pexpect/expect.py", line 144, in timeout
            raise exc
        pexpect.exceptions.TIMEOUT: <pexpect.popen_spawn.PopenSpawn object at 0x7f0ba9926510>
        searcher: searcher_re:
            0: re.compile(b'Changing pairable on succeeded')
        <pexpect.popen_spawn.PopenSpawn object at 0x7f0ba9926510>
        searcher: searcher_re:
            0: re.compile(b'Changing pairable on succeeded')


https://github.com/bluez/bluez/pull/2751

---
Regards,
Linux Bluetooth


--===============7843592762571355460==--
