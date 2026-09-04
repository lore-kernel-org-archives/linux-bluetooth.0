Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665593630BF
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Sep 2026 21:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788558454; cv=none; b=V71OiMd2en2CaCCybpATzn1J6fGGnTp08/xcyNmrXJ2R5PbbIj58R5SH3NTuy1MT4lTkJ1cF+vuQlBPLT1QJWAD/jdOqm0H/XJLw7jkuYhgdjh80ZcFZU23V8QbVH5noHW8mp8PaZc/5jJRnDTC8KwBNVurYRnwpGTT0bwRXoaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788558454; c=relaxed/simple;
	bh=/CxMzPkyRSPdcoR3dOchvGpwo4tK24p8pquz/0SXp4c=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=BPBrq3zNEWXz0052Sq5k8A9IvT2QmZ1LeCo1+uedRS6QXqBeA6EzCbWbpCRJpq2I1bx/hjhj8yhoOi5vKNXIlZtF5EubY86b8BScE2EYDBjjSu4OXUZXO2iFOKfIWKkGlEPa20chOhd6hcD59bi3pcSvQyj4+k+N77nVL5jfhts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lengyelf.eu; spf=pass smtp.mailfrom=lengyelf.eu; dkim=pass (2048-bit key) header.d=lengyelf.eu header.i=@lengyelf.eu header.b=MfuS5AkS; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lengyelf.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lengyelf.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lengyelf.eu header.i=@lengyelf.eu header.b="MfuS5AkS"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hc96k2D4kzMlFx;
	Fri, 04 Sep 2026 23:47:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lengyelf.eu; s=MBO0001;
	t=1788558446;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=E+s5wmsRm+douYc0Vvf94drN3P9xK0bBwS8xfRqemEw=;
	b=MfuS5AkSWCBA7CMQ+q73DLsNSfmjXg1Rbz2bTjiFl3C7dGEfBAg71CH61jJFbEkpgFzhfL
	xx+agnKTmjPcrgAmgpDOrjvDBaiGk5nhhTNvnSWZYDF/AI9moFKdlZD2yzmVLDm9wfcCPu
	E6JH7uOL8JQps7M0OhFOHwSmJMWBT4FRLHyN3TRZu39JEXIe5twgxdaxD9lTvWHoSv8ueV
	Pqwkb0fQ3+iKAb0lLOWrtcrBanOBxEXItK7aRcvfUrH0mrFwDDFBUWIlXqS9SoHjcOZfwj
	oKAITeEzcB5LA2m1j9l9WVOa4R0keVtWutV1bu36LBqnGIaOc/4HUxXuDZw5TQ==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of dev@lengyelf.eu designates 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=dev@lengyelf.eu
Message-ID: <22771256-6dcb-4ab9-ae77-3a88480e7d21@lengyelf.eu>
Date: Fri, 4 Sep 2026 23:47:22 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: en-US, hu
To: marcel@holtmann.org, luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org, kiran.k@intel.com,
 chandrashekar.devegowda@intel.com, tedd.an@intel.com, pmenzel@molgen.mpg.de
From: Ferenc Lengyel <dev@lengyelf.eu>
Subject: btintel_pcie: hibernation intermittently aborted by -EBUSY from D3
 entry timeout
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4hc96k2D4kzMlFx

Hardware / kernel
-----------------
Laptop:
Lenovo ThinkPad X9-15p Gen 1 (21VV004FHV)

CPU:
Intel Core Ultra X7 358H (Panther Lake)

BIOS:
Lenovo N4QET35W, version 1.14, released 2026-06-29

Kernel:
7.2.2-1-cachyos (CachyOS build, clang 22.1.8), so not a vanilla build. I 
have diffed the driver against upstream, though: 
drivers/bluetooth/btintel_pcie.c and btintel_pcie.h are byte-identical 
(md5 233c813fe57a0cc86f4127b464f0d421 and 
ca9095da10b69b8ebbf33fef2ac6a1a9) to both v7.2 and v7.2.2 in the stable 
tree, so the file is also unchanged across those two stable releases. No 
CachyOS patch for the 7.2 series touches btintel_pcie, and the shipped 
btintel_pcie.ko contains upstream's exact format strings. I believe this 
is upstream code behaving as written.

Bluetooth:
Intel Corporation Core Ultra Processors (Series 3) CNVi Bluetooth 
[8086:e476], PCI 0000:00:14.7, driver btintel_pcie

Summary
-------
Hibernation aborts intermittently. btintel_pcie's poweroff callback 
times out waiting for the Bluetooth controller to confirm D3 entry, 
returns -EBUSY, and that failure propagates all the way up and rolls the 
entire hibernation back - after the hibernation image has already been 
written to disk.

Observed with `systemctl hibernate` and with hibernate invoked from the 
KDE Plasma menu. I have also run hibernate cycles by writing to 
/sys/power/state directly and never saw the abort on that path, but I 
would not read anything into that: there were only about five such 
cycles, and the trigger path should not matter to a driver PM callback.

Failure signature, verbatim from dmesg -T (also reproduced twice more 
with different timestamps, see below):

     PM: Image saving progress: 100%
     PM: hibernation: Wrote 10763616 kbytes in 9.45 seconds (1139.00 MB/s)
     PM: Image size after compression: 3539961 kbytes
     PM: Image saving done
     PM: S|
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
pci_pm_poweroff.llvm.12216723919884285163 returns -16
     btintel_pcie 0000:00:14.7: PM: failed to hibernate async: error -16
     PM: hibernation: Wakeup event detected during hibernation, rolling 
back.
     PM: hibernation: hibernation exit

(The .llvm.<digits> suffix on the symbol name is an artefact of this 
kernel being a clang/LTO build, not something meaningful to the bug.)

Note the last two lines: power_down() in kernel/power/hibernate.c prints 
"Wakeup event detected during hibernation, rolling back." for both 
-EAGAIN and -EBUSY coming back from hibernation_platform_enter(). In 
this failure mode there was no wakeup event, but instead a device 
refused to power down, so that message is misleading and cost some time 
while this was investigated as a suspected wakeup-source problem instead 
of a driver timeout.

 From my perspective this looked like hibernation silently doing 
nothing: the screen goes black, the power LED blinks quickly, and then 
the machine comes back to the lockscreen on its own about a minute 
later, with no error visible anywhere in the desktop session. And the 
power LED keeps blinking until there is another event affecting the 
power states.

Reproduction and A/B result
----------------------------
Ran 10 hibernation cycles (systemctl hibernate) with btintel_pcie 
loaded, then 10 more immediately after `sudo modprobe -r btintel_pcie` 
(module fully unloaded, not just rfkill-blocked; rfkill was ruled out 
first: rfkill does not stop btintel_pcie_suspend_late() from running, 
and runtime PM is off on this PCI function, so the driver's own "already 
in D3" fast path never triggers from rfkill alone).

   With btintel_pcie loaded:    3 aborts out of 10  (cycles 2, 4, 8)
   With btintel_pcie unloaded:  0 aborts out of 10

journalctl -k -b counts across the loaded run:
   'alive interrupt for D3 entry'  -> 9   (3 aborted cycles x 3 retries)
   'rolling back'                  -> 3

All three aborted cycles produced byte-for-byte identical log lines, 
differing only in timestamp - I diffed them with the timestamps 
stripped, so I have not pasted three near-identical copies here. I can 
send the full journals from both runs (10 cycles each) if that would be 
useful.

Other occurrences (identical lines, different timestamps)
---------------------------------------------------------
Every occurrence I have logged produced the same lines as the signature 
above, character for character apart from the timestamp:

     2026-09-04 20:21:39   Round A, cycle 2 of 10
     2026-09-04 20:35:25   Round A, cycle 4 of 10
     2026-09-04 20:52:38   Round A, cycle 8 of 10
     2026-09-02 22:15:37   the original occurrence, before the A/B test 
existed

The 09-02 one is what first surfaced this. A second attempt made 
immediately afterward (on 09-02), with no other change, hibernated 
successfully and stayed hibernated for 9.5 hours. This seems to also 
back up the A/B result as the failure is intermittent on a per-attempt 
basis, not tied to a specific state that a reboot would clear.

Additional observation, possibly related: `Bluetooth: BT reprobe failed 
for BDF:0000:00:14.7` appears on every single resume in the retained 
journal, including all cycles that completed successfully. Whatever 
leaves the controller unable to reprobe cleanly on resume may be the 
same condition that later prevents it reaching D3 on poweroff, though 
this I didn't test directly.

Code read (upstream v7.2.2, byte-identical to what is running here)
-------------------------------------------------------------------
btintel_pcie_set_dxstate() in drivers/bluetooth/btintel_pcie.c retries 
the D3 transition BTINTEL_PCIE_DX_TRANSITION_MAX_RETRIES (3) times at 
200 ms each, and on each timeout it also polls btintel_pcie_in_d3() to 
work around a known case where the alive interrupt itself goes missing. 
In every observed failure here, all three retries timed out AND the poll 
also reported the controller was not in D3. So this is not (only) a 
missed interrupt, but the device also did not reach D3 on power-off in 
these instances.

btintel_pcie_suspend_late() backs .suspend, .freeze AND .poweroff via 
the same dev_pm_ops struct, but it does not ask for the same target 
state in each case:

     dxstate = (mesg.event == PM_EVENT_SUSPEND ?
                BTINTEL_PCIE_STATE_D3_HOT : BTINTEL_PCIE_STATE_D3_COLD);

with BTINTEL_PCIE_STATE_D3_HOT = 2 and BTINTEL_PCIE_STATE_D3_COLD = 3. 
The warning string is "...on alive interrupt for D%d entry" with dxstate 
as the argument, so "D3 entry" in every log line above is literally the 
D3_COLD transition; a plain suspend failing the same way would print "D2 
entry".

That fits what I see. Independently of this issue I have been running 
suspend cycles on this laptop and have not hit this once - around 15 
suspend entries in one earlier log alone, on this same kernel, with zero 
occurrences of the warning. So on the evidence here the problem is 
specific to the D3_COLD transition, not to the shared callback as such.

I also notice btintel_pcie_in_d3(), the fallback poll, tests a single 
BTINTEL_PCIE_CSR_BOOT_STAGE_D3_STATE_READY bit and so does not appear to 
distinguish D3_HOT from D3_COLD, but I have not chased whether that matters.

Expected behavior
------------------
Either the D3 entry succeeds reliably, or a failure to reach D3 on 
hibernation poweroff does not abort a hibernation whose image has 
already been safely written to disk. At minimum, the "Wakeup event 
detected" message should not be printed for an -EBUSY that did not 
originate from an actual wakeup event, since it actively misdirects 
debugging.

Workaround in use
-----------------
I have installed a systemd-sleep hook that unloads btintel_pcie before a 
hibernate leg and reloads it afterwards. The 0/10 fail rate above was 
with the module unloaded by hand for the whole run, which is the 
evidence for the driver being the cause. The hook is just a convenient 
way of arranging the same thing. Either way it is a workaround, not a fix.

Happy to provide the full journals, run more cycles, or add tracing if 
that would help narrow this down further.

Best regards,
Ferenc Lengyel
