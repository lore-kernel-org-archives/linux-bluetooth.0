Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <4614C6B7.9040008@free2move.net>
Date: Thu, 05 Apr 2007 11:51:51 +0200
From: Markus Adolfsson <markus.adolfsson@free2move.net>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <4614A31C.4010806@free2move.net> <1175765486.5815.598.camel@violet>
In-Reply-To: <1175765486.5815.598.camel@violet>
Content-Type: multipart/mixed; boundary="------------050603040009080307090909"
Subject: Re: [Bluez-devel] How to set packet-type and role from source-code?
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------050603040009080307090909
Content-Type: multipart/alternative;
	boundary="------------050604010601040804050100"


--------------050604010601040804050100
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Marcel,

Thanx for your response, I thought I had to set HV1 packets as I need to 
have 2 (hopefully even 3...) SCO connections simultaneously in a 
pico-net (this relates to the  conversation "Troubles with mulitple SCO 
connections" I posted yesterday) where it turned out that the USB dongle 
was the cause which is why I'm noe going directly for the embedded 
platform using serial hci connection...

But anyhow - to cut to the chase;
If I connect multiple SCO connections from my embedded platform, will 
the packet-types dynamically adjust when I add a second and even third 
SCO connection? This is why I though I had to specifically set 
packet-type to HV1... Could you (or someone that feel for it) just 
confirm my thoughts? ;)

Regards,
/Markus

Marcel Holtmann skrev:
> Hi Markus,
>
>   
>> I need to set SCO packet type to HV1 as well as I'd like to specify
>> that my device should be the "master" in a SCO connection. I known
>> that I can do this from the command-line using the hci* utilities, but
>> I'd like to set the packet-types to a known state when I initialize my
>> application (from code) and I'm sorry to say that I cannot find how to
>> go about and to that...
>>
>> It has to be possible, but I've search through the hci_lib but without
>> success - yet ;)
>> Could someone point me in the right direction?
>>     
>
> since hciconfig and hcitool can do it, you might wanna have a look at
> their source code and see how they handle it.
>
> However I can't advise you to play with the packet types at all. Leave
> them as they are. The link manager of the Bluetooth chip knows best what
> to do and what packet type to choose.
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
> opinions on IT & business topics through brief surveys-and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>   

-- 
------------------------------------------------------------------------
*Markus Adolfsson*
M.Sc.CE. Product Development
Mail: 	markus.adolfsson@free2move.net 
<mailto:markus.adolfsson@free2move.net>
Phone: 	+46 35 152268 <callto:+4635152268>
Mobile: 	+46 707 165296 <callto:+46707165296>

	
*Free2move AB* -- /WIRELESS MADE EASY/
Phone: 	+46 35 152260 <callto:+4635152260>
Fax: 	+46 35 152269 <callto:+4635152269>
Web: 	www.free2move.net <http://www.free2move.net>
Address: 	Sperlingsgatan 7
SE-30248 Halmstad
Sweden


--------------050604010601040804050100
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
Hi Marcel,<br>
<br>
Thanx for your response, I thought I had to set HV1 packets as I need
to have 2 (hopefully even 3...) SCO connections simultaneously in a
pico-net (this relates to the&nbsp; conversation "Troubles with mulitple SCO
connections" I posted yesterday) where it turned out that the USB
dongle was the cause which is why I'm noe going directly for the
embedded platform using serial hci connection...<br>
<br>
But anyhow - to cut to the chase; <br>
If I connect multiple SCO connections from my embedded platform, will
the packet-types dynamically adjust when I add a second and even third
SCO connection? This is why I though I had to specifically set
packet-type to HV1... Could you (or someone that feel for it) just
confirm my thoughts? ;)<br>
<br>
Regards,<br>
/Markus<br>
<br>
Marcel Holtmann skrev:
<blockquote cite="mid1175765486.5815.598.camel@violet" type="cite">
  <pre wrap="">Hi Markus,

  </pre>
  <blockquote type="cite">
    <pre wrap="">I need to set SCO packet type to HV1 as well as I'd like to specify
that my device should be the "master" in a SCO connection. I known
that I can do this from the command-line using the hci* utilities, but
I'd like to set the packet-types to a known state when I initialize my
application (from code) and I'm sorry to say that I cannot find how to
go about and to that...

It has to be possible, but I've search through the hci_lib but without
success - yet ;)
Could someone point me in the right direction?
    </pre>
  </blockquote>
  <pre wrap=""><!---->
since hciconfig and hcitool can do it, you might wanna have a look at
their source code and see how they handle it.

However I can't advise you to play with the packet types at all. Leave
them as they are. The link manager of the Bluetooth chip knows best what
to do and what packet type to choose.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT &amp; business topics through brief surveys-and earn cash
<a class="moz-txt-link-freetext" href="http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV">http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV</a>
_______________________________________________
Bluez-devel mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Bluez-devel@lists.sourceforge.net">Bluez-devel@lists.sourceforge.net</a>
<a class="moz-txt-link-freetext" href="https://lists.sourceforge.net/lists/listinfo/bluez-devel">https://lists.sourceforge.net/lists/listinfo/bluez-devel</a>
  </pre>
</blockquote>
<br>
<div class="moz-signature">-- <br>
<hr>
<table width="100%">
  <tbody>
    <tr>
      <td align="left" valign="top" width="50%">
      <table>
        <tbody>
          <tr>
            <td colspan="2"><b>Markus Adolfsson</b></td>
          </tr>
          <tr>
            <td colspan="2">M.Sc.CE. Product Development</td>
          </tr>
          <tr>
            <td align="left" valign="top">Mail:</td>
            <td><a href="mailto:markus.adolfsson@free2move.net">markus.adolfsson@free2move.net</a></td>
          </tr>
          <tr>
            <td align="left" valign="top">Phone:</td>
            <td><a href="callto:+4635152268">+46 35 152268</a></td>
          </tr>
          <tr>
            <td align="left" valign="top">Mobile:</td>
            <td><a href="callto:+46707165296">+46 707 165296</a></td>
          </tr>
        </tbody>
      </table>
      </td>
      <td align="left" valign="top" width="50%">
      <table>
        <tbody>
          <tr>
            <td colspan="2"><b>Free2move AB</b> -- <i>WIRELESS MADE
EASY</i></td>
          </tr>
          <tr>
            <td align="left" valign="top">Phone:</td>
            <td><a href="callto:+4635152260">+46 35 152260</a></td>
          </tr>
          <tr>
            <td align="left" valign="top">Fax:</td>
            <td><a href="callto:+4635152269">+46 35 152269</a></td>
          </tr>
          <tr>
            <td align="left" valign="top">Web:</td>
            <td><a href="http://www.free2move.net">www.free2move.net</a></td>
          </tr>
          <tr>
            <td align="left" valign="top">Address:</td>
            <td>Sperlingsgatan 7<br>
SE-30248 Halmstad<br>
Sweden</td>
          </tr>
        </tbody>
      </table>
      </td>
    </tr>
  </tbody>
</table>
</div>
</body>
</html>

--------------050604010601040804050100--

--------------050603040009080307090909
Content-Type: text/x-vcard; charset=utf-8;
 name="markus.adolfsson.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="markus.adolfsson.vcf"

begin:vcard
fn:Markus Adolfsson
n:Adolfsson;Markus
org:Free2move;Product Development
adr:;;Sperlingsgatan 7;Halmstad;;302 48;Sweden
email;internet:markus.adolfsson@free2move.net
title:M.Sc.C.E.
tel;work:+46 35 152268
url:http://www.free2move.net
version:2.1
end:vcard


--------------050603040009080307090909
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--------------050603040009080307090909
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--------------050603040009080307090909--
