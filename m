Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA5A1B85D0
	for <linux-bluetooth@vger.kernel.org>; Mon,  4 Nov 2024 13:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730725627; cv=none; b=imvxmHgmW+0QVtzKWT/9rgyBVdjPxwmN6GuN7o/+mMOanAeJhXb8NuhAvDKzs97UG/MxhHRfD3jzwyJlEFgjo4/3zF4S3hLq19tWp7RawK1BcLNa0gM4RYKXbHIDUC+xxMtJ22fRNsrIsWAW4Yjn2piFanCuBotMZ4V3WwG2aAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730725627; c=relaxed/simple;
	bh=PeACPRvajNFLvGPYx0QWUR+2a9g11uSXAcaN/fvLvrw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W4AUMamrx0FSFpb6YvTKNRY4rrDowQBSGSbmJt+31XF5RYBNd8EsRO4chylbDc4ykahayVrZIz5G3q3AvUB9eU8Ubr4pT1s2eaAWiS+nKqDuq2gV3pCsA7xRJny7dWpX0grjgjtseGklBuq9abYlTyXbxhMZ2de5b6ckGQiqisE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QNNZ/vLi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QNNZ/vLi"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 22F2FC4CED1
	for <linux-bluetooth@vger.kernel.org>; Mon,  4 Nov 2024 13:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730725627;
	bh=PeACPRvajNFLvGPYx0QWUR+2a9g11uSXAcaN/fvLvrw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=QNNZ/vLiAHsMnqqvyQCl9AXo232oTcuBRsMZsnBzwYnLtnYpiSAxHqVLQQ8bx5aRJ
	 Ue6o+d1SlU7197qRF09C/MSmkU8MfEgFrzwcwSdfVkCoPcmnmNcv3fRBkeFOnWe+b/
	 IWMaONGzPimdgTsn+FlmoYFw6u5E8cT6Zu/Sta1y2GPE3Gys0BKqUOm+eT8uRUtmAX
	 MVSX1PDsjAmMjv2tjMRNWtuFluvAK6I7/6A/G+kpPaRMb+nCV/2zy0M0d5unin6rqA
	 pY6Dg3DRvdO2Nc5Hsrwl7l+WjRFEGskR+ysNUPmbE7kRNsLOv14apfHuak+aibATgK
	 rTkE18VgMjcMQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 19660C53BCA; Mon,  4 Nov 2024 13:07:07 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219387] Bluetooth: hci0: Reading supported features failed
 (-16)
Date: Mon, 04 Nov 2024 13:07:06 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: pmenzel+bugzilla.kernel.org@molgen.mpg.de
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219387-62941-wWzaFsbMCe@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219387-62941@https.bugzilla.kernel.org/>
References: <bug-219387-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219387

--- Comment #8 from Paul Menzel (pmenzel+bugzilla.kernel.org@molgen.mpg.de)=
 ---
The error is logged by `btintel_read_debug_features()` in
`drivers/bluetooth/btintel.c`.

```
static int btintel_read_debug_features(struct hci_dev *hdev,
                                       struct intel_debug_features *feature=
s)
{
        struct sk_buff *skb;=20
        u8 page_no =3D 1;

        /* Intel controller supports two pages, each page is of 128-bit
         * feature bit mask. And each bit defines specific feature support
         */
        skb =3D __hci_cmd_sync(hdev, 0xfca6, sizeof(page_no), &page_no,
                             HCI_INIT_TIMEOUT);
        if (IS_ERR(skb)) {
                bt_dev_err(hdev, "Reading supported features failed (%ld)",
                           PTR_ERR(skb));
                return PTR_ERR(skb);
        }

[=E2=80=A6]
}
```

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
