Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] adding a sdp service with a 128bit uuid
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <42291076.5040109@gmx.ch>
References: <42291076.5040109@gmx.ch>
Content-Type: text/plain
Message-Id: <1110021688.8058.108.camel@pegasus>
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
Date: Sat, 05 Mar 2005 12:21:28 +0100

Hi Marco,

> by reading sdptool.c, I was able to write a little program that promotes my 
> service. Realising this, 3 questions arised:
> 
> 1. general:
> how to browse the local sdp services?
> [sdptool browse dev] seems to be only for remote devices. I now always did 
> it from another device to see the local seervices. how to [sdptool browse 
> localhost]?

sdptool browse local

> 2. from add_sp(...) in sdptool.c, changing:
>   # sdp_uuid16_create(&sp_uuid, SERIAL_PORT_SVCLASS_ID);
> into:
>   # sdp_uuid128_create(&sp_uuid, a128bitUUID);
> gives me (if I do [sdptool browse from the other device]):
>   # Service Class ID List:
>   #   "Error: This is uuid128" (0x0a333444-5556-6677-7888-9aa99000a1a1)
> Actually it works well. But why is it saying "Error: ..."? I noticed that 
> using the avetana jsr82 implementation (that uses bluez), and creating a 
> sdp entry with a 128bit uuid, it shows the same error.

This is because the friend display (without --tree) don't understand
UUID 128 and don't knows how to translate it into a service.

> 3. actually this is more a c then a bluez question, but i'd appreciate if 
> someone could tell it nevertheless:
>   # sdp_uuid32_create(uuid_t *uuid, uint32_t data);
>   # sdp_uuid128_create(uuid_t *uuid, const void *data);
> the second function takes the uuid as "const void *data". What is the 
> appropriate way to give a uuid like 2c3ef0c843674369b1dfb7315e76332a to 
> that function?

Using "unsigned char uuid[16]" and then casting with "(void *)" worked
for me.

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
