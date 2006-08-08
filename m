Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Tue, 8 Aug 2006 11:53:32 +0200 (CEST)
From: Peter Wippich <pewi@gw-instruments.de>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1c86461cc9a5.1cc9a51c8646@fh-wolfenbuettel.de>
Message-ID: <Pine.LNX.4.63.0608081147240.26758@redbean.intranet.gw-instruments.de>
References: <1c86461cc9a5.1cc9a51c8646@fh-wolfenbuettel.de>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-1463794332-1795595150-1155030812=:26758"
Subject: Re: [Bluez-devel] Multiplexing for SimAccessProfile
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463794332-1795595150-1155030812=:26758
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable


Hi Goetz,=20

TS07.10 ~ RFCOMM ....=20

Sorry ;-) but this won't help you much. No, I'm not aware of any free=20
implementation of TS07.10. You can ask Siemens for Multiplexer Source cod=
e=20
(I know they have) but I don't know if they are willing to release it and=
=20
I'm pretty sure they are not willing to release it for a GPL project.=20

On the other hand the Siemens modules do only use a subset of TS07.10 and=
=20
it isn't that hard to implement. If you already got something you may try=
=20
to debug it.=20

Ciao,=20

Peter=20

 On Tue, 8 Aug 2006, G=F6tz Isse wrote:

> Hi all,
>=20
> I am still working on the Sim Access Profile implementation and am now
> stuck on the communnication with the GSM module I use, the serial port
> multiplexing.=20
>=20
> The connection to the bluetooth device and all the messages and
> responses to and from the mobile phone work fine. So the bluetooth part
> is done. Now the GSM module will need to have the data from the SIM of
> the mobile phone to use it for connectiong to the GSM network. Since I
> use a device from Siemens (AC45) it already has the multiplexing (GSM
> 07.10) integrated meaning that I can send an AT-command (at+cmux=3D0) a=
nd
> it will switch to multiplexing mode and work as required. It will know
> how to handle data packets coming in from the serial port to divide the=
m
> into each channel and how to pack the data with the apppropriate header
> from each multiplexing channel to be sent back over the single serial p=
ort.=20
>=20
> The missing part is in my software. It will need to wrap and unwrap the
> messages to and from the GSM modem in the form it is defined in the
> specification for this multiplexing.=20
>=20
> There is solution of a final year project of a student in Finnland
> available, but it seems to possible have a few bugs.
> (http://users.tkk.fi/~tkarvone/). Compiling is fine and the load of use=
r
> space serial port module at runtime is ok too. To my understanding a
> controlling application is the second part of this project, which will
> open the port and enable the multiplexing of the GSM device and then
> wait for data coming into or out of the "virtual" ports, wrapping or
> unwrapping the data packets. Or am I wrong and have to replace the
> application with my blueZ-SAP-application?
>=20
> Has anyone used this multiplexing implementation successfully or does
> anyone know of a different implementation of the multiplexing as
> opensource to use with linux?
>=20
> Greetings,
> Goetz
>=20
> -----------------------------------------------------------------------=
--
> Using Tomcat but need to do more? Need to support web services, securit=
y?
> Get stuff done quickly with pre-integrated technology to make your job =
easier
> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geron=
imo
> http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=
=3D121642
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>=20


|       Peter Wippich                   Voice: +49 30 46776411          |
|       G&W Instruments GmbH            fax:   +49 30 46776419          |
|       Gustav-Meyer-Allee 25, Geb. 12  Email: pewi@gw-instruments.de   |
|       D-13355 Berlin  / Germany                                       |

---1463794332-1795595150-1155030812=:26758
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
---1463794332-1795595150-1155030812=:26758
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

---1463794332-1795595150-1155030812=:26758--
