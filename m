Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: Will Partain <will.partain@verilab.com>
Message-ID: <lu8ylbven9.fsf@pc22.verilab.com>
References: <3F4F6BF2.6080303@gtmp.org> <1062170277.27784.138.camel@pegasus>
 <3F4F70B1.20200@gtmp.org> <3F50803C.607@gtmp.org>
 <1062425807.13729.162.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-users] Re: Belkin F8T002 PC Card problem with Bluez
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 17 Dec 2003 11:59:22 +0000

(I am picking up a thread about this card from back in September.)

To recap, with Belkin F8T002 card plugged into a Presario
908EA laptop running a modified current-RH9 kernel [added a
few lines as Alexandre Jousset suggested earlier in this
thread]. Then with...

   # /etc/rc.d/init.d/pcmcia restart 
   Shutting down PCMCIA services: cardmgr modules. 
   Starting PCMCIA services: cardmgr. 
 
In the syslog for that, you see...

    kernel: unloading Kernel Card Services 
    kernel: Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0 
    kernel: sr0: scsi3-mmc drive: 24x/24x writer cd/rw xa/form2 cdda tray 
    kernel: Uniform CD-ROM driver Revision: 3.12 
    kernel: Linux Kernel Card Services 3.1.22 
    kernel:   options:  [pci] [cardbus] [pm] 
    kernel: PCI: Assigned IRQ 10 for device 00:0a.0 
    kernel: Yenta IRQ list 02b8, PCI irq10 
    kernel: Socket status: 30000020 
    kernel: cs: cb_alloc(bus 2): vendor 0x1415, device 0x950b 
    kernel: PCI: Enabling device 02:00.0 (0000 -> 0003) 
    kernel: ttyS4 at port 0x4000 (irq = 10) is a 16C950/954 
    cardmgr[1508]: starting, version is 3.1.31 
    cardmgr[1508]: watching 1 sockets 
    cardmgr[1508]: Card Services release does not match 
    kernel: cs: IO port probe 0x0c00-0x0cff: clean. 
    kernel: cs: IO port probe 0x0100-0x04ff: excluding 0x200-0x207 0x378-0x3\
    x4d0-0x4d7 
    kernel: cs: IO port probe 0x0a00-0x0aff: clean. 
    cardmgr[1508]: socket 0: CardBus hotplug device 
    /sbin/hotplug: arguments (pci) env (PCI_SLOT_NAME=02:00.0 PCI_ID=1415:95\
    /usr/sbin:/usr/bin ACTION=add PWD=/etc/hotplug PCI_SUBSYS_ID=1415:0001 S
    CLASS=70006 _=/bin/env) 
    /sbin/hotplug: invoke /etc/hotplug/pci.agent () 
    /etc/hotplug/pci.agent: ... no modules for PCI slot 02:00.0 

Anyway, it's there:

    # cardctl ident 
    Socket 0: 
      product info: "OXSEMI", "OXCB950", "Rev A" 
      manfid: 0x0279, 0x0001 
      function: 2 (serial) 

An 'hciattach' then "works", where "works" is defined to
mean "something happened".  The simplest form
(hciattach /dev/ttyS4 any) spews nonsense, as was seen
earlier in this thread.

The glorious Marcel suggested 'hciattach /dev/ttyS4 bcsp'
(which simply replies: "BCSP initialization timed out").  He
further suggested fiddling with baud rates and the like;
neither Alexandre not I have had any luck with that (it
still just times out).

So: Has anyone made further progress on this device and/or
has any suggestions?  (I am serially incompetent and short
of time, but I'll try to help if I can.)  Thanks and regards
to all,

Will



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
