Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <20060508153458.88001.qmail@web26908.mail.ukl.yahoo.com>
From: javier labella <javi_labella@yahoo.es>
To: bluez develop <bluez-devel@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1333238275-1147102498=:87566"
Subject: [Bluez-devel] Re:Advanced Audio Distribution Profile for BlueZ
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
Date: Mon, 8 May 2006 17:34:58 +0200 (CEST)

--0-1333238275-1147102498=:87566
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit



  Fecha: Wed, 3 May 2006 18:18:27 +0200 (CEST)
De: javier labella <javi_labella@yahoo.es>
Asunto: Re:Advanced Audio Distribution Profile for 
Bluez
Para: bluez-devel@lists.sourceforge.net


>We have implemented some a2dp already. See bluetooth-alsa.sf.net. There
>is still plenty to do, if you want to help integrate it with gstreamer
>for example.

>I think it's not totally clear how the a2dp profile gets "integrated"
>since it really looks more like a bluez client that belongs in one or
>more multimedia frameworks.

>Brad

Hi,
I've visited bluetooth-alsa.sf.net and the project is very interesting but I think that the profile's implementation is based on SCO channels. If I'm making a mistake I apologize for it. On the other hand, I've read the A2DP profile specification and I think that an implementation should uses ACL channels: "The Advanced Audio Distribution Profile (A2DP) defines the protocols and procedures that realize distribution of audio content of high-quality in mono or stereo on ACL channels (Introduction of Advanced Audio Distribution Profile Specification)" So I'd like to develop an implementation using ACL channels instead of SCO channels.

I'd like to know if you're interested in include this implementation in the BlueZ stack too.  
Thanks.

Javier.
  


		
---------------------------------

LLama Gratis a cualquier PC del Mundo.
Llamadas a fijos y móviles desde 1 céntimo por minuto.
http://es.voice.yahoo.com
--0-1333238275-1147102498=:87566
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<BR><BR>  <BLOCKQUOTE class=replbq style="PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #1010ff 2px solid">Fecha: Wed, 3 May 2006 18:18:27 +0200 (CEST)<BR>De: javier labella &lt;javi_labella@yahoo.es&gt;<BR>Asunto: Re:Advanced Audio Distribution Profile for <BR>Bluez<BR>Para: bluez-devel@lists.sourceforge.net<BR><BR><PRE><TT>&gt;We have implemented some a2dp already. See bluetooth-alsa.sf.net. There<BR>&gt;is still plenty to do, if you want to help integrate it with gstreamer<BR>&gt;for example.<BR><BR>&gt;I think it's not totally clear how the a2dp profile gets "integrated"<BR>&gt;since it really looks more like a bluez client that belongs in one or<BR>&gt;more multimedia frameworks.<BR><BR>&gt;Brad</TT></PRE><BR>Hi,<BR>I've visited bluetooth-alsa.sf.net and the project is very interesting but I think that the profile's implementation is based on SCO channels. If I'm making a mistake I apologize for it. On the other hand, I've read the A2DP profile specification and I
 think that an implementation should uses ACL channels: "The Advanced Audio Distribution Profile (A2DP) defines the protocols and procedures that realize distribution of audio content of high-quality in mono or stereo on ACL channels (Introduction of Advanced Audio Distribution Profile Specification)" So I'd like to develop an implementation using ACL channels instead of SCO channels.<BR><BR>I'd like to know if you're interested in include this implementation in the BlueZ stack too.&nbsp; <BR>Thanks.<BR><BR>Javier.<BR>  <div></div></BLOCKQUOTE><BR><p>
		<hr size=1><br><font face="Verdana" size="-2">LLama Gratis a cualquier PC del Mundo.<br>Llamadas a fijos y móviles desde 1 céntimo por minuto.<br><a href="http://us.rd.yahoo.com/mail/es/tagline/messenger/*http://es.voice.yahoo.com/">http://es.voice.yahoo.com</a></font>
--0-1333238275-1147102498=:87566--


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
