Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <422DAB03.1010402@prim-time.fr>
From: Xavier Garreau <x.garreau@prim-time.fr>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] adding a sdp service with a 128bit uuid
References: <20050308123527.49819.qmail@web60910.mail.yahoo.com>
In-Reply-To: <20050308123527.49819.qmail@web60910.mail.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
Date: Tue, 08 Mar 2005 14:39:15 +0100

>     3. actually this is more a c then a bluez question, but i'd
>     appreciate if
>     someone could tell it nevertheless:
>     # sdp_uuid32_create(uuid_t *uuid, uint32_t data);
>     # sdp_uuid128_create(uuid_t *uuid, const void *data);
>     the second function takes the uuid as "const void *data". What is the
>     appropriate way to give a uuid like 2c3ef0c843674369b1dfb7315e76332a to
>     that function?
>     I asked google and he (she?) told me this:
>     http://www.xgarreau.org/aide/devel/bluetooth/timeserver.c
>     but it seems a little big for me...

Whaou, nice, i love google :)

Actually i wrote this sample for a presentation in a university. It's 
not production quality code.

But to give data as void* you can do something like this:

unsigned char uuid_data[16] = {0x2c, 0x3e, 0xf0, 0xc8, 0x43, 0x67, 0x43, 
0x69, 0xb1, 0xdf, 0xb7, 0x31, 0x5e, 0x76, 0x33, 0x2a};
...
sdp_uuid128_create (&uuid, (void*)uuid_data);

Actually, in the code you mentionned i used the create_base_uuid 
function from a bluez source ... But i don't remember from what file it 
was ...

Regards,
Xavier


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
