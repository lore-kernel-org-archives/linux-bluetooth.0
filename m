Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <41A6F09C.5000801@parrot.fr>
From: Sebastien HENRIO <sebastien.henrio@parrot.fr>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] a2play and Toshiba SR-1 Bluetooth Headset
References: <20041125091124.GA19805@snoopy.src.ricoh.co.jp>	 <20041125112509.75347786.henryk@ploetzli.ch>	 <20041125105615.GA19821@snoopy.src.ricoh.co.jp>	 <1101440449.6465.64.camel@pegasus>	 <20041126045659.6a3291f5.henryk@ploetzli.ch> <1101442380.6465.77.camel@pegasus>
In-Reply-To: <1101442380.6465.77.camel@pegasus>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
Date: Fri, 26 Nov 2004 10:00:12 +0100

Hi,

Marcel Holtmann wrote:
> Hi Henryk,
>=20
>=20
>>>For me it is not clear if we have to set them, ignore them or what to
>>>do with them. Do we have to insert the content protection header in
>>>the media payload if these capability is present?
>>
>>Obviously we may only insert the content protection header if we reques=
t
>>content protection during set configuration. However, I don't remember
>>any document requiring us to do that. I think Content protection is
>>completely optional and we would only use that if we were a paranoid
>>Sony device that believed everybody else on the planet was after us to
>>steal our music.
>=20
>=20
> actually for me it is not clear if we have to insert that header (even
> with no content protection information) when the capabilities shows tha=
t
> record. Maybe I missed something in the specification.

In fact you have to insert the content protection header only if you=20
want to use it.

This capablity is optional, so you can skip it during the stream=20
configuration process.

Best Regards
S=E9bastien




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
