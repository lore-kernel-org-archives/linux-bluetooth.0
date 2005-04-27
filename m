Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: Phil Stopford <philstopford@hotmail.com>
Message-ID: <loom.20050427T153844-482@post.gmane.org>
References: <loom.20050427T005347-298@post.gmane.org>  <1114598331.10706.392.camel@pegasus>  <loom.20050427T142840-221@post.gmane.org> <1114606563.8836.1.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-users] Re: Belkin F8T002 PCMCIA - how to get working?
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 27 Apr 2005 13:46:55 +0000 (UTC)

Marcel Holtmann <marcel <at> holtmann.org> writes:

> 
> Hi Phil,
> 
> > > is this a PCMCIA, Compact Flash or CardBus card? Do you see another ttyS
> > > device when calling dmesg?
> > > 
> > 
> > Cardbus. A quick search on the dmesg
> > output, after inserting the card, for 'serial' turned up this :
> > 
> > serio: i8042 AUX port at 0x60,0x64 irq 12
> > serio: i8042 KBD port at 0x60,0x64 irq 1
> > Serial: 8250/16550 driver $Revision: 1.90 $ 48 ports, IRQ sharing enabled
> > PCI: Found IRQ 11 for device 0000:00:03.1
> > PCI: Sharing IRQ 11 with 0000:00:03.0
> > 
> > Searching for ttyS doesn't turn up anything in the dmesg output at all.
> 
> since it is a CardBus card, what does lspci say? What modules are
> loaded?
> 

Limitations with the posting interface on post.gmane.org (80 column width) means
that this will be formatted oddly, but hopefully it will make sense :

lscpi reports :

0000:00:00.0
  Host bridge: Intel Corporation 440BX/ZX/DX
                - 82443BX/ZX/DX Host bridge (rev 03)
0000:00:01.0
  PCI bridge: Intel Corporation 440BX/ZX/DX
               - 82443BX/ZX/DX AGP bridge (rev 03)
0000:00:02.0
  CardBus bridge: Texas Instruments PCI1450 (rev 03)
0000:00:02.1
  CardBus bridge: Texas Instruments PCI1450 (rev 03)
0000:00:03.0
  Ethernet controller: Intel Corporation 82557/8/9 [Ethernet Pro 100] (rev 09)
0000:00:03.1
  Serial controller: Xircom Mini-PCI V.90 56k Modem
0000:00:05.0
  Multimedia audio controller: Cirrus Logic CS 4614/22/24
             [CrystalClear SoundFusion Audio Accelerator] (rev 01)
0000:00:07.0
  Bridge: Intel Corporation 82371AB/EB/MB PIIX4 ISA (rev 02)
0000:00:07.1
  IDE interface: Intel Corporation 82371AB/EB/MB PIIX4 IDE (rev 01)
0000:00:07.2
  USB Controller: Intel Corporation 82371AB/EB/MB PIIX4 USB (rev 01)
0000:00:07.3
  Bridge: Intel Corporation 82371AB/EB/MB PIIX4 ACPI (rev 03)
0000:01:00.0
  VGA compatible controller: S3 Inc. 86C270-294 Savage/IX-MV (rev 11)
0000:02:00.0
  Serial controller: Oxford Semiconductor Ltd OXCB950 Cardbus 16950 UART

lsmod reports the following (where necessary lines have been broken up to allow
me to post this via post.gmane.org) :

Module                  Size  Used by
ipt_LOG                 6912  12 
ipt_limit               2432  12 
ipt_pkttype             1792  2 
subfs                   7296  1 
usbserial              28008  0 
nvram                   8200  0 
snd_pcm_oss            57632  0 
snd_mixer_oss          18944  1 snd_pcm_oss
snd_seq_midi            9376  0 
speedstep_lib           4100  0 
snd_seq_midi_event      7552  1 snd_seq_midi
snd_seq                52752  2 snd_seq_midi,snd_seq_midi_event
freq_table              4484  0 
processor              23732  0 
rfcomm                 36636  0 
hidp                   15360  2 
l2cap                  23556  10 rfcomm,hidp
bluetooth              47108  5 rfcomm,hidp,l2cap
usbhid                 41312  0 
pcmcia                 24072  4 
ipt_state               2048  12 
ip6t_REJECT             6784  3 
ipt_REJECT              6656  3 
iptable_mangle          2816  0 
iptable_filter          2944  1 
ip6table_mangle         2432  0 
ip_nat_ftp              3072  0 
edd                    10080  0 
evdev                   8832  0 
joydev                  9664  0 
sg                     36256  0 
iptable_nat            22236  1 ip_nat_ftp
st                     37788  0 
sd_mod                 17936  0 
snd_cs46xx             88008  0 
sr_mod                 16548  0 
gameport               14728  2 snd_cs46xx
scsi_mod              125256  4 sg,st,sd_mod,sr_mod
snd_rawmidi            24864  2 snd_seq_midi,snd_cs46xx
snd_seq_device          8588  3 snd_seq_midi,snd_seq,snd_rawmidi
snd_ac97_codec         71416  1 snd_cs46xx
snd_pcm                93832  3 snd_pcm_oss,snd_cs46xx,snd_ac97_codec
ip_conntrack_ftp       72592  1 ip_nat_ftp
snd_timer              24452  2 snd_seq,snd_pcm
i2c_piix4               8464  0 
i2c_core               21776  1 i2c_piix4
ip_conntrack           42168  4 ipt_state,ip_nat_ftp,iptable_nat,ip_conntrack_ftp

snd                    60548  11
snd_pcm_oss,snd_mixer_oss,snd_seq_midi,snd_seq_midi_event,snd_seq,
snd_cs46xx,snd_rawmidi,snd_seq_device,snd_ac97_codec,snd_pcm,snd_timer

soundcore               8928  1 snd
snd_page_alloc          9988  2 snd_cs46xx,snd_pcm
uhci_hcd               30224  0 
e100                   35968  0 
usbcore               108760  4 usbserial,usbhid,uhci_hcd
mii                     4864  1 e100
yenta_socket           21128  3 
rsrc_nonstatic         10112  1 yenta_socket
intel_agp              21532  1 
pcmcia_core            47024  3 pcmcia,yenta_socket,rsrc_nonstatic
agpgart                32296  1 intel_agp

ip_tables              20352  8 ipt_LOG,ipt_limit,ipt_pkttype,ipt_state,
ipt_REJECT,iptable_mangle,iptable_filter,iptable_nat

ip6table_filter         2816  1 
ip6_tables             18304  3 ip6t_REJECT,ip6table_mangle,ip6table_filter
ipv6                  236672  9 ip6t_REJECT
video1394              17612  0 
ohci1394               31492  1 video1394
raw1394                28140  0 
ieee1394               97976  3 video1394,ohci1394,raw1394
capability              3256  0 
parport_pc             38212  0 
lp                     11076  0 
parport                33864  2 parport_pc,lp
nls_utf8                2048  1 
ntfs                  167184  1 
dm_mod                 56316  0 
reiserfs              242928  1 
ide_cd                 37892  0 
cdrom                  36640  2 sr_mod,ide_cd
ide_disk               16640  4 
piix                    9988  0 [permanent]
ide_core              120020  3 ide_cd,ide_disk,piix

> Regards
> 
> Marcel
> 
> -------------------------------------------------------
> SF.Net email is sponsored by: Tell us your software development plans!
> Take this survey and enter to win a one-year sub to SourceForge.net
> Plus IDC's 2005 look-ahead and a copy of this survey
> Click here to start!  http://www.idcswdc.com/cgi-bin/survey?id=105hix
> 






-------------------------------------------------------
SF.Net email is sponsored by: Tell us your software development plans!
Take this survey and enter to win a one-year sub to SourceForge.net
Plus IDC's 2005 look-ahead and a copy of this survey
Click here to start!  http://www.idcswdc.com/cgi-bin/survey?id=105hix
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
