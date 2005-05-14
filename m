Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Guylhem Aznar <bluez-devel@externe.net>
To: bluez-devel@lists.sourceforge.net
Message-ID: <20050514155823.GA18818@externe.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ikeVEW9yuYc//A+q"
Subject: [Bluez-devel] compiling for the zaurus
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
Date: Sat, 14 May 2005 11:58:23 -0400


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello

Here's a follow up to my toolchain problems. It's stupid - I
mistakenly didn't notice /usr/include and /usr/lib were being used. I
guess configure adds them by default - bad idea, especially when
mentionning --host ! Solution : run the following before configure
export CPPFLAGS=3D-I/opt/Embedix/tools/arm-linux/include/
export LDFLAGS=3D-L/opt/Embedix/tools/arm-linux/lib/

Anyway here's a script to do everything for a zaurus host. It requires
a minimal etc for the zaurus (attached)

Maybe it could be added to the next bluez?

--=20
Bien =E0 vous - Best regards,
Guylhem P. Aznar

--=20
*@externe.net                                            http://externe.n=
et
P=E9rim=E9/Deprecated:    @oeil.qc.ca, @metalab.unc.edu, @ibiblio.org, @7=
un.org
GPG: 92EB37C1 DD11C9C9 20519D01 E8FA1B11 42975AF7 http://externe.net/pubk=
ey

--ikeVEW9yuYc//A+q
Content-Type: application/x-gzip
Content-Disposition: attachment; filename="etc.tar.gz"
Content-Transfer-Encoding: base64

H4sIAL0fhkIAA+0caXfbRi5fxV+B0m4Tp5ZEUlctb/rWlpVGrz60ltKkx25CkSOLzxTJ8rCt
Nv3vC8zwlA85ra30IJJniTO4BhiAM+BQLDTqTx4ZFIROqyU+203+qTbFZwxPVEVrqviv2VCe
KKqqIBq0HlsxgigIdR/gHnjMD+7oTwaSfP5FgKH/Pc971DlwH/8rnY7W0LRmo62S/zvYVPp/
DZD432M4vEeaBR/v/4aitkv/rwOK/t8fVw8Hx6/fPqwM4X/lVv932q0l/zfVlvoE1mLEf7j/
N2A8swLA/7oD7EqfezaD4XAIgeFbXghT1wfDdRxmhJZzBqELOhxaTnQlbcDEvYILS4d9O2Kh
64azGjYOQkBTcXb+1HDnczDZhWUwuJxZxgzmaG+YMOI5tc4in5nE03MtJwQ9RPpwxgBNbek2
eL47tWx+yTm4Du8d9sByoE4zd5JIrgtZdWJLWowRj6vJlby0bBscJmRNiGEYedgazkhNyyFS
HB3SJUNFUbG0oi41GExxfNwU2Ekj/wG/ofl89nNk+SxAJrppJghLI+EiA9NDnW0UbYIfOQ7h
mpFDyiGxbQUhcwp2d52gJkl1tGM8TE1qtpWvFEUy2VSP7NB3o5BJaHaKYtMJJHVHq6ntr2qq
tlPTFLWbv1YlKef/a/H/ZnD8dviwc2xF/OPSr3Mt/pudMv7XAb8n/t9YjuleBvB2WNdwqDhp
MST/xIkg0Rfxf1cmmLDwkmFMhpcu8gi24xGQzcJQN2aCW5IPuBrIINb9wvLDCD97J0c4Oj/M
lC/GtJrENE00kL+JWBDKUqwFyPUo8OvBxHLqxkwPoXoB1akYOkUvtQmHBXUewNXe4aB/PJYf
IEOU8HeGa/n/m+Hp6IFlrFz/Kc3l/M/X/2X+f3zYgL0s75Pv88k/W+hMLR/TdSGPJ2mQUiqm
u1xSzaX02/JzjXAIHc0KCzfywZu5DsOMHedsnuViNTDR0m1Ih2P3HO8y7YaqWLgQQ1G2xS4Y
V7DvW0aAqZWzoUVYvB5DKtOaTpnP8L5iOVaIOdkKdJ7XaQFm4jXeAYLQx6EWM7IiqWoLb3Bp
En66nIQDysN7+yenY5CPT6C3d3o66J/KuaaDwd7h+OS4n7btvx59L4OM1+Mf4ORb/DgYP9/Z
2cD7w/Fxvzd+Khk+pvIwkBzX8uLsLc1dk83z6buQ1v+I/2+6gzzU3Erg4/f/TQ2XhOX+fw2w
agXxEDJW5X+l01jyf1tplPv/tcB4cNQ/eT0GtSVhUhIgC9eLvz8ZsiSP+qffUWKLv1BbuUb8
WwDFv2/UzMd8AHCf/J88/2m1mrz+r6ll/l8HpP73jfZjzYJ73v/VDkJbRTxVa7dbpf/XAUv+
/7appEv1B5PB/d7p3Cv+NYp/TWm0cf+n1Wp1WrKjXg+vVAKl/4X/Y0M/hoz7rv+pFMz71Yaq
lvl/LbDs/8cItBX+b6gddcn/LaVZ1n/WAhuf1ameMdGDGa+9pP6njUBazoYgmgSLIGRzIHPx
RwFUPQlC1/N4vZwq5rNzUfnpQqPZAq0FO/RswGRiX2m5TvcmjkiLWCM38g0G08gRNXfbmvi6
v6hJNVFAys/RBCnIEWaMk+oTr/HUpI2YAQoTPdkUlyTPd89eyCkt7mpe752O3/VOjl++kJcK
VxGOGxH4+N/RRfBsS/pVqvzIK/FpZWhmWOKpAFR16tlMOcJ/4cMH8FkY+Y4Ub7VgcPDifVxS
0n3TCG2wTCpVfYAzn3lgOVO3ixcBM+FpUP8fPEeVzcgI457n9frTrFuu//STXD97+j5lz4WP
+uMX7zk7eXNwIOdV+gBGFKKaGlRNuStnhNYUfkT0hF6Gz15Q1eq/u1Rtc6QKotw05pRAqkwt
6Tcyl+vlrXVu2TYOwYCM5mvgRTcnsm3Qvv5CFWRI8mwLkCTRiBkzF6oObMqjZApukv9qtRrI
UmXumng1YXGRMtdga4buSSkfrjZpPdfP2TuUXCMf/1LDAEhQ0i+mzuY4GQsjNSWpwq1Tvcp1
BKZnZtapXCOkfm4TqZKbQdeVikus+NUE3balSuhGaKP6he7Xbdc4r4u4yU3ign3kA6qiyonl
b7XgLAq5BU330imYcVkRn9lMDxjXJeGT9+G9rJESFKyQTAyp4s/RWUl1+dp0SMQKLO7NVUjc
o9eRclgUmr/Hqtej3RRxza6sEBSekRiDmXsJlwz/+wwMtB0za5JBdpQ3VRljF/nzabAVT4dU
3u4u73K9LWGiYofPOPYH9IqrmwlKzKLCUTDJmTHaFk9O7I5houpffAHPiMtuqhBn83yraIJN
+XWgn7EubCrwq1CCqD4UNfqQk/6bnHEg26gSC3RDkmJDfeobXwkceP3XmGMyfrwK0P3qP7QS
bDU7bY32/w2tPP+7Fsj5P80K/OHcA8oQ/r+1/t9QcLOX+l9r0PpfbZfr/7VAfCZHNkNbfWcE
lLMNWw8CkNPpIAPeUiM7jyQlZIREC9eVpAXEjDxsGKtJE6Qc2U5LuQddgpUjpBXHPShTtJQU
7/TvxBbgLsoMS5JouCC/tXxc1kDPZ6YV9qgp26rsmboXMp9YXuDson1PjC9vg/yc/vT2x9TN
14MFvQrcT5luD10/1D6O+al2N/d9X7cc2HevWAD7h9W2pqzgnyMg/hnysAc09ruE0QGpE4fB
0Madm2NFc7iRPJWF+CqM9kjOUa+hKvT4/eAuAXvzidVDY+2P6dRav8C+3nt5XUJMsD1wDD4a
QZcXkU4wIWHkzSznCoaD3sl1bqPhq8HxW8GoukrXV9WROw35OvbLa5xEZ2LgL1fxwiF4+s9g
Dff+kxvzyGbsghUt+lLYEBl/0z/unw56GVtxmo3YXp/96VwX5zMyGdc0FwhH7oRO8w35UQ2S
djA+rKqZrCzNxGbFpSsL7+IrMHi8vPwShtjsOroNxyy8dP3zpam3zP5w1Fea6orZRr28cTsh
yJm8kNsypo2dvM7kBdy3v0Tr3TCCN6NRwrqxcxvrmHeDz+I71W1gdKRhfmcYJrn1U9+ISvgk
cNP676FlrFj/qZ2WtrT+b2qt8vz3WiCu/y5Xf/nVID4u9wudohv2jnqDvVzaEQsjRHvjWyG9
sjBZYJKz8f4/tJxzhy3gXwZd1jxx+W/X150zVnNY+DVnv6lCVRQd6ryMgS0atrzqDZKT4s9Y
7axGVSZli6rEg4P+8fiFfEO5VF5dt6VC6ybn8DG11ffS+Pthf5kyKUAXqbPWuCorSqsqlVZB
fi8VC0BxtQVwNSmaSRDvqVAJiZ8dj01c0bZ4wfUjK81xoQUyeORi8x+pN68uOUMB7i4+5xCn
VrGEJiBX3kLYgAMXHJwsVBKlo6b4lfkQLjwWLFHzGhZ+FSW6G7yHTVrCnOqeum1ntW4p5ZMq
QLKdVHjgMcOaWgbXwnGdqlh3SUX5IErUyFY80qDAoUouNQa4rvNAJR0L9bZbbvDFWHmcHHO/
+g9//t9ptxX+/Fcpn/+uBYr+x1T9CDLIHm3ljvOfSjs5/9NqNqn+02hrWnn/XweoWqNZLv7/
uXB9rfTwMniEx/F+U/yrSiuLf8oF5fs/a4P7lE7glF2AVmvJXf48NQwXowZMjMADraE0lfJZ
3l8Ybn056wFlrIr/lsbf/8C1X6OlUZ1AxY9GGf/rANqIn77snRwdFQ9OAf+1A7FPH5hdyM2M
7QtQaypoiqLVVaWudEBpdVtfddWvYK5fnUP/yoNN2q/Hr9HBr7Sl3YtCd46s6TTEQlQf6b29
eKdPL/vRhjjypArvW7BgVyK6rOCgm3S0IAB3mqOUKjEHRemqalfTuo1Gt9nstlqCPBnbTHcc
ZvNtFRFnb3dLlbivogqKg+y8WiKqgI1Doj2z3I9fmsw65V06IfLXyobF+KfjLA8d/SvjX2s1
G+n9v92g9X+zoypl/K8DKMB5xU0cWLszB6Szg2eAhsgASqeOga9i+GvdZnspA3DeJrieOK4Z
f96UEKys1uiwyzi4A6miIxb1ZQlhxIzIt8IFHOmOfsZ8evbKqAOoYMKgmmHMYwzTCvSJzUyB
RSwR63XAwHZROgwHxzwx8J9/oCpM7odXBAn/TYYq7NmX+iIAPTgXLeKtZCRHLKkSJGJJgNB1
qFv0XvGyisgq6SmqNo/s0OKCbPcSvBhH/DyF7TPdXPBGZmYGIjLXMVKm4oK/2sycBQSRgWiB
dUE5NmRzj87bJYy5uFhTtMGM2R7zsdty3onvyy9vnyEf7OV5jjIlfwmZfkSDDhOKt7Sz8m2Q
PDvn7j7kpo5bHH0e2+NzE/WOW63YCp/PsG3mBmGMR39B/nwmC1ULnPjDSMzK/JmkcqVqiqo2
k0Qu1PN0/viQqnnY7J2H7+grHLxStw+O1O1X38WJf+DQG+MLbrshzhsIDB0TvkUfwBxy0y54
+auCGNtyzq85GgfiuFlVz3Nty1hAPA/RM16IGHo8rcT17bNwrgchn4cThigsuXadG2m2BVEK
fDr4Lv2MCk4oY0Z0bhSeuddl4X97HuuzLaTs8ua09Yahi7EVBn/j6AWGHytBo6e5nlNMIMxc
2xQsBAK/zswbONZ0musW11m/p+PmJdfPr+NuGp7HGW5zsnhs+aZtwheDxDw1wxs+5qn0RwP6
juEvPLEe2MBon6UTosJEVxLXFCmfOsXfCTfG9wPLEPXfO+p/7eX6b7NZPv9bD2TP/5LT4TLe
CrqyhNN9OfvjzPhzT+YSSiihhBJKKKGEEkoooYQSSiihhBJKKKGEEkoooYQSSiihhBJKKKGE
fyD8Hxv7cMAAeAAA

--ikeVEW9yuYc//A+q
Content-Type: application/x-sh
Content-Disposition: attachment; filename="bluez-zaurus.sh"
Content-Transfer-Encoding: quoted-printable

#!/bin/sh=0A# Copyright (c) 2005, Guylhem Aznar <zaurus-ipk@externe.net> : =
GPL=0A# Requires the toolchain from:=0A# http://www.externe.net/zaurus/sdk/=
Embedix.tgz=0A=0AVERSION=3D$VERSION=0A=0Acd /tmp=0Awget http://bluez.source=
forge.net/download/bluez-libs-$VERSION.tar.gz=0Awget http://bluez.sourcefor=
ge.net/download/bluez-utils-$VERSION.tar.gz=0Atar zxvf bluez-libs-$VERSION.=
tar.gz=0Atar zxvf bluez-utils-$VERSION.tar.gz=0A=0Aexport CPPFLAGS=3D-I/opt=
/Embedix/tools/arm-linux/include/=0Aexport LDFLAGS=3D-L/opt/Embedix/tools/a=
rm-linux/lib/=0Aexport PATH=3D/opt/Embedix/tools/bin/:$PATH=0Acd bluez-libs=
-$VERSION=0A./configure --prefix=3D/ --host=3Darm-linux=0Amake=0Amkdir /tmp=
/bluez-zaurus=0Amkdir /tmp/bluez-zaurus/usr=0Amkdir /tmp/bluez-zaurus/usr/l=
ib=0Amv src/.libs/libbluetooth.* /tmp/bluez-zaurus/usr/lib=0Acp -adr includ=
e/ /tmp/bluez-zaurus/usr/=0Arm /tmp/bluez-zaurus/usr/include/Makefil*=0Acd =
../bluez-utils-$VERSION=0Amkdir /tmp/bluez-zaurus/usr/bin=0Amkdir /tmp/blue=
z-zaurus/usr/sbin=0A./configure --host=3Darm-linux --prefix=3D/ --with-blue=
z=3D/tmp/bluez-zaurus/usr/=0Amake=0Acd tools=0Acp ciptool hcisecfilter hcit=
ool l2ping ppporc sdptool /tmp/bluez-zaurus/usr/bin=0Acp hciattach hciconfi=
g pskey /tmp/bluez-zaurus/usr/sbin=0Acd ..=0Acp dund/dund /tmp/bluez-zaurus=
/usr/bin=0Acp hcid/hcid /tmp/bluez-zaurus/usr/bin=0Acp hidd/hidd /tmp/bluez=
-zaurus/usr/bin=0Acp pand/pand /tmp/bluez-zaurus/usr/bin=0Acp rfcomm/rfcomm=
 /tmp/bluez-zaurus/usr/bin=0Acp sdpd/sdpd /tmp/bluez-zaurus/usr/bin=0Acp te=
st/hsplay test/hsmicro /tmp/bluez-zaurus/usr/bin=0Acd /tmp/bluez-zaurus=0At=
ar zcvf ../data.tar.gz ./=0Amkdir ../control=0Aecho "Package: bluez-zaurus=
=0APriority: optional=0AVersion: $VERSION=0AArchitecture: arm=0AMaintainer:=
 Guylhem Aznar <zaurus-ipk@externe.net>=0ADepends: libc6=0ADescription: Blu=
eZ $VERSION bluetooth software for the Zaurus=0ASection: kernel" > control=
=0Aecho "#!/bin/sh=0A=0Arm /dev/rfcomm*=0A=0A/etc/rc.d/init.d/pcmcia restar=
t=0A=0A/sbin/rmmod l2cap=0A/sbin/rmmod rfcomm=0A/sbin/rmmod bluez=0A=0Aexit=
 0" > postrm=0Aecho "#!/bin/sh=0A=0A/sbin/cardctl eject=0A=0A/etc/rc.d/init=
.d/bluetooth stop=0A=0Aexit 0" > prerm=0Aecho "#!/bin/sh=0A=0Aif [ -f /etc/=
modules.conf ]; then=0A   if [ \"`grep net-pf-31 /etc/modules.conf`\" =3D \=
"\"  ]; then=0A      echo \"alias net-pf-31    bluez\" >> /etc/modules.conf=
=0A   fi=0A   if [ \"`grep bt-proto-0 /etc/modules.conf`\" =3D \"\"  ]; the=
n=0A      echo \"alias bt-proto-0   l2cap\" >> /etc/modules.conf=0A   fi=0A=
   if [ \"`grep bt-proto-2 /etc/modules.conf`\" =3D \"\"  ]; then=0A      e=
cho \"alias bt-proto-2   sco\" >> /etc/modules.conf=0A   fi=0A   if [ \"`gr=
ep bt-proto-3 /etc/modules.conf`\" =3D \"\"  ]; then=0A      echo \"alias b=
t-proto-3   rfcomm\" >> /etc/modules.conf=0A   fi=0A   if [ \"`grep bt-prot=
o-4 /etc/modules.conf`\" =3D \"\"  ]; then=0A      echo \"alias bt-proto-4 =
  bnep\" >> /etc/modules.conf=0A   fi=0A   if [ \"`grep tty-ldisc-15 /etc/m=
odules.conf`\" =3D \"\"  ]; then=0A      echo \"alias tty-ldisc-15 hci_uart=
\" >> /etc/modules.conf=0A   fi=0A   if [ \"`grep char-major-10-250 /etc/mo=
dules.conf`\" =3D \"\"  ]; then=0A      echo \"alias char-major-10-250 hci_=
vhci\" >> /etc/modules.conf=0A   fi=0Aelse=0A   echo \"alias net-pf-31    b=
luez\" > /etc/modules.conf=0A   echo \"alias bt-proto-0   l2cap\" >> /etc/m=
odules.conf=0A   echo \"alias bt-proto-2   sco\" >> /etc/modules.conf=0A   =
echo \"alias bt-proto-3   rfcomm\" >> /etc/modules.conf=0A   echo \"alias b=
t-proto-4   bnep\" >> /etc/modules.conf=0A   echo \"alias tty-ldisc-15 hci_=
uart\" >> /etc/modules.conf=0A   echo \"alias char-major-10-250 hci_vhci\" =
>> /etc/modules.conf=0Afi=0A=0A/usr/bin/make_dev.bluez.sh=0A=0A/sbin/depmod=
 -a=0A=0A/etc/rc.d/init.d/bluetooth start=0A=0A/etc/rc.d/init.d/pcmcia rest=
art=0A=0A/sbin/cardctl eject=0A/sbin/cardctl insert=0A=0Aexit 0">postinst=
=0A=0Atar zcvf ../control.tar.gz ./=0A=0Acd ..=0Aecho 2.0 > debian-binary=
=0Atar zcvf bluez-$VERSION-zaurus.ipk ./debian-binary ./data.tar.gz ./contr=
ol.tar.gz=0A
--ikeVEW9yuYc//A+q--


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
