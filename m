Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792463945;
	b=4RXoHzEt1IBjm0skWv1DpUzgoUWTBFjrSy4TsIXtzHwS3ipK4mWlHiDeyo9kFhCsFkhA
	 nvlgHStAbqYPF+5dIl2ZmCmfgvtmYlo3w0RSaQ/U2B3lI25tEm5qZP2E2xq3FJ3kFOozt
	 yqXwtnXT/hVJIqs7qqvJtBRHHkJmrs4h+K6H+YO6MJh+fe3Katm/zwJxf8SYJVsMxODYM
	 sipjeq6GI3CDMJs2Cg8lTJcu43hrujl8hhEBOV30YwagBhQe3yQPqqFEhUPqMmRhvEJQa
	 aQ5uNGTmMdIaDKoe+Fga4DLsE7Ny0jRDfRv0z2N2FnuzXLGyMxrnXPczSF7dPEugsHA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792463945;
	h=Received:Received:DKIM-Signature:Received:From:To:Subject:Date:
	 X-Bugzilla-Reason:X-Bugzilla-Type:X-Bugzilla-Watch-Reason:
	 X-Bugzilla-Product:X-Bugzilla-Component:X-Bugzilla-Version:
	 X-Bugzilla-Keywords:X-Bugzilla-Severity:X-Bugzilla-Who:
	 X-Bugzilla-Status:X-Bugzilla-Resolution:X-Bugzilla-Priority:
	 X-Bugzilla-Assigned-To:X-Bugzilla-Flags:X-Bugzilla-Changed-Fields:
	 Message-ID:Content-Type:Content-Transfer-Encoding:X-Bugzilla-URL:
	 Auto-Submitted:MIME-Version;
	bh=s8m/JDyg/lYow1mybC0XEOTp+msATD8Tuuahtq8Vsu4=;
	b=jOORTfJdmMUVRNmdrk8mA0gXkgosir35Z3cfhFxzVcTy3qx5axt/wOP9bSfInd98IlZu
	 dheAH+SGdtvptBTnmILGhqMcXJWsyGxMKvgBwd3/vDZlhujAtGs2OtoshbTrLsk4o/+Ek
	 zghm6neL/9UYjQTSZMguJLr+soN9CfUmcGj/2Vtx1pvfGiy0EqZ60eLyY9fEyXjFELb89
	 QbOX4pap7MYjkJRIIu8ICHhZgv7FKXTjxKrQb4ub1cywLezr9CGV8FC1WMcU9acvQY9bo
	 MSG3aeAjQLGhQSoEUcqPGJeXpK51TpquIshqSx4cKDaMT/wFDZmlz1Y6YoqsL1ax5Ig==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b="ZwNd+TV/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
Received: from aws-us-west-2-korg-listserv-1.web.codeaurora.org (ip-10-30-226-211.us-west-2.compute.internal [10.30.226.211])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0336A606A319
	for <linux-bluetooth.vger.kernel.org@localhost.mlmmj>; Tue, 20 Oct 2026 02:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ZwNd+TV/
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE67A25771
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 Oct 2026 02:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792463944; cv=none; b=tLQcb93ry+IcidAiqPd/LqdfGtKqIs9dnD753pywdhtslKMh+1GMayHVth70V8/UotNc/tOcyFjQ+jNlcwc0uJnLFYDmXcIRLLzsHK79+JNqLAA3l/AsQaw4RHZOi8d8NA//e0PvO7flwVjkmVKilKUmX0S8UH9bP04TydE8LMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792463944; c=relaxed/simple;
	bh=ZasHqLZGE1ZbO2RBunseJtyWSkggCP1BZC7yqBoso64=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=UUTvE4UEZY3nELSrraxPwpCrxtRP9vCytaMwXPbgInU2ZlDFQUu4tZubLDLCM72V8ZOF8wGew1qlUrmnPyXX6CsSIrhdDy48NLYiyL/rXdYsAgKGXC7NxGLs998FG34oBX1vRP/n+bilXyboKlnEBtP59vtYL6udwtm6BHjJX5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZwNd+TV/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4488CC2BCF4
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 Oct 2026 02:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1792463944;
	bh=ZasHqLZGE1ZbO2RBunseJtyWSkggCP1BZC7yqBoso64=;
	h=From:To:Subject:Date:From;
	b=ZwNd+TV/iFP/hZsmstuKSoIjvdDeQTpXEGxZdzfBTcC3aLKWp2IdYEq68PG3DH2+0
	 khkCSCEtX6wWFxTD/cudp2xUeyFg7qNkUzhqh/1rpcKr5Yo4flJqCD/PLRP3go+4Pj
	 X0FwmDjRcEYugWlykl6k5ODhUEUJGsWkgHJC2inWN5ZHego6FesqiWbTks8gjdHaVx
	 6FWhlh7SYBsGj/yJp8YipogDSdgiQtV3p7AYvAgeU2gsU/+6zdKFJBGst75R3EOhci
	 KcjM8XOd8EjmUu/AsYQGcP8+GpyukRHObe6K85KYNY1qswfjZVUh/RZV+dsxmxquSk
	 ItEPzYNdAgpVQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 1CDFDC4160E; Tue, 20 Oct 2026 02:39:04 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 222157] New: Macbook 8,1 Bluetooth Fix
Date: Tue, 20 Oct 2026 02:39:03 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: zach.robinson2e@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression attachments.created
Message-ID: <bug-222157-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

https://bugzilla.kernel.org/show_bug.cgi?id=3D222157

            Bug ID: 222157
           Summary: Macbook 8,1 Bluetooth Fix
           Product: Drivers
           Version: 2.5
          Hardware: Intel
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: zach.robinson2e@gmail.com
        Regression: No

Created attachment 311195
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D311195&action=3Dedit
macbook8-1-bluetooth-linux fix

Built-in Bluetooth working on MacBook8,1 (Ubuntu 26.04, kernel 7.0.0-38):
BCM4350C0 via hci_uart_bcm at 3 Mbaud. Four stacked issues:

1. DSDT: URT0 has two children, SSDC (apple-uart-ssdc) and BLTH (BCM2E7C).
   serdev attaches SSDC first, so BLTH fails with -EBUSY. Workaround: remove
   SSDC via a DSDT override (the mux Lukas Wunner described in 2017).
2. LPSS UART (8086:9ce3, 8250_lpss) using DMA from dw_dmac_pci (8086:9ce0):
   TX never completes (tx:0 in /proc/tty/driver/serial). Blacklisting
   dw_dmac_pci forces PIO and TX works.
3. BTLP(0) only sets GD54 as input, leaving the BT_WAKE line floating; the
   chip stays asleep with CTS low. Workaround: make BTLP a no-op.
4. The chip needs ~3 s after BTPU before it answers reliably (it emits a
   ~167 KB burst ~2 s after power-on). Workaround: Sleep(4000) in BTPU.

The UART mux (GPIO 36) already defaults to Bluetooth, and the 3 Mbaud from
_DSM is correct. Full write-up with the DSDT patch steps attached.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
