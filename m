Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20050308123527.49819.qmail@web60910.mail.yahoo.com>
From: Ka Kin Cheung <michaelhku2002@yahoo.com.hk>
Subject: Re: [Bluez-users] adding a sdp service with a 128bit uuid
To: bluez-users@lists.sourceforge.net
In-Reply-To: 6667
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1195799713-1110285326=:48554"
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
Date: Tue, 8 Mar 2005 20:35:26 +0800 (CST)

--0-1195799713-1110285326=:48554
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: 8bit

Hi Marco!
    Can you send the program you wrote to me for reference? Or can you tell briefly the algorithm about the program you wrote about adding a service profile, especially for which functions in sdptool.c are nneded? Thank you very much.
Michael

Marco Trudel <mtrudel@gmx.ch> wrote:
Hello everybody

by reading sdptool.c, I was able to write a little program that promotes my 
service. Realising this, 3 questions arised:

1. general:
how to browse the local sdp services?
[sdptool browse dev] seems to be only for remote devices. I now always did 
it from another device to see the local seervices. how to [sdptool browse 
localhost]?

2. from add_sp(...) in sdptool.c, changing:
# sdp_uuid16_create(&sp_uuid, SERIAL_PORT_SVCLASS_ID);
into:
# sdp_uuid128_create(&sp_uuid, a128bitUUID);
gives me (if I do [sdptool browse from the other device]):
# Service Class ID List:
# "Error: This is uuid128" (0x0a333444-5556-6677-7888-9aa99000a1a1)
Actually it works well. But why is it saying "Error: ..."? I noticed that 
using the avetana jsr82 implementation (that uses bluez), and creating a 
sdp entry with a 128bit uuid, it shows the same error.

3. actually this is more a c then a bluez question, but i'd appreciate if 
someone could tell it nevertheless:
# sdp_uuid32_create(uuid_t *uuid, uint32_t data);
# sdp_uuid128_create(uuid_t *uuid, const void *data);
the second function takes the uuid as "const void *data". What is the 
appropriate way to give a uuid like 2c3ef0c843674369b1dfb7315e76332a to 
that function?
I asked google and he (she?) told me this:
http://www.xgarreau.org/aide/devel/bluetooth/timeserver.c
but it seems a little big for me...


regards
Marco


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users



---------------------------------
Yahoo! 工具列 - 內置防止彈出視窗工能！

--0-1195799713-1110285326=:48554
Content-Type: text/html; charset=big5
Content-Transfer-Encoding: 8bit

<DIV>Hi Marco!</DIV>
<DIV>&nbsp;&nbsp;&nbsp; Can you send the program you wrote to me for reference? Or can you tell briefly the algorithm about the program you wrote about adding a service profile, especially for which functions in sdptool.c are nneded? Thank you very much.</DIV>
<DIV>Michael<BR><BR><B><I>Marco Trudel &lt;mtrudel@gmx.ch&gt;</I></B> wrote:</DIV>
<BLOCKQUOTE class=replbq style="PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #1010ff 2px solid">Hello everybody<BR><BR>by reading sdptool.c, I was able to write a little program that promotes my <BR>service. Realising this, 3 questions arised:<BR><BR>1. general:<BR>how to browse the local sdp services?<BR>[sdptool browse dev] seems to be only for remote devices. I now always did <BR>it from another device to see the local seervices. how to [sdptool browse <BR>localhost]?<BR><BR>2. from add_sp(...) in sdptool.c, changing:<BR># sdp_uuid16_create(&amp;sp_uuid, SERIAL_PORT_SVCLASS_ID);<BR>into:<BR># sdp_uuid128_create(&amp;sp_uuid, a128bitUUID);<BR>gives me (if I do [sdptool browse from the other device]):<BR># Service Class ID List:<BR># "Error: This is uuid128" (0x0a333444-5556-6677-7888-9aa99000a1a1)<BR>Actually it works well. But why is it saying "Error: ..."? I noticed that <BR>using the avetana jsr82 implementation (that uses bluez), and creating a <BR>sdp entry with a
  128bit
 uuid, it shows the same error.<BR><BR>3. actually this is more a c then a bluez question, but i'd appreciate if <BR>someone could tell it nevertheless:<BR># sdp_uuid32_create(uuid_t *uuid, uint32_t data);<BR># sdp_uuid128_create(uuid_t *uuid, const void *data);<BR>the second function takes the uuid as "const void *data". What is the <BR>appropriate way to give a uuid like 2c3ef0c843674369b1dfb7315e76332a to <BR>that function?<BR>I asked google and he (she?) told me this:<BR>http://www.xgarreau.org/aide/devel/bluetooth/timeserver.c<BR>but it seems a little big for me...<BR><BR><BR>regards<BR>Marco<BR><BR><BR>-------------------------------------------------------<BR>SF email is sponsored by - The IT Product Guide<BR>Read honest &amp; candid reviews on hundreds of IT Products from real users.<BR>Discover which products truly live up to the hype. Start reading
 now.<BR>http://ads.osdn.com/?ad_id=6595&amp;alloc_id=14396&amp;op=click<BR>_______________________________________________<BR>Bluez-users mailing list<BR>Bluez-users@lists.sourceforge.net<BR>https://lists.sourceforge.net/lists/listinfo/bluez-users<BR></BLOCKQUOTE><p><br><hr size=1>Yahoo! 工具列 - <a href=http://hk.toolbar.yahoo.com>內置防止彈出視窗工能</a>！<br>
--0-1195799713-1110285326=:48554--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
