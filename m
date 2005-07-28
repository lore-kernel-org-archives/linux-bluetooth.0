Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb0507280708b0a84ec@mail.gmail.com>
From: Claudio Takahasi <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Re: bluetoothd specification - new patch
In-Reply-To: <1122415021.6005.7.camel@notepaq>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <e1effdeb05071213476bbc0fa0@mail.gmail.com>
	 <e1effdeb050715103731d599d7@mail.gmail.com>
	 <42DBD4F5.8000805@palmsource.com>
	 <e1effdeb05071809461382a01c@mail.gmail.com>
	 <e1effdeb05072609312aa92cc0@mail.gmail.com>
	 <1122398308.5805.24.camel@notepaq>
	 <e1effdeb05072612066bd4d11a@mail.gmail.com>
	 <1122415021.6005.7.camel@notepaq>
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
Date: Thu, 28 Jul 2005 11:08:28 -0300

Hi Marcel,

I wrote a draft document describing the D-Bus interfaces, path and methods
for BlueZ.=20

Please check if I am following your ideas.

You can download it from:
http://www.cin.ufpe.br/~ckt/bluez/



Regards,
Claudio





On 7/26/05, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Claudio,
>=20
> > I will fix it. The current patch is just a skeleton(draft)
> > of my idea.
>=20
> very good.
>=20
> > Basically only the function signature or name changed, the behaviour
> > are the same. The current code is compatible with 0.23, 0.33 and 0.34.
> > I didn't test the 0.35 version. But, I belive that we will not have pro=
blems.
> > The current "configure"(2.18) file is using AC_CHECK_LIB, for check fun=
ction
> > availability. This is not so elegant too.
> > In my current implementation the version of D-Bus is checked by "config=
ure".
> > There is no references to changed functions in the code, I defined macr=
os
> > replacing the function name/signature according to D-Bus version.
>=20
> I think you missed my point. If some function is not available in 0.23,
> but it is in 0.3x then implement it in compat.c via a "static inline"
> function covered by an "#ifdef".
>=20
> And I do think that the checking for a specific library is a good thing
> to do, because tracking specific versions is bad. And after D-Bus 1.0 is
> released I might remove all compat D-Bus function from the BlueZ source
> code.
>=20
> > The current main loop is exactly the same approach of Glib.
> > bluetoothd supposes to be the main daemon, therefore it must
> > be the first D-Bus object of the hierarchy and the object resposible
> > for start the connection, register the object, register filters,
> > handle signals(Disconnect, NameOwnerChanged, NameAcquired ...)
> > The file descriptor poll should be flexible in order to handle other
> > file descriptors(socket for incomming connections, socket for hci packe=
ts).
> > These are the assumptions that I considered.
>=20
> What has the D-Bus object to do with the event loop? The event loop is
> something that is provided by Glib and we need our own implementation.
> The bluetoothd then adds file descriptors to the watch and that's it. I
> don't see any need why D-Bus must be the first file descriptor in the
> list and so bluetoothd itself and the event loop implementation are
> independent from each other.
>=20
> > I am not understanding how you plan integrate hcid and HAL. Could you
> > give me more details?
>=20
> This is not what I said. I said that we should model the D-Bus methods
> and signals like the HAL people did.
>=20
> > HCI and SDP are essential to the others profiles. PAN is important to m=
e
> > because I am developing a network library to help multiplayer games
> > developers and UPnP applications control bluetooth connections.
> > I will create a document with the basic interfaces required and submit
> > a for your analysis as son as possible. But I will keep coding because
> > I have a schedule to follow.
>=20
> I can't do anything about your schedule. For it is important that we get
> a clean interface over D-Bus.
>=20
> Regards
>=20
> Marcel
>=20
>=20
>=20
>=20
> -------------------------------------------------------
> SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
> from IBM. Find simple to follow Roadmaps, straightforward articles,
> informative Webcasts and more! Get everything you need to get up to
> speed, fast. http://ads.osdn.com/?ad_id=3D7477&alloc_id=3D16492&op=3Dclic=
k
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO September
19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
