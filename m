Return-Path: <cyrus@holtmann.org>
Message-ID: <4D754A84.1020609@interlinx.bc.ca>
Date: Mon, 07 Mar 2011 16:13:40 -0500
From: "Brian J. Murrell" <brian@interlinx.bc.ca>
MIME-Version: 1.0
To: public-linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@plane.gmane.org
Subject: Re: how to set adapter to master with bluez 4.69?
References: <4D6EF7ED.2090905@interlinx.bc.ca>	<4D740AA7.5080209@interlinx.bc.ca> <AANLkTin3-+9txbUyFxyrirySnkjwWVeMHrZtCqGfz-4m@mail.gmail.com>
In-Reply-To: <AANLkTin3-+9txbUyFxyrirySnkjwWVeMHrZtCqGfz-4m@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig6C9F87FD3DE476EC9852C649"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>



This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6C9F87FD3DE476EC9852C649
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 11-03-06 08:08 PM, Brad Midgley wrote:
> Brian,

Hi Brad,

> It has been really quiet.

Indeed.

> I got the latest bluez and looked through doc/ and test/ for
> references to link mode. I think maybe mentions of L2CAP_LM_MASTER in
> test/l2test.c might be on the right track.

OK.

> You could probably follow
> that model and set the l2cap link mode to get what you want. I didn't
> see it in any gui I could find. A patch to a gui would be ambitious
> but would end up being the nicest user experience in the end.

Agreed.  Unfortunately, unlike quite a bit of technology, I am a total
end-user of B/T.  I don't even really know what the stack looks like.  I
guess I just have not had the bandwidth to dive in.

That said, it seems odd that without a knob to give total control to the
user, that the implicit behavior is not to make the adapter the master,
if it can be.

Understood, yes, that there might be a situation such as B/T networking
where there are two hosts with adapters, so one would have to fall back,
but for the more common case such as mice, headsets, etc. if the adapter
needs to be master for them to co-exist peacefully, I wonder why that's
not being done implicitly.

Can in inquire from userspace which devices are master/slave?  hcitool
looks interesting but I can't seem to get it to report master/slave of
devices or the local adapter.

Ahhh.  Wait.  I just did (after turning the mouse on):

$ hcitool con
Connections:
	> ACL 00:1F:20:0F:30:6A handle 11 state 1 lm MASTER

So it seems the mouse, which is the only remote device that's on, is mast=
er.

When I try to change that I get:

$ sudo hcitool sr 00:1F:20:0F:30:6A slave
Switch role request failed: Input/output error

b.




--------------enig6C9F87FD3DE476EC9852C649
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk11SoQACgkQl3EQlGLyuXCmKgCghUrl9b0hbpAwRi873lGmd4On
foMAn1J46QVXVYnmgK0HWYKy+szVpPH7
=A9XF
-----END PGP SIGNATURE-----

--------------enig6C9F87FD3DE476EC9852C649--

