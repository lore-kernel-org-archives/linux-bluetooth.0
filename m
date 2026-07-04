Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE464433E8C
	for <linux-bluetooth@vger.kernel.org>; Sat,  4 Jul 2026 16:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783183178; cv=none; b=hUdovCbFqstPqCdKhrYYLw8njtjo59MJBO3gL06EJizrIPQp++JzIfwZOUvNUaoWjv507b93uAOt36MN+CAMU/TXtQko8vFfxQIBNdcapLY7XZ1KDAnQAAIX7ZZTawLhdNZMjl+l6V/9EkNidP3e7BHpInUgBL104Livwbt2OLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783183178; c=relaxed/simple;
	bh=ccRxJrdBOW4N/rhF7ZC7u8yaBALjLt1dt94bECOKEIs=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=H7EzVAIz0ax9jdCORUgLppUY/h+tqXYE9SFEAY5VGs8boMrbTKT98+nsOaUqIYx/y9Wx24C0X+NMLmHLTiXzlRcOPaY63vwKzoD0CxGKYwSJAELxQxPqvmYGPNaHEODeRkj9Ms3D49lbGOxgP7gZF8yI8AFmSpeVfAnEHRgGv5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kzEn5QjB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kzEn5QjB"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 54729C19425
	for <linux-bluetooth@vger.kernel.org>; Sat,  4 Jul 2026 16:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783183178;
	bh=ccRxJrdBOW4N/rhF7ZC7u8yaBALjLt1dt94bECOKEIs=;
	h=From:To:Subject:Date:From;
	b=kzEn5QjB+66Gs3myf/6PuM8kK6wOL5xmTFxLJsCkjsLuSZi1D2N0Nqu0YX930SIL/
	 i7rLNsy04fIbfGVqg3V94LcA2qunohxZOiQr5H9tHgHC9N3/foAlgCbSbnhcLdlmDs
	 puYSsCyT3FUXJMhkqMugDdqIz+gJS6TZzkphZOkvqg/WDF259dbI/vWM3cu4FmlrBy
	 FqGXBJ3zRQHuPX9WuUJ3IXYZYxFHJD3UjvPgQ8SjbdUbKAxWmZHMy5AJDHgyEX/OW7
	 UK1cZTM2deRaXDl7GGQufXYlsyVxTzjn9KaE9YMmxeq9azmdpgtJ9CXl4RLnTG7Z/k
	 vN5yNbkWzE67A==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 3F0DAC433E1; Sat,  4 Jul 2026 16:39:38 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221722] New: Blanket HCI_QUIRK_BROKEN_ENHANCED_SETUP_SYNC_CONN
 for all MediaTek chips breaks HFP mSBC microphone on MT7925 (0489:e111)
Date: Sat, 04 Jul 2026 16:39:38 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: purpleritza@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-221722-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221722

            Bug ID: 221722
           Summary: Blanket HCI_QUIRK_BROKEN_ENHANCED_SETUP_SYNC_CONN for
                    all MediaTek chips breaks HFP mSBC microphone on
                    MT7925 (0489:e111)
           Product: Drivers
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: purpleritza@gmail.com
        Regression: No

SUMMARY

- One line to remove: hci_set_quirk(hdev,
HCI_QUIRK_BROKEN_ENHANCED_SETUP_SYNC_CONN)
from the IS_ENABLED(CONFIG_BT_HCIBTUSB_MTK) block in btusb_probe().
- Location: drivers/bluetooth/btusb.c, line ~4279 in current mainline.
- Rationale: Blanket quirk for all MediaTek chips is incorrect.
MT7925 firmware correctly implements HCI_Enhanced_Setup_Sync_Conn.
The quirk was added for MT7921 only; scope it per-chip or remove
blanket and rely on fallback logic.
- Kernel fallback handles failure gracefully (re-tries with legacy
command), so no audio functionality is lost even on chips that
truly don't support Enhanced Setup.

ADDITIONAL CONTEXT: The MT6639 case

A separate patch submission exists for the MT6639 (dev_id 0x6639):
Title: "Bluetooth: btusb: Add HCI_QUIRK_BROKEN_ENHANCED_SETUP_SYNC_CONN
for MT6639"
This adds the quirk for MT6639 only, which is the OPPOSITE direction
(adding the quirk where it was not set before). This confirms that
Enhanced Setup behavior varies across MediaTek chip variants and
should not be blanket-configured.

BENEFIT:
HFP/HFP mSBC microphone works on MT7925 (and likely other
newer MediaTek chips). Users can make voice calls, use voice
assistants, and join conference calls with Bluetooth headsets.


HARDWARE

USB Bluetooth adapter:
Vendor:   0x0489  Foxconn / Hon Hai
Product:  0xe111  Wireless_Device
Chipset:  MediaTek MT7925 (Filogic 330)
Module:   Foxconn / Hon Hai (integrated in laptop)
Firmware: BT_RAM_CODE_MT7925_1_1_hdr.bin (Build Time: 20260605184651a)

dmesg:
usb 3-2.3: New USB device found, idVendor=3D0489, idProduct=3De111, bcdDevi=
ce=3D 1.00
mt7925e 0000:03:00.0: ASIC revision: 79250000
mt7925e 0000:03:00.0: HW/SW Version: 0x8a108a10, Build Time: 20260605184651a


SOFTWARE

Kernel:   7.0.14-arch1-1 (x86_64, SMP PREEMPT_DYNAMIC)
Distro:   Arch Linux
Bluetooth: BTUSB + BTMTK kernel modules
Userspace: WirePlumber 0.5, PipeWire, bluez


PROBLEM DESCRIPTION

HFP/HFP mSBC microphone produces complete silence when a Bluetooth
headset is connected via HFP/HFP (Hands-Free Profile) on the MediaTek
MT7925 USB Bluetooth adapter.

The SCO audio stream is established successfully, data frames arrive
at the host, but every sample is zero (silence). The headset's
microphone is known to work on other platforms/adapters.


ROOT CAUSE

In drivers/bluetooth/btusb.c, the function btusb_probe() sets
HCI_QUIRK_BROKEN_ENHANCED_SETUP_SYNC_CONN for ALL MediaTek
Bluetooth USB devices unconditionally:

if (IS_ENABLED(CONFIG_BT_HCIBTUSB_MTK) &&
(id->driver_info & BTUSB_MEDIATEK)) {
...
hci_set_quirk(hdev, HCI_QUIRK_BROKEN_ENHANCED_SETUP_SYNC_CONN);
...
}

This quirk was introduced by commit e11523e97f474
("Bluetooth: btusb: Add support for Mediatek MT7921") in 2022,
based on Bugzilla #215576 where the MT7921 failed to establish
HFP connections with HCI_Enhanced_Setup_Sync_Conn.

When the quirk is set, the kernel falls back to the legacy
HCI_Setup_Sync_Conn command, which only transmits a voice_setting
parameter and does NOT convey the mSBC codec configuration
(codec ID, frame size, data path) that the HCI_Enhanced_Setup_Sync_Conn
command includes.

The Mediatek MT7925 firmware (build 2026-06-05) correctly implements
HCI_Enhanced_Setup_Sync_Conn and the associated mSBC codec
configuration. Without this command, the firmware defaults to a
non-functional codec configuration, resulting in zero-sample output.

Evidence from dmesg:

Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection
command is advertised, but not supported.

This message appears because:
1. The controller advertises support via HCI command bit
2. The kernel has set HCI_QUIRK_BROKEN_ENHANCED_SETUP_SYNC_CONN
3. The kernel falls back to legacy HCI_Setup_Sync_Conn


VERIFICATION

Test: Capture PCM samples from the HFP mSBC audio source with and
without the quirk.

WITH quirk set (stock kernel):
- All 14,336 PCM samples are zero (complete silence)
- RMS amplitude: 0.0

WITH quirk removed (DKMS patch removing the single line):
- 14,333 out of 14,336 PCM samples are non-zero (valid audio)
- RMS amplitude: ~0.07 (normal speech-level signal)

The only change is the removal of:
hci_set_quirk(hdev, HCI_QUIRK_BROKEN_ENHANCED_SETUP_SYNC_CONN);
from the MediaTek section of btusb_probe().

No other modifications were made. The Qualcomm instance of the same
quirk (in btusb_setup_qca()) was left untouched.


PROPOSED FIX

The quirk should NOT be applied blanket to all MediaTek chips.
Instead, it should be scoped per-chip based on which controllers
actually exhibit the Enhanced Setup failure.

Two approaches:

APPROACH A (minimal, recommended):
Remove the blanket quirk from the MediaTek section in btusb_probe().
The quirk was added for MT7921 based on Bugzilla #215576, but even
for MT7921 the Enhanced Setup path may work in newer firmware
revisions. If regression is found on a specific chip, it can be
re-added with a per-USB-ID quirk table or a DMI-based workaround.

--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -4276,7 +4276,6 @@ static int btusb_probe(struct usb_inter
hdev->set_bdaddr =3D btmtk_set_bdaddr;
hdev->send =3D btusb_send_frame_mtk;
hci_set_quirk(hdev,
-                      HCI_QUIRK_BROKEN_ENHANCED_SETUP_SYNC_CONN);
hci_set_quirk(hdev, HCI_QUIRK_NON_PERSISTENT_SETUP);
data->recv_acl =3D btmtk_usb_recv_acl;
data->recv_event =3D btmtk_recv_event;

APPROACH B (conservative):
Add the quirk only for known-bad chip IDs using a per-device
quirk table or by checking dev_id from btmtk_usb_setup() and
only setting the quirk for dev_id =3D=3D 0x7922 (MT7921) or other
confirmed-bad chips.


SAFETY / IMPACT ANALYSIS

RISK OF REMOVING THE BLANKET QUIRK:
Low to moderate.

1. The quirk was originally added for MT7921 (dev_id 0x7922).
Even on MT7921, the HCI_Enhanced_Setup_Sync_Conn failure
manifests as a connection rejection, after which the kernel
fallback logic re-attempts with legacy HCI_Setup_Sync_Conn.
So at worst, the headset takes slightly longer to connect
(one extra round trip) rather than failing entirely.

2. The upstream Bluetooth stack has robust fallback logic:
if Enhanced Setup fails, the kernel retries with legacy
Setup_Sync_Conn. No audio functionality is lost.

3. Newer MediaTek chips (MT7925, MT7927/MT6639) with recent
firmware DO implement Enhanced Setup correctly. The blanket
quirk penalises all of them.

4. The same quirk for Qualcomm chips (in btusb_setup_qca()) is
NOT affected by this change.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
