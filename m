Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: "Daryl Van Vorst" <daryl@wideray.com>
To: "'Stephen Crane'" <steve.crane@rococosoft.com>
Cc: <bluez-devel@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Qualification Testing
Message-ID: <000001c318be$1ea92400$1a01010a@baked>
MIME-Version: 1.0
In-Reply-To: <1052757449.1664.85.camel@baroque.rococosoft.com>
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: 
	<https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: 
	<http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 12 May 2003 12:38:48 -0700
Content-Type: text/plain; CHARSET=us-ascii

Hey Steve,

Unfortunately it will be a while until I can get a dump showing exactly wha=
t
happens. You saw the Merlin logs right? Was that not enough info? I assume
you just want the hcidump to see exactly what the stack is getting and
sending in case there is some problem with the module.

I have to do the tests in batches. I'll do another run of tests once I get
everything else resolved (or believe to be resolved). When I do the next se=
t
of tests I'll do an hcidump -w for all failures.

-Daryl.

> -----Original Message-----
> From: bluez-devel-admin@lists.sourceforge.net=20
> [mailto:bluez-devel-admin@lists.sourceforge.net] On Behalf Of=20
> Stephen Crane
> Sent: May 12, 2003 9:37 AM
> To: Daryl Van Vorst
> Cc: bluez-devel@lists.sourceforge.net
> Subject: RE: [Bluez-devel] Qualification Testing
>=20
>=20
> Hi Daryl,
>=20
> On Thu, 2003-05-08 at 03:18, Daryl Van Vorst wrote:
> > Steve,
> >=20
> > > >         2.) There appears to be a problem handling continuation
> > > > states. Handling continuation state is optional. We found=20
> > > that if the
> > > > querying device sends a maximum byte count of 100, the
> > > continutation
> > > > state worked fine. But if the querying device sent a=20
> maximum byte
> > > > count of 8, the continuation state doesn't work (the=20
> > > continuation flag
> > > > wasn't recognized in the next packet). I can dig up an
> > > example log if
> > > > it would help.
> > >=20
> > > Yeah it would be good to get a log. I imagine 8-bytes is
> > > pretty close to the minimum size.
>=20
> Would it be possible to get an hcidump from the machine on=20
> which the SDP server is running? (I am interested to see what=20
> data the SDP server is actually returning.)
>=20
> (hcidump -x -w file.dump -i hci0)
>=20
> Thanks,
> Steve
> --=20
> Stephen Crane, Rococo Software Ltd. http://www.rococosoft.com=20
> steve.crane@rococosoft.com +353-1-6601315 (ext 209)
>=20
>=20
>=20
> -------------------------------------------------------
> Enterprise Linux Forum Conference & Expo, June 4-6, 2003,=20
> Santa Clara The only event dedicated to issues related to=20
> Linux enterprise solutions www.enterpriselinuxforum.com
>=20
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net=20
> https://lists.sourceforge.net/lists/listinfo/b> luez-devel
>=20



-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
