Received: from out203-205-221-242.mail.qq.com (out203-205-221-242.mail.qq.com [203.205.221.242])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3327925783C
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jul 2026 03:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.242
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783999135; cv=none; b=dB6YKLwDyODNmjlH2HpCIepO5wG4KIKNseeRa0F2ofLrkXc5tpS3EIZ93oZ6IArpJRxnYj/tyWvpVhk6Py+zOQLMbPNolobmJzB+P29ghZX8THtKuNLSIjyrgZWEFktJlyat/13D60wJcan3+/gXn4a+xRS60Jqww9wyyWJtYyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783999135; c=relaxed/simple;
	bh=riLaMPEmQgoxptwsCf1Kdu3Ki/D+M9nIPlRDS/0Ubpw=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=ORYH78rBWpf1RAAaBCQgkSBqBwaswZ3Xm2JhmNIWz8pdl38CZLKsKVKwefHFz7aWtg5L4CxL6+7xQ5swczBjVVZV51EtgeRlhiFD1UAjCMkqWD9Fu0T7NYO+MkbCwWyMnoJnf/WfS9gLWibq/T9jMu7QL2wQ+0PeDIahgWQw6Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=KWF+8Hfc; arc=none smtp.client-ip=203.205.221.242
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="KWF+8Hfc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1783999124; bh=rv3+1Liice68cFN0j7y1yD3gap3T4mbreCJEv66lNOY=;
	h=From:To:Cc:Subject:Date;
	b=KWF+8HfcNSrmp8R549JF2CMs+qgZ+4gnMjCNtScsI506ZlAi+ocyyhz22mrgPhd0d
	 G6pEVAa39ZntJszw1jY9onDORwexkMwsY793sGcJ4cU+21fVyZTLetbbZYhRQ0bTFO
	 6l1BhCl4IwABq6rlSDto3fb8P2dE/YfOX0lkHuI4=
Received: from caitao123456-pc.. ([116.128.244.169])
	by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
	id 4AA0585A; Tue, 14 Jul 2026 11:18:42 +0800
X-QQ-mid: xmsmtpt1783999122tica3ngs5
Message-ID: <tencent_A9E80607A55CCF00F26DBE8D8CB605EA5707@qq.com>
X-QQ-XMAILINFO: No7DFzN00JnRjwKedgQft2qrNssfbSNaG5FlMVtp8+lGCCFKkiKjEGO3EfOPYH
	 PJWYoaqD14ZavZWFD153YVwJakUIGDcs9jggnr02l0K4AeoLWrU2a588ZS+Viu0iUWPI8Q6rTI9L
	 kHEAYe8FXbLmiCflV/4CX++uWreWXOswT5FNunDTdhCu6flAoWDl5Xx5lqNE2ORG6+66IXJ/ukHd
	 S1c2tqEcSpz6fpBc/6WyOwu0DAJj4I1E9r3dCKzWaU766hG/eSsZNIN4xb2KOXuu7TEGjHTsY0uE
	 +s+C90O6R59SYYPvaUGzznAHc/WzB9U/WwoRiAZv5VjzEZfZz1DJcaJjw+eUgbyYPObO7f29OPJQ
	 PcDwxVWNVGbirA9HUN7noJpqE3qJmXFOCaNSSma6aSXY5bSgHw+wEHlh/SPDNwMQalfmTPAxVuYu
	 bPGTTupAfSIn3y51l1+U0pNviWQXdldDH/VbwFPge8dxrOMmmvabQJDEHhbgLiAn0R/l30ELpmrS
	 xvvpYRriuSeBmM5LAnfNg7WQAhgEFA8rBmGfAt3/JsD+bQON4GlgG/UlaHz2YWk+odF0JA67HsLj
	 vnVk8BZ/4f2lDZF5G2gDBUBVEI2pxTLUeiHhesDPgmbh6Ki0b+1B/O26gJ3FYQk/s3MxFqW6WrlA
	 PH3265Q/azIqbWwuPXJ9iJoqwNKXbTqex1MLOA7dIrMOnmlkt1MEIqi2s6iSIq4vFNrX+66scdnd
	 ekAM0mNkhLjZbZxyDh1kueceTAUv5WW01IWS2GoHEPgJ0GNQUbqDR93SDHQniADyjKJWLW2IdrND
	 SRlWku2og9T99wB3l+Kmtahu6z77pLJnsn4n/K0x1owKzQWKPRJdENubgf1payzhgiuydkscLYLw
	 TuqIbCsi4IWJGSfnPMWV0PW51lRvQgNrTIFdf0ZbxcHXJiACC3TS/LTikrIfxZFQcex6wFmKi3NJ
	 a0EANEd/dRnljOuzSV7jmHRLc88PiP8eV9wV2rRtV2b63NnKrRr9z8jZyUU7aRH2JRmvq0Xmoj4/
	 izw8lRlsCwJUqfqoQ8
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
From: caitao <294305068@qq.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	caitao <caitao@kylinos.cn>
Subject: [BUG] start_discovery_internal forces mutually exclusive BR/EDR and LE scans on Intel AX210
Date: Tue, 14 Jul 2026 11:18:34 +0800
X-OQ-MSGID: <20260714031834.111880-1-294305068@qq.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: caitao <caitao@kylinos.cn>

Dear Bluetooth Maintainers,

I am reporting a limitation in the Bluetooth MGMT layer that prevents
independent control of BR/EDR inquiry and LE scan, which persists even on
hardware that clearly supports such operations.

[1] Problem Description
=======================

The function start_discovery_internal() in net/bluetooth/mgmt.c enforces
mutual exclusion between BR/EDR inquiry and LE scan by requiring that
hdev->discovery.state == DISCOVERY_STOPPED before starting any new discovery.
This prevents:
  - Starting LE scan while BR/EDR inquiry is active
  - Starting BR/EDR inquiry while LE scan is active
  - Independently controlling each scan type

This limitation exists despite the fact that many modern Bluetooth controllers,
including the Intel AX210 in my system, support independent and simultaneous
scanning as evidenced by the ability to use hcitool commands separately.

[2] Hardware and Software Environment
=====================================

- Kernel: 6.6.0-58-generic (Ubuntu)
- Bluetooth Controller: Intel Corp. AX210 Bluetooth (USB ID 8087:0032)
- Firmware: intel/ibt-0041-0041.sfi (loaded successfully)
- BlueZ version: (please run `bluetoothctl --version` and fill in)

Relevant dmesg output:
    [ 3.839316] Bluetooth: Core ver 2.22
    [ 3.839335] NET: Registered PF_BLUETOOTH protocol family
    [ 3.986759] Bluetooth: hci0: Device revision is 0
    [ 3.986810] Bluetooth: hci0: No support for _PRR ACPI method
    [ 3.988198] Bluetooth: hci0: Found device firmware: intel/ibt-0041-0041.sfi
    [ 5.749096] Bluetooth: hci0: Waiting for firmware download to complete
    [ 5.749738] Bluetooth: hci0: Firmware loaded in 1720250 usecs
    [ 5.775405] Bluetooth: hci0: Found Intel DDC parameters: intel/ibt-0041-0041.ddc
    [ 5.780803] Bluetooth: hci0: Firmware timestamp 2023.48 buildtype 1 build 75324
    [ 5.859917] Bluetooth: MGMT ver 1.22


[3] Code Analysis
=================

In net/bluetooth/mgmt.c, start_discovery_internal() contains:

static int start_discovery_internal(struct sock *sk, struct hci_dev *hdev,
                                    u16 op, void *data, u16 len)
{
    ...
    if (hdev->discovery.state != DISCOVERY_STOPPED ||
        hci_dev_test_flag(hdev, HCI_PERIODIC_INQ)) {
        err = mgmt_cmd_complete(sk, hdev->id, op, MGMT_STATUS_BUSY,
                                &cp->type, sizeof(cp->type));
        goto failed;
    }
    ...
}

This single state check treats all discovery types as a monolithic operation,
rather than tracking BR/EDR and LE discovery states separately.

[4] Expected Behavior
=====================

- Allow independent start/stop of BR/EDR inquiry and LE scan via MGMT commands.
- If hardware supports simultaneous scan (via HCI_QUIRK_SIMULTANEOUS_DISCOVERY),
  allow both to run concurrently.
- For hardware that does not support concurrent scans, either:
  a) Automatically interleave the scans, or
  b) Return a clear error indicating the specific limitation.

[5] Actual Behavior
===================

- bluetoothctl scan on starts both scans, but cannot control them separately.
- Must execute scan off before switching scan types.
- MGMT_STATUS_BUSY is returned for any scan start request while another scan
  is in progress, regardless of hardware capabilities.

[6] Steps to Reproduce
======================

1. Start bluetoothctl:
   $ bluetoothctl

2. Start discovery (both BR/EDR and LE):
   [bluetooth]# scan on
   [CHG] Controller XX:XX:XX:XX:XX:XX Discovering: yes

3. Observe that both scan types are active.

4. Attempt to switch to LE-only scan without stopping:
   [bluetooth]# scan le
   (This fails or requires scan off first)

5. Stop all scanning:
   [bluetooth]# scan off

6. Now LE-only scan can be started:
   [bluetooth]# scan le

Alternatively, using MGMT commands directly (if mgmt-tool is available):
  # Start BR/EDR inquiry
  $ mgmt-tool -c "start-discovery"

  # Try to start LE scan while BR/EDR is active
  $ mgmt-tool -c "start-discovery-le"
  (Returns MGMT_STATUS_BUSY)

[7] Evidence of Hardware Capability
===================================

The Intel AX210 controller can perform independent scans via HCI commands:

  # BR/EDR inquiry
  $ sudo hcitool scan

  # LE scan (can run simultaneously or independently)
  $ sudo hcitool lescan

Both commands succeed without requiring the other to be stopped, confirming
that the limitation is purely in the MGMT layer policy, not in the hardware.

[8] Potential Fix Directions
============================

1. Introduce separate state tracking for BR/EDR and LE discovery:
   - hdev->discovery.br_state (BR/EDR inquiry state)
   - hdev->discovery.le_state (LE scan state)

2. Modify start_discovery_internal() to check only the relevant state:
   - For BR/EDR inquiry: check br_state == DISCOVERY_STOPPED
   - For LE scan: check le_state == DISCOVERY_STOPPED

3. If HCI_QUIRK_SIMULTANEOUS_DISCOVERY is set, allow both to be active
   simultaneously; otherwise, the existing mutual exclusion remains.

4. Update the HCI event handling to properly update both states.

[9] Additional Information
==========================

Please let me know if you need any further details, such as full HCI traces
using btmon or additional kernel logs.

Thank you for your time and consideration.

Signed-off-by: caitao <caitao@kylinos.cn>

