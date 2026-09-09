Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A498127B35F
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Sep 2026 00:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788914715; cv=none; b=eamk+mRbQUurs9CeNC5nXk5FSZiKzJ3rcZwkU9285X++eHKkd3cZvnGbDQqm3HdfMtxGNIkHXdXtjoKviOQHPe3K88CPAElyfSg6tgL8tAPy/0K36e9GwyWT/1hziLhGsrWk5Hfwu9NYOe3/nhHMpRap+ZQtYl1s3TC4qSbzijw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788914715; c=relaxed/simple;
	bh=pFCAo/UWY7/u9vd9PFguwJ9cg90Ys/yVUwfpuDtoEgQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=EGQpyGZAb1qsjKVC2DplmCOgB3gpUsdopMNm/AFRa5nPfhcr+I1hv46gtVmUcWU5NTazDlevUANZlCdPU64HrEoMbri9BpNA2eKrGjOxVhRkqMeYqxDvrgwpCR1NG5EUkqazJ1JSM7KEDOzaBEZ3cLilwZVaFEEerdwN9uxZzpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lengyelf.eu; spf=pass smtp.mailfrom=lengyelf.eu; dkim=pass (2048-bit key) header.d=lengyelf.eu header.i=@lengyelf.eu header.b=CYroxqx5; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lengyelf.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lengyelf.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lengyelf.eu header.i=@lengyelf.eu header.b="CYroxqx5"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4hfhst62NhzKryF;
	Wed, 09 Sep 2026 02:45:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lengyelf.eu; s=MBO0001;
	t=1788914706;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3lURiNj/8Rk4MfZa14Msr4coDHvrenmbjLKyuV88BkM=;
	b=CYroxqx5/sYNBmT8gCbGWt5mfctd5YCDgDX8/y5S/gEo743A41L0i//hY1xluH4BruLFlA
	SopwnDE8yaTubwQ22sYgT1YBxU/dQmp9ZpOM0odFWtva4C8S6WqqXWEJmt115kvgXa4p/d
	TX6fJwT7J8YIUM5D5wXDTu6GSF3v/P3pRpZznTPJfaW9zDpGUN1c20c0KBNlJVRiIPoZpU
	cBa7dLHe6aztSWi879YYQC/LYfHgJNyod/tqFKUp5IjA4CIpUM3kAirNYzH+F1ziHVDQS1
	jrKtnvxrXUYyGSuwyyAB+0bZJeRyNl1+CTjlutc80QdZ9Ccqeuzj7U2o+FdZAQ==
Message-ID: <df180a89-b214-41b4-b8ce-c6ed6b12372f@lengyelf.eu>
Date: Wed, 9 Sep 2026 02:45:03 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ferenc Lengyel <dev@lengyelf.eu>
Subject: Re: [PATCH v4] Bluetooth: btintel_pcie: fix stale cache in
 set_dxstate fallback check
To: 20260903192245.135310-2-vladimirkondratyev2@gmail.com
Cc: Ravindra <ravindra@intel.com>, Kiran K <kiran.k@intel.com>,
 Paul Menzel <pmenzel@molgen.mpg.de>, linux-bluetooth@vger.kernel.org,
 Sergey Lebedev <lsa.uz@pm.me>, luiz.dentz@gmail.com
References: <20260908174316.11795-1-lsa.uz@pm.me>
Content-Language: en-US, hu
In-Reply-To: <20260908174316.11795-1-lsa.uz@pm.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello,

I reported the intermittent hibernation abort in 
<22771256-6dcb-4ab9-ae77-3a88480e7d21@lengyelf.eu>, and Sergey asked 
whether v4 alone fixes it on my hardware. It does not. Applying v4 
together with Ravindra's "[PATCH v2] Bluetooth: btintel_pcie: fix PM 
flow for S0ix, S3 and S4" does. Details below, including a correction to 
my original report.

Hardware and software: Lenovo ThinkPad X9-15p (21VV004FHV), BIOS 
N4QET35W 1.14. Intel Panther Lake CNVi Bluetooth, 8086:e476 at 
0000:00:14.7, firmware 42-26.26 (ibt-00a0-01a1-iml.sfi then 
ibt-00a0-01a1-pci.sfi, timestamp 2026.26 build 94250). Kernel 
7.2.3-1-cachyos; drivers/bluetooth/btintel_pcie.{c,h} are byte-identical 
to upstream v7.2. Note this is a different generation from Sergey's 
Lunar Lake BE201 8086:a876.

First, a correction to my original report. I wrote that all three 
retries timed out "AND the poll also reported the controller was not in 
D3", and concluded the device genuinely did not reach D3. That inference 
was unfounded, for exactly the reason v4 exists: btintel_pcie_in_d3() 
reads data->boot_stage_cache, which on that path is only written by the 
alive interrupt handler, so after a missed interrupt it reports a value 
from before the transition. Sergey identified this. Please disregard 
that part of the report.

Results, using systemctl hibernate. The two patched arms are from a 
single boot on 7.2.3; the stock baseline is my original A/B test on 
7.2.2, where the driver files are identical:

    stock, 7.2.2                   3 aborts in 10 cycles
    stock, module unloaded         0 aborts in 10 cycles
    v4 alone, 7.2.3                2 aborts in 5 cycles
    v4 + Ravindra's v2, 7.2.3      0 aborts in 10 cycles

The v4 arm reproduced the original failure unchanged: all three retry 
counts, then -EBUSY, with the image already written.

To find out why, I built v4 with one extra bt_dev_warn immediately after 
the patch's register re-read, printing retry, boot_stage and in_d3. On a 
failing cycle it gives:

    Bluetooth: hci0: INSTR: after re-read, retry 0, boot_stage 
0x20db0001, in_d3 0
    Bluetooth: hci0: INSTR: after re-read, retry 1, boot_stage 
0x20db0001, in_d3 0
    Bluetooth: hci0: INSTR: after re-read, retry 2, boot_stage 
0x20db0001, in_d3 0

So the re-read is working and returning a live value: it is not 
0x00000000 or 0xffffffff, MAC_ACCESS_ON (bit 16) and ALIVE (bit 23) are 
set, and none of DEVICE_WARNING, ABORT_HANDLER or DEVICE_HALTED is set. 
The controller is reachable. But D3_STATE_READY (bit 24) is clear, 
identically across all three retries roughly 600 ms apart.

What 0x20db0001 is becomes clear with dynamic debug enabled on 
btintel_pcie_msix_gp0_handler, which prints the boot stage per alive 
context:

    Alive context: rom            0x20db0001    ROM set, IML and OPFW clear
    Alive context: intel_reset1   0xa0db0003    ROM, IML set
    Alive context: intel_reset1   0xa0db000f    ROM, IML, OPFW set
    Alive context: intel_reset2   0xa0db0007    ROM, IML, OPFW set
    Alive context: hci_reset      0xa0db0047    ROM, IML, OPFW set
    Alive context: d0             0x61710007    ROM, IML, OPFW and 
D3_STATE_READY set

The last row is the context in which the driver is waiting to leave D3, 
so it is also an example of D3_STATE_READY actually being set. The value 
seen at the failing D3 entry is byte-identical to the ROM-stage value. 
The controller has no firmware loaded at the moment .poweroff asks it to 
enter D3, and a ROM-stage controller does not complete the D3 handshake. 
That is a separate fault from the stale cache, which is why v4 alone 
cannot help here.

The reason it is in ROM is the driver's own .thaw callback, and the log 
ordering on a failing cycle shows it directly:

    PM: hibernation: Preallocating image memory
    PM: hibernation: Allocated 12776628 kbytes in 1.48 seconds (8632.85 
MB/s)
    printk: Suspending console(s) (use no_console_suspend to debug)
    PM: hibernation: Normal pages needed: 3179962 + 1024, available 
pages: 5078484
    btintel_pcie 0000:00:14.7: resetting
    btintel_pcie 0000:00:14.7: reset done
    Bluetooth: BT reprobe failed for BDF:0000:00:14.7
    PM: hibernation: Wrote 10837272 kbytes in 8.88 seconds (1220.41 MB/s)
    PM: Image size after compression: 3781433 kbytes
    PM: Image saving done
    printk: Suspending console(s) (use no_console_suspend to debug)
    Bluetooth: hci0: Timeout (200 ms) on alive interrupt for D3 entry, 
retry count 0
    Bluetooth: hci0: Timeout (200 ms) on alive interrupt for D3 entry, 
retry count 1
    Bluetooth: hci0: Timeout (200 ms) on alive interrupt for D3 entry, 
retry count 2
    btintel_pcie 0000:00:14.7: PM: pci_pm_poweroff(): 
btintel_pcie_hibernate [btintel_pcie] returns -16
    btintel_pcie 0000:00:14.7: PM: dpm_run_callback(): 
pci_pm_poweroff.llvm.16961064922821440386 returns -16
    btintel_pcie 0000:00:14.7: PM: failed to hibernate async: error -16
    PM: hibernation: Wakeup event detected during hibernation, rolling back.

hibernation_snapshot() runs .freeze, creates the image, then runs .thaw. 
btintel_pcie_suspend_late() has just recorded pm_sx_event = 
PM_EVENT_FREEZE, and pm_ops has .thaw = btintel_pcie_resume, so the thaw 
takes this branch:

      if (data->pm_sx_event == PM_EVENT_FREEZE ||
          data->pm_sx_event == PM_EVENT_HIBERNATE) {
          set_bit(BTINTEL_PCIE_CORE_HALTED, &data->flags);
          data->reset_type = BTINTEL_PCIE_IOSF_PRR_FLR;
          btintel_pcie_reset(data->hdev);
          return 0;
      }

The FLR drops the controller to ROM. No "Firmware loaded in ... usecs" 
line follows before the image write completes, so the firmware had not 
been reloaded by the time .poweroff asked a ROM-stage controller to 
enter D3 roughly nine seconds later. I have not established why the 
reload does not complete in that window; the freezer still being engaged 
during .thaw seems the likeliest reason, but I have not confirmed it. 
The "BT reprobe failed" line is not itself a failure marker, 
incidentally: it appears on every resume here, including ones that 
succeed. The comment above that branch justifies the reset by saying S4 
erases the loaded firmware, which is true on .restore, after power was 
actually cut, but on .thaw no power has been lost and the image has not 
even been written yet.

Ravindra's v2 removes exactly this: .thaw gets its own callback taking a 
normal D0 transition, and the FLR stays on .restore and S3 resume, which 
matches what he described on-list on 2026-09-08. With both patches 
applied I get 10 consecutive clean hibernations where v4 alone gave 2 
aborts in 5 in the same boot.

Caveats, so the numbers are not read as stronger than they are. Ten 
clean cycles against a roughly one-in-three prior failure rate is about 
a 2 percent outcome by chance; Fisher's exact test against my own 
controls (5 aborts in 15 before, 0 in 10 after) gives p ~= 0.06. It is 
consistent and it matches the mechanism, but it is not a large sample.

I could not observe the .thaw phase directly on a passing cycle. On a 
successful hibernation the restored ring buffer stops at the snapshot 
point, so everything after it, including the .thaw callback, the image 
write and the .poweroff D3 entry, is discarded. Worth flagging for 
anyone trying to test this: pm_test is not a way around that either. In 
hibernation_snapshot(), create_image() never runs on the TEST_DEVICES 
path, so in_suspend stays 0 and dpm_resume() is called with PMSG_RESTORE 
rather than PMSG_THAW, which means pm_test exercises .restore and says 
nothing about .thaw.

I am happy to run more cycles, or any other instrumentation that would help.

For the combination as tested, both patches applied together:

Assisted-by: Claude:claude-opus-5
Tested-by: Ferenc Lengyel <dev@lengyelf.eu>

v4 is correct and worth keeping on its own account: the stale cache is 
real, and fixing it is what let the second fault become visible. I would 
rather not give it a bare Tested-by on this thread, though, since on 
this hardware v4 alone does not fix the reported bug.

Regards,
Ferenc Lengyel
