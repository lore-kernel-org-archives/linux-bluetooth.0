Return-Path: <cyrus@holtmann.org>
From: Alexander <al_petukhov@mail.ru>
To: bluez-users@lists.sourceforge.net
Date: Sat, 12 Apr 2008 18:01:04 +0400
Message-Id: <1208008864.5456.4.camel@athlon>
Mime-Version: 1.0
Subject: [Bluez-users] Motorola H375 headset problem
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hello, i have Motorola H375 headset:
~/.asoundrc looks like: 

                                    
                                    
                            pcm.bluetooth { 
                                 type plug 
                                  slave { 
                              pcm "bluetooth_hw" 
                                     } 
                                   } 
                                    
                          pcm.bluetooth_hw { 
                              type bluetooth 
                         device 00:0B:2E:5B:30:E6 
                                   } 
                                    


only app that works is mplayer. it works with both "plug" and
"bluetooth" devices: 

                                    
                                    
      pit@athlon:~$ mplayer -ao alsa:device=bluetooth ~/file.mp3 
                                 ..... 
                      Playing /home/pit/file.mp3. 
                   Audio file file format detected. 
                              Clip info: 
                            Title: Buratino 
                        Artist: Psoiy Korolenko 
                       Album: www.cool-mp3.da.ru 
                               Year: 2001 
                      Comment: www.cool-mp3.da.ru 
                            Genre: Acoustic 
========================================================================== 
         Opening audio decoder: [mp3lib] MPEG layer-2, layer-3 
  AUDIO: 44100 Hz, 2 ch, s16le, 56.0 kbit/3.97% (ratio: 7000->176400) 
Selected audio codec: [mp3] afm: mp3lib (mp3lib MPEG layer-2, layer-3) 
========================================================================== 
           AO: [alsa] 8000Hz 2ch s16le (2 bytes per sample) 
                            Video: no video 
                         Starting playback... 
                                    


                                    
                                    
     pit@athlon:~$ mplayer -ao alsa:device=bluetooth_hw ~/file.mp3 
                                 .... 
                      Playing /home/pit/file.mp3. 
                   Audio file file format detected. 
                              Clip info: 
                            Title: Buratino 
                        Artist: Psoiy Korolenko 
                       Album: www.cool-mp3.da.ru 
                               Year: 2001 
                      Comment: www.cool-mp3.da.ru 
                            Genre: Acoustic 
========================================================================== 
         Opening audio decoder: [mp3lib] MPEG layer-2, layer-3 
  AUDIO: 44100 Hz, 2 ch, s16le, 56.0 kbit/3.97% (ratio: 7000->176400) 
Selected audio codec: [mp3] afm: mp3lib (mp3lib MPEG layer-2, layer-3) 
========================================================================== 
           AO: [alsa] 8000Hz 1ch s16le (2 bytes per sample) 
                            Video: no video 
                         Starting playback... 
                                    


all other apps i trying to make work with headset causes aaplication
crash, system freeez or sounds like beeps when trying to play with aplay
and something like a crackling when recording with arecord. 
aplay sounds ok only if using "bluetooth" type device and specify rate
format and channels count in command line 
using aplay with plug device causes system crash 

system crash log: 

                                    
                                    
   Apr  5 13:03:35 athlon kernel: usb 2-1: USB disconnect, address 2 
 Apr  5 13:03:35 athlon kernel: __tx_submit: hci0 tx submit failed urb
                        e0be3414 type 3 err -19 
 Apr  5 13:03:35 athlon kernel: __tx_submit: hci0 tx submit failed urb
                        e0be3414 type 3 err -19 
  Apr  5 13:03:35 athlon kernel: ------------[ cut here ]------------ 
      Apr  5 13:03:35 athlon kernel: kernel BUG at mm/slab.c:603! 
       Apr  5 13:03:35 athlon kernel: invalid opcode: 0000 [#1] 
                  Apr  5 13:03:35 athlon kernel: SMP 
  Apr  5 13:03:35 athlon kernel: Modules linked in: sco ipv6 nvidia(P)
    rfcomm l2cap button ac battery dm_snapshot dm_mirror dm_mod loop
 snd_intel8x0 snd_ac97_codec ac97_bus snd_pcm_oss snd_mixer_oss snd_pcm
 snd_seq_dummy snd_seq_oss snd_seq_midi snd_rawmidi snd_seq_midi_event
 snd_seq analog snd_timer snd_seq_device gameport snd hci_usb bluetooth
     parport_pc parport pcspkr rtc soundcore snd_page_alloc shpchp
 pci_hotplug i2c_nforce2 i2c_core nvidia_agp agpgart joydev evdev tsdev
   ext3 jbd mbcache ide_cd cdrom ide_disk usbhid hid amd74xx generic
    ide_core floppy 8139too mii ata_generic libata scsi_mod ehci_hcd
                ohci_hcd usbcore thermal processor fan 
               Apr  5 13:03:35 athlon kernel: CPU:    0 
 Apr  5 13:03:35 athlon kernel: EIP:    0060:[<c0167343>]    Tainted: P
                                    VLI 
  Apr  5 13:03:35 athlon kernel: EFLAGS: 00010046   (2.6.22-3-k7 #1) 
     Apr  5 13:03:35 athlon kernel: EIP is at free_block+0x4d/0xfb 
  Apr  5 13:03:35 athlon kernel: eax: 40000000   ebx: 00000004   ecx:
                       e125d080   edx: c1424ba0 
  Apr  5 13:03:35 athlon kernel: esi: e125d020   edi: dfffd2a0   ebp:
                       dffff4a0   esp: c1a93e20 
Apr  5 13:03:35 athlon kernel: ds: 007b   es: 007b   fs: 00d8  gs: 0000
                               ss: 0068 
  Apr  5 13:03:35 athlon kernel: Process khubd (pid: 629, ti=c1a92000
                    task=dff4f0b0 task.ti=c1a92000) 
    Apr  5 13:03:35 athlon kernel: Stack: 00000001 00000000 0000003c
             00000001 dfff9c18 0000003c dffff4a0 d7e964e0 
    Apr  5 13:03:35 athlon kernel:        00000000 c0167107 00000000
             dfff9c00 dfffd2a0 dfff9c00 00000282 d7e964e0 
    Apr  5 13:03:35 athlon kernel:        dfee7800 c01671af f7599c20
             00000003 00000000 c02464a8 dfe12308 c024662e 
                                    


any ideas?


-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
