Return-Path: <bluez-devel-admin@lists.sourceforge.net>
To: bluez-devel@lists.sourceforge.net
From: Sebastian Roth <sebastian.roth@esk.fhg.de>
Message-ID: <cusgdr$4g1$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-devel] snd-bt-sco built-in
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
Date: Tue, 15 Feb 2005 10:49:03 +0100

Hi,

I'm trying to build snd-bt-sco directly into the kernel.
Patched the kernel source a bit and it built ok.
On bootup my kernel oopses:

snd-bt-sco revision 1.4 $
Unable to handle kernel NULL pointer dereference at virtual address 00000000
  printing eip:
c02b7f92
*pde = 00000000
Oops: 0000 [#1]
Modules linked in:
CPU:    0
EIP:    0060: [<C02B7F92>] Not tainted VLI
EFLAGS: 00010246    (2.6.10-mh4-sr1)
EIP is at snd_minor_search+0x12/0x50
eax: 00000000   ebx: c7e3a8e0   ecx: c7ffb160   edx: 00000000
esi: 00000000   edi: c7e3a802   ebp: c7fc7f38   esp: c7fc7eec
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 1, threadinfo: c7fc6000, task: c113f9e0)
Stack: c7e3a8e0 c7fc7f42 c02b8259 00000000 000000d0 00000000 380380c8 
00000000
        00000000 c0434384 c7e30000 00000000 00000000 c02bce8d 00000000 
c7e30000
        00000000 c0434384 c7fc7f38 746e6f63 436c6f72 00000030 c04a2bb0 
c7e30000
Call Trace:
  [<c02b8259>] snd_register_device+0xc9/0x1a0
  [<c02bce8d>] snd_ctl_register+0x4d/0x70
  [<c02b8c70>] snd_card_free_thread+0x0/0x80
  [<c02b877a>] snd_card_new+0x19a/0x280
  [<c0498009>] snd_card_bt_sco_probe+0x29/0x260
  [<c0498267>] alsa_card_bt_sco_init+0x27/0x40
  [<c04788f3>] do_initcalls+0x23/0xc0
  [<c049a9f6>] sock_init+0x46/0x50
  [<c0100440>] init+0x0/0x120
  [<c010046a>] init+0x2a/0x120
  [<c0100858>] kernel_thread_helper+0x0/0x18
  [<c010085d>] kernel_thread_helper+0x5/0x18
Code: 20 3c c0 89 44 24 04 e9 ad e1 e6 ff 8d b6 00 00 00 00 8d bc 27 00 
00 00 0
0 56 53 8b 74 24 0c 89 f0 c1 f8 05 8b 14 c5 a0 75 4c c0 <8b> 0a 8b 74 26 
00 8d
04 c5 a0 75 4c c0 39 c2 74 22 89 c3 8d 74
  <0>Kernel panic - not syncing: Attempted to kill init!


Digging through the source I found this in sound/core/sound.c:
...
static snd_minor_t *snd_minor_search(int minor)
{
	struct list_head *list;
	snd_minor_t *mptr;

	list_for_each(list, &snd_minors_hash[SNDRV_MINOR_CARD(minor)]) {
		mptr = list_entry(list, snd_minor_t, list);
		if (mptr->number == minor)
			return mptr;
	}
	return NULL;
}
...

To find out what's going wrong I added some debug messages:
...
	printk(KERN_INFO "snd_minors_hash: minor: %d\n", minor);
	list_for_each(list, &snd_minors_hash[SNDRV_MINOR_CARD(minor)]) {
		printk(KERN_INFO "snd_minors_hash: list_for_each\n");
...

The kernel oopses the same way:
...
snd-bt-sco revision 1.4 $
snd_minors_hash: minor: 0
Unable to handle kernel NULL pointer dereference at virtual address 00000000
...

As other soundcard drivers can be built in I think this is no problem
with the kernel or ALSA-core.
Can someone please point me to why this is happening or is it known
that snd-bt-sco is working as module only?
Thanks in advance.

Best regards,
Sebastian



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
