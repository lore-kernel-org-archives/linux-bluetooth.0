Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20060802120735.632c4f18@p4.prod.lan>
References: <20060802120735.632c4f18@p4.prod.lan>
Date: Wed, 02 Aug 2006 15:37:17 +0200
Message-Id: <1154525837.3905.49.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Cc: Christoph Hellwig <hch@lst.de>
Subject: Re: [Bluez-devel] system freeze in 2.6.17-mh5
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Stefan,

> I am using gentoo linux and recently updated my kernel to
> gentoo-sources-2.6.17-r4 and patched it with the -mh5 patches from
> bluez.org. I need this patch for getting my Logitech Dinovo desktop to
> work.
> After upgrading I discovered that my machine freezes after being left
> idle for approximately 30 min.
> I posted this problem already at forums.gentoo.org and someone
> suggested me to remove the bluez-patch and see whether the problem
> still occurs and it does not without the patch. This makes me think
> that the system crash must somehow be related to your patch.
> The console log of the crash is as follows:
> 
> BUG: scheduling while atomic: swapper/0x00000100/0
>  <c02ecbd2> wait_for_completion+0x82/0xb6  <c0115504>
> default_wake_function+0x0/0x12 <c0115504>
> default_wake_function+0x0/0x12  <c0113c8e> wake_up_process+0xd/0xf
> <c02e8b6f> hidp_idle_timeout+0x0/0x10  <c01297e2>
> kthread_stop_sem+0x74/0x93 <c012976b> kthread_stop+0xb/0xe  <c01213bb>
> run_timer_softirq+0x138/0x17d <c011dd7f> __do_softirq+0x5b/0xc2
> <c011de13> do_softirq+0x2d/0x31 <c010315c>
> apic_timer_interrupt+0x1c/0x24  <c0100aec> default_idle+0x0/0x55
> <c0100b18> default_idle+0x2c/0x55  <c0100baf> cpu_idle+0x5a/0x6f
> <c03b2757> start_kernel+0x157/0x159 BUG: unable to handle kernel NULL
> pointer dereference at virtual address 00000000 printing eip: c0113241
> *pde = 00000000
> Oops: 0002 [#1]
> SMP
> Modules linked in: nfsd exportfs lockd sunrpc ipt_TCPMSS xt_state
> ipt_REJECT xt_tcpudp iptable_filter ipt_MASQUERADE iptable_nat ip_nat
> ip_conntrack ip_tables x_tables hci_usb pppoe pppox ppp_synctty
> ppp_async crc_ccitt ppp_generic slhc snd_seq_midi snd_emu10k1_synth
> snd_emux_synth snd_seq_virmidi snd_seq_midi_emul snd_pcm_oss
> snd_mixer_oss snd_seq_oss snd_seq_midi_event snd_seq usbhid snd_emu10k1
> snd_rawmidi snd_ac97_codec snd_ac97_bus snd_pcm snd_seq_device
> snd_timer snd_page_alloc snd_util_mem snd_hwdep snd CPU:    0 EIP:
> 0060:[<c0113241>]    Not tainted VLI EFLAGS: 00010046
> (2.6.17-gentoo-r4 #2) EIP is at dequeue_task+0xb/0x3f eax: c1c09b20
> ebx: c03473c0   ecx: c1c09b20   edx: c03473c0 esi: 00000000   edi:
> c03adf1c   ebp: c03ade98   esp: c03ade90 ds: 007b   es: 007b   ss: 0068
> Process swapper (pid: 0, threadinfo=c03ac000 task=c03473c0) Stack:
> c03473c0 c03473c0 c03adeac c01134e4 c03473c0 00000000 c03474c8 c03adf00
> c02ec68a c03473c0 c1c09b20 00000001 c03adee8 c0113481 c1ef4a90 c1c09b20
> 00000000 c03adee8 c1c09b20 02255100 964e6c00 003d0a85 c03adf3c c03473c0
> Call Trace: <c01134e4> deactivate_task+0x16/0x22  <c02ec68a>
> schedule+0x186/0x64c <c0113481> activate_task+0x5a/0xa7  <c02ecbd2> 
> 
> I can post any config-files as needed and I am willing to support the
> debugging if told how to.

this looks like a problem with the kthread API. We converted BNEP, CMTP
and HIDP to it with 2.6.17-mh3. So a 2.6.17-mh2 kernel should work
without any problems.

Christoph, any ideas. Did you see a similar problem before.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
