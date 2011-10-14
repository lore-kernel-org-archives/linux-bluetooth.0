Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <F82830D409D80E4881C83250E051B74B4784E604@banasiexm01.ASIA.ROOT.PRI>
References: <F82830D409D80E4881C83250E051B74B4784BE4F@banasiexm01.ASIA.ROOT.PRI>
	<CAKT1EBfYAgNQwX3KcbCM_JCiSTjZi5BnWhFZqSGXWWqv7zWvqw@mail.gmail.com>
	<F82830D409D80E4881C83250E051B74B4784E604@banasiexm01.ASIA.ROOT.PRI>
Date: Fri, 14 Oct 2011 08:19:35 -0400
Message-ID: <CAJdJm_O11czMQruB440OVns-Xiexvu+QsJHz8QcO3Us5YWR9gA@mail.gmail.com>
Subject: Re: Proposal for GATT Client Dbus API.
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Vijaykumar Dadmode <Vijaykumar.Dadmode@csr.com>
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vijay,

On Fri, Oct 14, 2011 at 7:51 AM, Vijaykumar Dadmode
<Vijaykumar.Dadmode@csr.com> wrote:
>> Read only? CCC can be writeable right?
>  It's actually "3.3.1.1 Characteristic Properties" from spec.

I think Claudio was actually referring to this part:

                        uint16 Configuration [readonly]
                                    Optional field containing the
configuration value on the server.

Looks like this is related to "Client Characteristic Configuration"
descriptor (section 3.3.3.3), which is:

* Readable with no authentication or authorization.
* Writable with authentication and authorization defined by a higher
layer specification or is implementation specific.

If you do not plan to have this property writable, it is not useful to
have it accessible for external D-Bus clients IMHO.

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
