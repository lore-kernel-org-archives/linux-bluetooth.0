Return-Path: <cyrus@holtmann.org>
Message-ID: <1348074340.1926.17.camel@sirocco.hadess.net>
Subject: Re: [PATCH v2] HID: Add support for Sony PS3 BD Remote Control
From: Bastien Nocera <hadess@hadess.net>
To: Antonio Ospite <ospite@studenti.unina.it>
Cc: David Dillow <dave@thedillows.org>,
	linux-bluetooth@vger.kernel.org,
	David Herrmann <dh.herrmann@googlemail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-input@vger.kernel.org, jkosina@suse.cz
Date: Wed, 19 Sep 2012 19:05:40 +0200
In-Reply-To: <20120919184834.8093076c520dba2dc91c2f5d@studenti.unina.it>
References: <1346378760.7976.2.camel@obelisk.thedillows.org>
	 <CABBYNZ+5E+BC-+9fj0e7iUpEDFJrJBQo8aoMZj8ZEkmiuB=QLA@mail.gmail.com>
	 <1347284864.3532.1.camel@sirocco.hadess.net>
	 <CABBYNZJpHkt8CGDsfVwirZ=vecb-fhbpPbrVFKt1UR_rA25mSw@mail.gmail.com>
	 <CABBYNZ+n9obON7iNcv66x2ZVQCeTs_JoJUDXZFwxJJ6C4cb4YQ@mail.gmail.com>
	 <CABBYNZKggzJ7bzQWVmWi30kxOUR8bVCyMLL=SM1=Oe74YPwvKg@mail.gmail.com>
	 <1347394656.1606.10.camel@sirocco.hadess.net>
	 <CABBYNZ+gpheC9sNeTp2uvDFBV-yPs+cY4PUR2omPt_kLTCafKw@mail.gmail.com>
	 <1347456657.23874.29.camel@sirocco.hadess.net>
	 <CABBYNZLwXhF0gixPGKUTJY4sZ7EHynTYmHzGtiZsoRGXgeEFaw@mail.gmail.com>
	 <CANq1E4SDXVHcumBbEA-4xpeuOQ0SjDxxtL_RqAiNYRPj6ccagQ@mail.gmail.com>
	 <20120913003628.ce5babb2a66d09fe17fa15de@studenti.unina.it>
	 <1347591892.6145.14.camel@obelisk.thedillows.org>
	 <20120917120441.a164d2e10bb02aa9a1e8d523@studenti.unina.it>
	 <1347929527.29391.9.camel@obelisk.thedillows.org>
	 <1347932038.29391.17.camel@obelisk.thedillows.org>
	 <20120919184834.8093076c520dba2dc91c2f5d@studenti.unina.it>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-input-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Em Wed, 2012-09-19 às 18:48 +0200, Antonio Ospite escreveu:
> For the note about the association procedure I had in mind something
> like this:
> 
> /* NOTE: in order to associate the Sony PS3 BD Remote with a Bluetooth
> host
>  * the key combination Start+Enter has to be kept pressed for about 7
> seconds,
>  * with the host BT Controller in discovering mode.
>  *
>  * Also the pin request should be ignored by the BT Controller (NULL
> pin).
>  */
> 
> Could someone more into BT please check the terminology here? Thanks.

Pairing means that the communication between the 2 Bluetooth devices
will be encrypted. In this case (and as is usually the case for mice),
the communication isn't encrypted, they will just agree to communicate
and the computer will just agree not to ask whether the connection is
allowed at every attempt (favourite/trusted settings depending on the OS
or terminology). There will be no PIN request.

Cheers

