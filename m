Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793738141;
	b=dybVXZcQUAlEb3hHnxD9Gi3RGnMTL2fHvbTcbn5SuctP36HjGHT24YpdxFjWnIbc2AdM
	 A2JwcZzmW+uxOaO6xa37EP4YQQOq/2y98og9xLS/EkqHmOEMZcfQy0VHug3HPnFY8TRBM
	 plhqT7+7MVb59cp+GVCGhM1IfnvbGgoTCbSSR9ZrqZPg5b3s71984L97cvdnNNYsBBWhc
	 hkV908UFMtnkij/+ykVy6khSkIi3BwD77wCof1PZD2r5AQgFPKn9PsWWIF1BKMWw29maI
	 KIbNXM2js1DFo8DmnaH7zVExomdqRaG+GpBnagJiwBU92bJ8WkLqO98yrDG5kjEKZUQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793738141;
	h=Received:Received:DKIM-Signature:Received:From:To:Subject:Date:
	 X-Bugzilla-Reason:X-Bugzilla-Type:X-Bugzilla-Watch-Reason:
	 X-Bugzilla-Product:X-Bugzilla-Component:X-Bugzilla-Version:
	 X-Bugzilla-Keywords:X-Bugzilla-Severity:X-Bugzilla-Who:
	 X-Bugzilla-Status:X-Bugzilla-Resolution:X-Bugzilla-Priority:
	 X-Bugzilla-Assigned-To:X-Bugzilla-Flags:X-Bugzilla-Changed-Fields:
	 Message-ID:Content-Type:Content-Transfer-Encoding:X-Bugzilla-URL:
	 Auto-Submitted:MIME-Version;
	bh=PbyZyketEmhj58C4xebhzX/GPDlFTAwMotCoSH5G260=;
	b=Xx6Sbb7CX4wmSVn+dir/i651L20MV/NmJVi+O0AexrdZngmAZppFVQiO26NpIStGCigu
	 Yc7126Fyh3byhfjz5oEE/Abh8NUrO+Yp7Td6T0u0bdP8pM5k3VzI0AWfrvR75mFBTov9I
	 HwY5T222IxWa9yr3WwRVW4Pmf7MU1z5q6pLjGUCRs/pUZGKXom7YsyLiBtJD/06aFQUBQ
	 uIbOiazMUQWin66NVSu+hIi+ux03PVtJhAS1w0GSkYYYhEF1n0AWGYq9SXNcxTNOJZWZ6
	 dWKx/HBd2jTAoit27TWrTxvubLHLEV9AswIpEYqUBKZ3fQ/16SB0b3Pu3SSRQdtnNpQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=SUPBuNPY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
Received: from aws-us-west-2-korg-listserv-1.web.codeaurora.org (ip-10-30-226-211.us-west-2.compute.internal [10.30.226.211])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D2F606A31B
	for <linux-bluetooth.vger.kernel.org@localhost.mlmmj>; Tue,  3 Nov 2026 20:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=SUPBuNPY
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF6D6513C0
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Nov 2026 20:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1793738141; cv=none; b=CE4k5ejhWkHH8qU5xH2kfNH5JCelSI559lNm6P5ZwotTmUXPSHe8Kxo7n+EE3mfWzIg2gcgR1KJBMdvVn5kn+JwcRs1pmVIvBxEcnK+2ydkNwmX6kGHHmpAaow7oo19akMWDeMvO0FhyjDBcUlddFJocWfaQDA8NUNQAfzwS1q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1793738141; c=relaxed/simple;
	bh=WxfeBcYPONvYRHc6rZbC0Im/I2IuXcqUauYwKqgDk3Q=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=CVHuZjdrPvIUHVUoDZDSmfqf4fRTbl53BY3lVeoaa6dCNckMBWWHqkkh91rg7sT+UguPgibF8jry9hxGS3HbB+J0WOorDv8s55bkDAgzpKyUFAVk237XKuRBI7P9SvtwV13TrIVhXHQzBryP7fbIAalzrck48iuajyNNY09/kLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SUPBuNPY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BFE51C2BCFC
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Nov 2026 20:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1793738140;
	bh=WxfeBcYPONvYRHc6rZbC0Im/I2IuXcqUauYwKqgDk3Q=;
	h=From:To:Subject:Date:From;
	b=SUPBuNPYk6DViC8qWbzkGnkRIWcm9NZXfy4cxTk4O1CJwGBCD1kkWZ3GfBANPUtBl
	 6w6ZsKlElOUuYptf5r5zn9H0Go6XzJq4Nn6fA1IPf+Dg1ES1Su/zYmt/taAU3+bVHW
	 L0zIitR/Ie6uwJeXv4HXdUt1ahKDMC3XctdRsQY188v+VxBj93jkSP31fJ80NuDZ1h
	 C1ts9yCerRv8pUgjuU6TWikoN6jlh9vHfgwh47Eizt+slBhHjnr07SyZbUpAWWJBjz
	 6Jwb/az0qu6h8swrpPKgVf53PR3jQCd5OOxuVJ9TjGLBn8de7Q31ayBtNZ+lTrFJcP
	 gnB8V9QDPeGDg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 920C6C4160E; Tue,  3 Nov 2026 20:35:40 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 222234] New: btintel_pcie: unable to recover from 8086:e476
 (BE211) hardware exeption
Date: Tue, 03 Nov 2026 20:35:40 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: alastair.swan@bommanager.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-222234-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D222234

            Bug ID: 222234
           Summary: btintel_pcie: unable to recover from 8086:e476 (BE211)
                    hardware exeption
           Product: Drivers
           Version: 2.5
          Hardware: Intel
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: alastair.swan@bommanager.org
        Regression: No

Hi,

I've had occasional problems where something causes Bluetooth to fail on my
laptop while in normal use and it does not recover without either rebooting=
 or
reloading the btintel_pcie driver.

The specific symptoms are that everything disconnects (mouse, headphones), =
but
the OS doesn't acknowledge the disconnection and attempts to reconnect fail.
This occurs once or twice a week.

The failure includes these log messages:
[161556.628515] Bluetooth: hci0: Received hw exception interrupt
[161556.628544] Bluetooth: hci0: Received gp1 mailbox interrupt
[161556.628614] Bluetooth: hci0: Controller in error state (boot_stage:
0xd0fb6047)
[161556.630738] Bluetooth: hci0: Invalid exception dump signature: 0x201420=
01
[175081.190541] Bluetooth: hci0: sending frame failed (-19)
[175088.484946] Bluetooth: hci0: sending frame failed (-19)
[175088.484961] Bluetooth: hci0: Opcode 0x0c1a failed: -19
And every subsequent entry gives the -19 failure.=20

I think the underlying hw exception is a real, environmentally driven probl=
em
since it only occurs in a specific room in the house and I've had similar
Bluetooth stability problems in that same room on other laptops but I can't
reproduce it on demand.

I believe I've traced the failure to recover to the `btintel_pcie_read_hwex=
p`
function in btintel_pcie.c.

I think the -19 failures are due to the `BTINTEL_PCIE_CORE_HALTED` flag get=
ting
set by the initial hw exception interrupt and then never getting cleared.

When attempting to read the dump, the `if (val !=3D BTINTEL_PCIE_MAGIC_NUM)`
check trips and the function cleans up and exits, but there is nothing that
allows the failure to be detected so no recovery can be initiated.

In my kernel version (7.2.11-200.fc44.x86_64) the `if (val !=3D
BTINTEL_PCIE_MAGIC_NUM)` check might be failing because the driver is tryin=
g to
read from a possibly incorrect hardcoded address of `0xB030F800` and so gets
garbage data. This address is no longer hardcoded in 7.4-rc1 and is instead
read on startup which may mask the issue if the correct address is used, but
the fragile code path remains present.

The hardware and firmware that I'm using is: "Intel Bluetooth PCI 8086:e476,
firmware build 102163 (2026.36, ibt-00a0-01a1-pci.sfi)"

Claude suggests the following patch against v7.2.11 but I am unable to test=
 or
vouch for it myself as the right solution. Mainline has changed so the patch
likely won't apply cleanly.

```
diff --git a/drivers/bluetooth/btintel_pcie.c
b/drivers/bluetooth/btintel_pcie.c
index ed4ba2e46..4551098c3 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -1296,9 +1296,13 @@ static int btintel_pcie_recv_frame(struct
btintel_pcie_data *data,
        return ret;
 }

-static void btintel_pcie_read_hwexp(struct btintel_pcie_data *data)
+/* Returns true if at least one HCI event was recovered from device memory
+ * and handed to the stack.
+ */
+static bool btintel_pcie_read_hwexp(struct btintel_pcie_data *data)
 {
        int len, err, offset, pending;
+       bool delivered =3D false;
        struct sk_buff *skb;
        u8 *buf, prefix[64];
        u32 addr, val;
@@ -1317,7 +1321,7 @@ static void btintel_pcie_read_hwexp(struct
btintel_pcie_data *data)
        case BTINTEL_CNVI_BLAZARIW:
                /* only from step B0 onwards */
                if (INTEL_CNVX_TOP_STEP(data->dmp_hdr.cnvi_top) !=3D 0x01)
-                       return;
+                       return false;
                len =3D BTINTEL_PCIE_BLZR_HWEXP_SIZE; /* exception data len=
gth */
                addr =3D BTINTEL_PCIE_BLZR_HWEXP_DMP_ADDR;
                break;
@@ -1332,7 +1336,7 @@ static void btintel_pcie_read_hwexp(struct
btintel_pcie_data *data)
                break;
        default:
                bt_dev_err(data->hdev, "Unsupported cnvi 0x%8.8x",
data->dmp_hdr.cnvi_top);
-               return;
+               return false;
        }

        buf =3D kzalloc(len, GFP_KERNEL);
@@ -1398,10 +1402,12 @@ static void btintel_pcie_read_hwexp(struct
btintel_pcie_data *data)
                               tlv->val, pkt_len, false);

                btintel_pcie_recv_frame(data, skb);
+               delivered =3D true;
        } while (offset < len);

 exit_on_error:
        kfree(buf);
+       return delivered;
 }

 static int btintel_pcie_dump_fwtrigger_event(struct btintel_pcie_data *dat=
a)
@@ -1520,7 +1526,15 @@ static void btintel_pcie_coredump_worker(struct
work_struct *work)
                 * exception event from device memory and passes it stack f=
or
                 * further processing.
                 */
-               btintel_pcie_read_hwexp(data);
+               /* CORE_HALTED is already set, so every TX now fails with
+                * -ENODEV. Recovery (FLR + reprobe) is only started from
+                * hdev->hw_error, which needs an HCI Hardware Error event.
+                * If none could be read back from device memory (e.g. bad
+                * dump signature), inject one so the controller is not left
+                * permanently dead until the module is reloaded.
+                */
+               if (!btintel_pcie_read_hwexp(data))
+                       hci_reset_dev(data->hdev);
                clear_bit(BTINTEL_PCIE_HWEXP_INPROGRESS, &data->flags);
        }
 }
```

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
