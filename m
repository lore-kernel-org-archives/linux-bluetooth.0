Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <44BFF555.2090606@gmail.com>
Date: Thu, 20 Jul 2006 17:27:49 -0400
From: JP Freeley <jpf321@gmail.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <44BE5DB3.7090406@gmail.com>
	<1153356539.4094.9.camel@aeonflux.holtmann.net>
In-Reply-To: <1153356539.4094.9.camel@aeonflux.holtmann.net>
Subject: Re: [Bluez-devel] Error: sdptool browse --> Connection reset by	peer
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1159204092=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.
--===============1159204092==
Content-Type: multipart/alternative;
	boundary="------------020405060306040008020906"

This is a multi-part message in MIME format.
--------------020405060306040008020906
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Mr. Holtmann--

Thanks for the reply, but I'm having trouble replicating the situation. 
I'm having trouble in general I think. My bluetooth setup seems quite 
finicky and unstable. There are so many factors which affect this, it's 
hard to point the finger at any single point of failure. (Could be 
handheld devices, could be Linux, could be bluez, could be BT Dongle, 
could be kernel, etc.)

I can send you any notes on my configuration that may lend clues, just 
tell me where to start. I just ran an "apt-get upgrade" last night and 
haven't had much time to see if it helped at all yet.

Thanks,

jpf

Marcel Holtmann wrote:
> Hi,
>
>   
>> I am getting an error ("Connection reset by peer") when I run an 
>> "sdptool browse" and it discovers my Sprint Pocket PC handset.
>>
>> I'm sure this is probably a common situation. I have attached my 
>> "hcidump -V -R". Any help in deciphering this problem would be great. My 
>> goal is to send a .vcf file to the device.
>>     
>
> please include "hcidump -X -V".
>
> Regards
>
> Marcel
>
>
>
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share your
> opinions on IT & business topics through brief surveys -- and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>
>   

--------------020405060306040008020906
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
Mr. Holtmann--<br>
<br>
Thanks for the reply, but I'm having trouble replicating the situation.
I'm having trouble in general I think. My bluetooth setup seems quite
finicky and unstable. There are so many factors which affect this, it's
hard to point the finger at any single point of failure. (Could be
handheld devices, could be Linux, could be bluez, could be BT Dongle,
could be kernel, etc.)<br>
<br>
I can send you any notes on my configuration that may lend clues, just
tell me where to start. I just ran an "apt-get upgrade" last night and
haven't had much time to see if it helped at all yet. <br>
<br>
Thanks, <br>
<br>
jpf<br>
<br>
Marcel Holtmann wrote:
<blockquote cite="mid1153356539.4094.9.camel@aeonflux.holtmann.net"
 type="cite">
  <pre wrap="">Hi,

  </pre>
  <blockquote type="cite">
    <pre wrap="">I am getting an error ("Connection reset by peer") when I run an 
"sdptool browse" and it discovers my Sprint Pocket PC handset.

I'm sure this is probably a common situation. I have attached my 
"hcidump -V -R". Any help in deciphering this problem would be great. My 
goal is to send a .vcf file to the device.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
please include "hcidump -X -V".

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT &amp; business topics through brief surveys -- and earn cash
<a class="moz-txt-link-freetext" href="http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV">http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV</a>
_______________________________________________
Bluez-devel mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Bluez-devel@lists.sourceforge.net">Bluez-devel@lists.sourceforge.net</a>
<a class="moz-txt-link-freetext" href="https://lists.sourceforge.net/lists/listinfo/bluez-devel">https://lists.sourceforge.net/lists/listinfo/bluez-devel</a>

  </pre>
</blockquote>
</body>
</html>

--------------020405060306040008020906--


--===============1159204092==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1159204092==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1159204092==--
