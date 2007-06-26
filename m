Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Tue, 26 Jun 2007 12:02:12 -0700 (PDT)
From: walt shekrota <penguinacity@yahoo.com>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <d89ddf300706260750o348a869dm9a4e53fd311df1a0@mail.gmail.com>
MIME-Version: 1.0
Message-ID: <150441.79664.qm@web62312.mail.re1.yahoo.com>
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
Content-Type: multipart/mixed; boundary="===============1885609220=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1885609220==
Content-Type: multipart/alternative; boundary="0-196315382-1182884532=:79664"
Content-Transfer-Encoding: 8bit

--0-196315382-1182884532=:79664
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

I think it is a copy and change from within the plugz subdirectory sample..
 it follows here 
 
 pcm.headset {
         @args [BDADDR TIMEOUT] 
         
         # The Bluetooth device address for target headset, used for Audio Gateway (PC) initiated connections
         # Please note that this value is ignored when the connection is Headset initiated
         @args.BDADDR {
                 type string
                  default "00:03:89:F7:A9:78"
         }
 
         # This value represents how long we will try to reach the headset, until we give up.
         # Value is in milliseconds
         @args.TIMEOUT {
                 type integer
                 default 6000
         }
 
         type        sco
         bdaddr      $BDADDR
         timeout     $TIMEOUT
 }
 
 ctl.headset { 
         type sco
 }
 
 # Simplest a2dpd possible
 pcm.a2dpdsimple {
         type a2dpd
 }
 
 Thanks Brad!
 -Walt
 
 Brad Midgley <bmidgley@gmail.com> wrote:  Walt,

Yes, I use 

 headset

in that field for alsa device. It has to match up with an entry in .asoundrc in order to talk to the plugin properly. What does your ~/.asoundrc look like?

Brad
 -------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
 
 

Brad Midgley <bmidgley@gmail.com> wrote: Walt,

Yes, I use 

 headset

in that field for alsa device. It has to match up with an entry in .asoundrc in order to talk to the plugin properly. What does your ~/.asoundrc look like?

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
Yahoo! oneSearch: Finally,  mobile search that gives answers, not web links. 
--0-196315382-1182884532=:79664
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

I think it is a copy and change from within the plugz subdirectory sample..<br> it follows here <br> <br> pcm.headset {<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; @args [BDADDR TIMEOUT] <br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; # The Bluetooth device address for target headset, used for Audio Gateway (PC) initiated connections<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; # Please note that this value is ignored when the connection is Headset initiated<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; @args.BDADDR {<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; type string<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default "00:03:89:F7:A9:78"<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br> <br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; # This value represents how long we will try to reach the headset, until
 we give up.<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; # Value is in milliseconds<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; @args.TIMEOUT {<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; type integer<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default 6000<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br> <br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; type&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sco<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bdaddr&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; $BDADDR<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; timeout&nbsp;&nbsp;&nbsp;&nbsp; $TIMEOUT<br> }<br> <br> ctl.headset { <br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; type sco<br> }<br> <br> # Simplest a2dpd possible<br> pcm.a2dpdsimple {<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; type a2dpd<br> }<br> <br> Thanks Brad!<br> -Walt<br> <br> <b><i>Brad Midgley
 &lt;bmidgley@gmail.com&gt;</i></b> wrote: <blockquote class="replbq" style="border-left: 2px solid rgb(16, 16, 255); margin-left: 5px; padding-left: 5px;"> Walt,<br><br>Yes, I use <br><br>&nbsp;headset<br><br>in that field for alsa device. It has to match up with an entry in .asoundrc in order to talk to the plugin properly. What does your ~/.asoundrc look like?<br><br>Brad<br> -------------------------------------------------------------------------<br>This SF.net email is sponsored by DB2 Express<br>Download DB2 Express C - the FREE version of DB2 express and take<br>control of your XML. No limits. Just data. Click to get it now.<br>http://sourceforge.net/powerbar/db2/_______________________________________________<br>Bluez-users mailing list<br>Bluez-users@lists.sourceforge.net<br>https://lists.sourceforge.net/lists/listinfo/bluez-users<br></blockquote> <br> <br><br><b><i>Brad Midgley &lt;bmidgley@gmail.com&gt;</i></b> wrote:<blockquote class="replbq"
 style="border-left: 2px solid rgb(16, 16, 255); margin-left: 5px; padding-left: 5px;"> Walt,<br><br>Yes, I use <br><br>&nbsp;headset<br><br>in that field for alsa device. It has to match up with an entry in .asoundrc in order to talk to the plugin properly. What does your ~/.asoundrc look like?<br><br>Brad<br> -------------------------------------------------------------------------<br>This SF.net email is sponsored by DB2 Express<br>Download DB2 Express C - the FREE version of DB2 express and take<br>control of your XML. No limits. Just data. Click to get it now.<br>http://sourceforge.net/powerbar/db2/_______________________________________________<br>Bluez-users mailing list<br>Bluez-users@lists.sourceforge.net<br>https://lists.sourceforge.net/lists/listinfo/bluez-users<br></blockquote><br><p>&#32;
      <hr size=1>Yahoo! oneSearch: Finally, <a href="http://us.rd.yahoo.com/evt=48252/*http://mobile.yahoo.com/mobileweb/onesearch?refer=1ONXIC"> mobile search 
that gives answers</a>, not web links. 


--0-196315382-1182884532=:79664--


--===============1885609220==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============1885609220==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1885609220==--
