Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <20060510151310.29728.qmail@web26907.mail.ukl.yahoo.com>
From: javier labella <javi_labella@yahoo.es>
To: bluez develop <bluez-devel@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-4835542-1147273990=:26862"
Subject: [Bluez-devel] A2DP  and VDP for BlueZ
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
Date: Wed, 10 May 2006 17:13:10 +0200 (CEST)

--0-4835542-1147273990=:26862
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

>Hi,
> I've visited bluetooth-alsa.sf.net and the project is very 
>interesting bu=
>t
> I think that the profile's implementation is based on SCO channels. 
>If I'=
>m
> making a mistake I apologize for it. On the other hand, I've read the 
>A2D=
>P
> profile specification and I think that an implementation should uses 
>ACL
> channels: "The Advanced Audio Distribution Profile (A2DP) defines the
> protocols and procedures that realize distribution of audio content 
>of
> high-quality in mono or stereo on ACL channels (Introduction of 
>Advanced
> Audio Distribution Profile Specification)" So I'd like to develop an
> implementation using ACL channels instead of SCO channels.
>
> I'd like to know if you're interested in include this implementation 
in
> the BlueZ stack too.
> Thanks.
>
>
> Javier.
>
  >Javier,
  >I think that you did not read the page bluetooth-alsa.sf.net 
>completely.
>Both SCO and ACL implementations have been done.
>Maybe you can add some new feature to the existing A2DP. (a2play or
>pcm_a2dp).
>I think support for the mp3 codec (making a choice at run time between 
>SBC
>and MP3 codec) could be handy.
>Also, the A2DP spec mentions briefly about RTP. Nobody has looked into 
>that
>till now.
  >Regards
>Mayank
  >
>
  >
  >it may not be all that clear but the project has two parts, sco and 
>a2dp.
  >an a2dp stream can be sent to a stereo headset using the application
>a2play. there are also some test apps for avrcp in av*.c in case that's
>interesting to you.
  >brad
   
  Hi
   
  Thank you very much for your comments. I was wrong. I've already seen the A2DP's implementation over ACL channels in the page bluetooth-alsa.sf.net.
   
  On the other hand, I'd like to know if you had studied the Video Distribution Profile (VDP). At first, my objetives were to develop the A2DP or, if it was already implemented, the VDP. Therefore, I'm interested in knowing if you have implemented something similar to a2play for A2DP.
   
  Regards.
  Javier
   

		
---------------------------------

LLama Gratis a cualquier PC del Mundo.
Llamadas a fijos y móviles desde 1 céntimo por minuto.
http://es.voice.yahoo.com
--0-4835542-1147273990=:26862
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<div>&gt;Hi,<BR>&gt; I've visited bluetooth-alsa.sf.net and the project is very <BR>&gt;interesting bu=<BR>&gt;t<BR>&gt; I think that the profile's implementation is based on SCO channels. <BR>&gt;If I'=<BR>&gt;m<BR>&gt; making a mistake I apologize for it. On the other hand, I've read the <BR>&gt;A2D=<BR>&gt;P<BR>&gt; profile specification and I think that an implementation should uses <BR>&gt;ACL<BR>&gt; channels: "The Advanced Audio Distribution Profile (A2DP) defines the<BR>&gt; protocols and procedures that realize distribution of audio content <BR>&gt;of<BR>&gt; high-quality in mono or stereo on ACL channels (Introduction of <BR>&gt;Advanced<BR>&gt; Audio Distribution Profile Specification)" So I'd like to develop an<BR>&gt; implementation using ACL channels instead of SCO channels.<BR>&gt;<BR>&gt; I'd like to know if you're interested in include this implementation <BR>in<BR>&gt; the BlueZ stack too.<BR>&gt; Thanks.<BR>&gt;<BR>&gt;<BR>&gt; Javier.<BR>&gt;</div> 
 <div>&gt;Javier,</div>  <div>&gt;I think that you did not read the page bluetooth-alsa.sf.net <BR>&gt;completely.<BR>&gt;Both SCO and ACL implementations have been done.<BR>&gt;Maybe you can add some new feature to the existing A2DP. (a2play or<BR>&gt;pcm_a2dp).<BR>&gt;I think support for the mp3 codec (making a choice at run time between <BR>&gt;SBC<BR>&gt;and MP3 codec) could be handy.<BR>&gt;Also, the A2DP spec mentions briefly about RTP. Nobody has looked into <BR>&gt;that<BR>&gt;till now.</div>  <div>&gt;Regards<BR>&gt;Mayank</div>  <div>&gt;<BR>&gt;</div>  <div>&gt;</div>  <div>&gt;it may not be all that clear but the project has two parts, sco and <BR>&gt;a2dp.</div>  <div>&gt;an a2dp stream can be sent to a stereo headset using the application<BR>&gt;a2play. there are also some test apps for avrcp in av*.c in case that's<BR>&gt;interesting to you.</div>  <div>&gt;brad</div>  <div>&nbsp;</div>  <div>Hi</div>  <div>&nbsp;</div>  <div>Thank you very much for your
 comments. I was&nbsp;wrong. I've already seen the A2DP's implementation over ACL&nbsp;channels in&nbsp;the page bluetooth-alsa.sf.net.</div>  <div>&nbsp;</div>  <div>On the other hand, I'd like to know if you had studied the Video Distribution Profile (VDP). At first, my objetives were to develop the A2DP or, if it&nbsp;was already implemented, the&nbsp;VDP. Therefore, I'm interested&nbsp;in knowing if you have&nbsp;implemented something similar to a2play for A2DP.</div>  <div>&nbsp;</div>  <div>Regards.</div>  <div>Javier</div>  <div>&nbsp;</div><p>
		<hr size=1><br><font face="Verdana" size="-2">LLama Gratis a cualquier PC del Mundo.<br>Llamadas a fijos y móviles desde 1 céntimo por minuto.<br><a href="http://us.rd.yahoo.com/mail/es/tagline/messenger/*http://es.voice.yahoo.com/">http://es.voice.yahoo.com</a></font>
--0-4835542-1147273990=:26862--


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
