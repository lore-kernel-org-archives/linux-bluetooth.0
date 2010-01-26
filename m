Return-Path: <cyrus@holtmann.org>
Message-ID: <4B5F29E2.2010906@gmx.net>
Date: Tue, 26 Jan 2010 18:44:02 +0100
From: Thomas Egerer <thomas.washeim@gmx.net>
MIME-Version: 1.0
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: Marcel Holtmann <marcel@holtmann.org>,
 linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/1] add configurable support for bridge forward delay
References: <4B5C554D.4030702@gmx.de> <1264343316.11653.0.camel@violet>	 <4B5C6062.4030705@gmx.de> <1264346020.11653.1.camel@violet>	 <2d5a2c101001241309u6e292a12hfc5c67011d6b77ba@mail.gmail.com>	 <4B5EA94B.1000204@gmx.de> <2d5a2c101001260236v506b53dcl9d948722f7926329@mail.gmail.com>
In-Reply-To: <2d5a2c101001260236v506b53dcl9d948722f7926329@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Luiz Augusto von Dentz wrote:
> Hi Thomas,
> 
> On Tue, Jan 26, 2010 at 10:35 AM, Thomas Egerer <hakke_007@gmx.de> wrote:
>> Luiz,
>> let me tell you why I'd like to have an extra config variable. Let's
>> imagine an admin who want to add the upcoming bnep interfaces to an
>> _already_ existing bridge (for that matter a test whether the given
>> interface name already exists would be nice, too) plus he knows about
>> the infrastructure behind the bridge and decides to set a different
>> forward delay. He could, of course reset the delay, once the bridge is
>> up. But ideally he would specify the setting in the network.conf. Hence
>> the extra config variable (which btw. were actually two variables by the
>> time I started writing the patch).
> 
> In lets say a pure network sense you are probably right, but what Im
> arging about is that the PAN spec doesn't mentioned anything about
> this, so in the spec sense once you accept the connection the
> interface _is_ already fully functional. So either we always set the
> delay to 0 or we have to wait until the interface is ready to accept
> the connection, although the second alternative is doable it happens
> to be after the connection is accepted that the network interface is
> created and there is no way to inform the other part that there is an
> arbitrary delay before the interface become functional again.
> 
> 

Luiz,

I disagree. On page 31 the specification states that a NAP/GN performs
the following (in regard to packet forwarding operations):
'Automatically learn and maintain the information required to make
frame-filtering decisions as described in [3] section 7.1 and specified
in [3] sections 7.8 and 7.9, for the support of Basic Filtering Services.'
and even if it says in the next paragraph:
'The NAP/GN is not required to perform any of the following aspects of
the 802.1D standard.'
footnote 4 mentions:
'Sophisticated Bluetooth NAP devices may choose to implement some or all
of the 802.1D features.'
In my eyes this supports my point of view since the forward delay as
part of the learning process should be a subject of configuration.
Could I convince you?

Cheers,

Thomas
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAktfKeIACgkQ2/ggQBUI/skLrQCcCt0QYw2UvqP29QNtJUCNIHOE
VSYAoJ3dlsJl/Q7Q+NbgIWA7b5qxJcOo
=0yd4
-----END PGP SIGNATURE-----
