Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Sun, 24 Jun 2007 17:00:02 -0700 (PDT)
From: walt shekrota <penguinacity@yahoo.com>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <d89ddf300706241509ica52867i7dd013150b3c2042@mail.gmail.com>
MIME-Version: 1.0
Message-ID: <198178.17599.qm@web62306.mail.re1.yahoo.com>
Subject: Re: [Bluez-users] plugz install still not right
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1472620504=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1472620504==
Content-Type: multipart/alternative; boundary="0-300743213-1182729602=:17599"
Content-Transfer-Encoding: 8bit

--0-300743213-1182729602=:17599
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

I get no headset entry in xmms or skype.
 So I must have something wrong. But headset pairs and is ready.
 I did not see any errors in compiles and either the headsetd or a2dpd runs seemingly.
 -Walt

Brad Midgley <bmidgley@gmail.com> wrote: https://developer.skype.com/jira/browse/SCL-7 has some info. I think Robert was making headset the default alsa device to get around the problem skype (and most alsa apps) have with selecting the plugin device. 

On 6/24/07, walt shekrota <penguinacity@yahoo.com> wrote: Ok I'm missing something here.
 
 I followed the directions at 
 http://bluetooth-alsa.sourceforge.net/build.html 
 so I have all the packages called for 
 built sbc and plugz
 
 I have a patched 2.6.21.5 kernel on my kubuntu  6.06 with your most recent diff from
 http://bluetooth-alsa.cvs.sourceforge.net/bluetooth-alsa/plugz/patches/ 
 headsetd was started and is running.
 I fire up skype and options does not show a headset entry for sound device.
 the .asoundrc was modified as suggested.
 
 Isolation tactics you might have?
 
  Thanks for any help.
 -Walt
         

---------------------------------
Sick sense of humor? Visit Yahoo! TV's  Comedy with an Edge to see what's on, when.    

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now. 
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-users mailing list 
Bluez-users@lists.sourceforge.net
 https://lists.sourceforge.net/lists/listinfo/bluez-users



 -------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users


       
---------------------------------
Luggage? GPS? Comic books? 
Check out fitting  gifts for grads at Yahoo! Search.
       
---------------------------------
Fussy? Opinionated? Impossible to please? Perfect.  Join Yahoo!'s user panel and lay it on us.
--0-300743213-1182729602=:17599
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

I get no headset entry in xmms or skype.<br> So I must have something wrong. But headset pairs and is ready.<br> I did not see any errors in compiles and either the headsetd or a2dpd runs seemingly.<br> -Walt<br><br><b><i>Brad Midgley &lt;bmidgley@gmail.com&gt;</i></b> wrote:<blockquote class="replbq" style="border-left: 2px solid rgb(16, 16, 255); margin-left: 5px; padding-left: 5px;"> <a href="https://developer.skype.com/jira/browse/SCL-7">https://developer.skype.com/jira/browse/SCL-7</a> has some info. I think Robert was making headset the default alsa device to get around the problem skype (and most alsa apps) have with selecting the plugin device. <br><br><div><span class="gmail_quote">On 6/24/07, <b class="gmail_sendername">walt shekrota</b> &lt;<a href="mailto:penguinacity@yahoo.com">penguinacity@yahoo.com</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"> Ok I'm
 missing something here.<br> <br> I followed the directions at <br> <a href="http://bluetooth-alsa.sourceforge.net/build.html" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">http://bluetooth-alsa.sourceforge.net/build.html </a><br> so I have all the packages called for <br> built sbc and plugz<br> <br> I have a patched <a href="http://2.6.21.5" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">2.6.21.5</a> kernel on my kubuntu  6.06 with your most recent diff from<br> <a href="http://bluetooth-alsa.cvs.sourceforge.net/bluetooth-alsa/plugz/patches/" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">http://bluetooth-alsa.cvs.sourceforge.net/bluetooth-alsa/plugz/patches/ </a><br> headsetd was started and is running.<br> I fire up skype and options does not show a headset entry for sound device.<br> the .asoundrc was modified as suggested.<br> <br> Isolation tactics you might have?<br> <br>  Thanks for any
 help.<br><span class="sg"> -Walt<br></span><span class="ad"> <div>        </div><hr size="1">Sick sense of humor? Visit Yahoo! TV's  <a href="http://us.rd.yahoo.com/evt=47093/*http://tv.yahoo.com/collections/222" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">Comedy with an Edge </a>to see what's on, when.    <div></div></span><br>-------------------------------------------------------------------------<br>This SF.net email is sponsored by DB2 Express<br>Download DB2 Express C - the FREE version of DB2 express and take<br>control of your XML. No limits. Just data. Click to get it now. <br><a onclick="return top.js.OpenExtLink(window,event,this)" href="http://sourceforge.net/powerbar/db2/" target="_blank">http://sourceforge.net/powerbar/db2/</a><br>_______________________________________________<br>Bluez-users mailing list <br><a onclick="return top.js.OpenExtLink(window,event,this)"
 href="mailto:Bluez-users@lists.sourceforge.net">Bluez-users@lists.sourceforge.net</a><br><a onclick="return top.js.OpenExtLink(window,event,this)" href="https://lists.sourceforge.net/lists/listinfo/bluez-users" target="_blank"> https://lists.sourceforge.net/lists/listinfo/bluez-users</a><br><br></blockquote></div><br> -------------------------------------------------------------------------<br>This SF.net email is sponsored by DB2 Express<br>Download DB2 Express C - the FREE version of DB2 express and take<br>control of your XML. No limits. Just data. Click to get it now.<br>http://sourceforge.net/powerbar/db2/_______________________________________________<br>Bluez-users mailing list<br>Bluez-users@lists.sourceforge.net<br>https://lists.sourceforge.net/lists/listinfo/bluez-users<br></blockquote><br><p> 
      <hr size=1>Luggage? GPS? Comic books? <br>
Check out fitting <a href="http://us.rd.yahoo.com/evt=48249/*http://search.yahoo.com/search?fr=oni_on_mail&p=graduation+gifts&cs=bz"> gifts for grads</a> at Yahoo! Search.<p>&#32;
      <hr size=1>Fussy? Opinionated? Impossible to please? Perfect.  <a href="http://us.rd.yahoo.com/evt=48516/*http://surveylink.yahoo.com/gmrs/yahoo_panel_invite.asp?a=7 ">Join Yahoo!'s user panel</a> and lay it on us.

--0-300743213-1182729602=:17599--


--===============1472620504==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============1472620504==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1472620504==--
