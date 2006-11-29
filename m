Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Wed, 29 Nov 2006 09:16:51 +0100
From: "Chafik Moalem" <Chafik.Moalem@perdictum.com>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Message-ID: <1164788211.17085.53.camel@chmo.prologistik.com>
In-Reply-To: <1164736384.13955.24.camel@aeonflux.holtmann.net>
References: <20061128071440.25196.qmail@bux.stollmann.net>
References: <1164736384.13955.24.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] BECI
Reply-To: Chafik Moalem <Chafik.Moalem@perdictum.com>,
        BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1596273306=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============1596273306==
Content-Type: multipart/related; type="multipart/alternative";
	boundary="=-aIWprj0oAPNkhoNFC/QQ"

--=-aIWprj0oAPNkhoNFC/QQ
Content-Type: multipart/alternative;
	boundary="=-9eYGeNXc/u34kXn2nIfT"

--=-9eYGeNXc/u34kXn2nIfT
Content-Type: text/plain
Content-Disposition: inline

Hi Marcel,

hmmm ... as I understood so far : 
a BECI Module with the right abstraction API (dbus) might "replace"
bluez then ?

btw.: I am currently working with a uart module which has already a
complete BT-Stack with profiles and all the needed logic implemented
"inside" a CSR BC03MM ! All I need to do is initiate profile, initiate
connection (implicit pairing), open SCO et voila : I have a nice
PCM-eSCO connection to my HS ! just testing concurrent connections at
the moment (SPP + HSP)

Just have a look at
 http://www.lintech.de/index.php?index=19&pc=4&p=36  
.. the datasheet is "on click" 

when they talk about "API" they mean a simple serial (uart) message
format :)
Well if I have a bit more time I should try to implement a "special"
uart<->dbus layer ... i think it is something pre-BECI !

Did you hear about other modules already implementing such intelligent
subsystems and already available?

regards
Chafik

Am Dienstag, den 28.11.2006, 18:53 +0100 schrieb Marcel Holtmann:

> Hi Juergen,
> 
> > BECI is designeated as a Profile orientated Interface situated on top of profiles and protocols
> > to interact with aplications.
> > So its not a question of hardware.
> > However since a working group has not been established yet no specs exist.
> 
> I heard about BECI and actually my understanding is that stuff like
> L2CAP and RFCOMM can run on the Bluetooth chip itself and doesn't needed
> to be implemented in the actual host OS. However my tip is that someone
> might simply have a look at our D-Bus based API, because we designed all
> methods and signals from the viewpoint of the applications. It has
> become one of the easiest to use abstractions, I have seen so far.
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
> opinions on IT & business topics through brief surveys - and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=-9eYGeNXc/u34kXn2nIfT
Content-Type: text/html;
	charset="utf-8"
Content-Disposition: inline

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.12.1">
</HEAD>
<BODY>
Hi Marcel,<BR>
<BR>
hmmm ... as I understood so far : <BR>
a BECI Module with the right abstraction API (dbus) might &quot;replace&quot; bluez then ?<BR>
<BR>
btw.: I am currently working with a uart module which has already a complete BT-Stack with profiles and all the needed logic implemented &quot;inside&quot; a CSR BC03MM ! All I need to do is initiate profile, initiate connection (implicit pairing), open SCO et voila : I have a nice PCM-eSCO connection to my HS ! just testing concurrent connections at the moment (SPP + HSP)<BR>
<BR>
Just have a look at<BR>
 <A HREF="http://www.lintech.de/index.php?index=19&pc=4&p=36">http://www.lintech.de/index.php?index=19&amp;pc=4&amp;p=36</A>&nbsp; <BR>
.. the datasheet is &quot;on click&quot; <BR>
<BR>
when they talk about &quot;API&quot; they mean a simple serial (uart) message format <IMG SRC="cid:1164787619.17085.44.camel@chmo.prologistik.com" ALIGN="middle" ALT=":)" BORDER="0"><BR>
Well if I have a bit more time I should try to implement a &quot;special&quot; uart&lt;-&gt;dbus layer ... i think it is something pre-BECI !<BR>
<BR>
Did you hear about other modules already implementing such intelligent subsystems and already available?<BR>
<BR>
regards<BR>
Chafik<BR>
<BR>
Am Dienstag, den 28.11.2006, 18:53 +0100 schrieb Marcel Holtmann:
<BLOCKQUOTE TYPE=CITE>
<PRE>
<FONT COLOR="#000000">Hi Juergen,</FONT>

<FONT COLOR="#000000">&gt; BECI is designeated as a Profile orientated Interface situated on top of profiles and protocols</FONT>
<FONT COLOR="#000000">&gt; to interact with aplications.</FONT>
<FONT COLOR="#000000">&gt; So its not a question of hardware.</FONT>
<FONT COLOR="#000000">&gt; However since a working group has not been established yet no specs exist.</FONT>

<FONT COLOR="#000000">I heard about BECI and actually my understanding is that stuff like</FONT>
<FONT COLOR="#000000">L2CAP and RFCOMM can run on the Bluetooth chip itself and doesn't needed</FONT>
<FONT COLOR="#000000">to be implemented in the actual host OS. However my tip is that someone</FONT>
<FONT COLOR="#000000">might simply have a look at our D-Bus based API, because we designed all</FONT>
<FONT COLOR="#000000">methods and signals from the viewpoint of the applications. It has</FONT>
<FONT COLOR="#000000">become one of the easiest to use abstractions, I have seen so far.</FONT>

<FONT COLOR="#000000">Regards</FONT>

<FONT COLOR="#000000">Marcel</FONT>



<FONT COLOR="#000000">-------------------------------------------------------------------------</FONT>
<FONT COLOR="#000000">Take Surveys. Earn Cash. Influence the Future of IT</FONT>
<FONT COLOR="#000000">Join SourceForge.net's Techsay panel and you'll get the chance to share your</FONT>
<FONT COLOR="#000000">opinions on IT &amp; business topics through brief surveys - and earn cash</FONT>
<FONT COLOR="#000000"><A HREF="http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV">http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV</A></FONT>
<FONT COLOR="#000000">_______________________________________________</FONT>
<FONT COLOR="#000000">Bluez-devel mailing list</FONT>
<FONT COLOR="#000000"><A HREF="mailto:Bluez-devel@lists.sourceforge.net">Bluez-devel@lists.sourceforge.net</A></FONT>
<FONT COLOR="#000000"><A HREF="https://lists.sourceforge.net/lists/listinfo/bluez-devel">https://lists.sourceforge.net/lists/listinfo/bluez-devel</A></FONT>
</PRE>
</BLOCKQUOTE>
</BODY>
</HTML>

--=-9eYGeNXc/u34kXn2nIfT--

--=-aIWprj0oAPNkhoNFC/QQ
Content-Type: image/png;
	name="smiley-3.png"
Content-Transfer-Encoding: base64
Content-ID: <1164787619.17085.44.camel@chmo.prologistik.com>
Content-Disposition: attachment;
	filename="smiley-3.png"

iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAC+klEQVR42n2TbUjVdxTHP/+H
69Xda2VWlFe69rzthZJUoxeNOWoFGxEhYRRFmZSVW2u9ab2KejWE1qDNBkEQhS82VoiaZkVP
moWaKNM5mA+opbd771//997//T/+epHBarEPHA6Hc84XDnwP/JcwcBS4AVgzcR04ONN7C+md
+pcPCz44dPLAarZs/gg1UABuGkvvp7X1Iad+itE/YtUAle8TuH26sujzqq/LkJQsnOQQVmIA
SVJQMhehZORiJwc5d76FH2pf3gY2Aigzy7+eObqmtOqbXbjGGHZqCM+eQpJ9AHhWFCc5CAjW
f1KAkppc+qg3vRCol4Fw0aqcisOVW3HTE7hmBElSKD/5GFkNMhH1KDvegST78CwNSfZxeM88
VuYrh4CwAuxqvxL6MnPuWiy9H1kNUPH9fZofDKPpHn8/z+Z6Yw8JK5stX5VhRO6h+OfiV3Wa
HxtPVKAwmF+KqXUDMkgqZ0+UoKcEP57/GXOqh46ODqrPXUQfufb6YOGxJOQD2CaHQnnlAJ4z
DXggHBYvK6ap6Rau+RIz1k7djd+YHrqMpXUC4KQnWTRPAdiuRqNRkFQG/omRNJOsKVQw408x
tS4QDsI10AaqEY6O8Fzq70fJy3XI8gsA5HTarBdOkvwFKj39EWrr/sJzEnj29OvsphGugfBs
LlwbZnjcYN36LxiLuADtMtCUetFAcE4ee8s+pbHVYtOemwhHx3MSaPEY3X9OUnqsk5a2OMeP
7KC3t4u+3gRALUC4cEW2eN62Q4ze3SAiz74TDxvOiI+XBcTsoCoyfJKYn6OKmrMbxGRnlXhy
JSSqv80Vq0KSAFa+ceKl0wcK9lfsW42TGsE/pxhfcDmKfz6eFUPg4iRH6Ov6g9EJh1t341xu
sWuAyn9b+c7BrbklJ8oDZGTOQpL9ePY08SmDpCEwbcHwuE370ykuNlj3gM/e90yXliyU9+8s
CVJYlEUgU8IwBZruMThm83uzxsAYV4Hd/A9h4BjQBthAFOgDLgDF7w6/ArI6YJ0eTQeGAAAA
AElFTkSuQmCC

--=-aIWprj0oAPNkhoNFC/QQ--


--===============1596273306==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1596273306==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1596273306==--
