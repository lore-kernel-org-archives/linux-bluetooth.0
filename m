Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Henryk =?ISO-8859-15?Q?Pl=F6tz?= <henryk@ploetzli.ch>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Kernel panic with SCO socket - Debian kernel
 2.6.15-8
Message-Id: <20060318201220.46312b44.henryk@ploetzli.ch>
In-Reply-To: <441C3CAB.5030806@silicom.fr>
References: <441C3CAB.5030806@silicom.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Sat__18_Mar_2006_20_12_20_+0100_dIFXqf_.WjeaDZ0q"
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
Date: Sat, 18 Mar 2006 20:12:20 +0100

--Signature=_Sat__18_Mar_2006_20_12_20_+0100_dIFXqf_.WjeaDZ0q
Content-Type: multipart/mixed;
 boundary="Multipart=_Sat__18_Mar_2006_20_12_20_+0100_ppXOeDymSh=TFuyR"


--Multipart=_Sat__18_Mar_2006_20_12_20_+0100_ppXOeDymSh=TFuyR
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Moin,

Am Sat, 18 Mar 2006 18:00:27 +0100 schrieb Fabien Chevalier -:

> I wrote a sample program that mimics the establishment of a Headset=20
> Profile like connection.

Hehe, I recently did something similar (in Python, though) ...

> The thing basically works... exect after 1or 2 minutes playback, the=20
> program suddenly exits.
> Then i just have a few seconds left and *bang* . Kernel Panic :-(

... and had similar results. Just look at the memory consumption when
this happens. Apparently all incoming SCO data is buffered in kernel
memory for you to read, so you *must* read it, even if you only ever
intend to send data.

I'd also suggest you simply use select() to wait for incoming data and
then only send something when you received (and read!) something. This
nicely gives the right timing without guessing the delay parameter.


For reference I've attached my headset emulator (to be used with
pybluez): It discards incoming audio and sends a pure sine wave.
--=20
Henryk Pl=F6tz
Gr=FC=DFe aus Berlin
~~~~~~~ Un-CDs, nein danke! http://www.heise.de/ct/cd-register/ ~~~~~~~
~ Help Microsoft fight software piracy: Give Linux to a friend today! ~

--Multipart=_Sat__18_Mar_2006_20_12_20_+0100_ppXOeDymSh=TFuyR
Content-Type: text/x-python;
 name="headset.py"
Content-Disposition: attachment;
 filename="headset.py"
Content-Transfer-Encoding: quoted-printable

#!/bin/env python

import bluetooth, select, math, struct

class Headset:
    MAX_TRIES =3D 3
    MAX_LINE_LENGTH =3D 100
    FREQUENCY =3D 19.8
   =20
    def __init__(self):
        self.local_address =3D "00:80:98:34:38:9B"
        self.connection =3D None
        self.SCOserver =3D None
        self.SCOconnection =3D None
        self.unhandled =3D ""
        self.peer =3D None
        self.waiting_for_OK =3D None
        self._audio_init =3D False
       =20
        self.bind_RFCOMM()
   =20
    def bind_RFCOMM(self):
        tries =3D 0
        self.serversock =3D bluetooth.BluetoothSocket(proto=3Dbluetooth.RFC=
OMM)
       =20
        while tries < Headset.MAX_TRIES:
            tries =3D tries + 1
            try:
                port =3D bluetooth.get_available_port(bluetooth.RFCOMM)
                self.serversock.bind( (self.local_address, port) )
                self.serversock.listen(1)
                self.local_port =3D port
                break
            except bluetooth.BluetoothError, e:
                if tries >=3D Headset.MAX_TRIES:
                    raise
           =20
        bluetooth.advertise_service(self.serversock, "Python-Headset",=20
            profiles =3D [bluetooth.HEADSET_PROFILE],
            service_classes =3D [bluetooth.HEADSET_CLASS])
       =20
        print "Bound to '%s' on %s" % (self.local_address, self.local_port)
   =20
    def bind_SCO(self):
        self.SCOserver =3D bluetooth.BluetoothSocket(proto=3Dbluetooth.SCO)
        self.SCOserver.bind( (self.local_address,) )
        self.SCOserver.listen(1)
   =20
    def close(self):
        print "Closing"
       =20
        try: self.SCOconnection.close()
        except: pass
       =20
        try: self.SCOserver.close()
        except: pass
       =20
        try: bluetooth.stop_advertising(self.serversock)
        except: pass
       =20
        try: self.serversock.close()
        except: pass
       =20
        try: self.connection.close()
        except: pass
   =20
    def run(self):
        while True:
            self.process_event()
   =20
    def process_event(self, timeout =3D None):
        rlist =3D [self.serversock, ]; wlist =3D []; xlist =3D []
        if self.connection:
            rlist.append(self.connection)
            xlist.append(self.connection)
       =20
        if self.SCOserver:
            rlist.append(self.SCOserver)
       =20
        if self.SCOconnection:
            rlist.append(self.SCOconnection)
       =20
        rlist, wlist, xlist =3D select.select(rlist, wlist, xlist, timeout)
       =20
        if self.serversock in rlist:
            self.accept_connection()
       =20
        if self.SCOserver in rlist:
            self.accept_SCO()
       =20
        if self.SCOconnection in rlist:
            self.do_SCO_cycle()
       =20
        if self.connection:
            if self.connection in xlist:
                print "X on connection"
            if self.connection in rlist:
                self.read_control()
   =20
    def accept_connection(self):
        conn, address =3D self.serversock.accept()
        print "Have connection by", address
        self.peer =3D address[0]
        self.connection =3D conn
       =20
        self.waiting_for_OK =3D True
        self.write_control("AT+CKPD=3D200")
   =20
    def accept_SCO(self):
        conn, address =3D self.SCOserver.accept()
        if address !=3D self.peer:
            print "Warning: unauthorized SCO connection by %s (!=3D%s). Clo=
sing." % (address, self.peer)
            conn.close()
        else:
            self.SCOconnection =3D conn
            print "Have SCO connection"
   =20
    def read_control(self):
        try:
            data =3D self.unhandled + self.connection.recv(65535)
        except bluetooth.BluetoothError, e:
            if str(e)[:5] =3D=3D "(104,":
                self.close_control()
                return
            else:
                raise
       =20
        line =3D None
       =20
        if data[0] =3D=3D "\r" and data[1] =3D=3D "\n":
            data =3D data[2:]
            pos =3D None
            for i in range(len(data)):
                if i > 0 and data[i-1] =3D=3D "\r" and data[i] =3D=3D "\n":
                    pos =3D i+1
                    break
           =20
            if pos is not None:
                line =3D data[:pos-2]
                data =3D data[pos:]
        elif data[:3] =3D=3D "AT+":
            pos =3D None
            for i in range(len(data)):
                if data[i] =3D=3D "\r":
                    pos =3D i
                    break
           =20
            if pos is not None:
                line =3D data[:pos]
                data =3D data[pos+1:]
       =20
        self.unhandled =3D data
        if line is not None:
            self.handle_command(line)
       =20
        if len(self.unhandled) > Headset.MAX_LINE_LENGTH:
            raise IOError("Maximum line length exceeded. Shouldn't happen.")
   =20
    def write_control(self, data):
        self.connection.send(data+"\r")
   =20
    def handle_command(self, command):
        if self.waiting_for_OK and command =3D=3D "OK":
            self.waiting_for_OK =3D False
            self.bind_SCO()
            print "Established"
        else:
            print "Ignoring '%s'" % command
   =20
    def do_SCO_cycle(self):
        try:
            data =3D self.SCOconnection.recv(1024)
        except bluetooth.BluetoothError, e:
            if str(e)[:5] =3D=3D "(104,":
                self.close_SCO()
                return
            else:
                raise
       =20
        if not hasattr(self, "_i"): self._i =3D 0
        print "Have %s bytes SCO data (%i)" % (len(data), self._i)
        self._i =3D self._i + 1
       =20
        response =3D []
        while len(response) < len(data)/2:
            response.append(self.nextaudio())
       =20
        self.SCOconnection.send("".join(response))
   =20
    def nextaudio(self):
        if not self._audio_init:
            self._x =3D 0.0
            self._audio_init =3D True
        sample =3D math.sin( math.radians( self._x ) ) * (1<<14)
        self._x =3D (self._x + Headset.FREQUENCY) % 360.0
        return struct.pack("<h", sample)
   =20
    def close_SCO(self):
        self.SCOconnection.close()
        self.SCOconnection =3D None
       =20
        print "SCO channel closed"
   =20
    def close_control(self):
        if self.SCOconnection:
            self.close_SCO()
       =20
        self.SCOserver.close()
        self.SCOserver =3D None
        self.waiting_for_OK =3D None
        self.connection.close()
        self.connection =3D None
        self.peer =3D None
       =20
        print "Control channel closed"

if __name__ =3D=3D "__main__":
    headset =3D Headset()
   =20
    try:
        try:
            headset.run()
        except KeyboardInterrupt:
            pass
    finally:
        headset.close()
   =20

--Multipart=_Sat__18_Mar_2006_20_12_20_+0100_ppXOeDymSh=TFuyR--

--Signature=_Sat__18_Mar_2006_20_12_20_+0100_dIFXqf_.WjeaDZ0q
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFEHFubvI90l8kWns8RAiQcAJ91eqa3L553BA994dDpAn363yxNOgCeMevI
zTZjfR0V0KSbvw7V39cTMas=
=CoE8
-----END PGP SIGNATURE-----

--Signature=_Sat__18_Mar_2006_20_12_20_+0100_dIFXqf_.WjeaDZ0q--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
