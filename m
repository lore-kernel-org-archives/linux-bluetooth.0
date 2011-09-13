Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <DABFC48DA02357418ED8A1EAD50CD9C012F6BF69@048-CH1MPN1-123.048d.mgd.msft.net>
References: <4E6A247C.5040403@nokia.com>
	<CAKT1EBdGAyxBh_aeTjPAhOeU2vHSsjbpgi91=vG8HqLv8aV0Yw@mail.gmail.com>
	<1315635815.1937.4.camel@aeonflux>
	<CAKT1EBc4z+rvgqKr1SuE_iYvBMqhLJ=E5AW6k5cq65nqa9EW=A@mail.gmail.com>
	<1315854441.1937.28.camel@aeonflux>
	<DABFC48DA02357418ED8A1EAD50CD9C012F6BF69@048-CH1MPN1-123.048d.mgd.msft.net>
Date: Tue, 13 Sep 2011 10:55:46 +0300
Message-ID: <CABBYNZLYa121-oERdc5v9KWAyzjDD8DcVF+Yc76QQd+tj4M4Cg@mail.gmail.com>
Subject: Re: Name resolution for mgmt interface
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: tim.howes@accenture.com
Cc: marcel@holtmann.org, claudio.takahasi@openbossa.org, antti.julku@nokia.com,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tim,

On Mon, Sep 12, 2011 at 10:15 PM,  <tim.howes@accenture.com> wrote:
> This last one is the approach we took in Symbian OS. =A0The short name ma=
y be just fine for the width of the UI widget in which inquiry results are =
displayed, so any autonomous lower-level request of longer non-EIR names ma=
y be wasted because the UI didn't need any more characters (and saves radio=
 time, which is quite a lot for RNR).

It would be nice to use such approach but iirc there are some devices
with broken EIR short names e.g. Nokia~1, so we use the short name but
don't store it permanently so the full name has to be resolved. But
that is not a big deal since the BlueZ discovery takes care of this
automatically.

--=20
Luiz Augusto von Dentz
