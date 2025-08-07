Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DF579CF
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 Aug 2025 17:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754586949; cv=none; b=PKNYZ6jYyGece1nFTqMm4n+tXKv0R/au8o7j8VVOAN8WUCGNeiieyaVlcnpxu0DLyH8qjPSm9rQNyColmn8iYs5zOlWME+naGouATShJY2HYWtZmcfc5mhg9pCtRPi0eiZBa5rrpi5xyU6syjBiz6436hnSAzp//w8NcNJoLC5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754586949; c=relaxed/simple;
	bh=8SXiPu3EshjLSssMnm8+PD181PZIM9JygVFeqgmSQic=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=MbHOc7EOk5vRg/lW8KuSRpg6iFSfwvswRm9gRp2ddTuN+fbYxZom/6xyY6VEEpthCPzYlB6RqkFWLAN7EdIKqWXSjTPywc3HgShKcIgrtLJr7Sj6j19JJ7r64RqQvJ0AzknZnaL8ZeSEyiTwZSNFzve8hGMQMy1PmwvM9DoYMWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hcJPXkWu; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hcJPXkWu"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-31f255eb191so1345266a91.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 07 Aug 2025 10:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754586947; x=1755191747; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/YYnMW6dI9soT4sitBl6sz8E5+pXOnPr8uFqY/kEZok=;
        b=hcJPXkWupywXoccd4Ff0SToRgWpd2uH4eYC/Y8d6vefFfdimoyXgrcSZ0heE43XK2Q
         W5MsynfqUWqycnZMQQ8Pl8aLS4c367Its9gBp4Cgk1ts4O2iRw3XRxDWdl5zEcBpGcjS
         u9BIrLcd6BSN5PitmTFssSDv8UFEOTCbr2mjzv4SCG6M6RJLRJpXoUdgqAxyBJq7WAnZ
         zwxiyNBDqUveZH8ncbeT7LVH2oQ2x7RjXnDzjUG0+Q2iOM34UdFUh81QM/+A5EBgsctN
         aiwH0eeWDPJT7coFP+KaDAIS7rYF6xOo1++uX4fehEdRB94RivY2CxOm8HSSf5LXjcYj
         eStg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754586947; x=1755191747;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/YYnMW6dI9soT4sitBl6sz8E5+pXOnPr8uFqY/kEZok=;
        b=DrJXNlwp2yMDVOzThOTKwPjlDxY2Zf9laSQOZrev/6E7v+AIMXOx3VW1gr4kw14a/T
         vO8XKovih95YwLq+Vd9QN0315c6+pxi9sSEDC8XTSC9RhJ60PkCDdK3S24VpNmNX44LO
         HoEDYKCTo4BT3UFjaTuEPoiE3G88cjD5lNQEjjnZfZ5M+nmJT+3BcAPSoifkp75OsMh4
         StjWs6nTe+1VRkUItb+XIrrtmB+YMK57pxa/GeS+4IQXQI3QJ5/FNj4zs+AEf83bxmgt
         r3QQnMC0veJJuCISlitz7Up5fVImnefKvAqP25JKP6FExe3C8xP7SF53AluEzw2FfK+P
         1D6g==
X-Gm-Message-State: AOJu0Yz6OlyG2u20viOYPACSOr361CamGC4MhhuKP5FGIfksMg9IppWY
	chEflld1Ut+vSzxlzPGN/ExAAkMnb5cRuIsaKdAcJXGSPlKkNCF6ydHRzUEttQ==
X-Gm-Gg: ASbGncuvPqHzdj+d6CbvKDPgBbuz6Tm/BnboPCa4BTy+cvYjIG9Am3Fi9HdJPRAyAHx
	cT42YtKaburk+8LB8LRBVFFKNNLH3zsEZT1Q+5Q0h8KfvRLGLWK6kLE1KeYtYXhVWc/6HdkOdPK
	7eFfQv+Tz8XKFH8m1tOqysDLcHH4ZFLyUotHI2VYwGLNsE65mE55n8C+/BvPTSvT3FDTkvnhMcZ
	O0Sg1irCkXi/Qsd+4P8krwYqUiV6BVTioZZW/gV5LjdsMcd8OJznzfZ59eAMk5MsVzRYByp5rW3
	DqSjV7kAmrjsR09MqrVomBGjXC4/KvL6XWkzS9fMaJFgQ1xysQPCEGaGkAmSVRQlt/emm4rUc4u
	rrToyD/Nb0koguDBmwp5wf110Sj2E
X-Google-Smtp-Source: AGHT+IGJJrxidrvmtMlnjY3JGb3tNtcMwih/vg7DC2X0++oRHGSbsSEikCHR7drsSB7xglMWtP0O8A==
X-Received: by 2002:a17:90b:3503:b0:311:d258:3473 with SMTP id 98e67ed59e1d1-321825f21fbmr442344a91.13.1754586946809;
        Thu, 07 Aug 2025 10:15:46 -0700 (PDT)
Received: from [172.17.0.2] ([68.220.62.101])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422b7bc91dsm16183872a12.19.2025.08.07.10.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 10:15:46 -0700 (PDT)
Message-ID: <6894df42.630a0220.34e0a3.a6a3@mx.google.com>
Date: Thu, 07 Aug 2025 10:15:46 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7468600422060617451=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hadess@hadess.net
Subject: RE: Prepare for meson build system
In-Reply-To: <20250807155115.1037982-2-hadess@hadess.net>
References: <20250807155115.1037982-2-hadess@hadess.net>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7468600422060617451==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=989173

---Test result---

Test Summary:
CheckPatch                    PENDING   0.37 seconds
GitLint                       PENDING   0.49 seconds
BuildEll                      PASS      20.71 seconds
BluezMake                     PASS      2791.66 seconds
MakeCheck                     PASS      19.96 seconds
MakeDistcheck                 PASS      183.00 seconds
CheckValgrind                 PASS      233.53 seconds
CheckSmatch                   WARNING   304.41 seconds
bluezmakeextell               PASS      127.26 seconds
IncrementalBuild              PENDING   0.42 seconds
ScanBuild                     PASS      909.64 seconds

Details
##############################
Test: CheckPatch - PENDING
Desc: Run checkpatch.pl script
Output:

##############################
Test: GitLint - PENDING
Desc: Run gitlint
Output:

##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
attrib/gatttool.c:235:23: warning: Variable length array is used.attrib/interactive.c: note: in included file (through /usr/include/readline/readline.h):attrib/interactive.c:174:27: warning: non-ANSI function declaration of function 'disconnect_io'attrib/interactive.c:299:23: warning: Variable length array is used.emulator/btdev.c:456:29: warning: Variable length array is used.emulator/bthost.c:678:28: warning: Variable length array is used.emulator/bthost.c:679:32: warning: Variable length array is used.emulator/bthost.c:896:28: warning: Variable length array is used.emulator/bthost.c:930:28: warning: Variable length array is used.emulator/bthost.c:931:32: warning: Variable length array is used.mesh/mesh-io-mgmt.c:525:67: warning: Variable length array is used.monitor/att.c: note: in included file:monitor/display.h:82:26: warning: Variable length array is used.monitor/l2cap.c: note: in included file:monitor/display.h:82:26: warning: Variable length array is used.monitor/msft.c: note: in included file:monitor/msft.h:88:44: warning: array of flexible structuresmonitor/packet.c: note: in included file:monitor/display.h:82:26: warning: Variable length array is used.monitor/packet.c:1918:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:3822:52: warning: array of flexible structuresmonitor/bt.h:3810:40: warning: array of flexible structuresprofiles/sap/server.c: note: in included file:profiles/sap/sap.h:77:35: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/gatt-helpers.c:768:31: warning: Variable length array is used.src/shared/gatt-helpers.c:830:31: warning: Variable length array is used.src/shared/gatt-helpers.c:1323:31: warning: Variable length array is used.src/shared/gatt-helpers.c:1354:23: warning: Variable length array is used.src/shared/gatt-helpers.c:768:31: warning: Variable length array is used.src/shared/gatt-helpers.c:830:31: warning: Variable length array is used.src/shared/gatt-helpers.c:1323:31: warning: Variable length array is used.src/shared/gatt-helpers.c:1354:23: warning: Variable length array is used.src/shared/gatt-helpers.c:768:31: warning: Variable length array is used.src/shared/gatt-helpers.c:830:31: warning: Variable length array is used.src/shared/gatt-helpers.c:1323:31: warning: Variable length array is used.src/shared/gatt-helpers.c:1354:23: warning: Variable length array is used.src/shared/gatt-server.c:278:25: warning: Variable length array is used.src/shared/gatt-server.c:618:25: warning: Variable length array is used.src/shared/gatt-server.c:716:25: warning: Variable length array is used.src/shared/gatt-server.c:278:25: warning: Variable length array is used.src/shared/gatt-server.c:618:25: warning: Variable length array is used.src/shared/gatt-server.c:716:25: warning: Variable length array is used.src/shared/gatt-server.c:278:25: warning: Variable length array is used.src/shared/gatt-server.c:618:25: warning: Variable length array is used.src/shared/gatt-server.c:716:25: warning: Variable length array is used.tools/bneptest.c:634:39: warning: unknown escape sequence: '\%'tools/meshctl.c:324:33: warning: non-ANSI function declaration of function 'forget_mesh_devices'tools/rctest.c:631:33: warning: non-ANSI function declaration of function 'automated_send_recv'tools/sco-tester.c: note: in included file:./lib/bluetooth/bluetooth.h:232:15: warning: array of flexible structures./lib/bluetooth/bluetooth.h:237:31: warning: array of flexible structuresunit/avctp.c:505:34: warning: Variable length array is used.unit/avctp.c:556:34: warning: Variable length array is used.unit/avrcp-lib.c:1085:34: warning: Variable length array is used.unit/avrcp-lib.c:1583:34: warning: Variable length array is used.unit/avrcp-lib.c:1612:34: warning: Variable length array is used.unit/avrcp-lib.c:1638:34: warning: Variable length array is used.unit/test-avrcp.c:373:26: warning: Variable length array is used.unit/test-avrcp.c:398:26: warning: Variable length array is used.unit/test-avrcp.c:414:24: warning: Variable length array is used.client/display.c: note: in included file (through /usr/include/readline/readline.h):
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============7468600422060617451==--
