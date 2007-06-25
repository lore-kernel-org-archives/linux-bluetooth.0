Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Sun, 24 Jun 2007 18:24:43 -0700 (PDT)
From: walt shekrota <penguinacity@yahoo.com>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <20fe625b0706241735x6d58ea54gc68fa3de25589a0e@mail.gmail.com>
MIME-Version: 1.0
Message-ID: <943279.40483.qm@web62314.mail.re1.yahoo.com>
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
Content-Type: multipart/mixed; boundary="===============0030880535=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0030880535==
Content-Type: multipart/alternative; boundary="0-228301602-1182734683=:40483"
Content-Transfer-Encoding: 8bit

--0-228301602-1182734683=:40483
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

ok I don't have any video players due to their propriety in distributions.
 But this gave me the idea to put a2dpd in the device option of xmms. I get the following output  with debug set in a2dpd. I get nothing when it is unset. (which I would expect) I get absolutely no sound in the paired headset.
 
 A2DPD[21:18:47.158]: stream_client_state_streamingsetup: PLAYBACK thread client_index=0, socket=10, id=0 started (44100 Hz, 2 channels, 16 bits, ring 65536, threshold 65536)
 A2DPD[21:19:00.317]: stream_client_send_pointer_resp: (errno=32:Broken pipe)Error while sending data
 A2DPD[21:19:00.318]: disconnect_client:
 I assume the broken pipe happens when I stop xmms?
 
 Thanks.
 -Walt

Pshem Kowalczyk <pshem.k@gmail.com> wrote: Hi,

I have exactly the same problem. But if I use mplayer with -ao
alsa:device=a2dpd it plays fine.

regards
Pshem

On 25/06/07, walt shekrota 
 wrote:
> I get no headset entry in xmms or skype.
>  So I must have something wrong. But headset pairs and is ready.
>  I did not see any errors in compiles and either the headsetd or a2dpd runs
> seemingly.
>  -Walt
>
> Brad Midgley  wrote:
>  https://developer.skype.com/jira/browse/SCL-7 has some
> info. I think Robert was making headset the default alsa device to get
> around the problem skype (and most alsa apps) have with selecting the plugin
> device.
>
> On 6/24/07, walt shekrota 
 wrote:
> > Ok I'm missing something here.
> >
> > I followed the directions at
> > http://bluetooth-alsa.sourceforge.net/build.html
> > so I have all the packages called for
> > built sbc and plugz
> >
> > I have a patched 2.6.21.5 kernel on my kubuntu 6.06 with your most recent
> diff from
> >
> http://bluetooth-alsa.cvs.sourceforge.net/bluetooth-alsa/plugz/patches/
> > headsetd was started and is running.
> > I fire up skype and options does not show a headset entry for sound
> device.
> > the .asoundrc was modified as suggested.
> >
> > Isolation tactics you might have?
> >
> > Thanks for any help.
> > -Walt
> >
> > ________________________________
> Sick sense of humor? Visit Yahoo! TV's Comedy with an Edge to see what's on,
> when.
> >
> >
> -------------------------------------------------------------------------
> > This SF.net email is sponsored by DB2 Express
> > Download DB2 Express C - the FREE version of DB2 express and take
> > control of your XML. No limits. Just data. Click to get it now.
> > http://sourceforge.net/powerbar/db2/
> > _______________________________________________
> > Bluez-users mailing list
> > Bluez-users@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/bluez-users
> >
> >
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by DB2 Express
> Download DB2 Express C - the FREE version of DB2 express and take
> control of your XML. No limits. Just data. Click to get it now.
> http://sourceforge.net/powerbar/db2/_______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>
>
>
>  ________________________________
> Luggage? GPS? Comic books?
>  Check out fitting gifts for grads at Yahoo! Search.
>
>  ________________________________
> Fussy? Opinionated? Impossible to please? Perfect. Join Yahoo!'s user panel
> and lay it on us.
>
>
>
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by DB2 Express
> Download DB2 Express C - the FREE version of DB2 express and take
> control of your XML. No limits. Just data. Click to get it now.
> http://sourceforge.net/powerbar/db2/
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>
>

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users




       
---------------------------------
Be a better Heartthrob. Get better relationship answers from someone who knows.
Yahoo! Answers - Check it out. 
--0-228301602-1182734683=:40483
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

ok I don't have any video players due to their propriety in distributions.<br> But this gave me the idea to put a2dpd in the device option of xmms. I get the following output&nbsp; with debug set in a2dpd. I get nothing when it is unset. (which I would expect) I get absolutely no sound in the paired headset.<br> <br> A2DPD[21:18:47.158]: stream_client_state_streamingsetup: PLAYBACK thread client_index=0, socket=10, id=0 started (44100 Hz, 2 channels, 16 bits, ring 65536, threshold 65536)<br> A2DPD[21:19:00.317]: stream_client_send_pointer_resp: (errno=32:Broken pipe)Error while sending data<br> A2DPD[21:19:00.318]: disconnect_client:<br> I assume the broken pipe happens when I stop xmms?<br> <br> Thanks.<br> -Walt<br><br><b><i>Pshem Kowalczyk &lt;pshem.k@gmail.com&gt;</i></b> wrote:<blockquote class="replbq" style="border-left: 2px solid rgb(16, 16, 255); margin-left: 5px; padding-left: 5px;"> Hi,<br><br>I have exactly the same problem. But if I use mplayer with
 -ao<br>alsa:device=a2dpd it plays fine.<br><br>regards<br>Pshem<br><br>On 25/06/07, walt shekrota <penguinacity @yahoo.com=""> wrote:<br>&gt; I get no headset entry in xmms or skype.<br>&gt;  So I must have something wrong. But headset pairs and is ready.<br>&gt;  I did not see any errors in compiles and either the headsetd or a2dpd runs<br>&gt; seemingly.<br>&gt;  -Walt<br>&gt;<br>&gt; Brad Midgley <bmidgley @gmail.com=""> wrote:<br>&gt;  https://developer.skype.com/jira/browse/SCL-7 has some<br>&gt; info. I think Robert was making headset the default alsa device to get<br>&gt; around the problem skype (and most alsa apps) have with selecting the plugin<br>&gt; device.<br>&gt;<br>&gt; On 6/24/07, walt shekrota <penguinacity @yahoo.com=""> wrote:<br>&gt; &gt; Ok I'm missing something here.<br>&gt; &gt;<br>&gt; &gt; I followed the directions at<br>&gt; &gt; http://bluetooth-alsa.sourceforge.net/build.html<br>&gt; &gt; so I have all the packages called for<br>&gt; &gt; built
 sbc and plugz<br>&gt; &gt;<br>&gt; &gt; I have a patched 2.6.21.5 kernel on my kubuntu 6.06 with your most recent<br>&gt; diff from<br>&gt; &gt;<br>&gt; http://bluetooth-alsa.cvs.sourceforge.net/bluetooth-alsa/plugz/patches/<br>&gt; &gt; headsetd was started and is running.<br>&gt; &gt; I fire up skype and options does not show a headset entry for sound<br>&gt; device.<br>&gt; &gt; the .asoundrc was modified as suggested.<br>&gt; &gt;<br>&gt; &gt; Isolation tactics you might have?<br>&gt; &gt;<br>&gt; &gt; Thanks for any help.<br>&gt; &gt; -Walt<br>&gt; &gt;<br>&gt; &gt; ________________________________<br>&gt; Sick sense of humor? Visit Yahoo! TV's Comedy with an Edge to see what's on,<br>&gt; when.<br>&gt; &gt;<br>&gt; &gt;<br>&gt; -------------------------------------------------------------------------<br>&gt; &gt; This SF.net email is sponsored by DB2 Express<br>&gt; &gt; Download DB2 Express C - the FREE version of DB2 express and take<br>&gt; &gt; control of your
 XML. No limits. Just data. Click to get it now.<br>&gt; &gt; http://sourceforge.net/powerbar/db2/<br>&gt; &gt; _______________________________________________<br>&gt; &gt; Bluez-users mailing list<br>&gt; &gt; Bluez-users@lists.sourceforge.net<br>&gt; &gt; https://lists.sourceforge.net/lists/listinfo/bluez-users<br>&gt; &gt;<br>&gt; &gt;<br>&gt;<br>&gt; -------------------------------------------------------------------------<br>&gt; This SF.net email is sponsored by DB2 Express<br>&gt; Download DB2 Express C - the FREE version of DB2 express and take<br>&gt; control of your XML. No limits. Just data. Click to get it now.<br>&gt; http://sourceforge.net/powerbar/db2/_______________________________________________<br>&gt; Bluez-users mailing list<br>&gt; Bluez-users@lists.sourceforge.net<br>&gt; https://lists.sourceforge.net/lists/listinfo/bluez-users<br>&gt;<br>&gt;<br>&gt;<br>&gt;  ________________________________<br>&gt; Luggage? GPS? Comic books?<br>&gt;  Check out
 fitting gifts for grads at Yahoo! Search.<br>&gt;<br>&gt;  ________________________________<br>&gt; Fussy? Opinionated? Impossible to please? Perfect. Join Yahoo!'s user panel<br>&gt; and lay it on us.<br>&gt;<br>&gt;<br>&gt;<br>&gt;<br>&gt; -------------------------------------------------------------------------<br>&gt; This SF.net email is sponsored by DB2 Express<br>&gt; Download DB2 Express C - the FREE version of DB2 express and take<br>&gt; control of your XML. No limits. Just data. Click to get it now.<br>&gt; http://sourceforge.net/powerbar/db2/<br>&gt; _______________________________________________<br>&gt; Bluez-users mailing list<br>&gt; Bluez-users@lists.sourceforge.net<br>&gt; https://lists.sourceforge.net/lists/listinfo/bluez-users<br>&gt;<br>&gt;<br><br>-------------------------------------------------------------------------<br>This SF.net email is sponsored by DB2 Express<br>Download DB2 Express C - the FREE version of DB2 express and take<br>control of
 your XML. No limits. Just data. Click to get it now.<br>http://sourceforge.net/powerbar/db2/<br>_______________________________________________<br>Bluez-users mailing list<br>Bluez-users@lists.sourceforge.net<br>https://lists.sourceforge.net/lists/listinfo/bluez-users<br></penguinacity></bmidgley></penguinacity></blockquote><br><p>&#32;
      <hr size=1>Be a better Heartthrob. <a href="http://us.rd.yahoo.com/evt=48255/*http://answers.yahoo.com/dir/_ylc=X3oDMTI5MGx2aThyBF9TAzIxMTU1MDAzNTIEX3MDMzk2NTQ1MTAzBHNlYwNCQUJwaWxsYXJfTklfMzYwBHNsawNQcm9kdWN0X3F1ZXN0aW9uX3BhZ2U-?link=list&sid=396545433">Get better relationship answers </a>from someone who knows.<br>Yahoo! Answers - Check it out. 

--0-228301602-1182734683=:40483--


--===============0030880535==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============0030880535==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0030880535==--
