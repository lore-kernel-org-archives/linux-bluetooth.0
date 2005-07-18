Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb05071809461382a01c@mail.gmail.com>
From: Claudio Takahasi <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Re: bluetoothd specification
In-Reply-To: <42DBD4F5.8000805@palmsource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <e1effdeb05071213476bbc0fa0@mail.gmail.com>
	 <e1effdeb050715103731d599d7@mail.gmail.com>
	 <42DBD4F5.8000805@palmsource.com>
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
Date: Mon, 18 Jul 2005 13:46:33 -0300

Hi Fred,

Thanks for your comment.
I will consider your suggestion. Currently, I am
developing the main loop. This is the biggest
challenge. The main loop function must be flexible
in order to monitor a lot of file descriptors: D-Bus,
periodic inquiry, incomming connections, ...

My ideia is develop the bluetoothd flexible,  making
possible enable/disable D-Bus service for the
profiles(daemons: pand, dund, hidd ) at run-time.

If you have time, try analyze the architecture(skeleton)
that I sent in the last patch and send me a feedback.

Regards,
Claudio.


On 7/18/05, Frederic Danis <frederic.danis@palmsource.com> wrote:
> Hello,
>=20
> I think that it could be interesting to add interfaces to bluetoothd to
> manage paired devices like:
>  - get paired devices list
>  - remove paired device
>=20
> Regards
>=20
> Fred
>=20
> -----------------------------------------------
> It is not by improving the oil lamp that one invents the electric bulb!
> -----------------------------------------------
> Danis Frederic            PalmSource Europe
> Software engineer
> Mail : mailto:frederic.danis@palmsource.com
> -----------------------------------------------
>=20
>=20
>=20
> Claudio Takahasi wrote:
>=20
> >Hi Marcel,
> >
> >I am sending a suggestion for bluetoothd implementation.
> >
> >Please send your feedback.
> >
> >Regarding the d-bus version checking, there is a different
> >approach using pkg-config for check dbus version instead of
> >verify if a function belongs to the dbus-1
> >
> >
> >The next step is implement the main loop.
> >
> >Regards,
> >Claudio.
> >
> >On 7/12/05, Claudio Takahasi <cktakahasi@gmail.com> wrote:
> >
> >
> >>Hi Marcel,
> >>
> >>Periodic inquiry and adapter setup is extremely
> >>necessary for me. Is it possible set a high priority
> >>for these features?
> >>
> >>Regarding the interfaces and objects path of the
> >>bluetoothd my suggestion is:
> >>
> >>
> >>
> >>>>>bluetoothd
> >>>>>
> >>>>>
> >>DBus service :    org.bluez.hci
> >>DBus interface:   org.bluez.hci
> >>DBus object path: org/bluez/hci
> >>    - setup link properties
> >>    - setup inquiry mode
> >>    - kill bluetoothd
> >>    - show local adapters
> >>    - ???
> >>
> >>
> >>>>>SDP
> >>>>>
> >>>>>
> >>DBus service :    org.bluez.sdp
> >>DBus interface:   org.bluez.sdp
> >>DBus object path: org/bluez/sdp
> >>methods:
> >>    - search
> >>    - register/unregister
> >>    - get local services
> >>    - ???
> >>
> >>
> >>
> >>>>>PAN
> >>>>>
> >>>>>
> >>DBus service :    org.bluez.pan
> >>DBus interface:   org.bluez.pan
> >>DBus object path: org/bluez/pan
> >>    - connect/disconnect
> >>    - listen start/stop
> >>    - connections
> >>
> >>
> >>Open issues:
> >>- How/Where handle multiple bluetooth adapters?
> >>  solution1: the device id (hci0) can be part of object path
> >>  eg: org.bluez.hci0.pan org.bluez.hci0.sdp
> >>
> >>  solution2: pass the device id as parameter or define a method
> >>             to set the active adapter.
> >>
> >>
> >>I am not sure if it is better define a hierarchical objects or
> >>register multiples objects. Dbus support two functions:
> >>dbus_connection_register_object_path and
> >>dbus_connection_register_fallback(for a given subsection of the
> >>object hierarchy). But I think that it is not important now because
> >>for both approachs the message handler functions are distinct.
> >>I will investigate more which approach is the best.
> >>
> >>Defining an hierarchical approach make easier define policy/rules
> >>in the dbus configuration files.
> >>
> >>Do you have a different design for it or suggestions?
> >>There are a lot services that shall be inserted in the bluetoothd,
> >>maybe should be better define multiple interfaces(adapter, link, ... )
> >>for this daemon.
> >>
> >>
> >>Regards,
> >>Claudio.
> >>
> >>
> >>
> >
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
