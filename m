Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793092022;
	b=WFcCNMdgvNu4BFE1lqfjLRG5kUjEd+wnuXwmFReULMSDaFg92Fi1c+mV7HCHZpIS8njD
	 in24BCsIxb4OCTmzhFFntbPwPBkQ+BeuUg4ybmmk+6C91Sihj8PL5SUjwmRr6DastI5Z1
	 DHKblmFc+acQl50CcCv2J7kFc6AcSnYesJpEomTe7Qs2LPIsDaLBxYI6lpL59NFHOQ/FV
	 vSQep/Y4oTmR+fMGysd6uON7Ost3NflDlIWeTR0gdPf/PUMC9V01o26y4EekCi2e+NJrN
	 6WMFeeJNGMI5cLgNt/J+bSVUe0Dt8Cwdqc15a72Mu0apJux9vvqTZxbh+d3k9rYdGMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793092022;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=e9uLmX2zxjN6cLjxPVbANpzjxtBV1enkmm65swDfU/g=;
	b=fPlt6bwSbhbvQCbxKQHzeSMKXWpYugj26LXVl+D2Arky3MB/JFlt4LR3/wS0oXFM0Eym
	 T8OTai1v4kBFWmoR3VM+vikQNSAl7u9rDkN0a1W9KLVXlXSpm8cTbYqTtnNGnOh8z5vQ1
	 Uxgyxl6S3/T7iLedUOJCJVs/5bHRkEc75wA10XAlT84j+Utgh117Rs4Y8rPr2cLn4wWDZ
	 9aovn4ePbOBHrIBgE8QX5QxpjtsqXY7X2GtXIptfyjukYN3hg2oFqXNKONVkItHZVNOin
	 qf4RM6SqIf4mq2qH8y2Rj4HhywdJ/Qpq5EfOQAF++G9DDgCuZTHTkpIKElrj5Lk3Q0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=AeqTo8xs;
	arc=none smtp.remote-ip=209.85.160.169
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFA4606A31A
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Oct 2026 09:07:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3BFA4606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=AeqTo8xs
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-5365d725440so33245401cf.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Oct 2026 02:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793092021; x=1793696821; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=e9uLmX2zxjN6cLjxPVbANpzjxtBV1enkmm65swDfU/g=;
        b=AeqTo8xsnu6eof8HcxOh46mFslhIDMNFZ/DN+mWlYDFaP0jE9wJ1+9E5yDL91zTN9A
         Bzl685jvbZgK/IeKQ3L53i5lRA2vG+BEMH2ale103C3RhCc6K5Q0aKyY4/76rZPWaeFU
         rUY+QTRjQ9l7uVQbeoaG1AiIIA3TUVdrjxFGmQpItqIIOJMfiw3umtq1i58hUTliEUSN
         LE2yfXJEmIHO9e1GTF/mTQz1VQu6qj60zZhzHuk6DAk1pehQIOBapDRJ4/72Su9IWGmJ
         aYwBwQfH8j8nKbkdSHZGmFLtGmai+h8JEwe2oQ4znSIEAR5tL/XolqNC2lwuAhTCRzSH
         aKlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793092021; x=1793696821;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=e9uLmX2zxjN6cLjxPVbANpzjxtBV1enkmm65swDfU/g=;
        b=LDyduWeFWpCiK+YachgXWtCPyW7uUm8jjF53THB+T87dCzmB1CZ3Ext1+HTyQ30gYQ
         UwSuaLmsZs/1MVqb6n7QbBJMI5krquj2n+gWnyliMvlvvvxLXrEzRgCnUFFUO8qILMWu
         4AsUKQN+xskohI4yf8gYm1atEXYj32D//lGXrC/ABgFYe/tqABQPgb+CKn6vuTQ4CzFH
         9FiIxyyiBgDfsp3RDFTLO8jL0Tpi90NtuZP1RxgL99dIGj54pd8Dj9WPHHOQH2nYBzPI
         CydBtWbRxU78t2uDUspwT+lZZDQyeU4US9ouKBrITi2XOrbU2DcmBiOsrfMwoN3wmxnK
         dP3Q==
X-Gm-Message-State: AFq9FYJYfFMFdWxHBOZpkTVrOpLkQBja99cDaIXdf81kImjfIT5t2Yq5
	7VCsWf6j5IF54DQOrh301GeGps/JcLrSKpgeNnXzI39MNdUpz36MXlFLX35L0A==
X-Gm-Gg: AYBFou2MTjCVyA5jez5fh9XssExuqdDp3t6+j8oBEBZ7/w3jT8tUXOwW31vIGE+Mz1E
	0yVcra9PxlX9u7pXIhh2XY95xaQ+R8v3exASIIiO5iIO6rbslHkpXQG36mE/LbwHsr2CAyjqFQX
	pNOeQ1aEfBFl6Lvra6U6gSF+Kn5bwZ8SZr+0TYkqBp+YreMAW8dhPvTQPD7ndlK1vRiEbr+CZCX
	P24jVzTPzcyfElnaObXAV8P58402Z2LzoxSbvcWfz+tGVsaH2mw0N4kFj7QJZrj+rrQPjMiAUKG
	e0hnVIKe4ZMrqKso9KsAD4hwgRMyltA2o4es6p/gDxlZbO7hTcW2h53FSYS0BfKrgTrGcb74SWf
	29ihJdfs2dmC9OAx/GNUVrftv0VRlqsvefslmsSBCm5VRxv/Q6iRD/TF8QK1s6KyS2ilP8XeFr+
	rCuGt7XGa61CA6Ew9p1xrkTITh7WS5hxKd5Z+Ky59KbJOCODXkKa3Wz2PjTlWQ2e5UW9Mc23KBd
	IzVovQTIIDAjZdEtN16lh9z+BUh06oExOKiWNTZFLwzkATnfnUrS//DHoADh0U=
X-Received: by 2002:a05:622a:a88a:b0:535:a5fb:67fb with SMTP id d75a77b69052e-5383b76c5d4mr151856861cf.71.1793092021062;
        Tue, 27 Oct 2026 02:07:01 -0700 (PDT)
Received: from [172.17.0.2] ([20.106.231.70])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-538397405e1sm73615501cf.25.2026.10.27.02.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 02:07:00 -0700 (PDT)
Message-ID: <6ae069b4.eb3ee9d5.acd82.0415@mx.google.com>
Date: Tue, 27 Oct 2026 02:07:00 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7170355118959533970=="
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
To: linux-bluetooth@vger.kernel.org, contact@capsize.online
Subject: RE: monitor: validate Return Link Keys length before parsing
In-Reply-To: <20261027032821.1088858-1-contact@capsize.online>
References: <20261027032821.1088858-1-contact@capsize.online>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7170355118959533970==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1194227/

---Test result---

Test Summary:
CheckPatch                    PASS      1.20 seconds
GitLint                       PASS      0.35 seconds
BuildEll                      PASS      19.54 seconds
BluezMake                     PASS      299.81 seconds
MakeCheck                     PASS      0.89 seconds
MakeDistcheck                 PASS      141.88 seconds
CheckValgrind                 PASS      145.09 seconds
CheckSmatch                   WARNING   291.45 seconds
bluezmakeextell               PASS      93.44 seconds
TestFunctional                FAIL      1147.42 seconds
IncrementalBuild              PASS      302.65 seconds
ScanBuild                     PASS      1160.84 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
monitor/packet.c:2289:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:3925:52: warning: array of flexible structuresmonitor/bt.h:3913:40: warning: array of flexible structures
##############################
Test: TestFunctional - FAIL
Desc: Run test-functional
Output:
FAIL functional.test_bluetoothctl::test_bluetoothctl_pair_bredr[hosts15-vm2]: pytest_bluezenv.rpc.RemoteError: <pexpect.popen_spawn.PopenSpawn object at 0x7f363325a510>
    searcher: searcher_re:
        0: re.compile(b'Changing pairable on succeeded')
    <pexpect.popen_spawn.PopenSpawn object at 0x7f363325a510>
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
        pexpect.exceptions.TIMEOUT: <pexpect.popen_spawn.PopenSpawn object at 0x7f363325a510>
        searcher: searcher_re:
            0: re.compile(b'Changing pairable on succeeded')
        <pexpect.popen_spawn.PopenSpawn object at 0x7f363325a510>
        searcher: searcher_re:
            0: re.compile(b'Changing pairable on succeeded')


https://github.com/bluez/bluez/pull/2717

---
Regards,
Linux Bluetooth


--===============7170355118959533970==--
