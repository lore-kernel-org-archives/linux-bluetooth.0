Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <422DA2A5.6070107@gmx.ch>
From: Marco Trudel <mtrudel@gmx.ch>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] adding a sdp service with a 128bit uuid
References: <20050308123527.49819.qmail@web60910.mail.yahoo.com>
In-Reply-To: <20050308123527.49819.qmail@web60910.mail.yahoo.com>
Content-Type: text/plain; charset=Big5
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
Date: Tue, 08 Mar 2005 14:03:33 +0100

Hallo Michael

just read the sdptool.c... it's all there. basically you need
add_sp(sdp_session_t *session, svc_info_t *si)

respectively you told once something about headset, i think... there is a
method like add_headset()...

regards
Marco


Ka Kin Cheung wrote:
> Hi Marco!
>     Can you send the program you wrote to me for reference? Or can you 
> tell briefly the algorithm about the program you wrote about adding a 
> service profile, especially for which functions in sdptool.c are nneded? 
> Thank you very much.
> Michael
> 
> */Marco Trudel <mtrudel@gmx.ch>/* wrote:
> 
>     Hello everybody
> 
>     by reading sdptool.c, I was able to write a little program that
>     promotes my
>     service. Realising this, 3 questions arised:
> 
>     1. general:
>     how to browse the local sdp services?
>     [sdptool browse dev] seems to be only for remote devices. I now
>     always did
>     it from another device to see the local seervices. how to [sdptool
>     browse
>     localhost]?
> 
>     2. from add_sp(...) in sdptool.c, changing:
>     # sdp_uuid16_create(&sp_uuid, SERIAL_PORT_SVCLASS_ID);
>     into:
>     # sdp_uuid128_create(&sp_uuid, a128bitUUID);
>     gives me (if I do [sdptool browse from the other device]):
>     # Service Class ID List:
>     # "Error: This is uuid128" (0x0a333444-5556-6677-7888-9aa99000a1a1)
>     Actually it works well. But why is it saying "Error: ..."? I noticed
>     that
>     using the avetana jsr82 implementation (that uses bluez), and
>     creating a
>     sdp entry with a 128bit uuid, it shows the same error.
> 
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
> 
> 
>     regards
>     Marco
> 
> 
>     -------------------------------------------------------
>     SF email is sponsored by - The IT Product Guide
>     Read honest & candid reviews on hundreds of IT Products from real users.
>     Discover which products truly live up to the hype. Start reading now.
>     http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
>     _______________________________________________
>     Bluez-users mailing list
>     Bluez-users@lists.sourceforge.net
>     https://lists.sourceforge.net/lists/listinfo/bluez-users
> 
> 
> ------------------------------------------------------------------------
> Yahoo! 工具列 - 內置防止彈出視窗工能 <http://hk.toolbar.yahoo.com>！


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
