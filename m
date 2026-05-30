Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E196548EE
	for <linux-bluetooth@vger.kernel.org>; Sat, 30 May 2026 22:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780179168; cv=none; b=ssfKgnowBBwtMCt7rJrxRJ2dmNNbmJmb5BFdijVIZfsYJf38CAUMMBt0QaZwhsJqNxy3s1uRsxDXKQt5ZU8QF7+tPpBvXkLpV9T6JCsUKYJS8Kht571Rvm2FmPuTOePoz7uHzan5EgS13qbjAS4kA8Glk2MbHKLuCGJfrHwgU+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780179168; c=relaxed/simple;
	bh=f2DS6uheccaYtPYnC3HtpIMsSEXPjjgORtBj84+HPWk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GmWF8/FJ/rXH6hQAhZdk20sFeogqaAU1L1ZsMQ2cHAXMPy/Yl4EFN5ib15E4u/FancsNuMzpv6rc7hDoY3OqT2xK7h7qwCM93LaEqxuQkjBkS8UWHPKxu1XmX3LlWoQncJz7hYpCW1CeWPnjbAK62GfPY8D8XAi/XhefxWDDsEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VtvEnVWi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VtvEnVWi"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9778DC19425
	for <linux-bluetooth@vger.kernel.org>; Sat, 30 May 2026 22:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780179167;
	bh=f2DS6uheccaYtPYnC3HtpIMsSEXPjjgORtBj84+HPWk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=VtvEnVWi32h9XYiq4T4oIYJ+kZDVHn/Fm2zdeN9eCBcZ5um06gQav6+Tnchja2EPv
	 XdI/zDwfEmGZEKJS611DEcUDCrEHqZw5jO17tXwCWYdj6t+mUn9Cx1Ory2ZmUoSTjS
	 A32UdVBdeSN9YFgQuTXp0aShTlsLJMaaJXez4PDH1ZFrLeSm7KpnJnivynYksexwnE
	 tr6YvOoG+YDSECw548bMntJwLCcaYg/NfsnJEZfgFgKETf5UxoppPwd1hoe2vmTVER
	 nOnoWmDF2B4vCnfUU9DghrkqkVVt7Pnq4krQjdhVnt/VDEI0Q3kwFBU481Gl+I6k8d
	 ue4maVpnGz6gw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 774D1C3279F; Sat, 30 May 2026 22:12:47 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221598] Bluetooth: btusb/btrtl RTL8821C 0bda:c821 HFP/mSBC
 microphone stutters with bursty SCO RX delivery
Date: Sat, 30 May 2026 22:12:47 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: apocarteres@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-221598-62941-ZECWEKs7bL@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221598-62941@https.bugzilla.kernel.org/>
References: <bug-221598-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221598

--- Comment #8 from Alexander Paderin (apocarteres@gmail.com) ---
Additional update: loading the RTL8821CE Wi-Fi-side driver dramatically
improves Bluetooth HFP/mSBC RX stability on this RTL8821CE combo module.

Hardware topology:

- Bluetooth: Realtek `0bda:c821`, internal USB Full-Speed device, handled by
`btusb`
- Wi-Fi: Realtek RTL8821CE PCIe `10ec:c821`, handled by `rtw88_8821ce` /
`rtw_8821ce`

I ran the same near/far/near2 Bluetooth HFP microphone range test twice:

1. Wi-Fi driver not loaded.
2. Wi-Fi driver loaded manually, but Wi-Fi radio kept disabled in
NetworkManager.

State during the improved run:

```text
02:00.0 Network controller [0280]: Realtek Semiconductor Co., Ltd. RTL8821CE
802.11ac PCIe Wireless Network Adapter [10ec:c821]
        Kernel driver in use: rtw_8821ce
        Kernel modules: rtw88_8821ce

WIFI-HW  WIFI      WWAN-HW  WWAN
enabled  disabled  missing  enabled

wlp2s0 DOWN
```

Kernel log also showed the Wi-Fi firmware initialized:

```text
rtw_8821ce 0000:02:00.0: Firmware version 24.11.0, H2C version 12
```

Results:

| run | Wi-Fi driver | phase | RSSI avg | RSSI min | RX markers | RX bad se=
q/k
| RX bad dist/k | TX bad seq | TX bad dist |
|---|---|---|---:|---:|---:|---:|---:|---:|---:|
| `range-sco-test-20260531-005925` | not loaded | near | -38.9 | -42 | 1976=
 |
1.01 | 3.54 | 0 | 0 |
| `range-sco-test-20260531-005925` | not loaded | far | -58.1 | -70 | 3528 |
123.30 | 103.74 | 0 | 0 |
| `range-sco-test-20260531-005925` | not loaded | near2 | -49.6 | -54 | 193=
6 |
38.74 | 31.51 | 0 | 0 |
| `range-sco-test-20260531-010648` | loaded, Wi-Fi radio off | near | -46.7=
 |
-52 | 1975 | 1.01 | 1.01 | 0 | 0 |
| `range-sco-test-20260531-010648` | loaded, Wi-Fi radio off | far | -53.9 |
-60 | 3989 | 2.51 | 2.51 | 0 | 0 |
| `range-sco-test-20260531-010648` | loaded, Wi-Fi radio off | near2 | -53.=
1 |
-64 | 1984 | 6.55 | 6.55 | 0 | 0 |

The important result is the far phase:

- RX bad sequence rate dropped from `123.30/k` to `2.51/k`.
- RX bad distance rate dropped from `103.74/k` to `2.51/k`.
- TX remained clean in both runs.
- RSSI no longer collapsed to `-70 dBm`; the improved run bottomed at `-60
dBm`.

Because Wi-Fi remained disabled and the interface stayed down, this improve=
ment
does not appear to come from active Wi-Fi traffic. It appears to come from =
the
Wi-Fi-side driver/firmware initialization of the same RTL8821CE combo chip.

This strongly suggests that the Linux Bluetooth-only initialization path for
`0bda:c821` leaves the combo chip in a worse Bluetooth RX/range state than =
the
state after `rtw_8821ce` initializes the Wi-Fi side. The likely area is Rea=
ltek
combo-chip coexistence/RF/antenna-path/shared firmware state.

Practical workaround on this machine:

- keep `rtw88_8821ce` loadable and loaded at boot;
- keep Wi-Fi radio disabled if Wi-Fi is not needed.

Local captures/reports:

- `captures/range-sco-test-20260531-005925.snoop`
- `captures/range-sco-test-20260531-005925-metrics.csv`
- `reports/range-sco-test-20260531-005925-analysis.md`
- `captures/range-sco-test-20260531-010648.snoop`
- `captures/range-sco-test-20260531-010648-metrics.csv`
- `reports/range-sco-test-20260531-010648-analysis.md`
- `reports/rtl8821ce-wifi-driver-coex-range-comparison-20260531.md`

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
