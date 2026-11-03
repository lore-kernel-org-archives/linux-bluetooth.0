Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793745737;
	b=QvzdP8D0htwbgP2fpKRavH4L6oyv+EFSGQrBJADPvD4o72WcckEhF03VzxXCysry9HYy
	 fmputLo32bcB8oDvZpiMEThIpl0h0VCShTZmwKwANo/UU5aibuWMTyPzgUplG7XLzrR8y
	 U4H6acaNC9mRuLzwnVgtcsy9PWUvTPB4ThEaKgZ/NY2xVZ5fRxw3FkB4OmstKPqTU6v28
	 KCwkq+Un8vsydULrnVYplZjMo9pv2nWN9SQOb4W5sVvS5N5x9RECP6NuoPpkXFL4q3ZrW
	 s/HUZmQkrzzxcFEPYFolfzm1rYlag3wLQ8s02nhCUMLWNIRN/VGKrcDDRmwdL0LqPFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793745737;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=PkcleQN6hapmiSkDpujgfDAmMMICwPjUZUIO9gjFQPs=;
	b=yTs0/aHbk/lV6Re2HyRJR7ZZObk6FZu0CkJAFpYTpHitBSzBidCXuHzCvD7cCdiynJ5p
	 2gABLfcBFRdu3EOB05datmhnVuF4/uIJdX23GjNUHMmJ/XfPurBsauT3WN5VTpT43Gvmr
	 snA+ibrnYBW8VGa1rqJz7zeiR2GNHQ0nKnyNxOxgFUOfKuP2fKso7+IAl878B6cocp3qe
	 J/UTT+YxdzqQX8oSeutA++KiQwQ+BiT0Bq/yjWQOcFi1HFbxmdFR0/21lqREPKiBFBZw7
	 /GLhh3NajW7YiozNFfQPqSH/Mlj8mv8CGdvL3hD9uvqc7OnGOcSP5q5thkR26Cq7iGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cBp31GFn;
	arc=none smtp.remote-ip=209.85.128.171
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D4D606A330
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Nov 2026 22:42:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35D4D606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cBp31GFn
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-8b0d63f60bcso1343577b3.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Nov 2026 14:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793745736; x=1794350536; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=PkcleQN6hapmiSkDpujgfDAmMMICwPjUZUIO9gjFQPs=;
        b=cBp31GFnDWzgOYnQ1FQ9AddNzFafc00v+Bh5dfcqRSXp9J7bCScJ6bSesAkdMWajIF
         VJJxlU2bnNpJj1LYRvAou988EQdqxcRIadQ59otg9+97r7yDFVIxi5aGGRJuJjc3AinD
         yb19bWq300pUu3Q/LHSynXFGyCnPyta98VOz1AD/SoapCp+sblw1W1ELODlQkpcxXRit
         mBScpjFtU5P6MWHYamGUn5kFt64qdRgNvr8Qc+ClGO2sihWTLLxnRyMqzphqyexzp6B+
         0fMOtgibi/b7A1sWBCm3UKpmx+ePRX3kC/Rb0dnAMa/lIiouOJpXqeX3e+nFj6V4Rl6a
         RfuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793745736; x=1794350536;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PkcleQN6hapmiSkDpujgfDAmMMICwPjUZUIO9gjFQPs=;
        b=ZUv7q6N7w0aZwk6SZjekoZd9bCkflObY0BmVlt+BeDS9t/zGtBnJ6u9fLBZzCyL5iY
         jgG9iqzLSlLMvVVSUakC3T05m26yjyI5kQ4C8C1McUKovay4U5CyaSp1aXh7iSyOWdz4
         sS8KCl9ebhbLrhVsK1OtH/AJv35z2yqtllF/ZW3i3gNuvAgPbYxVC3jnDC349wU7jiPc
         dBl/2PzW/BUHqidb32QCzvLgMB0jtWwLeW78hHtVYiM2MygOMZpcsJyX3BZnga9CQyD/
         WWyogushi+iTw86lrdJgYny8QemvylLGKqacOSleUuAERORxP7O5JI4/6PUqLkIQ2RpB
         yigw==
X-Gm-Message-State: APuU4Z+NYGXFMsscs+LBp4m4BCV2LMYjo3QelawLcOSZek7KkvlJxd1p
	qtZnAkd9xf150Bd9EXQoHwEhxCI8V1Z8RSbldg1rJpPNQre4w5RtbVKtXmVsQo+G
X-Gm-Gg: AYBFou2/wWNO9ciJMOTAEDygo5UXDNUXKt0+IPipMwOJxdNPEvU0kOODDAw5Bqnd1G3
	z4Zj7Hh2UKDskzaGK5RZP0ON0qF26/YmP7gP9l2TPxmz4wvLdux88aOsFrLjj580NANUc4T6AJj
	rSHtcmdL+FBMHk+VGG6j7xN1m8pcondieHtHul0HeMK1Sskpf8xQYQwE3aFvYqiGtAYgcHHrGNP
	D4NGk6owwhmKXPHGCGSOHKjTNxffszSSVpDFm/ejTJia3DAlHVx5U5iFMxYbNb+ef+0ArGeFR3I
	0T0UubMz4/GE6dS/VUbvnZxWOvnQfeaTKUwibIE9SU43m++08yeFnf00+E/ZF1zAGbJjF9zUVT9
	tzRDVgxgIYahUOrPNKf9TeZ+2F3njhdvRfZs8d7Jxyiw+hX0rTA2b6CYm07TbfeWK3ZfDNw/cOS
	zKRBG8Dy+g1q2j8a3wNijtrUngeYZfO1hz0NtnQi36Ls4CrJi6LY6cl2e/DqbMuN/pnzAx35tQM
	BmtFw9cvVZPlE0zYHveLfy08H+ZBfmUi3mk0TBWQT3pRH7zfUPH1hK9/4JWhe0=
X-Received: by 2002:a05:690c:c4e1:b0:8b3:5d3:4ef5 with SMTP id 00721157ae682-8b305d38c77mr10904547b3.54.1793745736088;
        Tue, 03 Nov 2026 14:42:16 -0800 (PST)
Received: from [172.17.0.2] ([134.138.41.56])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b309979323sm6597107b3.28.2026.11.03.14.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 14:42:15 -0800 (PST)
Message-ID: <6aea6347.04236805.205a58.6cd1@mx.google.com>
Date: Tue, 03 Nov 2026 14:42:15 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3802307267174421018=="
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
Subject: RE: Make Notify Multiple timeout configurable
In-Reply-To: <20261103203034.3904499-2-luiz.dentz@gmail.com>
References: <20261103203034.3904499-2-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3802307267174421018==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1200849/

---Test result---

Test Summary:
CheckPatch                    PASS      9.64 seconds
GitLint                       PASS      1.92 seconds
BuildEll                      PASS      19.09 seconds
BluezMake                     PASS      286.88 seconds
MakeCheck                     PASS      14.47 seconds
MakeDistcheck                 PASS      146.61 seconds
CheckValgrind                 PASS      242.67 seconds
CheckSmatch                   WARNING   274.74 seconds
bluezmakeextell               PASS      95.48 seconds
TestFunctional                FAIL      1217.49 seconds
IncrementalBuild              PASS      409.32 seconds
ScanBuild                     PASS      1061.38 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/main.c: note: in included file (through src/device.h):
##############################
Test: TestFunctional - FAIL
Desc: Run test-functional
Output:
FAIL functional.test_bap::test_bap_unicast_transport_resume[0-hosts4-vm2]: pytest_bluezenv.rpc.RemoteError: ('Acquire', [('/org/bluez/hci0/dev_00_AA_01_01_00_42/pac_sink0/fd1', 'org.bluez.Error.Failed: Input/output error'), ('/org/bluez/hci0/dev_00_AA_01_01_00_42/pac_sink0/fd0', 'org.freedesktop.DBus.Error.NoReply: Did not receive a reply. Possible causes include: the remote application did not send a reply, the message bus security policy blocked the reply, the reply timeout expired, or the network connection was broken.')])
    Remote traceback:
        Traceback (most recent call last):
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/rpc.py", line 102, in server_stream
            result = method(*msg["a"], **msg["kw"])
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/env.py", line 256, in call_plugin
            return getattr(self.plugins[name], method)(*a, **kw)
                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^
          File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv/../pytest_bluezenv/host_plugins.py", line 108, in __call__
            return func(*a, **kw)
          File "/home/runner/work/bluez/bluez/src/src/test/functional/test_bap.py", line 406, in resume_transports
            operation("Acquire")
            ~~~~~~~~~^^^^^^^^^^^
          File "/home/runner/work/bluez/bluez/src/src/test/functional/test_bap.py", line 377, in operation
            assert not errors, (method, errors)
                   ^^^^^^^^^^
        AssertionError: ('Acquire', [('/org/bluez/hci0/dev_00_AA_01_01_00_42/pac_sink0/fd1', 'org.bluez.Error.Failed: Input/output error'), ('/org/bluez/hci0/dev_00_AA_01_01_00_42/pac_sink0/fd0', 'org.freedesktop.DBus.Error.NoReply: Did not receive a reply. Possible causes include: the remote application did not send a reply, the message bus security policy blocked the reply, the reply timeout expired, or the network connection was broken.')])


https://github.com/bluez/bluez/pull/2755

---
Regards,
Linux Bluetooth


--===============3802307267174421018==--
