Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Sat, 16 Jun 2007 19:28:15 -0700 (PDT)
From: walt shekrota <penguinacity@yahoo.com>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <d89ddf300706161742w51422da1k49416bee58e2833c@mail.gmail.com>
MIME-Version: 1.0
Message-ID: <846060.92220.qm@web62302.mail.re1.yahoo.com>
Subject: Re: [Bluez-users] bluez/alsa modules vs kernel
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1822840197=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1822840197==
Content-Type: multipart/alternative; boundary="0-1361746517-1182047295=:92220"
Content-Transfer-Encoding: 8bit

--0-1361746517-1182047295=:92220
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

yeah I see choose a new name I get the picture.
 
 Would be nice to include some rough dates there to be a history so we can get an idea of flow.
 so when was plugz started and what are the goals?
 Since plugz is not in the gentoo portage tree yet from what I can see I assume it to be VERY young. Also the powers that correlate these packages for release are very wary of security and design issues these days and seem looking for reasons to exclude.
 
 So on the new package hows the doc etc?
 
 Thanks
 -Walt
 
 Brad Midgley <bmidgley@gmail.com> wrote: a lot of this is covered in http://bluetooth-alsa.sourceforge.net/history.html

On 6/16/07,  walt shekrota <penguinacity@yahoo.com> wrote:Ok maybe this more appropriately describes my concern. I am using btsco. Why can't the code just use the alsa driver why must there be a headset component driver? ie I change the driver in skype to headset not alsa for my sound card. 
 In my mind if that were the case it would always be a kernel component interfaced with that doesn't break in every release.
 
 Thanks for any info.
 -Walt
 
Brad Midgley < bmidgley@gmail.com> wrote:  walt


 Isn't there an alsa interface that can be used without patching?  
 ie Do all applications that use alsa when it's in the kernel, patch?


I'm not sure what you're asking. Have you tried out  plugz are you only talking about btsco? Also which headset are you working with? 

There is a recommended kernel patch regardless of which approach you use for voice headsets. See plugz/patches for the sco-flowcontrol patch. 

Brad

 -------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take 
control of your XML. No limits. Just data. Click to get it now.
 http://sourceforge.net/powerbar/db2/_______________________________________________
Bluez-users mailing list
 Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users 

        

---------------------------------
Shape Yahoo! in your own image.   Join our Network Research Panel today! 

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
Sick sense of humor? Visit Yahoo! TV's Comedy with an Edge to see what's on, when. 
--0-1361746517-1182047295=:92220
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

yeah I see choose a new name I get the picture.<br> <br> Would be nice to include some rough dates there to be a history so we can get an idea of flow.<br> so when was plugz started and what are the goals?<br> Since plugz is not in the gentoo portage tree yet from what I can see I assume it to be VERY young. Also the powers that correlate these packages for release are very wary of security and design issues these days and seem looking for reasons to exclude.<br> <br> So on the new package hows the doc etc?<br> <br> Thanks<br> -Walt<br> <br> <b><i>Brad Midgley &lt;bmidgley@gmail.com&gt;</i></b> wrote:<blockquote class="replbq" style="border-left: 2px solid rgb(16, 16, 255); margin-left: 5px; padding-left: 5px;"> a lot of this is covered in <a href="http://bluetooth-alsa.sourceforge.net/history.html">http://bluetooth-alsa.sourceforge.net/history.html</a><br><br><div><span class="gmail_quote">On 6/16/07, <b class="gmail_sendername"> walt shekrota</b> &lt;<a
 href="mailto:penguinacity@yahoo.com">penguinacity@yahoo.com</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Ok maybe this more appropriately describes my concern. I am using btsco. Why can't the code just use the alsa driver why must there be a headset component driver? ie I change the driver in skype to headset not alsa for my sound card. <br> In my mind if that were the case it would always be a kernel component interfaced with that doesn't break in every release.<br> <br> Thanks for any info.<span class="q"><br> -Walt<br> <br><b><i>Brad Midgley &lt;<a href="mailto:bmidgley@gmail.com" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)"> bmidgley@gmail.com</a>&gt;</i></b> wrote:</span><blockquote style="border-left: 2px solid rgb(16, 16, 255); margin-left: 5px; padding-left: 5px;"><div><span class="e" id="q_1133617eb28c3186_3"> <b
 class="gmail_sendername"> walt<br><br></b><div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><br> Isn't there an alsa interface that can be used without patching?  <br> ie Do all applications that use alsa when it's in the kernel, patch?</blockquote></div><br><br>I'm not sure what you're asking. Have you tried out  plugz are you only talking about btsco? Also which headset are you working with? <br><br>There is a recommended kernel patch regardless of which approach you use for voice headsets. See plugz/patches for the sco-flowcontrol patch. <br><br>Brad<br></span></div><span class="q"> -------------------------------------------------------------------------<br>This SF.net email is sponsored by DB2 Express<br>Download DB2 Express C - the FREE version of DB2 express and take <br>control of your XML. No limits. Just data. Click to get it now.<br><a
 href="http://sourceforge.net/powerbar/db2/_______________________________________________" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)"> http://sourceforge.net/powerbar/db2/_______________________________________________</a><br>Bluez-users mailing list<br><a href="mailto:Bluez-users@lists.sourceforge.net" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)"> Bluez-users@lists.sourceforge.net</a><br><a href="https://lists.sourceforge.net/lists/listinfo/bluez-users" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">https://lists.sourceforge.net/lists/listinfo/bluez-users </a><br></span></blockquote><span class="ad"><br><div>        </div><hr size="1">Shape Yahoo! in your own image.   <a href="http://us.rd.yahoo.com/evt=48517/*http://surveylink.yahoo.com/gmrs/yahoo_panel_invite.asp?a=7" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">Join our Network Research Panel today!</a>
 <div></div></span><br>-------------------------------------------------------------------------<br>This SF.net email is sponsored by DB2 Express<br>Download DB2 Express C - the FREE version of DB2 express and take<br>control of your XML. No limits. Just data. Click to get it now. <br><a onclick="return top.js.OpenExtLink(window,event,this)" href="http://sourceforge.net/powerbar/db2/" target="_blank">http://sourceforge.net/powerbar/db2/</a><br>_______________________________________________<br>Bluez-users mailing list <br><a onclick="return top.js.OpenExtLink(window,event,this)" href="mailto:Bluez-users@lists.sourceforge.net">Bluez-users@lists.sourceforge.net</a><br><a onclick="return top.js.OpenExtLink(window,event,this)" href="https://lists.sourceforge.net/lists/listinfo/bluez-users" target="_blank"> https://lists.sourceforge.net/lists/listinfo/bluez-users</a><br><br></blockquote></div><br> -------------------------------------------------------------------------<br>This
 SF.net email is sponsored by DB2 Express<br>Download DB2 Express C - the FREE version of DB2 express and take<br>control of your XML. No limits. Just data. Click to get it now.<br>http://sourceforge.net/powerbar/db2/_______________________________________________<br>Bluez-users mailing list<br>Bluez-users@lists.sourceforge.net<br>https://lists.sourceforge.net/lists/listinfo/bluez-users<br></blockquote><br><p>&#32;
      <hr size=1>Sick sense of humor? Visit Yahoo! TV's 
<a href="http://us.rd.yahoo.com/evt=47093/*http://tv.yahoo.com/collections/222">Comedy with an Edge </a>to see what's on, when. 



--0-1361746517-1182047295=:92220--


--===============1822840197==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============1822840197==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1822840197==--
