Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <1ab01fb50701300751v6c64eaacidff7d7b4fac8122d@mail.gmail.com>
Date: Tue, 30 Jan 2007 21:21:56 +0530
From: "Vikas Sinha" <compuvikas@gmail.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-devel] Hciattach not working
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0070549943=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============0070549943==
Content-Type: multipart/alternative;
	boundary="----=_Part_89619_32044195.1170172316472"

------=_Part_89619_32044195.1170172316472
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi all
I am trying to use serial bluetooth adaptor on linux RHEL 4.0 kernel 2.6.9.
with bluez support as
bluez-bluefw-1.0-6
bluez-libs-devel-2.10-2
bluez-libs-2.10-2
bluez-utils-2.10-2.1

I even try to build latest kernel 2.6.19 with all these support. But i am
not able to use my adaptor.
The Adaptor I am using is IOGEAR(GBS301) Bluetooth to Serial Adaptor.

I have used
setserial /dev/ttyS0 baud_base 115200 auto_irq
setserial -abGv /dev/ttyS0
hciattach -s 115200 /dev/ttyS0 any 115200

but after doing hciconfig i get

hci0: Type: UART
BD Address: 00:00:00:00:00:00 ACL MTU: 0:0 SCO MTU: 0:0
DOWN
RX bytes:0 acl:0 sco:0 events:0 errors:0
TX bytes:12 acl:0 sco:0 commands:3 errors:0

if I try
#hciattach -s 115200 /dev/ttyS0 bcsp 115200

it gives me BCSP initialization timeout

if I try with
#hciconfig hci0 up
it gives me
Can't init device hci0: Connection timed out (110)

my lsmod is
Module Size Used by
hidp 28160 2
rfcomm 37528 0
l2cap 23168 10 hidp,rfcomm
hci_uart 16120 1
bluetooth 50020 6 hidp,rfcomm,l2cap,hci_uart
ipv6 226720 18
autofs4 20996 0
sunrpc 149948 1
dm_mod 56216 0
button 7056 0
battery 10500 0
asus_acpi 16408 0
ac 5636 0
ehci_hcd 30216 0
i2c_viapro 8980 0
i2c_core 21248 1 i2c_viapro
snd_via82xx 26900 0
snd_ac97_codec 88096 1 snd_via82xx
snd_ac97_bus 2816 1 snd_ac97_codec
snd_pcm_oss 41760 0
snd_mixer_oss 16256 1 snd_pcm_oss
snd_pcm 75140 3 snd_via82xx,snd_ac97_codec,snd_pcm_oss
snd_timer 22788 1 snd_pcm
snd_page_alloc 10120 2 snd_via82xx,snd_pcm
snd_mpu401_uart 8832 1 snd_via82xx
snd_rawmidi 23456 1 snd_mpu401_uart
snd_seq_device 8076 1 snd_rawmidi
snd 50148 9
snd_via82xx,snd_ac97_codec,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer,snd_mpu401_uart,snd_rawmidi,s
nd_seq_device
soundcore 8160 1 snd
via_rhine 24328 0
mii 5760 1 via_rhine
ext3 124552 2
jbd 56104 1 ext3
sd_mod 20480 0
scsi_mod 132524 1 sd_mod


Can some one help me I am in deep trouble

-- 
Impossible
itself contain
I M Possible

Vikas

------=_Part_89619_32044195.1170172316472
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi all<br>
I am trying to use serial bluetooth adaptor on linux RHEL 4.0 kernel 2.6.9. with bluez support as <br>

<font color="Red">bluez-bluefw-1.0-6<br>
bluez-libs-devel-2.10-2<br>
bluez-libs-2.10-2<br>
bluez-utils-2.10-2.1</font><br>

<br>

I even try to build latest kernel 2.6.19 with all these support. But i am not able to use my adaptor. <br>

The Adaptor I am using is IOGEAR(GBS301) Bluetooth to Serial Adaptor. <br>

<br>

I have used <br>

<font color="Red">setserial /dev/ttyS0 baud_base 115200 auto_irq<br>
setserial -abGv /dev/ttyS0<br>
hciattach -s 115200 /dev/ttyS0 any 115200<br>
</font><br>

but after doing hciconfig i get <br>

<br>

<font color="Red">hci0:   Type: UART<br>
        BD Address: 00:00:00:00:00:00 ACL MTU: 0:0 SCO MTU: 0:0<br>
        DOWN<br>
        RX bytes:0 acl:0 sco:0 events:0 errors:0<br>
        TX bytes:12 acl:0 sco:0 commands:3 errors:0<br>
</font><br>

if I try <br>

#hciattach -s 115200 /dev/ttyS0 bcsp 115200<br>

<br>

it gives me BCSP initialization timeout<br>

<br>

if I try with <br>

#hciconfig hci0 up<br>

it gives me <br>

Can&#39;t init device hci0: Connection timed out (110)<br>

<br>

my lsmod is <br>

<font color="Red">Module                  Size  Used by<br>
hidp                   28160  2<br>
rfcomm                 37528  0<br>
l2cap                  23168  10 hidp,rfcomm<br>
hci_uart               16120  1<br>
bluetooth              50020  6 hidp,rfcomm,l2cap,hci_uart<br>
ipv6                  226720  18<br>
autofs4                20996  0<br>
sunrpc                149948  1<br>
dm_mod                 56216  0<br>
button                  7056  0<br>
battery                10500  0<br>
asus_acpi              16408  0<br>
ac                      5636  0<br>
ehci_hcd               30216  0<br>
i2c_viapro              8980  0<br>
i2c_core               21248  1 i2c_viapro<br>
snd_via82xx            26900  0<br>
snd_ac97_codec         88096  1 snd_via82xx<br>
snd_ac97_bus            2816  1 snd_ac97_codec<br>
snd_pcm_oss            41760  0<br>
snd_mixer_oss          16256  1 snd_pcm_oss<br>
snd_pcm                75140  3 snd_via82xx,snd_ac97_codec,snd_pcm_oss<br>
snd_timer              22788  1 snd_pcm<br>
snd_page_alloc         10120  2 snd_via82xx,snd_pcm<br>
snd_mpu401_uart         8832  1 snd_via82xx<br>
snd_rawmidi            23456  1 snd_mpu401_uart<br>
snd_seq_device          8076  1 snd_rawmidi<br>
snd 50148 9
snd_via82xx,snd_ac97_codec,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer,snd_mpu401_uart,snd_rawmidi,s
nd_seq_device<br>
soundcore               8160  1 snd<br>
via_rhine              24328  0<br>
mii                     5760  1 via_rhine<br>
ext3                  124552  2<br>
jbd                    56104  1 ext3<br>
sd_mod                 20480  0<br>
scsi_mod              132524  1 sd_mod<br>
</font><br>

<br>

Can some one help me I am in deep trouble<br clear="all"><br>-- <br>Impossible <br>itself contain <br>I M Possible<br><br>Vikas

------=_Part_89619_32044195.1170172316472--


--===============0070549943==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0070549943==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0070549943==--
