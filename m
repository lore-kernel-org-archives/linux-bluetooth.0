Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF7B647
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jan 2025 04:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738036970; cv=none; b=lHKpNGmo+5Ug4rQoBcPNsbjKS5YC5e99V9YLzOPe0hHfxDwXYLYnGQ47RZ4rv/8zLZBVgcC9bs/ij8/VJOf9aFcu75y3u0yMQmPkXwqSIJPkKaIzdnxXCe6IXnh9Vq5t4ZXVndCfiwl2thnJ71kQw5P5TNAGpYyyZVvA7rRj6kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738036970; c=relaxed/simple;
	bh=zT6YhB8g04y86/Ckr8wsLu+H7+YmWIcL/sW7XO9fWcs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C3ZvNX4l9xGyG7Z8xuVhO3kwvoXfwQ2HdJeB3iLP2k/McKNiJ0GAZ0Jgy0ktnS7L8NKnc7YBgwWrWePqqmlkMBLMe+0h7nCcNGSYAYoVQ86j/jtX3P/GLUFvYO3VEypEB5Es7m/XA/HMql3BsGJ4jwqRPpH1/jFfAyYmVPnP1KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qFAkzEyG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qFAkzEyG"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3E331C4CEE2
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jan 2025 04:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738036969;
	bh=zT6YhB8g04y86/Ckr8wsLu+H7+YmWIcL/sW7XO9fWcs=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=qFAkzEyGeNjpTrpyWwEEEUHiXvEF2QeTYb/RW85pvs1BSz3SG/ip6iJyX+erlivza
	 GQ+5zRT5CB/u2QK9lciyhCAGurZE4dZwg9neY89PLN8saUl0LWTAi3jiPzJXVxga8Y
	 +Z5FX2GpyX5IJzQ9sXr95jRFx9f6vvLhPIAJn3VPrLCFG+CBGpj7hKoLDTDFiYEd2H
	 z2hbn2/RKUxAAK3CatXYatDZ3uA7JypHML3vPLUSMoVj16nocxe0UGnyjToWY9iMBV
	 cO5EPMRNb19B4vxxmPKXoP8kVhk6XvNd+5wxVnZbyQxV1pzghN6NR1QTTENdE7ykHK
	 syNivGTXnoAfw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 32B78C41615; Tue, 28 Jan 2025 04:02:49 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219387] Bluetooth: hci0: Reading supported features failed
 (-16)
Date: Tue, 28 Jan 2025 04:02:48 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: alexknoptech@protonmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219387-62941-PsFAfbo3dJ@https.bugzilla.kernel.org/>
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

--- Comment #11 from alexknoptech@protonmail.com ---
I thought this message came after the firmware file was already loaded:

```
[16265.746551] Bluetooth: hci0: Bootloader revision 0.0 build 2 week 52 2014
[16265.753389] Bluetooth: hci0: Device revision is 5
[16265.753409] Bluetooth: hci0: Secure boot is enabled
[16265.753418] Bluetooth: hci0: OTP lock is enabled
[16265.753426] Bluetooth: hci0: API lock is enabled
[16265.753432] Bluetooth: hci0: Debug lock is disabled
[16265.753439] Bluetooth: hci0: Minimum firmware build 1 week 10 2014
[16265.765087] Bluetooth: hci0: Found device firmware: intel/ibt-11-5.sfi
[16267.499721] Bluetooth: hci0: Waiting for firmware download to complete
[16267.500335] Bluetooth: hci0: Firmware loaded in 1694653 usecs
[16267.500403] Bluetooth: hci0: Waiting for device to boot
[16267.512389] Bluetooth: hci0: Device booted in 11752 usecs
[16267.512396] Bluetooth: hci0: Malformed MSFT vendor event: 0x02
[16267.512498] Bluetooth: hci0: Found Intel DDC parameters: intel/ibt-11-5.=
ddc
[16267.516460] Bluetooth: hci0: Applying Intel DDC parameters completed
[16267.517413] Bluetooth: hci0: Firmware revision 0.0 build 14 week 44 2021
>>>>[16267.519407] Bluetooth: hci0: Reading supported features failed (-16)
[16267.519423] Bluetooth: hci0: Error reading debug features

```

But also I am wondering if this log level can be changed to bt_dev_info if =
this
is not actually an issue, since the parent function simply returns that:



```
static int btintel_register_devcoredump_support(struct hci_dev *hdev)
{
        struct intel_debug_features features;
        int err;

        FUNCTION CALLED HERE WHICH LOGS AT THE ERROR LEVEL>>>>
        err =3D btintel_read_debug_features(hdev, &features);
        if (err) {
                bt_dev_info(hdev, "Error reading debug features");
                return err;
        }

        if (!(features.page1[0] & 0x3f)) {
                bt_dev_dbg(hdev, "Telemetry exception format not supported"=
);
                return -EOPNOTSUPP;
        }

        hci_devcd_register(hdev, btintel_coredump, btintel_dmp_hdr, NULL);

        return err;
}

```

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
