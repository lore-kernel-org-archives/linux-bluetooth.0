Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514231CC16B
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Sep 2024 10:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725446556; cv=none; b=IYptlc5WnW42Cds21hBXdrJA5GC2xPWysmzzpxjinrWPtMbzU4fIhz61IOp8MmvYZ+60nv5PUcTwmLyjitUu3AO1YsrYgX1InQhm5hZvXOSJkUILtJ9P9jFLDXHNaDAs7YUdmn8zevlzSS1FaZic2VIjB951yzI/QmtwDIVlOcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725446556; c=relaxed/simple;
	bh=CPWyo3MoJII222SvyEZ4fOnLWY2qkZYkcKEhIKeNLMc=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=KSgJTy34FDhm7Gjpe3t0IXHNr4bGfqkmLwEXLwoWuUNr9i+hNeObOStATt2yTmZa5uCpdT0J9cQE2BdKJSre0O3H8erIu0sbmV8q2ZS8+GF7tahGuLun7luoZQWm3bYo+K55JYU4yUMX+h9a4VR5pBThStqHE2DnffHYaK7zcok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z4xzJfiw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z4xzJfiw"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D5118C4CEC2
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Sep 2024 10:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725446555;
	bh=CPWyo3MoJII222SvyEZ4fOnLWY2qkZYkcKEhIKeNLMc=;
	h=From:To:Subject:Date:From;
	b=Z4xzJfiweUdEV5HHy3bDmQgaVW3x2ZaKVaYBIY/g8LfZXmWJCJSF3BUswphjck238
	 sxgIIm1jqF/YHY17TXgZGI6k3KVSxpIkvIJ9CZpL95ebX9BtECUkzsaHFr2dUwJ0/t
	 rWUCKxV2sgDJPoNYa85kZ+P2cNeUAcWTKwxU5YNyLJ30LQcDT8S/jfvRFcUaOSd24X
	 Obi/U5abApPH3wzUDFXUw93UR54fGbqZ1phL4hiWk6IlGrdtk5tXO/KnveTkGFPJ1X
	 cGdnoikc8jmYTgZVIluV0D/wgj5nSx3olhKcU1+spZEa4aiTF6LKcfBZq9Ea0jM9S+
	 tTEylJjHuh7wA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id C0862C53B73; Wed,  4 Sep 2024 10:42:35 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219233] New: Bluetooth: hci0: Failed to load Intel firmware
 file intel/ibt-18-16-0.sfi (-2)
Date: Wed, 04 Sep 2024 10:42:35 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: ionut_n2001@yahoo.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-219233-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

https://bugzilla.kernel.org/show_bug.cgi?id=3D219233

            Bug ID: 219233
           Summary: Bluetooth: hci0: Failed to load Intel firmware file
                    intel/ibt-18-16-0.sfi (-2)
           Product: Drivers
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: ionut_n2001@yahoo.com
        Regression: No

Bluetooth: hci0: Failed to load Intel firmware file intel/ibt-18-16-0.sfi (=
-2)



[    7.895675] Bluetooth: hci0: Failed to load Intel firmware file
intel/ibt-18-16-0.sfi (-2)
[    7.896205] Bluetooth: hci0: Reading supported features failed (-56)
[    7.898867] Bluetooth: hci0: Opcode 0x0c03 failed: -56
[    7.899162] Bluetooth: hci0: Failed to read MSFT supported features (-56)


Kernel: 6.11.0-rc6

# lspci -s 04:00.00   -vvvvv
04:00.0 Network controller: Intel Corporation Wi-Fi 5(802.11ac) Wireless-AC
9x6x [Thunder Peak] (rev 29)
        Subsystem: Intel Corporation Dual Band Wi-Fi 5 Wireless-AC 9260 160=
MHz
2x2
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <T=
Abort-
<MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin A routed to IRQ 138
        IOMMU group: 5
        Region 0: Memory at 91300000 (64-bit, non-prefetchable) [size=3D16K]
        Capabilities: [c8] Power Management version 3
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
        Capabilities: [d0] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
                Address: 00000000fee00598  Data: 0000
        Capabilities: [40] Express (v2) Endpoint, IntMsgNum 0
                DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <512=
ns,
L1 unlimited
                        ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+
SlotPowerLimit 0W TEE-IO-
                DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
                        RlxdOrd+ ExtTag- PhantFunc- AuxPwr+ NoSnoop+ FLRese=
t-
                        MaxPayload 128 bytes, MaxReadReq 128 bytes
                DevSta: CorrErr+ NonFatalErr- FatalErr- UnsupReq- AuxPwr+
TransPend-
                LnkCap: Port #0, Speed 5GT/s, Width x1, ASPM L1, Exit Laten=
cy
L1 <8us
                        ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
                LnkCtl: ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk+
                        ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 5GT/s, Width x1
                        TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
                DevCap2: Completion Timeout: Range B, TimeoutDis+ NROPrPrP-
LTR+
                         10BitTagComp- 10BitTagReq- OBFF Via WAKE#, ExtFmt-
EETLPPrefix-
                         EmergencyPowerReduction Not Supported,
EmergencyPowerReductionInit-
                         FRS- TPHComp- ExtTPHComp-
                         AtomicOpsCap: 32bit- 64bit- 128bitCAS-
                DevCtl2: Completion Timeout: 16ms to 55ms, TimeoutDis-
                         AtomicOpsCtl: ReqEn-
                         IDOReq- IDOCompl- LTR+ EmergencyPowerReductionReq-
                         10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
                LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDi=
s-
                         Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
                         Compliance Preset/De-emphasis: -6dB de-emphasis, 0=
dB
preshoot
                LnkSta2: Current De-emphasis Level: -6dB, EqualizationCompl=
ete-
EqualizationPhase1-
                         EqualizationPhase2- EqualizationPhase3-
LinkEqualizationRequest-
                         Retimer- 2Retimers- CrosslinkRes: unsupported
        Capabilities: [80] MSI-X: Enable- Count=3D16 Masked-
                Vector table: BAR=3D0 offset=3D00002000
                PBA: BAR=3D0 offset=3D00003000
        Capabilities: [100 v1] Advanced Error Reporting
                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
RxOF- MalfTLP-
                        ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP-
AtomicOpBlocked- TLPBlockedErr-
                        PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDET=
LP-
PCRC_CHECK- TLPXlatBlocked-
                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
RxOF- MalfTLP-
                        ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP-
AtomicOpBlocked- TLPBlockedErr-
                        PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDET=
LP-
PCRC_CHECK- TLPXlatBlocked-
                UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt-
RxOF+ MalfTLP+
                        ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP-
AtomicOpBlocked- TLPBlockedErr-
                        PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDET=
LP-
PCRC_CHECK- TLPXlatBlocked-
                CESta:  RxErr+ BadTLP- BadDLLP- Rollover- Timeout-
AdvNonFatalErr- CorrIntErr- HeaderOF-
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
AdvNonFatalErr+ CorrIntErr- HeaderOF-
                AERCap: First Error Pointer: 00, ECRCGenCap- ECRCGenEn-
ECRCChkCap- ECRCChkEn-
                        MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
                HeaderLog: 00000000 00000000 00000000 00000000
        Capabilities: [14c v1] Latency Tolerance Reporting
                Max snoop latency: 3145728ns
                Max no snoop latency: 3145728ns
        Capabilities: [154 v1] L1 PM Substates
                L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
L1_PM_Substates+
                          PortCommonModeRestoreTime=3D30us PortTPowerOnTime=
=3D18us
                L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
                           T_CommonMode=3D0us LTR1.2_Threshold=3D0ns
                L1SubCtl2: T_PwrOn=3D10us
        Kernel driver in use: iwlwifi
        Kernel modules: iwlwifi

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
