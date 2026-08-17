Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20453BADA2;
	Mon, 17 Aug 2026 08:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786955294; cv=none; b=INX0PfUZ0lmkLvlKyP861BKpJfWXklyWQmG+eUDw8Ez5Z7Sexd/zrhuvyoSLHUchyUTERX6uyVnNp3C4JBjBKDtdYmqr5hnWaCK9jSXxAiBnPBxf70r6sxrnPEG6Ai4KEaD00WsH4Rhbmj574UlWmaKaPv3m6LXn0h5NuAYZP/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786955294; c=relaxed/simple;
	bh=e9Oye/LHXLFj4GOGpKDKHmWDwPPkjZSt9MXiy5z3KMs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=mnwEkPgWIn9x0zgHlnhqGPQ3Eao/eQt7IXJDMY+WNMnfHNlRUM2374+MqyKePPrQkH5tVGxv+ojFXDDcMrvRITkeuEvJFOAWrmwOB1fnpDX4QJAegNu3P6CtLS2CvowU2swICA5NCgombZFWK8/mjbdWvnu0A9nV3HulMLgXZ3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Almp08sI; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Almp08sI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786955292; x=1818491292;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=e9Oye/LHXLFj4GOGpKDKHmWDwPPkjZSt9MXiy5z3KMs=;
  b=Almp08sIUz28wyVzamBZQpIG/RdrAoQARqezEwHSfL7zR6g4zLaQGy8a
   XyaFo3jOFMpjPNTlTkQoSf1vrxg8RbpPUNEhahIIWXGuudPEu0pdtL2+M
   WDg0sXoY22CdGfZ6fn5x2pJxxjPdA/v3YhVaxEWEPqsVo/P9PW4MqV4a+
   j5yDZNRPefdgLAx76v1yTqjAexihfwqUPkQRkv9dee4YxrXmZrXK5YWya
   y2QAdsDUWQ+Yp1NB1A4wwuPs0f/c8mbIl77ifLI7dkNYmu10+ZsDh7yfI
   MM70H5IPBLsg3H4xFi9SDih+90GA8lhBa6F22nC67c2Kf7/EK2zGAcpH7
   A==;
X-CSE-ConnectionGUID: qX6Z3MZmTI60itsxFDV/Uw==
X-CSE-MsgGUID: kbF2eSqMRmSknunMqAS8OA==
X-IronPort-AV: E=McAfee;i="6800,10657,11877"; a="89941494"
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; 
   d="scan'208";a="89941494"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 01:28:11 -0700
X-CSE-ConnectionGUID: KCH8L2REQ/aolkeF/bZftA==
X-CSE-MsgGUID: Sd4z2oQ8SLqu44kdMfKgQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; 
   d="scan'208";a="263086890"
Received: from ly-workstation.sh.intel.com (HELO ly-workstation) ([10.239.182.64])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 01:28:08 -0700
Date: Mon, 17 Aug 2026 16:28:05 +0800
From: kernel test robot <yi1.lai@intel.com>
To: Sungwoo Kim <iam@sung-woo.kim>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, Dave Tian <daveti@purdue.edu>,
	linux-bluetooth@vger.kernel.org,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Chethan T N <chethan.tumkur.narayan@intel.com>,
	Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>,
	Kiran K <kiran.k@intel.com>, Manish Mandlik <mmandlik@google.com>,
	Sungwoo Kim <iam@sung-woo.kim>, linux-kernel@vger.kernel.org,
	yi1.lai@intel.com
Subject: Re: [PATCH] Bluetooth: hci_event: Synchronously cancel timers in
 hci_cmd_complete_evt()
Message-ID: <202608171032.be018232-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260619004222.3764523-2-iam@sung-woo.kim>


Hello,

kernel test robot noticed "BUG:sleeping_function_called_from_invalid_context_at_kernel/workqueue.c" on:

commit: 4e57c39dee9e03022145302358f459ed5a2d4676 ("[PATCH] Bluetooth: hci_event: Synchronously cancel timers in hci_cmd_complete_evt()")
url: https://github.com/intel-lab-lkp/linux/commits/Sungwoo-Kim/Bluetooth-hci_event-Synchronously-cancel-timers-in-hci_cmd_complete_evt/20260807-040337
base: https://git.kernel.org/cgit/linux/kernel/git/bluetooth/bluetooth.git master 
patch link: https://lore.kernel.org/all/20260619004222.3764523-2-iam@sung-woo.kim/
patch subject: [PATCH] Bluetooth: hci_event: Synchronously cancel timers in hci_cmd_complete_evt()

in testcase: perf-fuzzer
version: perf-fuzzer-x86_64-3cf46b1-1_20260807
with following parameters:

	runtime: 1h



config: x86_64-rhel-9.4-bpf
compiler: gcc-14
test machine: 16 threads Intel(R) Core(TM) i7-13620H (Raptor Lake) with 32G memory


If you fix the issue in a separate patch/commit (i.e. not just a new version of the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <yi1.lai@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202608171032.be018232-lkp@intel.com



kern  :err   : [   86.152673] [    T369] BUG: sleeping function called from invalid context at kernel/workqueue.c:4487
kern  :err   : [   86.152761] [    T369] in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 369, name: kworker/u65:1
kern  :err   : [   86.152792] [    T369] preempt_count: 0, expected: 0
kern  :err   : [   86.152812] [    T369] RCU nest depth: 1, expected: 0
kern  :warn  : [   86.152831] [    T369] 3 locks held by kworker/u65:1/369:
kern  :warn  : [   86.152852] [    T369]  #0: ffff888886372940 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_one_work (workqueue.c:3297)
kern  :warn  : [   86.152907] [    T369]  #1: ffff88888350fd40 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_one_work (workqueue.c:3298)
kern  :warn  : [   86.152956] [    T369]  #2: ffffffff8542d780 (rcu_read_lock){....}-{1:3}, at: handle_cmd_cnt_and_timer_sync (linux/rcupdate.h:300 linux/rcupdate.h:840 bluetooth/hci_event.c:3760) bluetooth
kern  :warn  : [   86.153170] [    T369] CPU: 12 UID: 0 PID: 369 Comm: kworker/u65:1 Tainted: G S                  7.2.0-rc4+ #1 PREEMPT(full)
kern  :warn  : [   86.153177] [    T369] Tainted: [S]=CPU_OUT_OF_SPEC
kern  :warn  : [   86.153179] [    T369] Hardware name: LENOVO 90XW004HPL/336B, BIOS M5LKT1CA 01/06/2025
kern  :warn  : [   86.153181] [    T369] Workqueue: hci0 hci_rx_work [bluetooth]
kern  :warn  : [   86.153342] [    T369] Call Trace:
kern  :warn  : [   86.153344] [    T369]  <TASK>
kern  :warn  : [   86.153347] [    T369]  dump_stack_lvl (dump_stack.c:94 dump_stack.c:120)
kern  :warn  : [   86.153356] [    T369]  __might_resched.cold (sched/core.c:9197)
kern  :warn  : [   86.153365] [    T369]  cancel_delayed_work_sync (workqueue.c:4487 workqueue.c:4568)
kern  :warn  : [   86.153371] [    T369] handle_cmd_cnt_and_timer_sync (bluetooth/hci_event.c:3763) bluetooth
kern  :warn  : [   86.153537] [    T369] hci_cmd_complete_evt (bluetooth/hci_event.c:4295) bluetooth
kern  :warn  : [   86.153704] [    T369]  ? __skb_clone (core/skbuff.c:1634)
kern  :warn  : [   86.153713] [    T369] hci_event_packet (bluetooth/hci_event.c:7781 bluetooth/hci_event.c:7835) bluetooth
kern  :warn  : [   86.153881] [    T369]  ? __pfx_hci_cmd_complete_evt (bluetooth/hci_event.c:4421 (discriminator 4)) bluetooth
kern  :warn  : [   86.154048] [    T369]  ? __pfx_hci_event_packet (net/bluetooth/hci_core.h:1688 (discriminator 2)) bluetooth
kern  :warn  : [   86.154217] [    T369]  ? __call_rcu_common+0x535/0x570
kern  :warn  : [   86.154225] [    T369]  ? preempt_count_sub (sched/core.c:6000 (discriminator 2) sched/core.c:5997 (discriminator 2) sched/core.c:6019 (discriminator 2))
kern  :warn  : [   86.154237] [    T369] hci_rx_work (bluetooth/hci_core.c:4039) bluetooth
kern  :warn  : [   86.154402] [    T369]  process_one_work (workqueue.c:3322)
kern  :warn  : [   86.154417] [    T369]  ? __pfx_process_one_work (workqueue.c:1978 (discriminator 7))
kern  :warn  : [   86.154423] [    T369]  ? __list_add_valid_or_report (list_debug.c:32)
kern  :warn  : [   86.154435] [    T369]  ? __pfx_hci_rx_work (linux/skbuff.h:1323) bluetooth
kern  :warn  : [   86.154595] [    T369]  worker_thread (workqueue.c:3405 workqueue.c:3486)
kern  :warn  : [   86.154605] [    T369]  ? __kthread_parkme (kthread.c:285 (discriminator 1))
kern  :warn  : [   86.154611] [    T369]  ? __pfx_worker_thread (workqueue.c:3380)
kern  :warn  : [   86.154616] [    T369]  kthread (kthread.c:436)
kern  :warn  : [   86.154621] [    T369]  ? kthread (kthread.c:412 (discriminator 1))
kern  :warn  : [   86.154625] [    T369]  ? __pfx_kthread (kthread.c:378)
kern  :warn  : [   86.154632] [    T369]  ret_from_fork (x86/kernel/process.c:158)
kern  :warn  : [   86.154638] [    T369]  ? __pfx_ret_from_fork (x86/include/asm/entry-common.h:54)
kern  :warn  : [   86.154646] [    T369]  ? __switch_to (linux/thread_info.h:142 (discriminator 2) x86/kernel/process.h:17 (discriminator 2) x86/kernel/process_64.c:676 (discriminator 2))
kern  :warn  : [   86.154651] [    T369]  ? __pfx_kthread (kthread.c:378)
kern  :warn  : [   86.154657] [    T369]  ret_from_fork_asm (x86/entry/entry_64.S:245)
kern  :warn  : [   86.154674] [    T369]  </TASK>
kern  :info  : [   86.156790] [    T172] Bluetooth: hci0: Firmware timestamp 2022.51 buildtype 1 build 56683
kern  :info  : [   86.156888] [    T172] Bluetooth: hci0: Firmware SHA1: 0xe2305c5c
kern  :info  : [   86.164030] [    T371] xor: automatically using best checksumming function   avx
kern  :info  : [   86.178626] [    T172] Bluetooth: hci0: DSM reset method type: 0x00
kern  :info  : [   86.202655] [    T328] think_lmi: ThinkCenter modified support being used
kern  :err   : [   86.311812] [    T312] ACPI BIOS Error (bug): Could not resolve symbol [^^RP28.PXSX.WIST], AE_NOT_FOUND (20260408/psargs-365)
kern  :err   : [   86.311950] [    T312] ACPI Error: Aborting method _SB.PC00.CNVW.IFUN due to previous error (AE_NOT_FOUND) (20260408/psparse-543)
kern  :err   : [   86.315878] [    T312] ACPI Error: Aborting method _SB.PC00.CNVW._DSM due to previous error (AE_NOT_FOUND) (20260408/psparse-543)
kern  :info  : [   86.318661] [    T312] iwlwifi 0000:00:14.3: Detected crf-id 0x1300504, cnv-id 0x80400 wfpm id 0x80000030
kern  :info  : [   86.318776] [    T312] iwlwifi 0000:00:14.3: PCI dev 51f1/0274, rev=0x370, rfid=0x10a100
kern  :info  : [   86.318810] [    T312] iwlwifi 0000:00:14.3: Detected Intel(R) Wi-Fi 6 AX203


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20260817/202608171032.be018232-lkp@intel.com



--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


