Return-Path: <cyrus@holtmann.org>
Message-ID: <e91dafd20803210756i5c127104j6001362ffabb8ed1@mail.gmail.com>
Date: Fri, 21 Mar 2008 15:56:40 +0100
From: mcINEK <mcinek@gmail.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-devel] sdp connection problem
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi!

I've got an application, which gets info about bluetooth devices around.
Therefore I need many sdp sessions. I figured, it is not possible to make
few connections at the same time, so I do it one by one.

Sometimes, even if previous session was closed by sdp_close, the next
sdp_connect gives me Too many links error. Usually it helps just to wait
some time. Therefore I wrote this code:

do
{
  session = sdp_connect(&local, &addr, SDP_RETRY_IF_BUSY | SDP_WAIT_ON_CLOSE);
  if(!session)
    sleep(5);
} while(!session && (errno == 31 || errno == 16 || errno == 117));

But this gives me an kernel error! (sometimes even Panic):

WARNING: at lib/kref.c:33 kref_get()
[<c001fd14>] (dump_stack+0x0/0x14) from [<c00d607c>] (kref_get+0x54/0x64)
[<c00d6028>] (kref_get+0x0/0x64) from [<c00d5120>] (kobject_get+0x18/0x20)
 r4:c19ea8f0
[<c00d5108>] (kobject_get+0x0/0x20) from [<c00f6ee8>] (get_device+0x1c/0x28)
 r4:c0262040
[<c00f6ecc>] (get_device+0x0/0x28) from [<c00f7b40>] (device_add+0x14/0x4d4)
[<c00f7b2c>] (device_add+0x0/0x4d4) from [<bf038fd8>]
(add_conn+0x18/0x90 [bluetooth])
[<bf038fc0>] (add_conn+0x0/0x90 [bluetooth]) from [<c0041f24>]
(run_workqueue+0xa8/0x15c)
 r5:bf038fc0 r4:c0262040
[<c0041e7c>] (run_workqueue+0x0/0x15c) from [<c004219c>]
(worker_thread+0x5c/0xb8)
 r6:c0277fb0 r5:c0262048 r4:c0262040
[<c0042140>] (worker_thread+0x0/0xb8) from [<c0045cc8>] (kthread+0x74/0x80)
 r6:00000000 r5:c0042140 r4:fffffffc
[<c0045c54>] (kthread+0x0/0x80) from [<c0033d74>] (do_exit+0x0/0x838)
 r5:00000000 r4:00000000
kobject_add failed for acl0016B8A0CF63 with -EEXIST, don't try to
register things with the same name in the same directory.
[<c001fd14>] (dump_stack+0x0/0x14) from [<c00d5490>]
(kobject_shadow_add+0x158/0x1b8)
[<c00d5338>] (kobject_shadow_add+0x0/0x1b8) from [<c00d5504>]
(kobject_add+0x14/0x18)
 r8:00000000 r7:00000000 r6:c0276000 r5:c1819a88 r4:c19ff9c0
[<c00d54f0>] (kobject_add+0x0/0x18) from [<c00f7bb8>] (device_add+0x8c/0x4d4)
[<c00f7b2c>] (device_add+0x0/0x4d4) from [<bf038fd8>]
(add_conn+0x18/0x90 [bluetooth])
[<bf038fc0>] (add_conn+0x0/0x90 [bluetooth]) from [<c0041f24>]
(run_workqueue+0xa8/0x15c)
 r5:bf038fc0 r4:c0262040
[<c0041e7c>] (run_workqueue+0x0/0x15c) from [<c004219c>]
(worker_thread+0x5c/0xb8)
 r6:c0277fb0 r5:c0262048 r4:c0262040
[<c0042140>] (worker_thread+0x0/0xb8) from [<c0045cc8>] (kthread+0x74/0x80)
 r6:00000000 r5:c0042140 r4:fffffffc
[<c0045c54>] (kthread+0x0/0x80) from [<c0033d74>] (do_exit+0x0/0x838)
 r5:00000000 r4:00000000
add_conn: Failed to register connection device

Am I doing something wrong?

Best Regards,
Marcin

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
