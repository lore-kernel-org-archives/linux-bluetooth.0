Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81010208A1
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 May 2024 08:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716540225; cv=none; b=lmTkVs5HKW46HxATapinyYFjl36XmDTBEWdxaO2N3idDvsceFD7jUXd2k+3JuoVLy4ShVJs2NLRXLVE9alLIX+w0gAii4HpM0pZilrJDAjahayojZqD22N0nsVih3fdnjarnE1BX4IDSuAVntlH3pHVPVLLSGpW6jgL5TnX2oyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716540225; c=relaxed/simple;
	bh=hz5DvcT/O2C6zCGX9Xjzq6rWrms+e1JVcGYN6MUigrs=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Bg/wb9plD/ELOKRtWSY5SfaFnNb8XOUH6smR5mTHpO/i9BN3Q/h+qSwS0r2Xf/ya/ZhQ0N4bS/E5GPai+3aB76QvoAodjVKv5AOZCmQVI9kGBckj5b4Yv55hY5i27x1zt0aHKPZenD4w6LJytI/9rwAd6TJCG81eRt208M3CnFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YpO2hzmn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YpO2hzmn"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0FCF3C2BBFC
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 May 2024 08:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716540225;
	bh=hz5DvcT/O2C6zCGX9Xjzq6rWrms+e1JVcGYN6MUigrs=;
	h=From:To:Subject:Date:From;
	b=YpO2hzmnZXkE1275nBHraViTYH0uXSJ01I4V0g7/o+v6/whkjuLcFldcuq9Gan2AZ
	 eHE33810LmQiv0iqiUcZy29ONHHgDc8fKj9MhO0Syb/6DJTDwMvtPQH09PsxJBb9x+
	 f426J8u6mLTHPHlkpXCLOOk0aNvrKVQ8/ue0tOY3MD8smf3uABNFbNwGUrhXKmkPgf
	 H5Kyx/e+MA6Twj3Ng3NxNRJfkgcaluTul55N9FLKOf+axbC1tugqukUMCmrdlahZD9
	 S9TTTX60YLaFIP4yp3W6GbhzXhUW48w4cYWiJgQS1mlk1VSbEtwEYd9iTiwZ+/ECiX
	 faUzLjOgfHwbQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 01327C53B73; Fri, 24 May 2024 08:43:44 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218880] New: HCI_EVT Packet 'Flush Occurred' Misalignment
Date: Fri, 24 May 2024 08:43:44 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: yuxuanhu@buaa.edu.cn
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-218880-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218880

            Bug ID: 218880
           Summary: HCI_EVT Packet 'Flush Occurred' Misalignment
           Product: Drivers
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: yuxuanhu@buaa.edu.cn
        Regression: No

Hi All,

Our fuzzing tool found a possible bug when testing Bluetooth RFCOMM connect=
ion:

(1) A 'Flush Occurred' HCI_EVT packet with incorrect 'parameter_total_lengt=
h'
field and parameters was maliciously sent to the host (hexadecimal content:=
 '11
3D C4 02 62 D1').

(2) Because 'hci_ev_table'(/net/bluetooth/hci_event.c: 7514) does not inclu=
de
'Flush Occurred' event, the function hci_event_func(/net/bluetooth/hci_even=
t.c:
7644) doesn't check the 'parameter_total_length' field of this packet.

(3) When the controller transmits additional HCI packets to the host, these
packets are concatenated to the previously mentioned Flush Occurred packet.
This results in the packets being disregarded by the host.

Attachment 1 is Kernel Log, which includes the printed HCI packet interacti=
ons
between the host and controller. All HCI packets following the line mention=
ed
below are ignored by the host:

'''
[ 1555.520646] <- [EVT] 11 3D C4 02 62 D1
'''

Attachment 2 contains packet captures from tshark.

It remains unclear whether this behavior constitutes a bug or a feature. We
apologize if this inquiry causes any offense.
Thank you very much for taking the time to read.

Best Regard,
Yuxuan Hu.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
