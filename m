Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <461C9E0C.8090003@free2move.net>
Date: Wed, 11 Apr 2007 10:36:28 +0200
From: Markus Adolfsson <markus.adolfsson@free2move.net>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <005101c77c12$5c842c50$9d0cc70a@dlh.st.com>
In-Reply-To: <005101c77c12$5c842c50$9d0cc70a@dlh.st.com>
Content-Type: multipart/mixed; boundary="------------050107000909070201040207"
Subject: Re: [Bluez-devel] Troubles with mulitple SCO connections (duplex)
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
--------------050107000909070201040207
Content-Type: multipart/alternative;
	boundary="------------080506000902040704030703"


--------------080506000902040704030703
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I actually set the packet-types to "ALL SCO" and let stack do its magic 
work according to your suggestions, but in reality it turned out to use 
HV3 which makes sense as that imply (AFAIK) that 2/3 of the bandwidth is 
used for the two SCO connections, leaving 1/3 left for the 3 RF_COMM 
connections.

/Markus

Mayank BATRA skrev:
>> For what it's worth;
>>     
> 	
>   
>> After having cross-compiled to my embedded system and leaving the
>>     
> USB-dongle solution behind, everything now works like a breeze and I now
> have a BT device hosting running 2 SCO connections and 3 RF_COMM sockets
> simultaneously.
> 	
> And what packet types are these two SCO connectionis using now?
>
> -Mayank
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


--------------080506000902040704030703
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
I actually set the packet-types to "ALL SCO" and let stack do its magic
work according to your suggestions, but in reality it turned out to use
HV3 which makes sense as that imply (AFAIK) that 2/3 of the bandwidth
is used for the two SCO connections, leaving 1/3 left for the 3 RF_COMM
connections.<br>
<br>
/Markus<br>
<br>
Mayank BATRA skrev:
<blockquote cite="mid005101c77c12$5c842c50$9d0cc70a@dlh.st.com"
 type="cite">
  <blockquote type="cite">
    <pre wrap="">For what it's worth;
    </pre>
  </blockquote>
  <pre wrap=""><!---->	
  </pre>
  <blockquote type="cite">
    <pre wrap="">After having cross-compiled to my embedded system and leaving the
    </pre>
  </blockquote>
  <pre wrap=""><!---->USB-dongle solution behind, everything now works like a breeze and I now
have a BT device hosting running 2 SCO connections and 3 RF_COMM sockets
simultaneously.
	
And what packet types are these two SCO connectionis using now?

-Mayank


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

--------------080506000902040704030703--

--------------050107000909070201040207
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


--------------050107000909070201040207
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--------------050107000909070201040207
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--------------050107000909070201040207--
