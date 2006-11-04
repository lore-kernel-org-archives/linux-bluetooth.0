Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Jon Barnett <jbarnett@pobox.com>
To: bluez-devel@lists.sourceforge.net
Date: Sat, 04 Nov 2006 10:30:43 -0500
Message-Id: <1162654243.3863.12.camel@localhost>
Mime-Version: 1.0
Subject: [Bluez-devel] Headset has sound problems
Reply-To: jbarnett@pobox.com,
        BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1673774290=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


--===============1673774290==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-Al52r23rtHFfc3XRJ/lK"


--=-Al52r23rtHFfc3XRJ/lK
Content-Type: multipart/alternative; boundary="=-JgMc87xe4BZ5nUBQ9k0j"


--=-JgMc87xe4BZ5nUBQ9k0j
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

I have kernel 2.6.18.1. I recently upgraded alsa both in the kernel and
userland to 1.0.13.

Running btsco and kernel module without a recompile causes this:
kernel: EIP: [<f992054c>] snd_card_bt_sco_playback_open+0xac/0x110
[snd_bt_sco] SS:ESP 0068:d3d01e40

Solution was to recompile btsco and snd-bt-sco module.

However, now no sound issues from the headset and no microphone is
picked up.

aplay -B 1000000 -D plughw:2 podbay.wav completes but nothing comes out
of the headphones.

hcitool info for the headphone is:
        BD Address:  00:12:EE:E0:AB:CA
        LMP Version: 2.0 (0x3) LMP Subversion: 0xe1b
        Manufacturer: Texas Instruments Inc. (13)
        Features: 0xff 0xfd 0x29 0x78 0x18 0x18 0x00 0x80
                <3-slot packets> <5-slot packets> <encryption> <slot
offset>=20
                <timing accuracy> <role switch> <hold mode> <sniff
mode>=20
                <park state> <channel quality> <SCO link> <HV2 packets>=20
                <HV3 packets> <u-law log> <A-law log> <CVSD>
<transparent SCO>=20
                <enhanced iscan> <interlaced iscan> <interlaced pscan>=20
                <inquiry with RSSI> <AFH cap. slave> <AFH class. slave>=20
                <AFH cap. master> <AFH class. master> <extended
features>=20

btsco -v during a session provides this:
btsco v0.42
Device is 2:0
Voice setting: 0x0060
RFCOMM channel 1 connected
Using interface hci0
recieved AT*ECBP=3D?
recieved AT+CLIP=3D1
recieved AT+CSCS=3D"UTF-8"
recieved AT*SEAM=3D"HBH-610a",13
recieved AT+CLAN?
speaker volume: 10 mic volume: 1
i/o needed: connecting sco...
connected SCO channel
Done setting sco fd
recieved AT+VGS=3D6
Sending up speaker change 6
speaker volume: 6 mic volume: 1
driver is not in use
disconnected SCO channel
speaker volume: 6 mic volume: 1
i/o needed: connecting sco...
connected SCO channel
Done setting sco fd
recieved AT+VGS=3D6
Sending up speaker change 6
speaker volume: 6 mic volume: 1
driver is not in use
disconnected SCO channel

This worked previously before the alsa upgrade (required to fix a
problem with a soundcard).

--=-JgMc87xe4BZ5nUBQ9k0j
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; CHARSET=3DUTF-8">
  <META NAME=3D"GENERATOR" CONTENT=3D"GtkHTML/3.12.1">
</HEAD>
<BODY>
I have kernel 2.6.18.1. I recently upgraded alsa both in the kernel and use=
rland to 1.0.13.<BR>
<BR>
Running btsco and kernel module without a recompile causes this:<BR>
kernel: EIP: [&lt;f992054c&gt;] snd_card_bt_sco_playback_open+0xac/0x110 [s=
nd_bt_sco] SS:ESP 0068:d3d01e40<BR>
<BR>
Solution was to recompile btsco and snd-bt-sco module.<BR>
<BR>
However, now no sound issues from the headset and no microphone is picked u=
p.<BR>
<BR>
aplay -B 1000000 -D plughw:2 podbay.wav completes but nothing comes out of =
the headphones.<BR>
<BR>
hcitool info for the headphone is:<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BD Address:&nbsp; 00:12:EE:E0:AB=
:CA<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; LMP Version: 2.0 (0x3) LMP Subve=
rsion: 0xe1b<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Manufacturer: Texas Instruments =
Inc. (13)<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Features: 0xff 0xfd 0x29 0x78 0x=
18 0x18 0x00 0x80<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; &lt;3-slot packets&gt; &lt;5-slot packets&gt; &lt;encryptio=
n&gt; &lt;slot offset&gt; <BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; &lt;timing accuracy&gt; &lt;role switch&gt; &lt;hold mode&g=
t; &lt;sniff mode&gt; <BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; &lt;park state&gt; &lt;channel quality&gt; &lt;SCO link&gt;=
 &lt;HV2 packets&gt; <BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; &lt;HV3 packets&gt; &lt;u-law log&gt; &lt;A-law log&gt; &lt=
;CVSD&gt; &lt;transparent SCO&gt; <BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; &lt;enhanced iscan&gt; &lt;interlaced iscan&gt; &lt;interla=
ced pscan&gt; <BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; &lt;inquiry with RSSI&gt; &lt;AFH cap. slave&gt; &lt;AFH cl=
ass. slave&gt; <BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; &lt;AFH cap. master&gt; &lt;AFH class. master&gt; &lt;exten=
ded features&gt; <BR>
<BR>
btsco -v during a session provides this:<BR>
btsco v0.42<BR>
Device is 2:0<BR>
Voice setting: 0x0060<BR>
RFCOMM channel 1 connected<BR>
Using interface hci0<BR>
recieved AT*ECBP=3D?<BR>
recieved AT+CLIP=3D1<BR>
recieved AT+CSCS=3D&quot;UTF-8&quot;<BR>
recieved AT*SEAM=3D&quot;HBH-610a&quot;,13<BR>
recieved AT+CLAN?<BR>
speaker volume: 10 mic volume: 1<BR>
i/o needed: connecting sco...<BR>
connected SCO channel<BR>
Done setting sco fd<BR>
recieved AT+VGS=3D6<BR>
Sending up speaker change 6<BR>
speaker volume: 6 mic volume: 1<BR>
driver is not in use<BR>
disconnected SCO channel<BR>
speaker volume: 6 mic volume: 1<BR>
i/o needed: connecting sco...<BR>
connected SCO channel<BR>
Done setting sco fd<BR>
recieved AT+VGS=3D6<BR>
Sending up speaker change 6<BR>
speaker volume: 6 mic volume: 1<BR>
driver is not in use<BR>
disconnected SCO channel<BR>
<BR>
This worked previously before the alsa upgrade (required to fix a problem w=
ith a soundcard).
</BODY>
</HTML>

--=-JgMc87xe4BZ5nUBQ9k0j--

--=-Al52r23rtHFfc3XRJ/lK
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFTLIiu2cEic/xsEARAlpPAKDGcdye7O9kBTxUNnlFmu3lYjhuIACffcK2
53hKHvdK6vRSJzGmHERsCk8=
=mE25
-----END PGP SIGNATURE-----

--=-Al52r23rtHFfc3XRJ/lK--



--===============1673774290==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============1673774290==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1673774290==--
