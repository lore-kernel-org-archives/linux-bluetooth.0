Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] adding a sdp service with a 128bit uuid
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <4229B30E.8080803@gmx.ch>
References: <42291076.5040109@gmx.ch> <1110021688.8058.108.camel@pegasus>
	 <4229B30E.8080803@gmx.ch>
Content-Type: text/plain
Message-Id: <1110029911.8168.5.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sat, 05 Mar 2005 14:38:31 +0100

Hi Marco,

> >>how to browse the local sdp services?
> >>[sdptool browse dev] seems to be only for remote devices. I now always did 
> >>it from another device to see the local seervices. how to [sdptool browse 
> >>localhost]?
> > 
> > 
> > sdptool browse local
> 
> nice :-)
> maybe something that should/could be mentioned in the manpage or in --help

feel free to send in a patch.

> >>from add_sp(...) in sdptool.c, changing:
> >>  # sdp_uuid16_create(&sp_uuid, SERIAL_PORT_SVCLASS_ID);
> >>into:
> >>  # sdp_uuid128_create(&sp_uuid, a128bitUUID);
> >>gives me (if I do [sdptool browse from the other device]):
> >>  # Service Class ID List:
> >>  #   "Error: This is uuid128" (0x0a333444-5556-6677-7888-9aa99000a1a1)
> >>Actually it works well. But why is it saying "Error: ..."? I noticed that 
> >>using the avetana jsr82 implementation (that uses bluez), and creating a 
> >>sdp entry with a 128bit uuid, it shows the same error.
> > 
> > 
> > This is because the friend display (without --tree) don't understand
> > UUID 128 and don't knows how to translate it into a service.
> 
> nice again. this solves my proglem that never existed :-)
> maybee another thing to mention in the manpage...

Again, any updates of the manual pages are always welcome.

> >>actually this is more a c then a bluez question, but i'd appreciate if 
> >>someone could tell it nevertheless:
> >>  # sdp_uuid32_create(uuid_t *uuid, uint32_t data);
> >>  # sdp_uuid128_create(uuid_t *uuid, const void *data);
> >>the second function takes the uuid as "const void *data". What is the 
> >>appropriate way to give a uuid like 2c3ef0c843674369b1dfb7315e76332a to 
> >>that function?
> > 
> > 
> > Using "unsigned char uuid[16]" and then casting with "(void *)" worked
> > for me.
> 
> actually, i've a long representation of my uuid. but i'm willing to try!
> using 0x233438787A233438787A233438787A23 as long uuid and an ascii table 
> gives me: "#48xz#48xz#48xz#" for a char representation of the uuid and it 
> works! :-)
> 
> but unfortunately that's an invented uuid to avoid control-chars. my uuid 
> has values as 0x0F -> that's a SI (left shift) in the ascii table.
> so i did:
> 
> unsigned char uuid[] = { 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08,
>                           0x09, 0x0A, 0x0B, 0x0C, 0x0D, 0x0E, 0x0F, 0x10 };
> 
> and it works as too. is this what you meant?

It is exactly how I create UUID 128 if needed. If you play with long
types then you may ran into compiler or platform problems. The unsigned
character array is supposed to work everywhere.

> thanks a lot for the short and precise answers! it's always a pleasure!

You are welcome.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
