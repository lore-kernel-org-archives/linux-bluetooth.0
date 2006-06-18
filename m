Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <85cea3460606181559q2d4bc1d3qa235739eca06b629@mail.gmail.com>
Date: Sun, 18 Jun 2006 15:59:13 -0700
From: "Sweta Vasudevan" <sweta.vasudevan@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <4492E62E.3010005@dgreaves.com>
MIME-Version: 1.0
References: <85cea3460606111303r218e088ek21d50709fce3c6df@mail.gmail.com>
	<448C81FC.50509@xmission.com>
	<85cea3460606142049y81d6573q476aa9e599e4372d@mail.gmail.com>
	<4491C2FF.3010604@xmission.com> <4492E62E.3010005@dgreaves.com>
Subject: Re: [Bluez-devel] btsco and connection problems
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1434125141=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============1434125141==
Content-Type: multipart/alternative;
	boundary="----=_Part_94576_14138881.1150671553918"

------=_Part_94576_14138881.1150671553918
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello David,


> lsmod??
>
> looking for rfcomm
>
>
> David
>
> --



rfcomm did show up. output of lsmod:

Module                  Size      Used by
snd_bt_sco             15020  1
snd_hwdep               9797  1 snd_bt_sco
hci_usb                17109    2
i2c_i810                5445     0
i2c_algo_bit            9161    1 i2c_i810
i915                   19521      1
drm                    69589      2 i915
parport_pc             27437   1
lp                     12929        0
parport                36489     2 parport_pc,lp
autofs4                19653    1
rfcomm                 37333   0
l2cap                  24641     5 rfcomm
bluetooth              48165   7 hci_usb,rfcomm,l2cap
sunrpc                149093   1
dm_mod                 55765  0
video                  15429      0
button                  6609      0
battery                 9413      0
ac                      4933       0
ipv6                  249601     20
uhci_hcd               32465   0
ehci_hcd               33101   0
hw_random               5977  0
i2c_i801                8909     0
i2c_core               22081    2 i2c_algo_bit,i2c_i801
snd_intel8x0           31965  1
snd_ac97_codec      88673  1 snd_intel8x0
snd_ac97_bus           2496  1 snd_ac97_codec
snd_seq_dummy       3781  0
snd_seq_oss            30885  0
snd_seq_midi_event      7233  1 snd_seq_oss
snd_seq                49677   5
snd_seq_dummy,snd_seq_oss,snd _seq_midi_event
snd_seq_device          9292  3 snd_seq_dummy,snd_seq_oss,snd_seq
snd_pcm_oss            48625  0
snd_mixer_oss          17473  1 snd_pcm_oss
snd_pcm                84933     4
snd_bt_sco,snd_intel8x0,snd_ac97_codec,snd_pcm_oss
snd_timer              25029     2 snd_seq,snd_pcm
snd                    52513       15
snd_bt_sco,snd_hwdep,snd_intel8x0,snd_ac97_codec,snd_seq_oss,snd_seq,snd_seq_device,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer

soundcore               9633    1 snd
snd_page_alloc         10825  3 snd_bt_sco,snd_intel8x0,snd_pcm
tulip                  51041         0
3c59x                  44777      0
b44                    24653        0
mii                     5697         2 3c59x,b44
floppy                 63869       0
ext3                  128969      2
jbd                    57173       1 ext3

Thanks,
Sweta.

Thanks,
Sweta.

------=_Part_94576_14138881.1150671553918
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br>Hello David,<br><br><div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><br>lsmod??<br><br>looking for rfcomm<br><br><br>David<br><br>--
</blockquote><div><br><br></div></div>rfcomm did show up. output of lsmod:<br><br>Module &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Size &nbsp; &nbsp;&nbsp; Used by<br>snd_bt_sco &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 15020 &nbsp;1<br>snd_hwdep &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 9797 &nbsp;1 snd_bt_sco<br>hci_usb &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;17109 &nbsp;&nbsp; 2
<br>
i2c_i810 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;5445 &nbsp;&nbsp;&nbsp; 0<br>i2c_algo_bit &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;9161 &nbsp;&nbsp; 1 i2c_i810<br>i915 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 19521 &nbsp;&nbsp;&nbsp;&nbsp; 1<br>drm &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;69589 &nbsp;&nbsp;&nbsp;&nbsp; 2 i915<br>parport_pc &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 27437 &nbsp; 1<br>lp &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 12929 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0
<br>
parport &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;36489 &nbsp;&nbsp;&nbsp; 2 parport_pc,lp<br>autofs4 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;19653 &nbsp;&nbsp; 1<br>rfcomm &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 37333 &nbsp; 0<br>l2cap &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;24641 &nbsp;&nbsp;&nbsp; 5 rfcomm<br>bluetooth &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;48165 &nbsp; 7 hci_usb,rfcomm,l2cap
<br>sunrpc &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;149093 &nbsp; 1
<br>dm_mod &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 55765 &nbsp;0<br>video &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;15429 &nbsp;&nbsp;&nbsp;&nbsp; 0<br>button &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;6609 &nbsp;&nbsp;&nbsp;&nbsp; 0<br>battery &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 9413 &nbsp;&nbsp;&nbsp;&nbsp; 0<br>ac &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;4933 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0<br>ipv6 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;249601 &nbsp;&nbsp;&nbsp; 20
<br>uhci_hcd &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 32465 &nbsp; 0
<br>ehci_hcd &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 33101 &nbsp; 0<br>hw_random &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 5977&nbsp; 0<br>i2c_i801 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;8909 &nbsp;&nbsp;&nbsp; 0<br>i2c_core &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 22081 &nbsp;&nbsp; 2 i2c_algo_bit,i2c_i801<br>snd_intel8x0 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 31965&nbsp; 1<br>snd_ac97_codec &nbsp; &nbsp;&nbsp; 88673 &nbsp;1 snd_intel8x0
<br>snd_ac97_bus &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;&nbsp; 2496 &nbsp;1 snd_ac97_codec<br>snd_seq_dummy &nbsp; &nbsp; &nbsp; 3781 &nbsp;0<br>snd_seq_oss &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;30885 &nbsp;0<br>snd_seq_midi_event &nbsp; &nbsp; &nbsp;7233 &nbsp;1 snd_seq_oss<br>snd_seq &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;49677 &nbsp; 5<br>snd_seq_dummy,snd_seq_oss,snd
<div style="direction: ltr;">_seq_midi_event<br>snd_seq_device &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;9292 &nbsp;3 snd_seq_dummy,snd_seq_oss,snd_seq<br>snd_pcm_oss &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;48625 &nbsp;0<br>snd_mixer_oss &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;17473 &nbsp;1 snd_pcm_oss<br>snd_pcm &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;84933 &nbsp;&nbsp;&nbsp; 4
<br>snd_bt_sco,snd_intel8x0,snd_ac97_codec,snd_pcm_oss<br>snd_timer &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;25029 &nbsp;&nbsp;&nbsp; 2 snd_seq,snd_pcm<br>snd &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;52513 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 15<br>snd_bt_sco,snd_hwdep,snd_intel8x0,snd_ac97_codec,snd_seq_oss,snd_seq,snd_seq_device,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer
<br>soundcore &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 9633 &nbsp;&nbsp; 1 snd<br>snd_page_alloc &nbsp; &nbsp; &nbsp; &nbsp; 10825 &nbsp;3 snd_bt_sco,snd_intel8x0,snd_pcm<br>tulip &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;51041 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0<br>3c59x &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;44777 &nbsp;&nbsp;&nbsp;&nbsp; 0<br>b44 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;24653 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0
<br>mii &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 5697 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2 3c59x,b44
<br>floppy &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 63869 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0<br>ext3 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;128969 &nbsp;&nbsp;&nbsp;&nbsp; 2<br>jbd &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;57173 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1 ext3<br><br>Thanks,<br>Sweta.<br><br>Thanks,<br>Sweta.<br></div>


------=_Part_94576_14138881.1150671553918--


--===============1434125141==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1434125141==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1434125141==--
