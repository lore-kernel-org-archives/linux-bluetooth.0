Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Fri, 5 Oct 2007 05:47:51 -0400 (EDT)
From: Catalin Drula <catalindrula@yahoo.ca>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Message-ID: <237238.48685.qm@web51810.mail.re2.yahoo.com>
Subject: Re: [Bluez-devel] kernel BUG in 2.6.20-1.2944.fc6
	(add_conn/hci_sysfs)
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1001692657=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============1001692657==
Content-Type: multipart/alternative; boundary="0-1867853831-1191577671=:48685"
Content-Transfer-Encoding: 8bit

--0-1867853831-1191577671=:48685
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi,

This bug still occurs with the Fedora Core 6 kernel, 2.6.22.7-57.fc6.

Sep 29 16:07:51 lexlights kernel: hci_cmd_task: hci2 command tx timeout
Sep 29 16:08:58 lexlights kernel: WARNING: at lib/kref.c:33 kref_get() (Not tainted)
Sep 29 16:08:58 lexlights kernel:  [<c04e76d8>] kref_get+0x3d/0x45
Sep 29 16:08:58 lexlights kernel:  [<c04e6b3d>] kobject_get+0xf/0x13
Sep 29 16:08:58 lexlights kernel:  [<c054fb8f>] get_device+0xe/0x14
Sep 29 16:08:58 lexlights kernel:  [<c05502e9>] device_add+0xc/0x526
Sep 29 16:08:58 lexlights kernel:  [<c04e6ae3>] kobject_cleanup+0x49/0x54
Sep 29 16:08:58 lexlights kernel:  [<c04e6aee>] kobject_release+0x0/0x8
Sep 29 16:08:58 lexlights kernel:  [<d09de72b>] find_dock+0x1e2/0x219 [dock]
Sep 29 16:08:58 lexlights kernel:  [<d007df5f>] add_conn+0x0/0x5b [bluetooth]
Sep 29 16:08:58 lexlights kernel:  [<d007df70>] add_conn+0x11/0x5b [bluetooth]
Sep 29 16:08:58 lexlights kernel:  [<c0432410>] run_workqueue+0x74/0xf7
Sep 29 16:08:58 lexlights kernel:  [<c0435427>] prepare_to_wait+0x24/0x3f
Sep 29 16:08:58 lexlights kernel:  [<c0432be2>] worker_thread+0x0/0xc6
Sep 29 16:08:58 lexlights kernel:  [<c0432c9c>] worker_thread+0xba/0xc6
Sep 29 16:08:58 lexlights kernel:  [<c04352dd>] autoremove_wake_function+0x0/0x35
Sep 29 16:08:58 lexlights kernel:  [<c0435216>] kthread+0x38/0x5e
Sep 29 16:08:58 lexlights kernel:  [<c04351de>] kthread+0x0/0x5e
Sep 29 16:08:58 lexlights kernel:  [<c0406177>] kernel_thread_helper+0x7/0x10
Sep 29 16:08:58 lexlights kernel:  =======================
Sep 29 16:09:01 lexlights kernel: hci_cmd_task: hci3 command tx timeout
Sep 29 16:09:02 lexlights kernel: list_del corruption. next->prev should be c51a9cd8, but was 4d554e51
Sep 29 16:09:02 lexlights kernel: ------------[ cut here ]------------
Sep 29 16:09:02 lexlights kernel: kernel BUG at lib/list_debug.c:72!
Sep 29 16:09:02 lexlights kernel: invalid opcode: 0000 [#1]
Sep 29 16:09:02 lexlights kernel: SMP
Sep 29 16:09:02 lexlights kernel: last sysfs file: /devices/pci0000:00/0000:00:07.2/usb1/1-2/1-2.4/dev
Sep 29 16:09:02 lexlights kernel: Modules linked in: bnep rfcomm l2cap bridge ipv6 dm_mirror dm_mod video sbs button dock battery ac lp floppy snd_via82xx gameport snd_ac97_codec ac97_bus snd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq snd_pcm_oss snd_mixer_oss i2c_viapro snd_pcm 8139cp via686a snd_timer hwmon snd_page_alloc snd_mpu401_uart i2c_isa 8139too parport_pc snd_rawmidi parport i2c_core cyblafb snd_seq_device mii snd soundcore hci_usb bluetooth ext3 jbd mbcache ehci_hcd ohci_hcd uhci_hcd
Sep 29 16:09:02 lexlights kernel: CPU:    0
Sep 29 16:09:02 lexlights kernel: EIP:    0060:[<c04ec282>]    Not tainted VLI
Sep 29 16:09:02 lexlights kernel: EFLAGS: 00010286   (2.6.22.7-57.fc6 #1)
Sep 29 16:09:02 lexlights kernel: EIP is at list_del+0x42/0x5d
Sep 29 16:09:02 lexlights kernel: eax: 00000048   ebx: 4d554e51   ecx: 00000086   edx: 00000000
Sep 29 16:09:02 lexlights kernel: esi: c0626fef   edi: c51a9cd4   ebp: cec8d570   esp: c124bf3c
Sep 29 16:09:02 lexlights kernel: ds: 007b   es: 007b   fs: 00d8  gs: 0000  ss: 0068
Sep 29 16:09:02 lexlights kernel: Process events/0 (pid: 6, ti=c124b000 task=c1256000 task.ti=c124b000)
Sep 29 16:09:02 lexlights kernel: Stack: c06d18ba c51a9cd8 4d554e51 c51a9ce0 c0626ffa c51a9ce0 c04e768e 00000000
Sep 29 16:09:02 lexlights kernel:        c124b000 00000000 c11f8950 c1256000 cec8d570 c054fb59 c0626fbe cf7eb480
Sep 29 16:09:02 lexlights kernel:        c51a9cc0 d007df12 c054ffc5 cf7eb480 c51a9cb0 d007df12 00000000 c0432410
Sep 29 16:09:02 lexlights kernel: Call Trace:
Sep 29 16:09:02 lexlights kernel:  [<c0626ffa>] klist_release+0xb/0x1c
Sep 29 16:09:02 lexlights kernel:  [<c04e768e>] kref_put+0x72/0x7f
Sep 29 16:09:02 lexlights kernel:  [<c054fb59>] klist_children_put+0x0/0x8
Sep 29 16:09:02 lexlights kernel:  [<c0626fbe>] klist_del+0x18/0x31
Sep 29 16:09:02 lexlights kernel:  [<d007df12>] del_conn+0x0/0x8 [bluetooth]
Sep 29 16:09:02 lexlights kernel:  [<c054ffc5>] device_del+0x15/0x266
Sep 29 16:09:02 lexlights kernel:  [<d007df12>] del_conn+0x0/0x8 [bluetooth]
Sep 29 16:09:02 lexlights kernel:  [<c0432410>] run_workqueue+0x74/0xf7
Sep 29 16:09:02 lexlights kernel:  [<c0432be2>] worker_thread+0x0/0xc6
Sep 29 16:09:02 lexlights kernel:  [<c0432c9c>] worker_thread+0xba/0xc6
Sep 29 16:09:02 lexlights kernel:  [<c04352dd>] autoremove_wake_function+0x0/0x35
Sep 29 16:09:02 lexlights kernel:  [<c0435216>] kthread+0x38/0x5e
Sep 29 16:09:02 lexlights kernel:  [<c04351de>] kthread+0x0/0x5e
Sep 29 16:09:02 lexlights kernel:  [<c0406177>] kernel_thread_helper+0x7/0x10
Sep 29 16:09:02 lexlights kernel:  =======================
Sep 29 16:09:02 lexlights kernel: Code: 24 6c 18 6d c0 e8 1e a1 f3 ff 0f 0b eb fe 8b 10 8b 5a 04 39 c3 74 18 89 5c 24 08 89 44 24 04 c7 04 24 ba 18 6d c0 e8
fd a0 f3 ff <0f> 0b eb fe 89 4a 04 89 11 c7 40 04 00 02 20 00 c7 00 00 01 10
Sep 29 16:09:02 lexlights kernel: EIP: [<c04ec282>] list_del+0x42/0x5d SS:ESP 0068:c124bf3c

Catalin

Marcel Holtmann <marcel <at> holtmann.org> writes:

> 
> Hi Catalin,
> 
> > I'm seeing the following oopses and eventually a kernel panic with the 
> > Fedora Core 6 kernel, 2.6.20-1.2944.fc6. They seem to be originating in 
> > the add_conn function from net/bluetooth/hci_sysfs.c
> 
> please re-test with a 2.6.22-rc4 kernel. I might have already been
> fixed. At least it shouldn't oops.
> 
> Regards
> 
> Marcel
> 
> -------------------------------------------------------------------------
> This SF.net email is sponsored by DB2 Express
> Download DB2 Express C - the FREE version of DB2 express and take
> control of your XML. No limits. Just data. Click to get it now.
> http://sourceforge.net/powerbar/db2/
> 

       
---------------------------------
Be smarter than spam. See how smart SpamGuard is at giving junk email the boot with the All-new Yahoo! Mail  
--0-1867853831-1191577671=:48685
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi,<br><br>This bug still occurs with the Fedora Core 6 kernel, 2.6.22.7-57.fc6.<br><br>Sep 29 16:07:51 lexlights kernel: hci_cmd_task: hci2 command tx timeout<br>Sep 29 16:08:58 lexlights kernel: WARNING: at lib/kref.c:33 kref_get() (Not tainted)<br>Sep 29 16:08:58 lexlights kernel:&nbsp; [&lt;c04e76d8&gt;] kref_get+0x3d/0x45<br>Sep 29 16:08:58 lexlights kernel:&nbsp; [&lt;c04e6b3d&gt;] kobject_get+0xf/0x13<br>Sep 29 16:08:58 lexlights kernel:&nbsp; [&lt;c054fb8f&gt;] get_device+0xe/0x14<br>Sep 29 16:08:58 lexlights kernel:&nbsp; [&lt;c05502e9&gt;] device_add+0xc/0x526<br>Sep 29 16:08:58 lexlights kernel:&nbsp; [&lt;c04e6ae3&gt;] kobject_cleanup+0x49/0x54<br>Sep 29 16:08:58 lexlights kernel:&nbsp; [&lt;c04e6aee&gt;] kobject_release+0x0/0x8<br>Sep 29 16:08:58 lexlights kernel:&nbsp; [&lt;d09de72b&gt;] find_dock+0x1e2/0x219 [dock]<br>Sep 29 16:08:58 lexlights kernel:&nbsp; [&lt;d007df5f&gt;] add_conn+0x0/0x5b [bluetooth]<br>Sep 29 16:08:58 lexlights kernel:&nbsp;
 [&lt;d007df70&gt;] add_conn+0x11/0x5b [bluetooth]<br>Sep 29 16:08:58 lexlights kernel:&nbsp; [&lt;c0432410&gt;] run_workqueue+0x74/0xf7<br>Sep 29 16:08:58 lexlights kernel:&nbsp; [&lt;c0435427&gt;] prepare_to_wait+0x24/0x3f<br>Sep 29 16:08:58 lexlights kernel:&nbsp; [&lt;c0432be2&gt;] worker_thread+0x0/0xc6<br>Sep 29 16:08:58 lexlights kernel:&nbsp; [&lt;c0432c9c&gt;] worker_thread+0xba/0xc6<br>Sep 29 16:08:58 lexlights kernel:&nbsp; [&lt;c04352dd&gt;] autoremove_wake_function+0x0/0x35<br>Sep 29 16:08:58 lexlights kernel:&nbsp; [&lt;c0435216&gt;] kthread+0x38/0x5e<br>Sep 29 16:08:58 lexlights kernel:&nbsp; [&lt;c04351de&gt;] kthread+0x0/0x5e<br>Sep 29 16:08:58 lexlights kernel:&nbsp; [&lt;c0406177&gt;] kernel_thread_helper+0x7/0x10<br>Sep 29 16:08:58 lexlights kernel:&nbsp; =======================<br>Sep 29 16:09:01 lexlights kernel: hci_cmd_task: hci3 command tx timeout<br>Sep 29 16:09:02 lexlights kernel: list_del corruption. next-&gt;prev should be c51a9cd8, but was
 4d554e51<br>Sep 29 16:09:02 lexlights kernel: ------------[ cut here ]------------<br>Sep 29 16:09:02 lexlights kernel: kernel BUG at lib/list_debug.c:72!<br>Sep 29 16:09:02 lexlights kernel: invalid opcode: 0000 [#1]<br>Sep 29 16:09:02 lexlights kernel: SMP<br>Sep 29 16:09:02 lexlights kernel: last sysfs file: /devices/pci0000:00/0000:00:07.2/usb1/1-2/1-2.4/dev<br>Sep 29 16:09:02 lexlights kernel: Modules linked in: bnep rfcomm l2cap bridge ipv6 dm_mirror dm_mod video sbs button dock battery ac lp floppy snd_via82xx gameport snd_ac97_codec ac97_bus snd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq snd_pcm_oss snd_mixer_oss i2c_viapro snd_pcm 8139cp via686a snd_timer hwmon snd_page_alloc snd_mpu401_uart i2c_isa 8139too parport_pc snd_rawmidi parport i2c_core cyblafb snd_seq_device mii snd soundcore hci_usb bluetooth ext3 jbd mbcache ehci_hcd ohci_hcd uhci_hcd<br>Sep 29 16:09:02 lexlights kernel: CPU:&nbsp;&nbsp;&nbsp; 0<br>Sep 29 16:09:02 lexlights kernel:
 EIP:&nbsp;&nbsp;&nbsp; 0060:[&lt;c04ec282&gt;]&nbsp;&nbsp;&nbsp; Not tainted VLI<br>Sep 29 16:09:02 lexlights kernel: EFLAGS: 00010286&nbsp;&nbsp; (2.6.22.7-57.fc6 #1)<br>Sep 29 16:09:02 lexlights kernel: EIP is at list_del+0x42/0x5d<br>Sep 29 16:09:02 lexlights kernel: eax: 00000048&nbsp;&nbsp; ebx: 4d554e51&nbsp;&nbsp; ecx: 00000086&nbsp;&nbsp; edx: 00000000<br>Sep 29 16:09:02 lexlights kernel: esi: c0626fef&nbsp;&nbsp; edi: c51a9cd4&nbsp;&nbsp; ebp: cec8d570&nbsp;&nbsp; esp: c124bf3c<br>Sep 29 16:09:02 lexlights kernel: ds: 007b&nbsp;&nbsp; es: 007b&nbsp;&nbsp; fs: 00d8&nbsp; gs: 0000&nbsp; ss: 0068<br>Sep 29 16:09:02 lexlights kernel: Process events/0 (pid: 6, ti=c124b000 task=c1256000 task.ti=c124b000)<br>Sep 29 16:09:02 lexlights kernel: Stack: c06d18ba c51a9cd8 4d554e51 c51a9ce0 c0626ffa c51a9ce0 c04e768e 00000000<br>Sep 29 16:09:02 lexlights kernel:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; c124b000 00000000 c11f8950 c1256000 cec8d570 c054fb59 c0626fbe
 cf7eb480<br>Sep 29 16:09:02 lexlights kernel:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; c51a9cc0 d007df12 c054ffc5 cf7eb480 c51a9cb0 d007df12 00000000 c0432410<br>Sep 29 16:09:02 lexlights kernel: Call Trace:<br>Sep 29 16:09:02 lexlights kernel:&nbsp; [&lt;c0626ffa&gt;] klist_release+0xb/0x1c<br>Sep 29 16:09:02 lexlights kernel:&nbsp; [&lt;c04e768e&gt;] kref_put+0x72/0x7f<br>Sep 29 16:09:02 lexlights kernel:&nbsp; [&lt;c054fb59&gt;] klist_children_put+0x0/0x8<br>Sep 29 16:09:02 lexlights kernel:&nbsp; [&lt;c0626fbe&gt;] klist_del+0x18/0x31<br>Sep 29 16:09:02 lexlights kernel:&nbsp; [&lt;d007df12&gt;] del_conn+0x0/0x8 [bluetooth]<br>Sep 29 16:09:02 lexlights kernel:&nbsp; [&lt;c054ffc5&gt;] device_del+0x15/0x266<br>Sep 29 16:09:02 lexlights kernel:&nbsp; [&lt;d007df12&gt;] del_conn+0x0/0x8 [bluetooth]<br>Sep 29 16:09:02 lexlights kernel:&nbsp; [&lt;c0432410&gt;] run_workqueue+0x74/0xf7<br>Sep 29 16:09:02 lexlights kernel:&nbsp; [&lt;c0432be2&gt;]
 worker_thread+0x0/0xc6<br>Sep 29 16:09:02 lexlights kernel:&nbsp; [&lt;c0432c9c&gt;] worker_thread+0xba/0xc6<br>Sep 29 16:09:02 lexlights kernel:&nbsp; [&lt;c04352dd&gt;] autoremove_wake_function+0x0/0x35<br>Sep 29 16:09:02 lexlights kernel:&nbsp; [&lt;c0435216&gt;] kthread+0x38/0x5e<br>Sep 29 16:09:02 lexlights kernel:&nbsp; [&lt;c04351de&gt;] kthread+0x0/0x5e<br>Sep 29 16:09:02 lexlights kernel:&nbsp; [&lt;c0406177&gt;] kernel_thread_helper+0x7/0x10<br>Sep 29 16:09:02 lexlights kernel:&nbsp; =======================<br>Sep 29 16:09:02 lexlights kernel: Code: 24 6c 18 6d c0 e8 1e a1 f3 ff 0f 0b eb fe 8b 10 8b 5a 04 39 c3 74 18 89 5c 24 08 89 44 24 04 c7 04 24 ba 18 6d c0 e8<br>fd a0 f3 ff &lt;0f&gt; 0b eb fe 89 4a 04 89 11 c7 40 04 00 02 20 00 c7 00 00 01 10<br>Sep 29 16:09:02 lexlights kernel: EIP: [&lt;c04ec282&gt;] list_del+0x42/0x5d SS:ESP 0068:c124bf3c<br><br>Catalin<br><br>Marcel Holtmann &lt;marcel &lt;at&gt; holtmann.org&gt; writes:<br><br>&gt; <br>&gt; Hi
 Catalin,<br>&gt; <br>&gt; &gt; I'm seeing the following oopses and eventually a kernel panic with the <br>&gt; &gt; Fedora Core 6 kernel, 2.6.20-1.2944.fc6. They seem to be originating in <br>&gt; &gt; the add_conn function from net/bluetooth/hci_sysfs.c<br>&gt; <br>&gt; please re-test with a 2.6.22-rc4 kernel. I might have already been<br>&gt; fixed. At least it shouldn't oops.<br>&gt; <br>&gt; Regards<br>&gt; <br>&gt; Marcel<br>&gt; <br>&gt; -------------------------------------------------------------------------<br>&gt; This SF.net email is sponsored by DB2 Express<br>&gt; Download DB2 Express C - the FREE version of DB2 express and take<br>&gt; control of your XML. No limits. Just data. Click to get it now.<br>&gt; http://sourceforge.net/powerbar/db2/<br>&gt; <br><p>&#32;
      <hr size=1>Be smarter than spam. See how smart SpamGuard is at giving junk email the boot with the <a href="http://us.rd.yahoo.com/evt=40705/*http://mrd.mail.yahoo.com/try_beta?.intl=ca"><b>All-new Yahoo! Mail </b></a> 

--0-1867853831-1191577671=:48685--


--===============1001692657==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
--===============1001692657==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1001692657==--
