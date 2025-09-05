Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC6D1B0F23
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Sep 2025 13:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757078357; cv=none; b=MGktdvIWN3TJbRVxqGTX5IVekOSRyt2YzR4M/IJT5ni1U6SqZKfeGT1xRDAMf1HPqUTbp9ZCJAUpi0BQ2ivcqAwGgNIJmbgmJnbYFnxHREVN4YbQTPAdtq1V6vW2VlGS9h4/2d0LUH5MyPfbmcJf1+rtZqO7F/6BbHCrVNLo1dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757078357; c=relaxed/simple;
	bh=3KqFdc1Q7WcIK+T3j93Xi9lHi2RvHVFOkbcGVadqSpQ=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=FqJ/OEMTHQdWaMzZMyf5Fiq0Xaj4Ljj4r5PTHhe2IiT74rnLEV3q5zthdfV3qePXm4o9oXHWPnau6/z9QKkacXOrsi5oNK7WpGaQzlPt1v2FazIpqubJUvwgbl3ZUE0QKzkRqM25QG6CuOYK3BYKs1Rz6zC7+r0mD4H+/eQ2QBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KpUI/yYy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KpUI/yYy"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1B1FCC4CEF1
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Sep 2025 13:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757078357;
	bh=3KqFdc1Q7WcIK+T3j93Xi9lHi2RvHVFOkbcGVadqSpQ=;
	h=From:To:Subject:Date:From;
	b=KpUI/yYyVzQL/eGwUwTw1NWe6AE56R/xyZepIsO6VCCvNM4cXOhxuYLcAVbDSVe7b
	 ve9tyzEdXpwMyC3ZwKD+THE1lxbbDtDket4RldpXFiVXO6K/DrPQ31ExhuswY7VxmO
	 rmeK7/4h79Q0Pi1WhzeIU7RnhIUHx2zKQUPruUIuCkq0gOohGaROItaPQAUDrYFfDZ
	 p/GVO3PhSGyeJvLHF2xeR6v0TD8hhJclj3bGKXGQVmPFowAyXkTA3yKli0jNQswat0
	 Kvv6VqL+IZAiHBIL+J9PfrikxxDwFbUY5eoW7HMuXOrLkAzYjo71xf1/rlL0t2SKkT
	 FLP6PtkMDwOLA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id F0CF6C4160E; Fri,  5 Sep 2025 13:19:16 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220538] New: iwlwifi: BE200 can not install on ubuntu 22.04
 (kernel 6.15.5)
Date: Fri, 05 Sep 2025 13:19:16 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: et020598@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-220538-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220538

            Bug ID: 220538
           Summary: iwlwifi: BE200 can not install on ubuntu 22.04 (kernel
                    6.15.5)
           Product: Drivers
           Version: 2.5
          Hardware: Intel
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: et020598@gmail.com
        Regression: No

Unsuccessful install BE200 on X86 Linux (Kernel 6.15.5)

I think BE200 does not support Linux.=20

Icon name: computer-desktop=20
Chassis: desktop=20
Machine ID: 505bffedb02b4aceac20902046eb2103=20
Boot ID: e22f9a8673b7407d91afc34ba4d0070d=20
Operating System: Ubuntu 22.04.1 LTS=20
Kernel: Linux 6.16.5-061605-generic=20
Architecture: x86-64=20
Hardware Vendor: Dell Inc.=20
Hardware Model: OptiPlex 3040


root@edimax:/home/edimax# journalctl -b -p err
 =E4=B9=9D  06 03:55:32 edimax kernel: x86/cpu: SGX disabled or unsupported=
 by BIOS.
 =E4=B9=9D  06 03:55:32 edimax kernel: usbhid 1-4.3:1.1: couldn't find an i=
nput
interrupt endpoint
 =E4=B9=9D  06 03:55:34 edimax kernel: iwlwifi 0000:01:00.0: Microcode SW e=
rror
detected. Restarting 0x0.
 =E4=B9=9D  06 03:55:34 edimax kernel: iwlwifi 0000:01:00.0: Start IWL Erro=
r Log Dump:
 =E4=B9=9D  06 03:55:34 edimax kernel: iwlwifi 0000:01:00.0: Transport stat=
us:
0x0000004A, valid: 6
 =E4=B9=9D  06 03:55:34 edimax kernel: iwlwifi 0000:01:00.0: Loaded firmwar=
e version:
98.d661c37c.0 gl-c0-fm-c0>
 =E4=B9=9D  06 03:55:34 edimax kernel: iwlwifi 0000:01:00.0: 0x00000071 |
NMI_INTERRUPT_UMAC_FATAL=20=20=20=20
 =E4=B9=9D  06 03:55:34 edimax kernel: iwlwifi 0000:01:00.0: 0x000002F0 |
trm_hw_status0
 =E4=B9=9D  06 03:55:34 edimax kernel: iwlwifi 0000:01:00.0: 0x00000000 |
trm_hw_status1
 =E4=B9=9D  06 03:55:34 edimax kernel: iwlwifi 0000:01:00.0: 0x002C40D6 | b=
ranchlink2
 =E4=B9=9D  06 03:55:34 edimax kernel: iwlwifi 0000:01:00.0: 0x002B8AC4 |
interruptlink1
 =E4=B9=9D  06 03:55:34 edimax kernel: iwlwifi 0000:01:00.0: 0x002B8AC4 |
interruptlink2
 =E4=B9=9D  06 03:55:34 edimax kernel: iwlwifi 0000:01:00.0: 0x00015FC2 | d=
ata1
 =E4=B9=9D  06 03:55:34 edimax kernel: iwlwifi 0000:01:00.0: 0x00000010 | d=
ata2
 =E4=B9=9D  06 03:55:34 edimax kernel: iwlwifi 0000:01:00.0: 0x00000000 | d=
ata3
 =E4=B9=9D  06 03:55:34 edimax kernel: iwlwifi 0000:01:00.0: 0x00000000 | b=
eacon time
 =E4=B9=9D  06 03:55:34 edimax kernel: iwlwifi 0000:01:00.0: 0x000115F5 | t=
sf low
 =E4=B9=9D  06 03:55:34 edimax kernel: iwlwifi 0000:01:00.0: 0x00000000 | t=
sf hi
 =E4=B9=9D  06 03:55:34 edimax kernel: iwlwifi 0000:01:00.0: 0x00000000 | t=
ime gp1
 =E4=B9=9D  06 03:55:34 edimax kernel: iwlwifi 0000:01:00.0: 0x0003B9E7 | t=
ime gp2
 =E4=B9=9D  06 03:55:34 edimax kernel: iwlwifi 0000:01:00.0: 0x00000001 | u=
Code
revision type
 =E4=B9=9D  06 03:55:34 edimax kernel: iwlwifi 0000:01:00.0: 0x00000062 | u=
Code version
major
 =E4=B9=9D  06 03:55:34 edimax kernel: iwlwifi 0000:01:00.0: 0xD661C37C | u=
Code version
minor
 =E4=B9=9D  06 03:55:34 edimax kernel: iwlwifi 0000:01:00.0: 0x00000472 | h=
w version
 =E4=B9=9D  06 03:55:34 edimax kernel: iwlwifi 0000:01:00.0: 0x18C80002 | b=
oard version
 =E4=B9=9D  06 03:55:34 edimax kernel: iwlwifi 0000:01:00.0: 0x800CFD1B | h=
cmd
 =E4=B9=9D  06 03:55:34 edimax kernel: iwlwifi 0000:01:00.0: 0x00020000 | i=
sr0
 =E4=B9=9D  06 03:55:34 edimax kernel: iwlwifi 0000:01:00.0: 0x60000000 | i=
sr1
 =E4=B9=9D  06 03:55:34 edimax kernel: iwlwifi 0000:01:00.0: 0x58F00002 | i=
sr2
 =E4=B9=9D  06 03:55:34 edimax kernel: iwlwifi 0000:01:00.0: 0x00C0000C | i=
sr3
 =E4=B9=9D  06 03:55:34 edimax kernel: iwlwifi 0000:01:00.0: 0x02000000 | i=
sr4
 =E4=B9=9D  06 03:55:34 edimax kernel: iwlwifi 0000:01:00.0: 0x00000000 | l=
ast cmd Id
 =E4=B9=9D  06 03:55:34 edimax kernel: iwlwifi 0000:01:00.0: 0x00015FC2 | w=
ait_event
 =E4=B9=9D  06 03:55:34 edimax kernel: iwlwifi 0000:01:00.0: 0x10000017 | l=
2p_control
 =E4=B9=9D  06 03:55:34 edimax kernel: iwlwifi 0000:01:00.0: 0x00000000 | l=
2p_duration
 =E4=B9=9D  06 03:55:34 edimax kernel: iwlwifi 0000:01:00.0: 0x00000000 | l=
2p_mhvalid
 =E4=B9=9D  06 03:55:34 edimax kernel: iwlwifi 0000:01:00.0: 0x00000000 |
l2p_addr_match
 =E4=B9=9D  06 03:55:34 edimax kernel: iwlwifi 0000:01:00.0: 0x0000000B | l=
mpm_pmg_sel
 =E4=B9=9D  06 03:55:34 edimax kernel: iwlwifi 0000:01:00.0: 0x00000000 | t=
imestamp
 =E4=B9=9D  06 03:55:34 edimax kernel: iwlwifi 0000:01:00.0: 0x00000024 | f=
low_handler
 =E4=B9=9D  06 03:55:34 edimax kernel: iwlwifi 0000:01:00.0: Start IWL Erro=
r Log Dump:
 =E4=B9=9D  06 03:55:34 edimax kernel: iwlwifi 0000:01:00.0: Transport stat=
us:
0x0000004A, valid: 6
 =E4=B9=9D  06 03:55:34 edimax kernel: iwlwifi 0000:01:00.0: Loaded firmwar=
e version:
98.d661c37c.0 gl-c0-fm-c0>
 =E4=B9=9D  06 03:55:34 edimax kernel: iwlwifi 0000:01:00.0: 0x00000071 |
NMI_INTERRUPT_UMAC_FATAL=20=20=20=20
 =E4=B9=9D  06 03:55:34 edimax kernel: iwlwifi 0000:01:00.0: 0x000002F0 |
trm_hw_status0
 =E4=B9=9D  06 03:55:34 edimax kernel: iwlwifi 0000:01:00.0: 0x00000000 |
trm_hw_status1
 =E4=B9=9D  06 03:55:34 edimax kernel: iwlwifi 0000:01:00.0: 0x002C40D6 | b=
ranchlink2
 =E4=B9=9D  06 03:55:34 edimax kernel: iwlwifi 0000:01:00.0: 0x002B8AC4 |
interruptlink1
 =E4=B9=9D  06 03:55:34 edimax kernel: iwlwifi 0000:01:00.0: 0x002B8AC4 |
interruptlink2
 =E4=B9=9D  06 03:55:34 edimax kernel: iwlwifi 0000:01:00.0: 0x002A58C6 | d=
ata1
 =E4=B9=9D  06 03:55:34 edimax kernel: iwlwifi 0000:01:00.0: 0x00000010 | d=
ata2
 =E4=B9=9D  06 03:55:34 edimax kernel: iwlwifi 0000:01:00.0: 0x00000000 | d=
ata3

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

dmesg | grep -i error

[    1.112586] RAS: Correctable Errors collector initialized.
[    5.646097] iwlwifi 0000:01:00.0: Direct firmware load for
iwlwifi-gl-c0-fm-c0-99.ucode failed with error -2
[    6.142491] iwlwifi 0000:01:00.0: Microcode SW error detected. Restarting
0x0.
[    6.142553] iwlwifi 0000:01:00.0: Start IWL Error Log Dump:
[    6.142670] iwlwifi 0000:01:00.0: Start IWL Error Log Dump:
[    6.142758] iwlwifi 0000:01:00.0: Start IWL Error Log Dump:
[    6.142822] iwlwifi 0000:01:00.0: 0x00000070 | error ID
[    6.142884] iwlwifi 0000:01:00.0: 0x00000070 | error ID
[    6.142916] iwlwifi 0000:01:00.0: 0x00000000 | MAC header error
[    6.142949] iwlwifi 0000:01:00.0: 0x00000070 | error ID
[    6.143013] iwlwifi 0000:01:00.0: 0x00000070 | error ID
[    6.143044] iwlwifi 0000:01:00.0: 0x00000000 | MAC header error
[    6.143059] iwlwifi 0000:01:00.0: 0x00000B03 | IML/ROM error/state
[    6.143091] iwlwifi 0000:01:00.0: 0x67A00000 | FSEQ_ERROR_CODE
[    8.920845] iwlwifi 0000:01:00.0: Microcode SW error detected. Restarting
0x0.
[    8.920946] iwlwifi 0000:01:00.0: Start IWL Error Log Dump:
[    8.921255] iwlwifi 0000:01:00.0: Start IWL Error Log Dump:
[    8.921555] iwlwifi 0000:01:00.0: Start IWL Error Log Dump:
[    8.921715] iwlwifi 0000:01:00.0: 0x00000070 | error ID
[    8.921875] iwlwifi 0000:01:00.0: 0x00000070 | error ID
[    8.921993] iwlwifi 0000:01:00.0: 0x00000000 | MAC header error
[    8.922041] iwlwifi 0000:01:00.0: 0x00000070 | error ID
[    8.922199] iwlwifi 0000:01:00.0: 0x00000070 | error ID
[    8.922315] iwlwifi 0000:01:00.0: 0x00000000 | MAC header error
[    8.922342] iwlwifi 0000:01:00.0: 0x00000B03 | IML/ROM error/state
[    8.922418] iwlwifi 0000:01:00.0: 0x67A00000 | FSEQ_ERROR_CODE
[   11.771402] iwlwifi 0000:01:00.0: Microcode SW error detected. Restarting
0x0.
[   11.771513] iwlwifi 0000:01:00.0: Start IWL Error Log Dump:
[   11.771829] iwlwifi 0000:01:00.0: Start IWL Error Log Dump:
[   11.772096] iwlwifi 0000:01:00.0: Start IWL Error Log Dump:
[   11.772253] iwlwifi 0000:01:00.0: 0x00000070 | error ID
[   11.772413] iwlwifi 0000:01:00.0: 0x00000070 | error ID
[   11.772539] iwlwifi 0000:01:00.0: 0x00000000 | MAC header error
[   11.772589] iwlwifi 0000:01:00.0: 0x00000070 | error ID
[   11.772757] iwlwifi 0000:01:00.0: 0x00000070 | error ID
[   11.772874] iwlwifi 0000:01:00.0: 0x00000000 | MAC header error
[   11.772901] iwlwifi 0000:01:00.0: 0x00000B03 | IML/ROM error/state
[   11.772977] iwlwifi 0000:01:00.0: 0x67A00000 | FSEQ_ERROR_CODE
[   14.614142] iwlwifi 0000:01:00.0: Microcode SW error detected. Restarting
0x0.
[   14.614234] iwlwifi 0000:01:00.0: Start IWL Error Log Dump:
[   14.614455] iwlwifi 0000:01:00.0: Start IWL Error Log Dump:
[   14.614651] iwlwifi 0000:01:00.0: Start IWL Error Log Dump:
[   14.614746] iwlwifi 0000:01:00.0: 0x00000070 | error ID
[   14.614859] iwlwifi 0000:01:00.0: 0x00000070 | error ID
[   14.614920] iwlwifi 0000:01:00.0: 0x00000000 | MAC header error
[   14.614957] iwlwifi 0000:01:00.0: 0x00000070 | error ID
[   14.615050] iwlwifi 0000:01:00.0: 0x00000070 | error ID
[   14.615127] iwlwifi 0000:01:00.0: 0x00000000 | MAC header error
[   14.615164] iwlwifi 0000:01:00.0: 0x00000B03 | IML/ROM error/state
[   14.615211] iwlwifi 0000:01:00.0: 0x67A00000 | FSEQ_ERROR_CODE
[   17.496941] iwlwifi 0000:01:00.0: Microcode SW error detected. Restarting
0x0.
[   17.496995] iwlwifi 0000:01:00.0: Start IWL Error Log Dump:
[   17.497114] iwlwifi 0000:01:00.0: Start IWL Error Log Dump:
[   17.497203] iwlwifi 0000:01:00.0: Start IWL Error Log Dump:
[   17.497266] iwlwifi 0000:01:00.0: 0x00000070 | error ID
[   17.497330] iwlwifi 0000:01:00.0: 0x00000070 | error ID
[   17.497362] iwlwifi 0000:01:00.0: 0x00000000 | MAC header error
[   17.497410] iwlwifi 0000:01:00.0: 0x00000070 | error ID
[   17.497485] iwlwifi 0000:01:00.0: 0x00000070 | error ID
[   17.497518] iwlwifi 0000:01:00.0: 0x00000000 | MAC header error
[   17.497534] iwlwifi 0000:01:00.0: 0x00000B03 | IML/ROM error/state
[   17.497572] iwlwifi 0000:01:00.0: 0x67A00000 | FSEQ_ERROR_CODE
[   20.368976] iwlwifi 0000:01:00.0: Microcode SW error detected. Restarting
0x0.
[   20.369055] iwlwifi 0000:01:00.0: Start IWL Error Log Dump:
[   20.369185] iwlwifi 0000:01:00.0: Start IWL Error Log Dump:
[   20.369274] iwlwifi 0000:01:00.0: Start IWL Error Log Dump:
[   20.369352] iwlwifi 0000:01:00.0: 0x00000070 | error ID
[   20.369440] iwlwifi 0000:01:00.0: 0x00000070 | error ID
[   20.369473] iwlwifi 0000:01:00.0: 0x00000000 | MAC header error
[   20.369523] iwlwifi 0000:01:00.0: 0x00000070 | error ID
[   20.369602] iwlwifi 0000:01:00.0: 0x00000070 | error ID
[   20.369647] iwlwifi 0000:01:00.0: 0x00000000 | MAC header error
[   20.369674] iwlwifi 0000:01:00.0: 0x00000B03 | IML/ROM error/state
[   20.369717] iwlwifi 0000:01:00.0: 0x67A00000 | FSEQ_ERROR_CODE
[   23.405668] iwlwifi 0000:01:00.0: Microcode SW error detected. Restarting
0x0.
[   23.405795] iwlwifi 0000:01:00.0: Start IWL Error Log Dump:
[   23.405908] iwlwifi 0000:01:00.0: Start IWL Error Log Dump:
[   23.406010] iwlwifi 0000:01:00.0: Start IWL Error Log Dump:
[   23.406085] iwlwifi 0000:01:00.0: 0x00000070 | error ID
[   23.406158] iwlwifi 0000:01:00.0: 0x00000070 | error ID
[   23.406188] iwlwifi 0000:01:00.0: 0x00000000 | MAC header error
[   23.406220] iwlwifi 0000:01:00.0: 0x00000070 | error ID
[   23.406306] iwlwifi 0000:01:00.0: 0x00000070 | error ID
[   23.406351] iwlwifi 0000:01:00.0: 0x00000000 | MAC header error
[   23.406386] iwlwifi 0000:01:00.0: 0x00000B03 | IML/ROM error/state
[   23.406466] iwlwifi 0000:01:00.0: 0x67A00000 | FSEQ_ERROR_CODE
[   26.240508] iwlwifi 0000:01:00.0: Microcode SW error detected. Restarting
0x0.
[   26.240563] iwlwifi 0000:01:00.0: Start IWL Error Log Dump:
[   26.240686] iwlwifi 0000:01:00.0: Start IWL Error Log Dump:
[   26.240774] iwlwifi 0000:01:00.0: Start IWL Error Log Dump:
[   26.240836] iwlwifi 0000:01:00.0: 0x00000070 | error ID
[   26.240899] iwlwifi 0000:01:00.0: 0x00000070 | error ID
[   26.240930] iwlwifi 0000:01:00.0: 0x00000000 | MAC header error
[   26.240963] iwlwifi 0000:01:00.0: 0x00000070 | error ID
[   26.241025] iwlwifi 0000:01:00.0: 0x00000070 | error ID
[   26.241056] iwlwifi 0000:01:00.0: 0x00000000 | MAC header error
[   26.241071] iwlwifi 0000:01:00.0: 0x00000B03 | IML/ROM error/state
[   26.241109] iwlwifi 0000:01:00.0: 0x67A00000 | FSEQ_ERROR_CODE
[   29.101592] iwlwifi 0000:01:00.0: Microcode SW error detected. Restarting
0x0.
[   29.101663] iwlwifi 0000:01:00.0: FW error in SYNC CMD UNKNOWN
[   29.101672] iwlwifi 0000:01:00.0: Start IWL Error Log Dump:
[   29.101997] iwlwifi 0000:01:00.0: Start IWL Error Log Dump:
[   29.102259] iwlwifi 0000:01:00.0: Start IWL Error Log Dump:
[   29.102458] iwlwifi 0000:01:00.0: 0x00000070 | error ID
[   29.102634] iwlwifi 0000:01:00.0: 0x00000070 | error ID
[   29.102773] iwlwifi 0000:01:00.0: 0x00000000 | MAC header error
[   29.102821] iwlwifi 0000:01:00.0: 0x00000070 | error ID
[   29.102977] iwlwifi 0000:01:00.0: 0x00000070 | error ID
[   29.103093] iwlwifi 0000:01:00.0: 0x00000000 | MAC header error
[   29.103120] iwlwifi 0000:01:00.0: 0x00000B03 | IML/ROM error/state
[   29.103204] iwlwifi 0000:01:00.0: 0x67A00000 | FSEQ_ERROR_CODE
[   29.164145] iwlwifi 0000:01:00.0: Device is not enabled - cannot dump er=
ror
[   29.165055] iwlwifi 0000:01:00.0: Device error - SW reset
[   29.224685]  iwl_fw_error_ini_dump+0x86/0x1b0 [iwlwifi]
[   29.224853]  iwl_mld_dump_error+0xae/0x160 [iwlmld]
[   56.167926]  iwl_fw_error_ini_dump+0x86/0x1b0 [iwlwifi]
[   56.168082]  iwl_mld_dump_error+0xae/0x160 [iwlmld]
[   57.788689] i915 0000:00:02.0: [drm] *ERROR* Atomic update failure on pi=
pe A
(start=3D4123 end=3D4124) time 219 us, min 1073, max 1079, scanline start 1=
072, end
1087
[   79.320564] mate-settings-d[1294]: segfault at 5d180937007f ip
00007562972ad801 sp 00007ffcc8914350 error 6 in
libpulse-mainloop-glib.so.0.0.6[1801,7562972ad000+2000] likely on CPU 1 (co=
re
1, socket 0)

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D

[   26.240686] iwlwifi 0000:01:00.0: Start IWL Error Log Dump:
[   26.240688] iwlwifi 0000:01:00.0: Transport status: 0x0000004A, valid: 6
[   26.240690] iwlwifi 0000:01:00.0: Loaded firmware version: 98.d661c37c.0
gl-c0-fm-c0-98.ucode
[   26.240692] iwlwifi 0000:01:00.0: 0x00000071 | NMI_INTERRUPT_UMAC_FATAL=
=20=20=20=20
[   26.240694] iwlwifi 0000:01:00.0: 0x000002F0 | trm_hw_status0
[   26.240696] iwlwifi 0000:01:00.0: 0x00000000 | trm_hw_status1
[   26.240697] iwlwifi 0000:01:00.0: 0x002C40D6 | branchlink2
[   26.240699] iwlwifi 0000:01:00.0: 0x002B8AC4 | interruptlink1
[   26.240701] iwlwifi 0000:01:00.0: 0x002B8AC4 | interruptlink2
[   26.240703] iwlwifi 0000:01:00.0: 0x002A58C6 | data1
[   26.240704] iwlwifi 0000:01:00.0: 0x00000010 | data2
[   26.240706] iwlwifi 0000:01:00.0: 0x00000000 | data3
[   26.240708] iwlwifi 0000:01:00.0: 0x00000000 | beacon time
[   26.240709] iwlwifi 0000:01:00.0: 0x000116CC | tsf low
[   26.240711] iwlwifi 0000:01:00.0: 0x00000000 | tsf hi
[   26.240713] iwlwifi 0000:01:00.0: 0x00000000 | time gp1
[   26.240715] iwlwifi 0000:01:00.0: 0x0003BAB5 | time gp2
[   26.240716] iwlwifi 0000:01:00.0: 0x00000001 | uCode revision type
[   26.240718] iwlwifi 0000:01:00.0: 0x00000062 | uCode version major
[   26.240720] iwlwifi 0000:01:00.0: 0xD661C37C | uCode version minor
[   26.240722] iwlwifi 0000:01:00.0: 0x00000472 | hw version
[   26.240723] iwlwifi 0000:01:00.0: 0x18C80002 | board version
[   26.240725] iwlwifi 0000:01:00.0: 0x8008FF05 | hcmd
[   26.240727] iwlwifi 0000:01:00.0: 0x00020000 | isr0
[   26.240729] iwlwifi 0000:01:00.0: 0x60000000 | isr1
[   26.240730] iwlwifi 0000:01:00.0: 0x58F00002 | isr2
[   26.240732] iwlwifi 0000:01:00.0: 0x00C0001C | isr3
[   26.240734] iwlwifi 0000:01:00.0: 0x02000000 | isr4
[   26.240735] iwlwifi 0000:01:00.0: 0x00000000 | last cmd Id
[   26.240737] iwlwifi 0000:01:00.0: 0x002A58C6 | wait_event
[   26.240739] iwlwifi 0000:01:00.0: 0x10000017 | l2p_control
[   26.240741] iwlwifi 0000:01:00.0: 0x00000000 | l2p_duration
[   26.240742] iwlwifi 0000:01:00.0: 0x00000000 | l2p_mhvalid
[   26.240744] iwlwifi 0000:01:00.0: 0x00000000 | l2p_addr_match
[   26.240746] iwlwifi 0000:01:00.0: 0x0000000B | lmpm_pmg_sel
[   26.240747] iwlwifi 0000:01:00.0: 0x00000000 | timestamp
[   26.240749] iwlwifi 0000:01:00.0: 0x00000024 | flow_handler
[   26.240774] iwlwifi 0000:01:00.0: Start IWL Error Log Dump:
[   26.240776] iwlwifi 0000:01:00.0: Transport status: 0x0000004A, valid: 7
[   26.240778] iwlwifi 0000:01:00.0: PNVM data is missing, please install
iwlwifi-gl-c0-fm-c0.pnvm
[   26.240780] iwlwifi 0000:01:00.0: 0x2010070D | PNVM_MISSING
[   26.240782] iwlwifi 0000:01:00.0: 0x00000000 | umac branchlink1
[   26.240784] iwlwifi 0000:01:00.0: 0xC008088A | umac branchlink2
[   26.240786] iwlwifi 0000:01:00.0: 0x0001FDE2 | umac interruptlink1
[   26.240788] iwlwifi 0000:01:00.0: 0x0105744A | umac interruptlink2
[   26.240789] iwlwifi 0000:01:00.0: 0x00000005 | umac data1
[   26.240791] iwlwifi 0000:01:00.0: 0xDEADBEEF | umac data2
[   26.240793] iwlwifi 0000:01:00.0: 0xDEADBEEF | umac data3
[   26.240794] iwlwifi 0000:01:00.0: 0x00000062 | umac major
[   26.240796] iwlwifi 0000:01:00.0: 0xD661C37C | umac minor
[   26.240798] iwlwifi 0000:01:00.0: 0x0003BAA9 | frame pointer
[   26.240800] iwlwifi 0000:01:00.0: 0xD00D5EC8 | stack pointer
[   26.240801] iwlwifi 0000:01:00.0: 0x0001016A | last host cmd
[   26.240803] iwlwifi 0000:01:00.0: 0x00000000 | isr status reg
[   26.240834] iwlwifi 0000:01:00.0: TCM1 status:
[   26.240836] iwlwifi 0000:01:00.0: 0x00000070 | error ID
[   26.240838] iwlwifi 0000:01:00.0: 0x00001B8A | tcm branchlink2
[   26.240840] iwlwifi 0000:01:00.0: 0x00001F4C | tcm interruptlink1
[   26.240841] iwlwifi 0000:01:00.0: 0x00001F4C | tcm interruptlink2
[   26.240843] iwlwifi 0000:01:00.0: 0x40000000 | tcm data1
[   26.240845] iwlwifi 0000:01:00.0: 0xDEADBEEF | tcm data2
[   26.240846] iwlwifi 0000:01:00.0: 0xDEADBEEF | tcm data3
[   26.240848] iwlwifi 0000:01:00.0: 0x00001C08 | tcm log PC
[   26.240850] iwlwifi 0000:01:00.0: 0x00803FF0 | tcm frame pointer
[   26.240852] iwlwifi 0000:01:00.0: 0x00803F5C | tcm stack pointer
[   26.240853] iwlwifi 0000:01:00.0: 0x00000000 | tcm msg ID
[   26.240855] iwlwifi 0000:01:00.0: 0x40080000 | tcm ISR status
[   26.240857] iwlwifi 0000:01:00.0: 0x000002F0 | tcm HW status[0]
[   26.240859] iwlwifi 0000:01:00.0: 0x00000000 | tcm HW status[1]
[   26.240861] iwlwifi 0000:01:00.0: 0x00000000 | tcm HW status[2]
[   26.240862] iwlwifi 0000:01:00.0: 0x00008100 | tcm HW status[3]
[   26.240864] iwlwifi 0000:01:00.0: 0x00000000 | tcm HW status[4]
[   26.240866] iwlwifi 0000:01:00.0: 0x00000000 | tcm SW status[0]
[   26.240897] iwlwifi 0000:01:00.0: RCM1 status:
[   26.240899] iwlwifi 0000:01:00.0: 0x00000070 | error ID
[   26.240900] iwlwifi 0000:01:00.0: 0x00001E02 | rcm branchlink2
[   26.240902] iwlwifi 0000:01:00.0: 0x00002780 | rcm interruptlink1
[   26.240904] iwlwifi 0000:01:00.0: 0x00002780 | rcm interruptlink2
[   26.240906] iwlwifi 0000:01:00.0: 0x20000000 | rcm data1
[   26.240907] iwlwifi 0000:01:00.0: 0xDEADBEEF | rcm data2
[   26.240909] iwlwifi 0000:01:00.0: 0xDEADBEEF | rcm data3
[   26.240911] iwlwifi 0000:01:00.0: 0x00001E6C | rcm log PC
[   26.240912] iwlwifi 0000:01:00.0: 0x00803FF0 | rcm frame pointer
[   26.240914] iwlwifi 0000:01:00.0: 0x00803F5C | rcm stack pointer
[   26.240916] iwlwifi 0000:01:00.0: 0x00000000 | rcm msg ID
[   26.240918] iwlwifi 0000:01:00.0: 0x20000000 | rcm ISR status
[   26.240919] iwlwifi 0000:01:00.0: 0x00420500 | frame HW status
[   26.240921] iwlwifi 0000:01:00.0: 0x00000000 | LMAC-to-RCM request mbox
[   26.240923] iwlwifi 0000:01:00.0: 0x00000000 | RCM-to-LMAC request mbox
[   26.240925] iwlwifi 0000:01:00.0: 0x00000000 | MAC header control
[   26.240926] iwlwifi 0000:01:00.0: 0x00000000 | MAC header addr1 low
[   26.240928] iwlwifi 0000:01:00.0: 0x003C0000 | MAC header info
[   26.240930] iwlwifi 0000:01:00.0: 0x00000000 | MAC header error
[   26.240961] iwlwifi 0000:01:00.0: TCM2 status:
[   26.240963] iwlwifi 0000:01:00.0: 0x00000070 | error ID
[   26.240964] iwlwifi 0000:01:00.0: 0x00001B8A | tcm branchlink2
[   26.240966] iwlwifi 0000:01:00.0: 0x00001F4C | tcm interruptlink1
[   26.240968] iwlwifi 0000:01:00.0: 0x00001F4C | tcm interruptlink2
[   26.240969] iwlwifi 0000:01:00.0: 0x40000000 | tcm data1
[   26.240971] iwlwifi 0000:01:00.0: 0xDEADBEEF | tcm data2
[   26.240973] iwlwifi 0000:01:00.0: 0xDEADBEEF | tcm data3
[   26.240974] iwlwifi 0000:01:00.0: 0x00001C08 | tcm log PC
[   26.240976] iwlwifi 0000:01:00.0: 0x00803FF0 | tcm frame pointer
[   26.240978] iwlwifi 0000:01:00.0: 0x00803F5C | tcm stack pointer
[   26.240980] iwlwifi 0000:01:00.0: 0x00000000 | tcm msg ID
[   26.240981] iwlwifi 0000:01:00.0: 0x40080000 | tcm ISR status
[   26.240983] iwlwifi 0000:01:00.0: 0x000002F0 | tcm HW status[0]
[   26.240985] iwlwifi 0000:01:00.0: 0x00000000 | tcm HW status[1]
[   26.240987] iwlwifi 0000:01:00.0: 0x00000000 | tcm HW status[2]
[   26.240988] iwlwifi 0000:01:00.0: 0x00008000 | tcm HW status[3]
[   26.240990] iwlwifi 0000:01:00.0: 0x00000000 | tcm HW status[4]
[   26.240992] iwlwifi 0000:01:00.0: 0x00000000 | tcm SW status[0]
[   26.241023] iwlwifi 0000:01:00.0: RCM2 status:
[   26.241025] iwlwifi 0000:01:00.0: 0x00000070 | error ID
[   26.241027] iwlwifi 0000:01:00.0: 0x00001E02 | rcm branchlink2
[   26.241028] iwlwifi 0000:01:00.0: 0x00002780 | rcm interruptlink1
[   26.241030] iwlwifi 0000:01:00.0: 0x00002780 | rcm interruptlink2
[   26.241032] iwlwifi 0000:01:00.0: 0x20000000 | rcm data1
[   26.241034] iwlwifi 0000:01:00.0: 0xDEADBEEF | rcm data2
[   26.241035] iwlwifi 0000:01:00.0: 0xDEADBEEF | rcm data3
[   26.241037] iwlwifi 0000:01:00.0: 0x00001E6C | rcm log PC
[   26.241039] iwlwifi 0000:01:00.0: 0x00803FF0 | rcm frame pointer
[   26.241040] iwlwifi 0000:01:00.0: 0x00803F5C | rcm stack pointer
[   26.241042] iwlwifi 0000:01:00.0: 0x00000000 | rcm msg ID
[   26.241044] iwlwifi 0000:01:00.0: 0x20000000 | rcm ISR status
[   26.241046] iwlwifi 0000:01:00.0: 0x00420500 | frame HW status
[   26.241047] iwlwifi 0000:01:00.0: 0x00000000 | LMAC-to-RCM request mbox
[   26.241049] iwlwifi 0000:01:00.0: 0x00000000 | RCM-to-LMAC request mbox
[   26.241051] iwlwifi 0000:01:00.0: 0x00000000 | MAC header control
[   26.241052] iwlwifi 0000:01:00.0: 0x00000000 | MAC header addr1 low
[   26.241054] iwlwifi 0000:01:00.0: 0x003C0000 | MAC header info
[   26.241056] iwlwifi 0000:01:00.0: 0x00000000 | MAC header error
[   26.241069] iwlwifi 0000:01:00.0: IML/ROM dump:
[   26.241071] iwlwifi 0000:01:00.0: 0x00000B03 | IML/ROM error/state
[   26.241088] iwlwifi 0000:01:00.0: 0x0000ED67 | IML/ROM data1
[   26.241097] iwlwifi 0000:01:00.0: 0x00000080 | IML/ROM WFPM_AUTH_KEY_0
[   26.241103] iwlwifi 0000:01:00.0: Fseq Registers:
[   26.241109] iwlwifi 0000:01:00.0: 0x67A00000 | FSEQ_ERROR_CODE
[   26.241114] iwlwifi 0000:01:00.0: 0x80B10005 | FSEQ_TOP_INIT_VERSION
[   26.241120] iwlwifi 0000:01:00.0: 0x00570000 | FSEQ_CNVIO_INIT_VERSION
[   26.241126] iwlwifi 0000:01:00.0: 0x0000AA14 | FSEQ_OTP_VERSION
[   26.241132] iwlwifi 0000:01:00.0: 0x0000000F | FSEQ_TOP_CONTENT_VERSION
[   26.241137] iwlwifi 0000:01:00.0: 0x4552414E | FSEQ_ALIVE_TOKEN
[   26.241143] iwlwifi 0000:01:00.0: 0x02001910 | FSEQ_CNVI_ID
[   26.241149] iwlwifi 0000:01:00.0: 0x02001910 | FSEQ_CNVR_ID
[   26.241155] iwlwifi 0000:01:00.0: 0x02001910 | CNVI_AUX_MISC_CHIP
[   26.241162] iwlwifi 0000:01:00.0: 0x02001910 | CNVR_AUX_MISC_CHIP
[   26.241172] iwlwifi 0000:01:00.0: 0x00001BED |
CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
[   26.241181] iwlwifi 0000:01:00.0: 0x00000000 |
CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
[   26.241186] iwlwifi 0000:01:00.0: 0x00570000 | FSEQ_PREV_CNVIO_INIT_VERS=
ION
[   26.241192] iwlwifi 0000:01:00.0: 0x00B10005 | FSEQ_WIFI_FSEQ_VERSION
[   26.241198] iwlwifi 0000:01:00.0: 0xCB3129C8 | FSEQ_BT_FSEQ_VERSION
[   26.241204] iwlwifi 0000:01:00.0: 0x000000BF | FSEQ_CLASS_TP_VERSION
[   26.241214] iwlwifi 0000:01:00.0: UMAC CURRENT PC: 0x802876d2
[   26.241220] iwlwifi 0000:01:00.0: LMAC1 CURRENT PC: 0xd0
[   26.241225] iwlwifi 0000:01:00.0: LMAC2 CURRENT PC: 0xd0
[   26.241231] iwlwifi 0000:01:00.0: UMAC CURRENT PC 1: 0x802876d0
[   26.241236] iwlwifi 0000:01:00.0: TCM1 CURRENT PC: 0xd0
[   26.241242] iwlwifi 0000:01:00.0: RCM1 CURRENT PC: 0xd0
[   26.241247] iwlwifi 0000:01:00.0: RCM2 CURRENT PC: 0xd0
[   26.241253] iwlwifi 0000:01:00.0: Function Scratch status:
[   26.241255] iwlwifi 0000:01:00.0: 0x01010101 | Func Scratch
[   28.302736] iwlwifi 0000:01:00.0: Failed to get INIT_COMPLETE -110
[   28.302759] iwlwifi 0000:01:00.0: WRT: Collecting data: ini trigger 4 fi=
red
(delay=3D0ms).
[   29.099059] iwlwifi 0000:01:00.0: Sending Phy CFG command: 0x330018
[   29.101592] iwlwifi 0000:01:00.0: Microcode SW error detected. Restarting
0x0.
[   29.101663] iwlwifi 0000:01:00.0: FW error in SYNC CMD UNKNOWN
[   29.101672] iwlwifi 0000:01:00.0: Start IWL Error Log Dump:
[   29.101678] iwlwifi 0000:01:00.0: Transport status: 0x0000004A, valid: 6
[   29.101688] iwlwifi 0000:01:00.0: Loaded firmware version: 98.d661c37c.0
gl-c0-fm-c0-98.ucode
[   29.101699] iwlwifi 0000:01:00.0: 0x00000071 | NMI_INTERRUPT_UMAC_FATAL=
=20=20=20=20
[   29.101711] iwlwifi 0000:01:00.0: 0x000002F0 | trm_hw_status0
[   29.101718] iwlwifi 0000:01:00.0: 0x00000000 | trm_hw_status1
[   29.101728] iwlwifi 0000:01:00.0: 0x002C40D6 | branchlink2
[   29.101736] iwlwifi 0000:01:00.0: 0x002B8AC4 | interruptlink1
[   29.101743] iwlwifi 0000:01:00.0: 0x002B8AC4 | interruptlink2
[   29.101751] iwlwifi 0000:01:00.0: 0x00015FC2 | data1
[   29.101758] iwlwifi 0000:01:00.0: 0x00000010 | data2
[   29.101765] iwlwifi 0000:01:00.0: 0x00000000 | data3
[   29.101771] iwlwifi 0000:01:00.0: 0x00000000 | beacon time
[   29.101778] iwlwifi 0000:01:00.0: 0x00011825 | tsf low
[   29.101784] iwlwifi 0000:01:00.0: 0x00000000 | tsf hi
[   29.101791] iwlwifi 0000:01:00.0: 0x00000000 | time gp1
[   29.101748]  iwl_trans_pcie_send_hcmd_sync+0x36f/0x380 [iwlwifi]
[   29.101798] iwlwifi 0000:01:00.0: 0x0003BCCD | time gp2
[   29.101803] iwlwifi 0000:01:00.0: 0x00000001 | uCode revision type
[   29.101808] iwlwifi 0000:01:00.0: 0x00000062 | uCode version major
[   29.101813] iwlwifi 0000:01:00.0: 0xD661C37C | uCode version minor
[   29.101818] iwlwifi 0000:01:00.0: 0x00000472 | hw version
[   29.101823] iwlwifi 0000:01:00.0: 0x18C80002 | board version
[   29.101828] iwlwifi 0000:01:00.0: 0x800CFD1B | hcmd
[   29.101847] iwlwifi 0000:01:00.0: 0x00020000 | isr0
[   29.101854] iwlwifi 0000:01:00.0: 0x60000000 | isr1
[   29.101860] iwlwifi 0000:01:00.0: 0x58F00002 | isr2
[   29.101866] iwlwifi 0000:01:00.0: 0x00C0000C | isr3
[   29.101873] iwlwifi 0000:01:00.0: 0x02000000 | isr4
[   29.101879] iwlwifi 0000:01:00.0: 0x00000000 | last cmd Id
[   29.101849]  iwl_trans_pcie_send_hcmd+0xbb/0x1a0 [iwlwifi]
[   29.101886] iwlwifi 0000:01:00.0: 0x00015FC2 | wait_event
[   29.101891] iwlwifi 0000:01:00.0: 0x10000017 | l2p_control
[   29.101896] iwlwifi 0000:01:00.0: 0x00000000 | l2p_duration
[   29.101901] iwlwifi 0000:01:00.0: 0x00000000 | l2p_mhvalid
[   29.101906] iwlwifi 0000:01:00.0: 0x00000000 | l2p_addr_match
[   29.101910] iwlwifi 0000:01:00.0: 0x0000000B | lmpm_pmg_sel
[   29.101915] iwlwifi 0000:01:00.0: 0x00000000 | timestamp
[   29.101933] iwlwifi 0000:01:00.0: 0x00000024 | flow_handler
[   29.101921]  iwl_trans_send_cmd+0x6c/0x120 [iwlwifi]
[   29.101997] iwlwifi 0000:01:00.0: Start IWL Error Log Dump:
[   29.102001] iwlwifi 0000:01:00.0: Transport status: 0x0000004A, valid: 6
[   29.102007] iwlwifi 0000:01:00.0: Loaded firmware version: 98.d661c37c.0
gl-c0-fm-c0-98.ucode
[   29.102018] iwlwifi 0000:01:00.0: 0x00000071 | NMI_INTERRUPT_UMAC_FATAL=
=20=20=20=20
[   29.102026] iwlwifi 0000:01:00.0: 0x000002F0 | trm_hw_status0
[   29.102033] iwlwifi 0000:01:00.0: 0x00000000 | trm_hw_status1
[   29.102039] iwlwifi 0000:01:00.0: 0x002C40D6 | branchlink2
[   29.102046] iwlwifi 0000:01:00.0: 0x002B8AC4 | interruptlink1
[   29.102052] iwlwifi 0000:01:00.0: 0x002B8AC4 | interruptlink2
[   29.102059] iwlwifi 0000:01:00.0: 0x002A58C6 | data1
[   29.102064] iwlwifi 0000:01:00.0: 0x00000010 | data2
[   29.102068] iwlwifi 0000:01:00.0: 0x00000000 | data3
[   29.102073] iwlwifi 0000:01:00.0: 0x00000000 | beacon time
[   29.102078] iwlwifi 0000:01:00.0: 0x00011825 | tsf low
[   29.102083] iwlwifi 0000:01:00.0: 0x00000000 | tsf hi
[   29.102087] iwlwifi 0000:01:00.0: 0x00000000 | time gp1
[   29.102103] iwlwifi 0000:01:00.0: 0x0003BCCD | time gp2
[   29.102110] iwlwifi 0000:01:00.0: 0x00000001 | uCode revision type
[   29.102117] iwlwifi 0000:01:00.0: 0x00000062 | uCode version major
[   29.102123] iwlwifi 0000:01:00.0: 0xD661C37C | uCode version minor
[   29.102130] iwlwifi 0000:01:00.0: 0x00000472 | hw version
[   29.102135] iwlwifi 0000:01:00.0: 0x18C80002 | board version
[   29.102140] iwlwifi 0000:01:00.0: 0x8008FF05 | hcmd
[   29.102144] iwlwifi 0000:01:00.0: 0x00020000 | isr0
[   29.102149] iwlwifi 0000:01:00.0: 0x60000000 | isr1
[   29.102164] iwlwifi 0000:01:00.0: 0x58F00002 | isr2
[   29.102171] iwlwifi 0000:01:00.0: 0x00C0001C | isr3
[   29.102177] iwlwifi 0000:01:00.0: 0x02000000 | isr4
[   29.102184] iwlwifi 0000:01:00.0: 0x00000000 | last cmd Id
[   29.102190] iwlwifi 0000:01:00.0: 0x002A58C6 | wait_event
[   29.102154]  ? iwl_pcie_check_hw_rf_kill+0x24/0xc0 [iwlwifi]
[   29.102197] iwlwifi 0000:01:00.0: 0x10000017 | l2p_control
[   29.102202] iwlwifi 0000:01:00.0: 0x00000000 | l2p_duration
[   29.102207] iwlwifi 0000:01:00.0: 0x00000000 | l2p_mhvalid
[   29.102211] iwlwifi 0000:01:00.0: 0x00000000 | l2p_addr_match
[   29.102216] iwlwifi 0000:01:00.0: 0x0000000B | lmpm_pmg_sel
[   29.102221] iwlwifi 0000:01:00.0: 0x00000000 | timestamp
[   29.102225] iwlwifi 0000:01:00.0: 0x00000024 | flow_handler
[   29.102259] iwlwifi 0000:01:00.0: Start IWL Error Log Dump:
[   29.102276] iwlwifi 0000:01:00.0: Transport status: 0x0000004A, valid: 7
[   29.102285] iwlwifi 0000:01:00.0: PNVM data is missing, please install
iwlwifi-gl-c0-fm-c0.pnvm
[   29.102295] iwlwifi 0000:01:00.0: 0x2010070D | PNVM_MISSING
[   29.102302] iwlwifi 0000:01:00.0: 0x00000000 | umac branchlink1
[   29.102309] iwlwifi 0000:01:00.0: 0xC008088A | umac branchlink2
[   29.102316] iwlwifi 0000:01:00.0: 0x0001FDE2 | umac interruptlink1
[   29.102321] iwlwifi 0000:01:00.0: 0x0105744A | umac interruptlink2
[   29.102326] iwlwifi 0000:01:00.0: 0x00000005 | umac data1
[   29.102331] iwlwifi 0000:01:00.0: 0xDEADBEEF | umac data2
[   29.102342] iwlwifi 0000:01:00.0: 0xDEADBEEF | umac data3
[   29.102349] iwlwifi 0000:01:00.0: 0x00000062 | umac major
[   29.102356] iwlwifi 0000:01:00.0: 0xD661C37C | umac minor
[   29.102362] iwlwifi 0000:01:00.0: 0x0003BCC0 | frame pointer
[   29.102369] iwlwifi 0000:01:00.0: 0xD00D5EC8 | stack pointer
[   29.102339]  _iwl_op_mode_start+0x70/0x100 [iwlwifi]
[   29.102376] iwlwifi 0000:01:00.0: 0x0001016A | last host cmd
[   29.102380] iwlwifi 0000:01:00.0: 0x00000000 | isr status reg
[   29.102420] iwlwifi 0000:01:00.0: TCM1 status:
[   29.102407]  iwl_opmode_register+0x7f/0x100 [iwlwifi]
[   29.102458] iwlwifi 0000:01:00.0: 0x00000070 | error ID
[   29.102463] iwlwifi 0000:01:00.0: 0x00001B8A | tcm branchlink2
[   29.102474] iwlwifi 0000:01:00.0: 0x00001F4C | tcm interruptlink1
[   29.102481] iwlwifi 0000:01:00.0: 0x00001F4C | tcm interruptlink2
[   29.102488] iwlwifi 0000:01:00.0: 0x40000000 | tcm data1
[   29.102495] iwlwifi 0000:01:00.0: 0xDEADBEEF | tcm data2
[   29.102500] iwlwifi 0000:01:00.0: 0xDEADBEEF | tcm data3
[   29.102505] iwlwifi 0000:01:00.0: 0x00001C08 | tcm log PC
[   29.102510] iwlwifi 0000:01:00.0: 0x00803FF0 | tcm frame pointer
[   29.102523] iwlwifi 0000:01:00.0: 0x00803F5C | tcm stack pointer
[   29.102530] iwlwifi 0000:01:00.0: 0x00000000 | tcm msg ID
[   29.102537] iwlwifi 0000:01:00.0: 0x40080000 | tcm ISR status
[   29.102543] iwlwifi 0000:01:00.0: 0x000002F0 | tcm HW status[0]
[   29.102549] iwlwifi 0000:01:00.0: 0x00000000 | tcm HW status[1]
[   29.102554] iwlwifi 0000:01:00.0: 0x00000000 | tcm HW status[2]
[   29.102567] iwlwifi 0000:01:00.0: 0x00008100 | tcm HW status[3]
[   29.102575] iwlwifi 0000:01:00.0: 0x00000000 | tcm HW status[4]
[   29.102580] iwlwifi 0000:01:00.0: 0x00000000 | tcm SW status[0]
[   29.102621] iwlwifi 0000:01:00.0: RCM1 status:
[   29.102634] iwlwifi 0000:01:00.0: 0x00000070 | error ID
[   29.102641] iwlwifi 0000:01:00.0: 0x00001E02 | rcm branchlink2
[   29.102649] iwlwifi 0000:01:00.0: 0x00002780 | rcm interruptlink1
[   29.102656] iwlwifi 0000:01:00.0: 0x00002780 | rcm interruptlink2
[   29.102663] iwlwifi 0000:01:00.0: 0x20000000 | rcm data1
[   29.102671] iwlwifi 0000:01:00.0: 0xDEADBEEF | rcm data2
[   29.102679] iwlwifi 0000:01:00.0: 0xDEADBEEF | rcm data3
[   29.102686] iwlwifi 0000:01:00.0: 0x00001E6C | rcm log PC
[   29.102693] iwlwifi 0000:01:00.0: 0x00803FF0 | rcm frame pointer
[   29.102701] iwlwifi 0000:01:00.0: 0x00803F5C | rcm stack pointer
[   29.102709] iwlwifi 0000:01:00.0: 0x00000000 | rcm msg ID
[   29.102716] iwlwifi 0000:01:00.0: 0x20000000 | rcm ISR status
[   29.102724] iwlwifi 0000:01:00.0: 0x00420500 | frame HW status
[   29.102732] iwlwifi 0000:01:00.0: 0x00000000 | LMAC-to-RCM request mbox
[   29.102741] iwlwifi 0000:01:00.0: 0x00000000 | RCM-to-LMAC request mbox
[   29.102749] iwlwifi 0000:01:00.0: 0x00000000 | MAC header control
[   29.102757] iwlwifi 0000:01:00.0: 0x00000000 | MAC header addr1 low
[   29.102764] iwlwifi 0000:01:00.0: 0x003C0000 | MAC header info
[   29.102773] iwlwifi 0000:01:00.0: 0x00000000 | MAC header error
[   29.102816] iwlwifi 0000:01:00.0: TCM2 status:
[   29.102821] iwlwifi 0000:01:00.0: 0x00000070 | error ID
[   29.102825] iwlwifi 0000:01:00.0: 0x00001B8A | tcm branchlink2
[   29.102832] iwlwifi 0000:01:00.0: 0x00001F4C | tcm interruptlink1
[   29.102839] iwlwifi 0000:01:00.0: 0x00001F4C | tcm interruptlink2
[   29.102845] iwlwifi 0000:01:00.0: 0x40000000 | tcm data1
[   29.102845] iwlwifi 0000:01:00.0: Failed to send PHY config command: -5
[   29.102852] iwlwifi 0000:01:00.0: 0xDEADBEEF | tcm data2
[   29.102856] iwlwifi 0000:01:00.0: 0xDEADBEEF | tcm data3
[   29.102863] iwlwifi 0000:01:00.0: 0x00001C08 | tcm log PC
[   29.102870] iwlwifi 0000:01:00.0: 0x00803FF0 | tcm frame pointer
[   29.102876] iwlwifi 0000:01:00.0: 0x00803F5C | tcm stack pointer
[   29.102883] iwlwifi 0000:01:00.0: 0x00000000 | tcm msg ID
[   29.102889] iwlwifi 0000:01:00.0: 0x40080000 | tcm ISR status
[   29.102895] iwlwifi 0000:01:00.0: 0x000002F0 | tcm HW status[0]
[   29.102902] iwlwifi 0000:01:00.0: 0x00000000 | tcm HW status[1]
[   29.102909] iwlwifi 0000:01:00.0: 0x00000000 | tcm HW status[2]
[   29.102916] iwlwifi 0000:01:00.0: 0x00008000 | tcm HW status[3]
[   29.102923] iwlwifi 0000:01:00.0: 0x00000000 | tcm HW status[4]
[   29.102929] iwlwifi 0000:01:00.0: 0x00000000 | tcm SW status[0]
[   29.102971] iwlwifi 0000:01:00.0: RCM2 status:
[   29.102977] iwlwifi 0000:01:00.0: 0x00000070 | error ID
[   29.102984] iwlwifi 0000:01:00.0: 0x00001E02 | rcm branchlink2
[   29.102990] iwlwifi 0000:01:00.0: 0x00002780 | rcm interruptlink1
[   29.102997] iwlwifi 0000:01:00.0: 0x00002780 | rcm interruptlink2
[   29.103003] iwlwifi 0000:01:00.0: 0x20000000 | rcm data1
[   29.103009] iwlwifi 0000:01:00.0: 0xDEADBEEF | rcm data2
[   29.103016] iwlwifi 0000:01:00.0: 0xDEADBEEF | rcm data3
[   29.103022] iwlwifi 0000:01:00.0: 0x00001E6C | rcm log PC
[   29.103029] iwlwifi 0000:01:00.0: 0x00803FF0 | rcm frame pointer
[   29.103035] iwlwifi 0000:01:00.0: 0x00803F5C | rcm stack pointer
[   29.103042] iwlwifi 0000:01:00.0: 0x00000000 | rcm msg ID
[   29.103048] iwlwifi 0000:01:00.0: 0x20000000 | rcm ISR status
[   29.103055] iwlwifi 0000:01:00.0: 0x00420500 | frame HW status
[   29.103061] iwlwifi 0000:01:00.0: 0x00000000 | LMAC-to-RCM request mbox
[   29.103068] iwlwifi 0000:01:00.0: 0x00000000 | RCM-to-LMAC request mbox
[   29.103074] iwlwifi 0000:01:00.0: 0x00000000 | MAC header control
[   29.103081] iwlwifi 0000:01:00.0: 0x00000000 | MAC header addr1 low
[   29.103087] iwlwifi 0000:01:00.0: 0x003C0000 | MAC header info
[   29.103093] iwlwifi 0000:01:00.0: 0x00000000 | MAC header error
[   29.103114] iwlwifi 0000:01:00.0: IML/ROM dump:
[   29.103120] iwlwifi 0000:01:00.0: 0x00000B03 | IML/ROM error/state
[   29.103145] iwlwifi 0000:01:00.0: 0x0000EE38 | IML/ROM data1
[   29.103171] iwlwifi 0000:01:00.0: 0x00000080 | IML/ROM WFPM_AUTH_KEY_0
[   29.103191] iwlwifi 0000:01:00.0: Fseq Registers:
[   29.103204] iwlwifi 0000:01:00.0: 0x67A00000 | FSEQ_ERROR_CODE
[   29.103219] iwlwifi 0000:01:00.0: 0x80B10005 | FSEQ_TOP_INIT_VERSION
[   29.103233] iwlwifi 0000:01:00.0: 0x00570000 | FSEQ_CNVIO_INIT_VERSION
[   29.103247] iwlwifi 0000:01:00.0: 0x0000AA14 | FSEQ_OTP_VERSION
[   29.103261] iwlwifi 0000:01:00.0: 0x0000000F | FSEQ_TOP_CONTENT_VERSION
[   29.103275] iwlwifi 0000:01:00.0: 0x4552414E | FSEQ_ALIVE_TOKEN
[   29.103289] iwlwifi 0000:01:00.0: 0x02001910 | FSEQ_CNVI_ID
[   29.103304] iwlwifi 0000:01:00.0: 0x02001910 | FSEQ_CNVR_ID
[   29.103318] iwlwifi 0000:01:00.0: 0x02001910 | CNVI_AUX_MISC_CHIP
[   29.103334] iwlwifi 0000:01:00.0: 0x02001910 | CNVR_AUX_MISC_CHIP
[   29.103351] iwlwifi 0000:01:00.0: 0x00001BED |
CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
[   29.103369] iwlwifi 0000:01:00.0: 0x00000000 |
CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
[   29.103383] iwlwifi 0000:01:00.0: 0x00570000 | FSEQ_PREV_CNVIO_INIT_VERS=
ION
[   29.103397] iwlwifi 0000:01:00.0: 0x00B10005 | FSEQ_WIFI_FSEQ_VERSION
[   29.103411] iwlwifi 0000:01:00.0: 0xCB3129C8 | FSEQ_BT_FSEQ_VERSION
[   29.103425] iwlwifi 0000:01:00.0: 0x000000BF | FSEQ_CLASS_TP_VERSION
[   29.103459] iwlwifi 0000:01:00.0: UMAC CURRENT PC: 0x802876d2
[   29.103474] iwlwifi 0000:01:00.0: LMAC1 CURRENT PC: 0xd0
[   29.103489] iwlwifi 0000:01:00.0: LMAC2 CURRENT PC: 0xd0
[   29.103502] iwlwifi 0000:01:00.0: UMAC CURRENT PC 1: 0x802876d0
[   29.103516] iwlwifi 0000:01:00.0: TCM1 CURRENT PC: 0xd0
[   29.103529] iwlwifi 0000:01:00.0: RCM1 CURRENT PC: 0xd0
[   29.103543] iwlwifi 0000:01:00.0: RCM2 CURRENT PC: 0xd0
[   29.103557] iwlwifi 0000:01:00.0: Function Scratch status:
[   29.103564] iwlwifi 0000:01:00.0: 0x01010101 | Func Scratch
[   29.164125] iwlwifi 0000:01:00.0: WRT: Collecting data: ini trigger 4 fi=
red
(delay=3D0ms).
[   29.164145] iwlwifi 0000:01:00.0: Device is not enabled - cannot dump er=
ror
[   29.165055] iwlwifi 0000:01:00.0: Device error - SW reset
[   29.165059] iwlwifi 0000:01:00.0: WRT: Collecting data: ini trigger 4 fi=
red
(delay=3D0ms).
[   29.224307] WARNING: CPU: 1 PID: 421 at
drivers/net/wireless/intel/iwlwifi/pcie/trans.c:2448
__iwl_trans_pcie_grab_nic_access+0x195/0x1a0 [iwlwifi]
[   29.224344] Modules linked in: snd_hda_codec_hdmi snd_ctl_led snd_soc_avs
snd_soc_hda_codec snd_hda_ext_core snd_hda_codec_realtek snd_hda_codec_gene=
ric
snd_hda_scodec_component snd_soc_core snd_compress ac97_bus snd_pcm_dmaengi=
ne
snd_hda_intel snd_intel_dspcfg intel_rapl_msr intel_rapl_common
intel_tcc_cooling x86_pkg_temp_thermal snd_intel_sdw_acpi snd_hda_codec
intel_powerclamp snd_hda_core snd_hwdep snd_pcm coretemp mei_pxp snd_seq_mi=
di
kvm_intel mei_hdcp binfmt_misc kvm snd_seq_midi_event iwlmld(+) irqbypass
platform_profile joydev input_leds nls_iso8859_1 snd_rawmidi mac80211 rapl
libarc4 snd_seq snd_seq_device intel_cstate iwlwifi dell_wmi dell_smbios
snd_timer dcdbas sparse_keymap dell_wmi_descriptor wmi_bmof at24 mei_me
cfg80211 serio_raw snd intel_pmc_core intel_pch_thermal soundcore mei
pmt_telemetry pmt_class intel_pmc_ssram_telemetry mac_hid intel_vsec acpi_p=
ad
sch_fq_codel ipmi_devintf ipmi_msghandler msr parport_pc ppdev lp parport
ramoops reed_solomon efi_pstore pstore_blk pstore_zone ip_tables
[   29.224450] Workqueue: events_unbound iwl_trans_restart_wk [iwlwifi]
[   29.224479] RIP: 0010:__iwl_trans_pcie_grab_nic_access+0x195/0x1a0 [iwlw=
ifi]
[   29.224526]  iwl_trans_pcie_grab_nic_access+0x1c/0x50 [iwlwifi]
[   29.224548]  _iwl_trans_grab_nic_access+0xe/0x20 [iwlwifi]
[   29.224571]  iwl_read_prph+0x17/0x60 [iwlwifi]
[   29.224589]  iwl_dump_ini_prph_mac_iter+0x45/0x80 [iwlwifi]
[   29.224616]  iwl_dump_ini_mem+0x1df/0x340 [iwlwifi]
[   29.224640]  iwl_dump_ini_dump_regions+0x99/0x260 [iwlwifi]
[   29.224662]  iwl_dump_ini_trigger+0x128/0x180 [iwlwifi]
[   29.224685]  iwl_fw_error_ini_dump+0x86/0x1b0 [iwlwifi]
[   29.224706]  iwl_fw_dbg_collect_sync+0x1c9/0x3a0 [iwlwifi]
[   29.224726]  ? __iwl_warn+0x79/0xf0 [iwlwifi]
[   29.224756]  ? iwl_fw_ini_trigger_on+0x58/0x110 [iwlwifi]
[   29.224779]  iwl_fw_dbg_ini_collect+0x177/0x210 [iwlwifi]
[   29.224804]  iwl_dbg_tlv_tp_trigger.isra.0+0xcd/0x1c0 [iwlwifi]
[   29.224829]  _iwl_dbg_tlv_time_point+0x103/0x1f0 [iwlwifi]
[   29.224874]  iwl_trans_restart_wk+0x83/0x3d0 [iwlwifi]
[   29.224933] iwlwifi 0000:01:00.0: iwlwifi transaction failed, dumping
registers
[   29.224937] iwlwifi 0000:01:00.0: iwlwifi device config registers:
[   29.225027] iwlwifi 0000:01:00.0: 00000000: 272b8086 00100506 0280001a
00800000 f7100004 00000000 00000000 00000000
[   29.225030] iwlwifi 0000:01:00.0: 00000020: 00000000 00000000 00000000
00f48086 00000000 00000040 00000000 0000010b
[   29.225033] iwlwifi 0000:01:00.0: 00000040: c9c35001 0d000008 00000000
00000000 00807005 00000000 00000000 00000000
[   29.225035] iwlwifi 0000:01:00.0: 00000060: 00000000 00000000 00000000
00000000 0002b010 112c8fc0 0019281f 00476814
[   29.225038] iwlwifi 0000:01:00.0: 00000080: 10130040 00000000 00000000
00000000 00000000 00010810 00000410 0180001e
[   29.225040] iwlwifi 0000:01:00.0: 000000a0: 011f0004 00000000 00000000
00000000 801f0011 00002000 00003000 00000000
[   29.225042] iwlwifi 0000:01:00.0: 000000c0: 00000000 00000000 00000000
00000000 00000000 00000000 00000000 00000000
[   29.225044] iwlwifi 0000:01:00.0: 000000e0: 00000000 00000000 00000000
00000000 00000000 00000000 00000000 00000000
[   29.225047] iwlwifi 0000:01:00.0: 00000100: 14820001 00000000 00400000
00462030 00002000 0000e000 000002a0 00000000
[   29.225049] iwlwifi 0000:01:00.0: 00000120: 00000000 00000000 00000000
00000000 00000000 00000000 00000000 00000000
[   29.225051] iwlwifi 0000:01:00.0: 00000140: 00000000 00000000 15810019
00000000 00000000 00002700 17c10026 00000000
[   29.225053] iwlwifi 0000:01:00.0: iwlwifi device memory mapped registers:
[   29.225076] iwlwifi 0000:01:00.0: 00000000: 18880000 d55555d5 00000000
00000000 00000000 00000000 00000000 00000000
[   29.225078] iwlwifi 0000:01:00.0: 00000020: 00000000 09000000 00000472
01010000 c88a9a6c 0000ff07 00000000 00000000
[   29.225080] iwlwifi 0000:01:00.0: iwlwifi device AER capability structur=
e:
[   29.225088] iwlwifi 0000:01:00.0: 00000000: 14820001 00000000 00400000
00462030 00002000 0000e000 000002a0 00000000
[   29.225090] iwlwifi 0000:01:00.0: 00000020: 00000000 00000000 00000000
[   29.225092] iwlwifi 0000:01:00.0: iwlwifi parent port (0000:00:01.0) con=
fig
registers:
[   29.225122] iwlwifi 0000:00:01.0: 00000000: 19018086 00100507 06040007
00810000 00000000 00000000 00010100 000000f0
[   29.225125] iwlwifi 0000:00:01.0: 00000020: f710f710 0001fff1 00000000
00000000 00000000 00000088 00000000 0012010b
[   29.225127] iwlwifi 0000:00:01.0: 00000040: 00000000 00000000 00000000
00000000 00000000 00000000 00000000 00000000
[   29.225129] iwlwifi 0000:00:01.0: 00000060: 00000000 00000000 00000000
00000000 00000000 00000000 00011085 0a000000
[   29.225131] iwlwifi 0000:00:01.0: 00000080: c8039001 00000008 0000800d
06bb1028 0001a005 fee00218 00000000 00000000
[   29.225134] iwlwifi 0000:00:01.0: 000000a0: 01420010 00008001 00000000
0261ad03 10130c40 00142580 00480000 00000008
[   29.225136] iwlwifi 0000:00:01.0: 000000c0: 00000000 00080b80 00006400
0000000e 001e0043 00000000 00000000 00000000
[   29.225138] iwlwifi 0000:00:01.0: 000000e0: 00000000 00000000 00000000
00000000 1400c000 2001014e 00000000 001000e0
[   29.225140] iwlwifi 0000:00:01.0: 00000100: 14010002 00000000 00000000
00000000 00000001 800000ff 00000000 00000000
[   29.225143] iwlwifi 0000:00:01.0: 00000120: 00000000 00000000 00000000
00000000 00000000 00000000 00000000 00000000
[   29.225145] iwlwifi 0000:00:01.0: 00000140: d9410005 02010100 00000000
00000000 00010001 00000000 fed19000 00000000
[   29.225147] iwlwifi 0000:00:01.0: 00000160: 00000000 00000000 00000000
00000000 00000000 00000000 00000000 00000000
[   29.225149] iwlwifi 0000:00:01.0: 00000180: 00000000 00000000 00000000
00000000 00000000 00000000 00000000 00000000
[   29.225152] iwlwifi 0000:00:01.0: 000001a0: 00000000 00000000 00000000
00000000 00000000 00000000 00000000 00000000
[   29.225154] iwlwifi 0000:00:01.0: 000001c0: d9410001 00000000 00000000
00064010 00000000 00002000 00000000 00000000
[   29.225156] iwlwifi 0000:00:01.0: 000001e0: 00000000 00000000 00000000
00000000 00000000 00000000 04010800 7c000000
[   29.225158] iwlwifi 0000:00:01.0: 00000200: 80000000 00f48000 400074b0
[   56.167617] Modules linked in: snd_hda_codec_hdmi snd_ctl_led snd_soc_avs
snd_soc_hda_codec snd_hda_ext_core snd_hda_codec_realtek snd_hda_codec_gene=
ric
snd_hda_scodec_component snd_soc_core snd_compress ac97_bus snd_pcm_dmaengi=
ne
snd_hda_intel snd_intel_dspcfg intel_rapl_msr intel_rapl_common
intel_tcc_cooling x86_pkg_temp_thermal snd_intel_sdw_acpi snd_hda_codec
intel_powerclamp snd_hda_core snd_hwdep snd_pcm coretemp mei_pxp snd_seq_mi=
di
kvm_intel mei_hdcp binfmt_misc kvm snd_seq_midi_event iwlmld(+) irqbypass
platform_profile joydev input_leds nls_iso8859_1 snd_rawmidi mac80211 rapl
libarc4 snd_seq snd_seq_device intel_cstate iwlwifi dell_wmi dell_smbios
snd_timer dcdbas sparse_keymap dell_wmi_descriptor wmi_bmof at24 mei_me
cfg80211 serio_raw snd intel_pmc_core intel_pch_thermal soundcore mei
pmt_telemetry pmt_class intel_pmc_ssram_telemetry mac_hid intel_vsec acpi_p=
ad
sch_fq_codel ipmi_devintf ipmi_msghandler msr parport_pc ppdev lp parport
ramoops reed_solomon efi_pstore pstore_blk pstore_zone ip_tables
[   56.167689] Workqueue: events_unbound iwl_trans_restart_wk [iwlwifi]
[   56.167746]  iwl_poll_bit+0x36/0x80 [iwlwifi]
[   56.167763]  __iwl_trans_pcie_grab_nic_access+0xbb/0x1a0 [iwlwifi]
[   56.167784]  iwl_trans_pcie_grab_nic_access+0x1c/0x50 [iwlwifi]
[   56.167802]  _iwl_trans_grab_nic_access+0xe/0x20 [iwlwifi]
[   56.167824]  iwl_read_prph+0x17/0x60 [iwlwifi]
[   56.167840]  iwl_dump_ini_prph_mac_iter+0x45/0x80 [iwlwifi]
[   56.167864]  iwl_dump_ini_mem+0x1df/0x340 [iwlwifi]
[   56.167885]  iwl_dump_ini_dump_regions+0x99/0x260 [iwlwifi]
[   56.167906]  iwl_dump_ini_trigger+0x128/0x180 [iwlwifi]
[   56.167926]  iwl_fw_error_ini_dump+0x86/0x1b0 [iwlwifi]
[   56.167945]  iwl_fw_dbg_collect_sync+0x1c9/0x3a0 [iwlwifi]
[   56.167963]  ? __iwl_warn+0x79/0xf0 [iwlwifi]
[   56.167990]  ? iwl_fw_ini_trigger_on+0x58/0x110 [iwlwifi]
[   56.168012]  iwl_fw_dbg_ini_collect+0x177/0x210 [iwlwifi]
[   56.168034]  iwl_dbg_tlv_tp_trigger.isra.0+0xcd/0x1c0 [iwlwifi]
[   56.168058]  _iwl_dbg_tlv_time_point+0x103/0x1f0 [iwlwifi]
[   56.168104]  iwl_trans_restart_wk+0x83/0x3d0 [iwlwifi]
[   60.171401] iwlwifi 0000:01:00.0: WRT: Failed to dump region: id=3D2, ty=
pe=3D11
[   60.532605] iwlwifi 0000:01:00.0: Failed to get monitor header
[   60.532612] iwlwifi 0000:01:00.0: WRT: Failed to fill region header: id=
=3D16,
type=3D2
[   64.500838] iwlwifi 0000:01:00.0: Failed to get monitor header
[   64.500845] iwlwifi 0000:01:00.0: WRT: Failed to fill region header: id=
=3D32,
type=3D18

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
