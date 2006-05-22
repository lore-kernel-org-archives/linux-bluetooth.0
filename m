Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <20060522154201.3cff8m3ju4w0ck4o@mail.blas.net>
From: db <ml@blas.net>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Subject: [Bluez-devel] A few tests: a2play aborts when hanging up the call. That's not
 the way it should work.
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
Date: Mon, 22 May 2006 15:42:01 +0200

I've made some tests with 2 recent stereo headsets : the Jabra 620s and the =
Com1
(a french company) headset.
I've noticed the following things with the Jabra and the Com1 headsets.

While listening to stereo music with a2play, taking a call works (that the p=
art
of the headset) and the a2play keeps on to stream during the call. Normal.
But when I hang up in order to go on and listen to the music the a2play dete=
cts
a connection reset by peer and aborts.

I made the same test with a QTek 9100 (HTC Wizard is the same device) and
whatever the headset: when I hang up the music stream goes on but on the
internal speakers of the Qtek not on the headset.

I made the same test with the A2DP emitter that comes with the Com1 headset =
and
with this device the stream goes on on the headset (Jabra or Com1).
What I want to say is that the a2play (or alsa plugin) code SHOULD be more
reluctant to abort depending on the kind of error.
Maybe could we introduce a kind of L2ping in order to see if the device has
vanished.

My 2 cents,

My best to all the team,

--
db
<pre>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Ce message et toutes les pi=E8ces jointes (ci-apres le "message")
sont confidentiels et =E9tablis a l'intention exclusive de ses destinataires=
.
Toute utilisation ou diffusion non autoris=E9e est interdite.
Tout message =E9lectronique non sign=E9 (et non v=E9rifi=E9) est susceptible=
 d'alt=E9ration.
L'exp=E9diteur d=E9cline toute responsabilit=E9
au titre de ce message s'il a =E9t=E9 alt=E9r=E9, d=E9form=E9 ou falsifi=E9.
                               =20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

This message and any attachments (the "message") are confidential
and intended solely for the addressees.
Any unauthorized use or dissemination is prohibited.
Unsigned (and unverified) E-mails are susceptible to alteration. =20
The sender shall not be liable for the message if altered, changed or falsif=
ied.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
</pre>


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
