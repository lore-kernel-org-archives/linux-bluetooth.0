Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794078201;
	b=tk6UZPOmyHLZ7BOQjt5Xc8k+7xfFXudmTH6eZ1YujDxZYSSLd0EoPmkPwCfYOJzsyD46
	 huJXLhE3KW5X+45IP46eQm5sc4U5tWitcEJrVKfxWirlmUhdVd6Sa747zKBUj2PGh1ESm
	 BzAWBEMpvJVmIL7MAxWouE4gfDyTltrB1a/7N3g7FD127HMSKdVcWpHuWLMpNUA3ixuQB
	 osCZHPIB1v0C7X6i9dfGM+MGvPH9ZZ3LTLqBo9ykAypGEop/8iLD2mD0/HnDtMfSWlVG8
	 +cnl0Kpkv98+ADBN1QQ4FEQWP1//tiRnmmOsBK0FgpLH4b1LJ4G6cIXE0DhxISyd/eg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794078201;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=wnkJuwYmdw8oDnNw+jhSTyvy9Fskgw4gOdefjlga+Nc=;
	b=tp8O/MD89MGsosWSaPIoMFWba1gYxmO3BKn1lCozbz8m8NI8/3ywdV81qvckzDMCNhrH
	 /wL0RsKbz+yY1+kEhqkwPo3eiytBa3tNg/HPtfSLYQ3SD/cksLsmlM94O0/q5jyZ4It8j
	 twqu7JoQQBkEQFz+yLrgpL3a85FSZcIvJ+G1yHa1tC7J5I7Q5oOfQTpfldfKMCvW4FQdl
	 NhHOB7JsTd9ORVQTxZw4/xyBaTC5oalsYglML3LP/NVnOAaXB/YVYccHdGH6srSvtAb/R
	 I3iwbagFoxomr9rLjBHhA/a1Qs4WNfhlsqEiXBOD0zF8453TLZcpFsfQOdhRdIUZnqg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0d9p+oUW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.45
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B029606A326
	for <linux-bluetooth@vger.kernel.org>; Sat,  7 Nov 2026 19:03:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B029606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0d9p+oUW
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6b561b60b78so996647a12.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 07 Nov 2026 11:03:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794078200; cv=none;
        d=google.com; s=arc-20260327;
        b=DEjEBGGXUwcli0F2R1an2iCwGYP+6lS9194pVRTHj5OcKIkWfxR2H4t15djUFO8Nt4
         yA+po+Y07yyLCDqIBADanIraqpKbm4QcV6vxxAZ+GpGIpOtuyKMg9iRQFNsJdbasYyfa
         FxcV2W+UR9uPFbxhGLAWT9j1wT3dNB4xaXvLcv+nL7jPn1hwLBAAJYpchAyHLES7NdQf
         P3Z10qCET/mSr2PEaBMTg2wGAvdZzHDrnqQQh5Iz4W+QxIYjMn5Mmjeeyiv60BSVPJI5
         eZhfQp1W0GvMuo6KRFdwUrl/WumVoAKbNoygQlEaOFkXpfE9OJ0j24Rjz1GKcB0pxGwM
         dTJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=wnkJuwYmdw8oDnNw+jhSTyvy9Fskgw4gOdefjlga+Nc=;
        fh=gYVn2NY1pl5FWHKbmHOpTcjy+fqdlQcNz38f5g7CXLU=;
        b=InwLH1UI4ympN32MV4rXxOII9d80n8rsx4bB6vTrMFuyq0Kxq56ehXaIDh8IHhqd7C
         Ag9ttZSlOD6jBUIvsJNYIoA1FM2pTT+481qphJG8U9F7M8rxByNdWXq2elEM9pFM6roR
         K89aSchy1t20vmKT3/KNoPDPGfmdGiOxsjMUogZi83sSNw0/ZyL9AgE/soVLoVAB9ntx
         05LfOSerxxgSU7LwHw7rb2f+7W7bze3kVdnIRgM/TPTFPzVwlU8nA/BTQkwFmoE5inn4
         +rncGYyqXTMLA35ZCZjgiCESoDY3/ynmgrr+cPxEgAGU568OYI0VxAUTr+GdKQTz8ZcW
         MBIw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794078200; x=1794683000; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wnkJuwYmdw8oDnNw+jhSTyvy9Fskgw4gOdefjlga+Nc=;
        b=0d9p+oUWemmGlyPzt0ZbxWD+HeXgMIB+B1Z/9W47E6kEAjGTcW7XBXkpp3ZYQJ6rfJ
         5lW1+jSuNAUeW2gVIQ28D7vJNERR1+wc3vl4S16vapkoQh6fVdsIGycdRSa3xBNZhZzi
         lpLX+cETT2RDZ7eR5+51eRLQNQsl5yOM6T7vxrQZLKNGcmFo2gwIN1AfUVDZ3DYXzMuO
         HsGw5nT0yn17oP7+h/Rma1y5BvPvtiXtJTD0rWTpaZl9w1mRkpBb7leuKtXYyDHAr6pX
         biaBHFIisAIYKQnRzSAhmTNQZmAxfRCwvsWPryHf578azl/kaCbvUxNcCO29VRwk6P+B
         Ii4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794078200; x=1794683000;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=wnkJuwYmdw8oDnNw+jhSTyvy9Fskgw4gOdefjlga+Nc=;
        b=wngemHUMAcO0UVUjPenGDTYwyTrPHtLEt9RuRnCKi58O5pckxHVfPpvmxMYVVAr2Xf
         SMtPbCo3Qyg0UtjzF/U3v6X0YkX7wJOuX4K6dzMqI+hGf6GDuqV+NRQ8HuCjAZRcOca7
         AKEAWxUDx4k/g6m9+JXWcGF3w8sexGDXEiJFUalaphOOpQc9bMH1BPTPzi+OOJD8Czf1
         pMAiVGspR0XHiCFZIV91nYuHEXFqB9gG86utLFrhoeLpOhq33xZlQQzoDGYF9AHh9buO
         ygKnsLSFQyU0cOhtjKzhlDCCm/WMoFjlQupFhTfoQdtlhiLBAs46vC+P9AvDppRPzKDw
         okmg==
X-Gm-Message-State: APuU4Z/Zxo3vQ3j5JqjM56pr9dar0vkxu88AvtE8cwIUEoeS7V4O6pH4
	ANYm9DxjN4mJY+YdxL1kl1HZSwckmMLOd9CLfOaK2G1EgcdjDmaPqGckxIEweKHM4xikrJ2tBKW
	uVGsQzpaESFQFz05wzT88TuhNQj/IgxJUqJko
X-Gm-Gg: AYBFou2FPUL3IxFt8X0t4zeEjlytWkDi/e9SyBw2f8LjjSYz2OzbsxLTjrf1bxYV06F
	U9irRv/pjcNLI3Piv5ZqoWYS5Hn5EftkZ4rsz/jK7rJ7S0tzdCOeEmZFmc+zBQZZifyOWrJHFHm
	ifHpn6/M4qSV0+JbsghAdQZXZh9hvPbZFeW4u8bnMUn/V35B1on4VmgUqZHz1ql0nqqQhFLX2Ah
	vZwzjOiRiqpSJbmtxb8nMroIi2O7hOSsxVyXvRDmcBcl5nQwHtwTowSfSZ4xv01m7VBp1loj3y0
	NweAIJmpLYjiOxXEt5r05EQY6fkaBlhb/z33xDZrKBGN4EzRbs5TYyASqtzERmdVh4yZb5vV3vn
	kIiJ5uAU+XPmnLpIl3n7PWdwPpFiLK4noSYk7
X-Received: by 2002:a05:6402:a2d0:10b0:6b5:6cd0:18ac with SMTP id
 4fb4d7f45d1cf-6b6fb94a405mr1174624a12.8.1794078199568; Sat, 07 Nov 2026
 11:03:19 -0800 (PST)
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: J R <secarsenal@gmail.com>
Date: Sat, 7 Nov 2026 13:03:07 -0600
X-Gm-Features: AclHuK_mFteJfXc3dSA9nqafxrfNT3SMsmi4JK7W_xnbUGVVuI5BBmHYIxMxI60
Message-ID: <CAFC7XimOGvQUgXzg24vfDZ4q=9obX0yCYrrijus3RwigGOVSQw@mail.gmail.com>
Subject: [BUG] Bluetooth: btintel_pcie: controller never recovered after HW
 exception with "Invalid exception dump signature" (Panther Lake 8086:e376)
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, kiran.k@intel.com, 
	chandrashekar.devegowda@intel.com
Content-Type: text/plain; charset="UTF-8"

Summary
-------
On an Intel Panther Lake CNVi Bluetooth controller (PCI 8086:e376, BE211),
the firmware occasionally raises a hardware exception while the system is
idle. When the exception dump read from device memory has a valid
signature, the driver resets the controller and Bluetooth comes back
("resetting" / "reset done"). When the signature is invalid, the driver
logs "Invalid exception dump signature" and does nothing else.
BTINTEL_PCIE_CORE_HALTED stays set. Every HCI command then fails
immediately with -ENODEV, so the hci_cmd_timeout() reset path never runs
either. The controller stays dead until reboot. All connected HID devices
(keyboard, mouse) are lost, and the user has to fall back to a wired
keyboard to reboot.

The hang has happened every day this machine has been in use, and a
reboot was the only fix every time. The logs below cover 2026-11-05 to
2026-11-07 on two kernels (7.0.0-42 and 7.0.0-43). They are examples of a
daily problem, not its full history. The read_hwexp() path below is
unchanged in torvalds/master and in bluetooth-next as of 2026-11-07.

Hardware / software
-------------------
Machine:     ASUS ROG Zephyrus Duo 16 (2026), GX651AX, BIOS
GX651AX.310 (2026-08-20)
CPU:         Intel Core Ultra 9 386H (Panther Lake)
BT:          0000:00:14.7 Intel Panther Lake Bluetooth PCI Enumerator
[8086:e376],
             subsystem [8086:0011], driver btintel_pcie
WiFi:        0000:00:14.3 Intel Panther Lake PCH CNVi WiFi [8086:e340]
Kernel:      Ubuntu 7.0.0-42-generic and 7.0.0-43-generic
Distro:      Ubuntu 26.04.1 LTS, bluez 5.85-4ubuntu0.4
Firmware:    intel/ibt-00a0-01a1-pci.sfi + -iml.sfi from upstream linux-firmware
             commit 8a2941fa (2026-10-01). Driver reports
             "Firmware timestamp 2026.36 buildtype 1 build 102163",
             "Firmware Version: 19-36.26", "Fseq BT Top: 00.87.00.04".
             DDC: upstream ibt-00a0-01a1-pci.ddc (commit a98a6daa).
             The same crashes also happened on Ubuntu's older linux-firmware
             20260319 before the update.
Devices:     Logitech MX Keys S and MX Master 4 (BLE HID), ASUS Zephyrus Duo
             detachable keyboard (BLE HID), AirPods Pro (BR/EDR).

Observed events (kernel log)
----------------------------
Recovered (valid dump), 7.0.0-42, 2026-11-05 (4 times, e.g.):
  Bluetooth: hci0: Received hw exception interrupt
  Bluetooth: hci0: Controller in error state
  btintel_pcie 0000:00:14.7: resetting
  btintel_pcie 0000:00:14.7: reset done

NOT recovered (invalid dump), logged examples:
  2026-11-06 00:49:30  7.0.0-42  Invalid exception dump signature: 0xdf5db677
  2026-11-06 13:47:07  7.0.0-43  Invalid exception dump signature: 0xdf5db67f
  2026-11-07 11:54:50  7.0.0-43  Invalid exception dump signature: 0xdf5db67f

Full sequence, 2026-11-07, 7.0.0-43 (monotonic time):
  [3892.553133] Bluetooth: hci0: Received hw exception interrupt
  [3892.553259] Bluetooth: hci0: Received gp1 mailbox interrupt
  [3892.553278] Bluetooth: hci0: Controller in error state
(boot_stage: 0xd0fb6047)
  [3892.556045] Bluetooth: hci0: Invalid exception dump signature: 0xdf5db67f
  ... no "resetting" ever follows ...
  [5125.032033] Bluetooth: hci0: sending frame failed (-19)
  [5144.296133] Bluetooth: hci0: Opcode 0x0c1a failed: -19
  [5144.296145] Bluetooth: hci0: Error when powering off device on rfkill (-19)
  [5144.304099] Bluetooth: hci0: HCI reset during shutdown failed
  [5148.440100] Bluetooth: hci0: Opcode 0x0c03 failed: -19
  [5148.440144] Bluetooth: hci0: Failed to read MSFT supported features (-19)
  [5149.118202] Bluetooth: hci0: MSFT extension not registered
  ... repeats until reboot ...

The same boot_stage (0xd0fb6047) and nearly the same bogus signature
(0xdf5db67f, expected 0xA5A5A5A5) appear on separate boots. So the crash
is the same every time, not random memory. The dump read seems to return
garbage in this state, perhaps because MAC access isn't actually granted
after the core halts.

Reproduction
------------
Not deterministic. Happens while the machine sits idle with BLE HID devices
connected (no suspend involved: the system was awake and idle). Happens
daily. The user typically steps away and comes back to find all Bluetooth
dead.

Analysis (drivers/bluetooth/btintel_pcie.c, torvalds/master and bluetooth-next)
-------------------------------------------------------------------------------
1. btintel_pcie_msix_hw_exp_handler() sets BTINTEL_PCIE_CORE_HALTED
   (cleared only by re-probe) and queues hwexp_work.

2. btintel_pcie_hwexp_worker() -> btintel_pcie_read_hwexp(). The only way
   recovery is triggered is through the HCI Hardware Error event that this
   function extracts from the TLVs in the dump and passes to
   btintel_pcie_recv_frame(). The core's hw_error handling then resets the
   device.

3. If the dump can't be used, read_hwexp() returns without passing on any
   event and without requesting a reset. This applies to an invalid
   signature, a bad address or length, an unsupported cnvi_top, a failed
   read_device_mem(), or no type-1 TLV:

       val = get_unaligned_le32(buf);
       if (val != BTINTEL_PCIE_MAGIC_NUM) {
               bt_dev_err(data->hdev, "Invalid exception dump
signature: 0x%8.8x", val);
               goto exit_on_error;      /* -> kfree(buf); return; */
       }

4. btintel_pcie_send_frame() returns -ENODEV immediately while
   CORE_HALTED is set. Commands therefore fail at once instead of timing
   out. hci_cmd_timeout() -> hdev->reset (btintel_pcie_hci_reset) never
   runs, so there is no backup recovery path either.

Result: the device is wedged permanently. Recent bluetooth-next adds a
"vendor_reset" sysfs attribute that could be used to recover by hand, but
nothing recovers automatically.

Suggested fix
-------------
In btintel_pcie_read_hwexp(), whenever no HCI event was delivered (all the
early-return / exit_on_error paths), fall back to
btintel_pcie_request_reset(data, BTINTEL_PCIE_IOSF_PRR_FLR) or a
function-level reset. Alternatively, inject a synthetic
HCI_EV_HARDWARE_ERROR so the normal hw_error recovery runs. A controller
that has raised a HW exception and is marked CORE_HALTED should always end
up reset, whether or not the dump could be parsed.

Separately, the firmware exception itself (boot_stage 0xd0fb6047) probably
needs attention from Intel's firmware team.

Workarounds tried
-----------------
- Newer upstream firmware (2026-10-01) and the dedicated BE211 DDC: the
  crashes keep happening.
- User-space PCI unbind/bind or remove+rescan of 0000:00:14.7: brings the
  adapter back, but in practice the BLE HID devices didn't reconnect
  reliably and had to be re-paired. Repeated resets made things worse.
  Not a usable workaround.
- Reboot: the only reliable recovery.

I can test patches on this machine and give more logs (dynamic debug,
coredump, btmon) if useful.

Thanks,
Jason
