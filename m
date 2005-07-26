Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb05072612066bd4d11a@mail.gmail.com>
From: Claudio Takahasi <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Re: bluetoothd specification - new patch
In-Reply-To: <1122398308.5805.24.camel@notepaq>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <e1effdeb05071213476bbc0fa0@mail.gmail.com>
	 <e1effdeb050715103731d599d7@mail.gmail.com>
	 <42DBD4F5.8000805@palmsource.com>
	 <e1effdeb05071809461382a01c@mail.gmail.com>
	 <e1effdeb05072609312aa92cc0@mail.gmail.com>
	 <1122398308.5805.24.camel@notepaq>
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
Date: Tue, 26 Jul 2005 16:06:57 -0300

Hi Marcel,

On 7/26/05, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Claudio,
>=20
> > I am sending a new patch of bluetoothd.
> >
> > Marcel, if possible,  send me a feedback.
>=20
> I am still on the road and this means that the feedback will be very
> limited.
>=20
> The first thing is that you really need to follow the coding style. I
> can't go through all your code and change it. Using indent is no option,
> because in most cases it makes it worse. Take a look at my code and see
> how I placed the whitespaces etc.
[Claudio Takahasi]
I will fix it. The current patch is just a skeleton(draft)
of my idea.

>=20
> The second thing is that I don't like patches that also change autoconf
> and automake stuff. It seems you only need that for D-Bus workarounds.
> So it would be great to do this first. I don't like your way how you
> handled it. So the best idea is to use the final D-Bus 1.0 API as a
> base. I know that it is not ready, but I think 0.35 is quite close. This
> is the API to go, because the old API will disapear after the final
> release. Basically we only need to take care of the old 0.23 API and for
> that we should have a compat.h file that defines missing or renamed
> functions. The use of "static inline" is your friend here. I also don't
> wanna check the D-Bus version. We check for available functions, because
> keeping track of the different version can get very ugly.
[Claudio Takahasi]
Basically only the function signature or name changed, the behaviour=20
are the same. The current code is compatible with 0.23, 0.33 and 0.34.
I didn't test the 0.35 version. But, I belive that we will not have problem=
s.
The current "configure"(2.18) file is using AC_CHECK_LIB, for check functio=
n
availability. This is not so elegant too.
In my current implementation the version of D-Bus is checked by "configure"=
.
There is no references to changed functions in the code, I defined macros
replacing the function name/signature according to D-Bus version.

>=20
> My third thing is that we need to introduce a main event loop like Glib
> is doing. So what I think is, that we should provide a common watch
> implementation in watch.[ch]. This implementation must be thread-safe
> and independent from the bluetoothd. Integrating it directly into
> bluetoothd makes no sense, because in general it is only about watching
> file descriptors and then calling a callback function.
[Claudio Takahasi]
The current main loop is exactly the same approach of Glib.
bluetoothd supposes to be the main daemon, therefore it must
be the first D-Bus object of the hierarchy and the object resposible
for start the connection, register the object, register filters,=20
handle signals(Disconnect, NameOwnerChanged, NameAcquired ...)
The file descriptor poll should be flexible in order to handle other
file descriptors(socket for incomming connections, socket for hci packets).
These are the assumptions that I considered.

>=20
> I haven't looked at any other details of your patch, but we need to sort
> that out first. Otherwise it gets ugly for me to review your patch.
>=20
> > The ideia behind this daemon is provide a modular
> > D-Bus implementation for Bluez. Profiles(pan, dund, hcid) and
> > other services(sdp, hcitool, hciconfig) can be developed individualy.
> > It is possible enable/disable this profile at run-time.
> >
> > There are a lot of pieces missing. This is just a skeleton of the
> > architecture. My ideia is export all current features of the bluez-util=
s
> > daemons and tools using a D-Bus interface.
>=20
> The idea is the same way I like to go, but I like to do one step at a
> time. My main focus is on HCI and SDP. The PAN and HID intergration is
> not so important for me at the moment.
>=20
> What we should design first is the HCI D-Bus interface for the methods
> and the signals. There is no need to name them like their HCI names,
> because I like to see the D-Bus interface as an abstracted interface for
> easy use from within other programs and especially from Python. The
> bluetoothd is responsible for executing the right HCI commands to
> perform a specific task. I think we should design our interface along
> the HAL interface.
>=20
[Claudio Takahasi]
I am not understanding how you plan integrate hcid and HAL. Could you
give me more details?
HCI and SDP are essential to the others profiles. PAN is important to me
because I am developing a network library to help multiplayer games
developers and UPnP applications control bluetooth connections.
I will create a document with the basic interfaces required and submit=20
a for your analysis as son as possible. But I will keep coding because
I have a schedule to follow.

Regards,
Claudio.

> For the SDP I would like to see a complete SDP implementation inside
> bluetoothd, because this gives us the possibilty of SDP record caching.
> No application should be forced to do this by their own. And we can
> create an easier API to SDP. The current one is horrible.
>=20
> I like to see some D-Bus interface proposals first, before getting too
> much into coding.
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
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
