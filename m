Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <41D52FFF.10400@Qindel.ES>
From: Nito Martinez <Nito@Qindel.ES>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] compilation of kernel module snd-bt-sco with kernel-2.6.10
References: <41D4394B.7000509@Qindel.ES> <41D4B6BF.3050204@dark-reality.de>
In-Reply-To: <41D4B6BF.3050204@dark-reality.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
Date: Fri, 31 Dec 2004 11:54:55 +0100


Hi Lars,

that worked,

I had to add the

CONFIG_SND_EMU10K1=m

to the kernel configuration (so that the snd_hwdep module was built).

Thanks for your help,

Nito

Lars Grunewaldt wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> snd_hwdep_new is supplied by snd_hwdep, it's a seperate alsa kernel
> module. Maybe it's not loaded automatically.
>
> Make sure it is compiled and insmod/modprobe it before snd-bt-sco.
>
> I hope this helps!
>
> regards,
> ~  Lars
>
> Nito Martinez wrote:
> | Hi,
> |
> | I have been trying to compile the snd-bt-sco with kernel-2.6.10, and 
> I'm
> | getting this error/warning:
> |
> - 
> ---------------------------------------------------------------------------- 
>
>
> |
> | 18:00:02 nito@cardalda:/usr/src/btsco/kernel $ make clean
> | make[1]: Entering directory `/usr/src/linux-2.6.10'
> |  CLEAN   /usr/src/btsco/kernel/.tmp_versions
> | make[1]: Leaving directory `/usr/src/linux-2.6.10'
> | 18:15:55 nito@cardalda:/usr/src/btsco/kernel $ make
> | make[1]: Entering directory `/usr/src/linux-2.6.10'
> |  CC [M]  /usr/src/btsco/kernel/btsco.o
> |  LD [M]  /usr/src/btsco/kernel/snd-bt-sco.o
> |  Building modules, stage 2.
> |  MODPOST
> | *** Warning: "snd_hwdep_new" [/usr/src/btsco/kernel/snd-bt-sco.ko]
> | undefined!
> |  CC      /usr/src/btsco/kernel/snd-bt-sco.mod.o
> |  LD [M]  /usr/src/btsco/kernel/snd-bt-sco.ko
> | make[1]: Leaving directory `/usr/src/linux-2.6.10'
> | 18:16:06 nito@cardalda:/usr/src/btsco/kernel $
> |
> | When I try to load the module in the kernel I get the following error:
> |
> - 
> ------------------------------------------------------------------------------------------------------------------- 
>
>
> |
> | snd_bt_sco: Unknown symbol snd_hwdep_new
> |
> | which relates to the warning above.
> |
> | I've been tracing the function and it is available in the
> | "sound/core/hwdep.c" file, but I'm unable (or my knowledge of the 
> kernel
> | build structure is too short) to establish the dependency into the 
> module.
> |
> | I have a couple of questions:
> |
> | 1) Do I need to add in some way the hwdep.o into the kernel/Makefile ?
> | 2) Is it necessary that another module is loaded so that the dependency
> | is met?
> |
> | My current configuration is:
> | - Debian unstable (with updated packages as of 30/12)
> | - kernel 4.6.10
> | - Laptop with a Bluetooth/usb connector (works fine with other 
> bluetooth
> | devices like phones...)
> | - Alsa working with a trident module.
> |
> | Output of lsmod:
> |
> | cardalda:/usr/src/linux# lsmod
> | Module                  Size  Used by
> | ppp_deflate             4832  0
> | zlib_deflate           21720  1 ppp_deflate
> | zlib_inflate           17120  1 ppp_deflate
> | bsd_comp                5344  0
> | ppp_async               9184  0
> | ircomm_tty             35240  0
> | ircomm                 19332  1 ircomm_tty
> | ppp_generic            20820  3 ppp_deflate,bsd_comp,ppp_async
> | slhc                    6336  1 ppp_generic
> | snd_pcm_oss            58692  0
> | hci_usb                12256  2
> | nls_iso8859_1           3680  1
> | nls_cp437               5312  1
> | vfat                   11456  1
> | fat                    36512  1 vfat
> | nls_base                6240  4 nls_iso8859_1,nls_cp437,vfat,fat
> | snd_mixer_oss          19616  2 snd_pcm_oss
> | snd_seq_midi            7520  0
> | snd_seq_midi_event      6048  1 snd_seq_midi
> | snd_trident_synth      11552  1
> | snd_ainstr_simple       2592  1 snd_trident_synth
> | snd_seq_instr           8000  1 snd_trident_synth
> | snd_seq_midi_emul       7040  1 snd_trident_synth
> | snd_seq                55856  6
> |
> snd_seq_midi,snd_seq_midi_event,snd_trident_synth,snd_seq_instr,snd_seq_midi_emul 
>
>
> |
> | 8250_pci               16768  0
> | snd_trident            40548  2 snd_trident_synth
> | snd_ac97_codec         75392  1 snd_trident
> | snd_pcm                97384  3 snd_pcm_oss,snd_trident,snd_ac97_codec
> | snd_timer              23044  2 snd_seq,snd_pcm
> | snd_page_alloc          8004  3 snd_trident_synth,snd_trident,snd_pcm
> | snd_util_mem            3648  1 snd_trident
> | snd_mpu401_uart         6592  1 snd_trident
> | snd_rawmidi            21408  2 snd_seq_midi,snd_mpu401_uart
> | snd_seq_device          7212  5
> | snd_seq_midi,snd_trident_synth,snd_seq,snd_trident,snd_rawmidi
> | snd                    55748  15
> |
> snd_pcm_oss,snd_mixer_oss,snd_seq_midi,snd_seq_midi_event,snd_seq_instr,snd_seq_midi_emul,snd_seq,snd_trident,snd_ac97_codec,snd_pcm,snd_timer,snd_util_mem,snd_mpu401_uart,snd_rawmidi,snd_seq_device 
>
>
> |
> | soundcore               7328  2 snd
> | ohci_hcd               33064  0
> | sis                    71648  2
> | sis_agp                 5892  1
> | floppy                 54608  0
> | 8250_pnp                7872  0
> | psmouse                20040  0
> | rfcomm                 33948  1
> | l2cap                  22340  5 rfcomm
> | bluetooth              43748  7 hci_usb,rfcomm,l2cap
> | af_packet              13192  2
> | orinoco_cs              6984  1
> | orinoco                41516  1 orinoco_cs
> | hermes                  7616  2 orinoco_cs,orinoco
> | pcmcia                 17412  5 orinoco_cs
> | yenta_socket           19136  1
> | pcmcia_core            45292  3 orinoco_cs,pcmcia,yenta_socket
> | irtty_sir               7488  2
> | sir_dev                15404  1 irtty_sir
> | irda                  189216  6 ircomm_tty,ircomm,irtty_sir,sir_dev
> | crc_ccitt               1632  2 ppp_async,irda
> | usbcore               118104  3 hci_usb,ohci_hcd
> | parport_pc             22436  1
> | lp                      8136  0
> | parport                20736  2 parport_pc,lp
> | 8250                   20452  4 8250_pci,8250_pnp
> | serial_core            19200  1 8250
> |
> | Thanks in advance,
> |
> | Nito
> |
> |
> |
> | -------------------------------------------------------
> | The SF.Net email is sponsored by: Beat the post-holiday blues
> | Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
> | It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
> | _______________________________________________
> | Bluez-devel mailing list
> | Bluez-devel@lists.sourceforge.net
> | https://lists.sourceforge.net/lists/listinfo/bluez-devel
> |
>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.2.3 (GNU/Linux)
> Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org
>
> iD8DBQFB1La/QWC6DTWkDAoRAs1qAJ9fHv0aCmqgv0PiX7uZaNkv3flDrACfdowB
> bWksWBoSU88ssQ1bZwcX1zU=
> =62t5
> -----END PGP SIGNATURE-----
>
>
> -------------------------------------------------------
> The SF.Net email is sponsored by: Beat the post-holiday blues
> Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
> It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel



-- 
Benito Martinez                  
Jefe de Tecnologia               
email: Benito.Martinez@Qindel.ES 
--------------------------------
Qindel                           
C/ Cedaceros n.11, 2-H
28014 Madrid                     
Telf: (+34) 678476906
Telf: (+34) 913690059
Fax: (+34) 913690056



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
