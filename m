Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] non-blocking device discovery
From: Stephen Crane <steve.crane@rococosoft.com>
To: Fred =?ISO-8859-1?Q?Sch=E4ttgen?= <bluez-devel@schaettgen.de>
Cc: bluez-devel@lists.sourceforge.net
In-Reply-To: <1073403253.26243.1099.camel@baroque.rococosoft.com>
References: <1073308932.26243.1058.camel@baroque.rococosoft.com>
	 <200401052012.34307.bluez-devel@schaettgen.de>
	 <1073403253.26243.1099.camel@baroque.rococosoft.com>
Content-Type: text/plain; charset=ISO-8859-15
Message-Id: <1073404409.26094.1101.camel@baroque.rococosoft.com>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: 06 Jan 2004 15:53:30 +0000

Sorry, it was my fsck-up. (Funny how quickly these things are discovered
after going public :-)

On Tue, 2004-01-06 at 15:34, Stephen Crane wrote:
> Hi Fred and list,
> Yeah that was the code I was referring to. (It is also very similar to
> the code I'd cobbled together from Marcel's libs2 and the old
> hci_inquiry() from libs1.)
>=20
> Now onto my new question, what are the semantics of OCF_INQUIRY? I seem
> to be getting one unique device per inquiry call. That is I get one
> EVT_INQUIRY_RESULT event with a bdaddr I haven't seen before and then i=
t
> terminates with an EVT_INQUIRY_COMPLETE. For example:
>=20
> inquiry
> found 00:aa:bb:cc:dd:ee
> inquiry complete
> ...
> inquiry
> found 00:aa:bb:cc:dd:ee
> found 00:aa:bb:cc:dd:ef
> inquiry complete
>=20
> ...and so on. It seems that when it finds a new device, it passes that
> back up and exits inquiry mode. Can this be right (or have I fscked
> up)?  It only stays in inquiry mode for the specified length of time
> when there are no new devices to be found.
>=20
> I have set the inquiry time parameter to 0x30 and the number of devices
> to 0xff (both the max as per the spec).
>=20
> TIA,
> Steve
>=20
> On Mon, 2004-01-05 at 19:12, Fred Sch=E4ttgen wrote:
> > On Monday 05 January 2004 14:22, Stephen Crane wrote:
> > > Hi,
> > > I seem to remember a posting to this list in which someone mentione=
d
> > > that they'd implemented non-blocking device-discovery by writing
> > > commands directly to the hci socket. The code was C++ which leads m=
e to
> > > think that it was part of KDE but I can't find it on the net.
> > >
> > > Can someone refresh my memory?
> >=20
> > Maybe you were looking for this: http://cvs.sourceforge.net/viewcvs.p=
y/
> > kde-bluetooth/kdebluetooth/libkbluetooth/? It's not part of the offic=
ial KDE=20
> > distribution (yet), but it's in fact KDE/Qt code..
> >=20
> > greetings
> > Fred
> >=20
> >=20
> >=20
> > -------------------------------------------------------
> > This SF.net email is sponsored by: IBM Linux Tutorials.
> > Become an expert in LINUX or just sharpen your skills.  Sign up for I=
BM's
> > Free Linux Tutorials.  Learn everything from the bash shell to sys ad=
min.
> > Click now! http://ads.osdn.com/?ad_id=3D1278&alloc_id=3D3371&op=3Dcli=
ck
> > _______________________________________________
> > Bluez-devel mailing list
> > Bluez-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/bluez-devel
--=20
Stephen Crane, Rococo Software Ltd. http://www.rococosoft.com
steve.crane@rococosoft.com +353-1-6601315 (ext 209)



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
