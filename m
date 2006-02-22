Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Ville Tervo <ville.tervo@nokia.com>
To: bluez-devel@lists.sourceforge.net
Message-ID: <20060222091231.GM19185@null.research.nokia.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ExXT7PjY8AI4Hyfa"
Subject: [Bluez-devel] Soft lockup
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 22 Feb 2006 11:12:31 +0200


--ExXT7PjY8AI4Hyfa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I'm got attached oops while playing with Nokia 770. Attached patch
helps. 

Comments?

-- 
Ville

--ExXT7PjY8AI4Hyfa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="rfcomm_oopt.txt"

[  277.991851] BUG: soft lockup detected on CPU#0!
[  277.996490] 
[  277.998016] Pid: 770, comm:           gwhwdetect
[  278.002685] CPU: 0
[  278.004791] PC is at lock_timer_base+0x1c/0x7c
[  278.009307] LR is at del_timer+0x2c/0x8c
[  278.013336] pc : [<c00572f8>]    lr : [<c0057384>]    Tainted: P     
[  278.013366] sp : c0b19db0  ip : c0b19dd0  fp : c0b19dcc
[  278.025177] r10: 00900006  r9 : c0b18000  r8 : 00000000
[  278.030487] r7 : 00000001  r6 : c3b92678  r5 : c0b19dd4  r4 : 00000000
[  278.037109] r3 : c2d87053  r2 : c32cd460  r1 : c0b19dd4  r0 : c3b92678
[  278.043731] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  Segment user
[  278.050231] Control: 5317F  Table: 10B80000  DAC: 00000015
[  278.055786] [<c002523c>] (show_regs+0x0/0x50) from [<c006e100>] (softlockup_tick+0x78/0xb4)
[  278.064361]  r4 = 00000000 
[  278.067230] [<c006e088>] (softlockup_tick+0x0/0xb4) from [<c0057d74>] (do_timer+0x3c4/0x440)
[  278.075866]  r5 = C03432C0  r4 = C03442FC 
[  278.080047] [<c00579b0>] (do_timer+0x0/0x440) from [<c00283b4>] (timer_tick+0xb8/0xe8)
[  278.088165] [<c00282fc>] (timer_tick+0x0/0xe8) from [<c0039cd8>] (omap_32k_timer_interrupt+0x64/0xd4)
[  278.097595]  r6 = C0B19D68  r5 = C03432B0  r4 = 008AFEF5 
[  278.103118] [<c0039c74>] (omap_32k_timer_interrupt+0x0/0xd4) from [<c00240c4>] (__do_irq+0x70/0xb8)
[  278.112396]  r7 = 00000036  r6 = 00000000  r5 = 00000000  r4 = C02D867C
[  278.119171] [<c0024054>] (__do_irq+0x0/0xb8) from [<c0024338>] (do_level_IRQ+0x74/0xcc)
[  278.127380]  r8 = C0B19D68  r7 = 00000002  r6 = C0B19D68  r5 = 00000036
[  278.134124]  r4 = C0337B58 
[  278.136993] [<c00242c4>] (do_level_IRQ+0x0/0xcc) from [<c00243e8>] (asm_do_IRQ+0x58/0x164)
[  278.145446]  r6 = FFFFFFFF  r5 = 00000036  r4 = C0337B58 
[  278.150970] [<c0024390>] (asm_do_IRQ+0x0/0x164) from [<c00229a4>] (__irq_svc+0x44/0x94)
[  278.159179] [<c00572dc>] (lock_timer_base+0x0/0x7c) from [<c0057384>] (del_timer+0x2c/0x8c)
[  278.167724]  r6 = C3A35000  r5 = 00000000  r4 = C3B92678 
[  278.173278] [<c0057358>] (del_timer+0x0/0x8c) from [<c026830c>] (rfcomm_dlc_clear_timer+0x28/0x60)
[  278.182434]  r5 = 00000000  r4 = C3B92660 
[  278.186645] [<c02682e4>] (rfcomm_dlc_clear_timer+0x0/0x60) from [<c026893c>] (__rfcomm_dlc_close+0x158/0x248)
[  278.196777]  r4 = C3B92660 
[  278.199645] [<c02687e4>] (__rfcomm_dlc_close+0x0/0x248) from [<c0268afc>] (rfcomm_dlc_close+0x3c/0x68)
[  278.209167]  r7 = 00000000  r6 = C3A35000  r5 = 00000000  r4 = C02F85F8
[  278.215942] [<c0268ac0>] (rfcomm_dlc_close+0x0/0x68) from [<c026d004>] (rfcomm_tty_close+0x3c/0xc0)
[  278.225189]  r4 = C3B92BE0 
[  278.228057] [<c026cfc8>] (rfcomm_tty_close+0x0/0xc0) from [<c015919c>] (release_dev+0x1bc/0x7b8)
[  278.237060]  r6 = C3A35000  r5 = C110E960  r4 = 00000000 
[  278.242584] [<c0158fe0>] (release_dev+0x0/0x7b8) from [<c0159b40>] (tty_release+0x20/0x2c)
[  278.251037] [<c0159b20>] (tty_release+0x0/0x2c) from [<c009149c>] (__fput+0x60/0x16c)
[  278.259094]  r4 = C110E960 
[  278.261932] [<c009143c>] (__fput+0x0/0x16c) from [<c00915dc>] (fput+0x34/0x38)
[  278.269348]  r8 = C110E960  r7 = C3DCF040  r6 = C3DCF040  r5 = 00000000
[  278.276123]  r4 = C110E960 
[  278.278961] [<c00915a8>] (fput+0x0/0x38) from [<c008fa88>] (filp_close+0x78/0x84)
[  278.286651] [<c008fa10>] (filp_close+0x0/0x84) from [<c008fb38>] (sys_close+0xa4/0xc8)
[  278.294738]  r6 = C0B18000  r5 = 00000008  r4 = 00000001 
[  278.300262] [<c008fa94>] (sys_close+0x0/0xc8) from [<c0022dc0>] (ret_fast_syscall+0x0/0x2c)
[  278.308837]  r8 = C0023544  r7 = 00000006  r6 = 00000000  r5 = 00000001
[  278.315582]  r4 = 0001C5F8 

--ExXT7PjY8AI4Hyfa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="rfcomm_dlc_patch.txt"

diff --git a/net/bluetooth/rfcomm/tty.c b/net/bluetooth/rfcomm/tty.c
index 74368f7..a2a1b7d 100644
--- a/net/bluetooth/rfcomm/tty.c
+++ b/net/bluetooth/rfcomm/tty.c
@@ -593,6 +593,7 @@ static int rfcomm_tty_open(struct tty_st
 	set_bit(RFCOMM_TTY_ATTACHED, &dev->flags);
 
 	err = rfcomm_dlc_open(dlc, &dev->src, &dev->dst, dev->channel);
+	rfcomm_dlc_hold(dlc);
 	if (err < 0)
 		return err;
 
@@ -641,6 +642,7 @@ static void rfcomm_tty_close(struct tty_
 		tty->driver_data = NULL;
 		dev->tty = NULL;
 		rfcomm_dlc_unlock(dev->dlc);
+		rfcomm_dlc_put(dev->dlc);
 	}
 
 	rfcomm_dev_put(dev);

--ExXT7PjY8AI4Hyfa--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
