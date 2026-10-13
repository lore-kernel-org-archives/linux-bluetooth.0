Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC36279DCC
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 05:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791867823; cv=none; b=I/blW33xMtS0l5VfOWaJAUXYoJf3MGJs+UpEHSgemvkG1jJHdl+ygOCNRjMggb7H9l6yK/udIuH6sed5gg01o65yyyDV2Ibg0sg6gBp0lT6wfzqDmgbE9uPKNqoDifJuKr4uKgrHYpDvIkacmqTdloPFhXxeVkckSTXjhi3NzDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791867823; c=relaxed/simple;
	bh=umNMkQa9d3RkFNDXXomu3qPNDTJDmchU8mEBsuPtb9A=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=pYycYgEqU+LSL4dksmU03sUuAz2di/NLr8sB+NkwBFxH43yutI1GFw59Dlhayapr+MwwxM6ENtg8oBRhqsP/6Sl2qp0PHTQ7xbz7PFQVufz2nTv1xz2lU/7GTx5YIMVwn+hAnZov323OObONITU3ltm8JWmL4kwMp/EWLJWvAVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oHyPeuzE; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oHyPeuzE"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-4a69499cefaso761212fac.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Oct 2026 22:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791867821; x=1792472621; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=RMRwh1tI20DqxK3nbOQkU2k/9V8HMTIpEpBqn4FE3zU=;
        b=oHyPeuzEbsIBaRYYCvC+VB7VhSu1dpb1VVUb0vqP2b5N3/Xsj4MfDJaBLut4nCZGZk
         71WnJFRe2Ds3TgAOcBwE8524AT13HyDpdNZV8jwSImTzXdel93QSmRalK+6zE+Z43Fo0
         IA6g3UCXVx4lMu+1uQMkwv5rD9kjPAgmYnsPzNkq9rUfblDj5HJ13lG5GVNchrae24qK
         8/YKCm4EPGqTHRvB5sEHkW09MyEZtCwdt0tqWLC97Rln7XruvRLbpU2Ub3JedMDP2/D1
         XSc6maz9xQc7B1n8SSuNrwtFfEPAD9X06Fr1HWjzvBiKs+dEd4vSnjlkD7HZ4Sj8JfhG
         4y7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791867821; x=1792472621;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=RMRwh1tI20DqxK3nbOQkU2k/9V8HMTIpEpBqn4FE3zU=;
        b=GZVRxu3g5S++Svyh1CglbwIlU499TPS96SFwdsF3yvraa04AeMlpnPEG4Wgftu6Glv
         0+W0Mr0wbsgRESBihF4rwJmoWsXPvs8BvtZ7cVTf9bNALz+2u3tRBBjY5rxeE9bmQq5m
         2fgrKj9hvJfpB/KZaLBqcplC/sTD43sIclAg6eBKLPnXgg90E5cYYixPYLH4FWQenKIW
         EKW9Q1dbuMI2L6hWLBXufh32wga2y4ortCLrxRHDO/zZ/PCDrZcXHnVQQwfL/9AdkJ9y
         RZXRfOx86ikh1HSxm6tTLQZIcvBISbji9DDXnk4rr20QP5IJe4x38j+rjjyTSO0D4sEY
         eLAg==
X-Gm-Message-State: AFq9FYKmEZjxUJ6exY/gYg+77HDjbEZwdoUOLrgO9yTE6H6D3yTaL/Jo
	IrbUxNKtvYSv5PmFoQWN+UtiSElJ56vOw0lAg1E3o7p866dtOkcfLToOJTSfpQ==
X-Gm-Gg: AYBFou3lHEOiDRhvHEzYO+Q9LN/23boLFvZY607AZZyR2sHG9dfpOt9B0/z/RVS+8Yc
	3pfH1tNPRUyZ10S3BPoJrBTT7L3M0++iMNhcpr3PK87BiBndHL44sGDvokZYdSMseKc0XLpdlcV
	M+pOY8QuAtHIXtqRE/JZR2oh1RcTE8D6khYJw1oLVztiU+ZNLIsKQmTB71Q8KcPMdEfb2JxGUoS
	E1joorlhxgG/sDNGTqzm/VHBOykdSlj7MqPjmCFHmk6eLtSQNCCEn94+Rg9nlK+dEGN9pLxxHG/
	E7M/sNghA0GISshELAL5Eicn5sGI920JELbjVyscbHnMiiJzlt+4QFDDTU/Yy659I9rFuzmnHcl
	e8KSfPvqQx88J28c1w1kWonNZcroko9Di/95OJAJvHy4AODuaSR4vsPSTMBRjI9J9w4AVJjLJ1+
	7m240NVJBwhNwXj5PxB4hscx6bxXeGQwP5mWNQXqk8SJfBYKl49Z+0jlUUTARCVvGfsn2Gv3cCX
	jGlyvc=
X-Received: by 2002:a05:6870:d624:b0:48f:e0f6:bd4d with SMTP id 586e51a60fabf-4a2a4b061f8mr7628648fac.34.1791867820971;
        Mon, 12 Oct 2026 22:03:40 -0700 (PDT)
Received: from [172.17.0.2] ([52.173.178.209])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a6972b4658sm5237373fac.1.2026.10.12.22.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 22:03:40 -0700 (PDT)
Message-ID: <6acdbbac.a8122b97.18c10f.fb67@mx.google.com>
Date: Mon, 12 Oct 2026 22:03:40 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7627868625839565775=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, cochcoder@proton.me
Subject: RE: shared/asha: prime volume before starting audio
In-Reply-To: <20261013034613.516771-1-cochcoder@proton.me>
References: <20261013034613.516771-1-cochcoder@proton.me>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7627868625839565775==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1184354/

---Test result---

Test Summary:
CheckPatch                    PASS      0.47 seconds
GitLint                       PASS      0.27 seconds
BuildEll                      PASS      19.44 seconds
BluezMake                     PASS      291.44 seconds
MakeCheck                     PASS      14.18 seconds
MakeDistcheck                 PASS      145.25 seconds
CheckValgrind                 PASS      231.58 seconds
CheckSmatch                   PASS      290.49 seconds
bluezmakeextell               PASS      93.58 seconds
TestFunctional                FAIL      1198.04 seconds
IncrementalBuild              PASS      293.18 seconds
ScanBuild                     PASS      1131.33 seconds

Details
##############################
Test: TestFunctional - FAIL
Desc: Run test-functional
Output:
FAIL functional.test_bluetoothctl::test_bluetoothctl_pair_bredr[hosts15-vm2]: pytest_bluezenv.rpc.RemoteError: <pexpect.popen_spawn.PopenSpawn object at 0x7f9674e9e510>
    searcher: searcher_re:
        0: re.compile(b'Changing pairable on succeeded')
    <pexpect.popen_spawn.PopenSpawn object at 0x7f9674e9e510>
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
        pexpect.exceptions.TIMEOUT: <pexpect.popen_spawn.PopenSpawn object at 0x7f9674e9e510>
        searcher: searcher_re:
            0: re.compile(b'Changing pairable on succeeded')
        <pexpect.popen_spawn.PopenSpawn object at 0x7f9674e9e510>
        searcher: searcher_re:
            0: re.compile(b'Changing pairable on succeeded')
FAIL functional.test_hog::test_hog[sci-hosts18-vm2]: pytest_bluezenv.rpc.RemoteTimeoutError: Connection recv timed out


https://github.com/bluez/bluez/pull/2665

---
Regards,
Linux Bluetooth


--===============7627868625839565775==--
