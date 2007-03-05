Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <57c68ddc0703050133o71dcf774je4fd4fbf87bbf6b@mail.gmail.com>
Date: Mon, 5 Mar 2007 15:03:33 +0530
From: "siddhant tewari" <siddhant.tewari@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1ab01fb50703010418i4b4738ebya621923466eaaeb6@mail.gmail.com>
MIME-Version: 1.0
References: <57c68ddc0702280731j1470f59bj2f4cba52ecd6229f@mail.gmail.com>
	<1ab01fb50702282041o36bdbf55mfa073858cc9e5c77@mail.gmail.com>
	<57c68ddc0702282140j2561f505uc79584eecb7c60dd@mail.gmail.com>
	<1ab01fb50703010418i4b4738ebya621923466eaaeb6@mail.gmail.com>
Subject: Re: [Bluez-devel] how to create rfcomm channel
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1218608728=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============1218608728==
Content-Type: multipart/alternative;
	boundary="----=_Part_127204_33314560.1173087213853"

------=_Part_127204_33314560.1173087213853
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

hi vikas,
              Thanks for replying and going through my mail. As suggested by
marcel , now i am using rfcomm sockets directly without using virtual tty
layer and till now (fingers crossed) things are working fine. Example code
in rctest.c really helped a lot.

By the way i am sending file using obex_push service by calling pi from open
obex.What i was doing was , through the code i wrote above , i made a device
special file , which i then passed to the obex pi for performing obex push.
Now instead of passing the file path i am passing the rfcomm socket id
directly which is working fine.I hope this is the right way of doing things.

regards
siddhant

On 3/1/07, Vikas Sinha <compuvikas@gmail.com> wrote:
>
> Hi Siddhant,
>
> ur code seems to be fine. I think there are some problem in releasing
> device. Generally Bad File Descriptor comes if socket does not get closed
> properly. Actually rfcomm takes some time to set free device. try to put
> some sleep time in between release and again bind.  Even binding at hci
> layer is longer then rfcomm layer.  But can u tell me how did u send file to
> your handset. or ur testing it with pc to pc.
>
> hcidump will also be useful.
>
> On 3/1/07, siddhant tewari <siddhant.tewari@gmail.com> wrote:
>
> > hi vikas ,
> >             Really great to get i reply from you. I was trying to write
> > a program that can send file to my nokia phone. I was looking for a api that
> > can create a character device which can be passed to ioctl.  To do so what i
> > am doing right now is
> >
> > i)              char cmdBuf[256];
> >                 sprintf(cmdBuf,"mknod %s c 216 %d",tempBuf,dev);
> >                 if (system(cmdBuf) != 0 )
> >                 {
> >                     fprintf(stderr,"\nError in executng mknod\n");
> >                     exit(1);
> >                 }
> >
> > ii) And then
> > err = ioctl(ctl, RFCOMMCREATEDEV, &req);
> >
> > iii) For releasing the device i am doing :-
> > err = ioctl(ctl, RFCOMMRELEASEDEV, &req);
> >
> > These things are working fine for a single run but after 2 run (keeping
> > the above 3 in while(1) block) ;  while releasing the device , ioctl gives
> > error bad file descriptor. Please tell me what i am doing wrong.
> >
> > regards
> > siddhant
> >
> >
> >
> >
> >
> > -------------------------------------------------------------------------
> > Take Surveys. Earn Cash. Influence the Future of IT
> > Join SourceForge.net's Techsay panel and you'll get the chance to share
> > your
> > opinions on IT & business topics through brief surveys-and earn cash
> >
> > http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> > _______________________________________________
> > Bluez-devel mailing list
> > Bluez-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/bluez-devel
> >
> >
>
>
> --
> Impossible
> itself contain
> I M Possible
>
> Vikas
>
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share
> your
> opinions on IT & business topics through brief surveys-and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>
>

------=_Part_127204_33314560.1173087213853
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

hi vikas,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Thanks for replying and going through my mail. As suggested by marcel , now i am using rfcomm sockets directly without using virtual tty layer and till now (fingers crossed) things are working fine. Example code in 
rctest.c really helped a lot.<br><br>By the way i am sending file using obex_push service by calling pi from open obex.What i was doing was , through the code i wrote above , i made a device special file , which i then passed to the obex pi for performing obex push. Now instead of passing the file path i am passing the rfcomm socket id directly which is working 
fine.I hope this is the right way of doing things.<br><br>regards<br>siddhant<br><br><div><span class="gmail_quote">On 3/1/07, <b class="gmail_sendername">Vikas Sinha</b> &lt;<a href="mailto:compuvikas@gmail.com">compuvikas@gmail.com
</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Hi Siddhant,<br>
<br>
ur code seems to be fine. I think there are some problem in releasing
device. Generally Bad File Descriptor comes if socket does not get
closed properly. Actually rfcomm takes some time to set free device.
try to put some sleep time in between release and again bind.&nbsp;
Even binding at hci layer is longer then rfcomm layer.&nbsp; But can u
tell me how did u send file to your handset. or ur testing it with pc
to pc.<br>
<br>
hcidump will also be useful.<br><br><div><div><span class="e" id="q_1110d6fe0493cab5_1"><span class="gmail_quote">On 3/1/07, <b class="gmail_sendername">siddhant tewari</b> &lt;<a href="mailto:siddhant.tewari@gmail.com" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">
siddhant.tewari@gmail.com</a>&gt; wrote:</span>
</span></div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div><span class="e" id="q_1110d6fe0493cab5_3">hi vikas ,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Really great to get i reply from you. I was trying to write a program
that can send file to my nokia phone. I was looking for a api that can
create a character device which can be passed to ioctl.&nbsp; To do so
what i am doing right now is <br><br>i) &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char cmdBuf[256];<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
sprintf(cmdBuf,&quot;mknod %s c 216 %d&quot;,tempBuf,dev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (system(cmdBuf) != 0 )<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
fprintf(stderr,&quot;\nError in executng mknod\n&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; exit(1);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br><br>ii) And then <br>err = ioctl(ctl, RFCOMMCREATEDEV, &amp;req);<br><br>iii) For releasing the device i am doing :-<br>err = ioctl(ctl, RFCOMMRELEASEDEV, &amp;req);<br><br>These
things are working fine for a single run but after 2 run (keeping the
above 3 in while(1) block) ;&nbsp; while releasing the device , ioctl
gives error bad file descriptor. Please tell me what i am doing wrong.
<br><br>regards<br><span>siddhant <br><br><br><br>
</span><br></span></div><span class="q">-------------------------------------------------------------------------<br>Take Surveys. Earn Cash. Influence the Future of IT<br>Join SourceForge.net&#39;s Techsay panel and you&#39;ll get the chance to share your
<br>opinions on IT &amp; business topics through brief surveys-and earn cash<br><a href="http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">

http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV</a><br>_______________________________________________<br>Bluez-devel mailing list<br><a href="mailto:Bluez-devel@lists.sourceforge.net" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">

Bluez-devel@lists.sourceforge.net</a><br><a href="https://lists.sourceforge.net/lists/listinfo/bluez-devel" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">https://lists.sourceforge.net/lists/listinfo/bluez-devel
</a><br><br></span></blockquote></div><div><span class="e" id="q_1110d6fe0493cab5_6"><br><br clear="all"><br>-- <br>Impossible <br>itself contain <br>I M Possible<br><br>Vikas
</span></div><br>-------------------------------------------------------------------------<br>Take Surveys. Earn Cash. Influence the Future of IT<br>Join SourceForge.net&#39;s Techsay panel and you&#39;ll get the chance to share your
<br>opinions on IT &amp; business topics through brief surveys-and earn cash<br><a onclick="return top.js.OpenExtLink(window,event,this)" href="http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV" target="_blank">
http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV</a><br>_______________________________________________<br>Bluez-devel mailing list<br><a onclick="return top.js.OpenExtLink(window,event,this)" href="mailto:Bluez-devel@lists.sourceforge.net">
Bluez-devel@lists.sourceforge.net</a><br><a onclick="return top.js.OpenExtLink(window,event,this)" href="https://lists.sourceforge.net/lists/listinfo/bluez-devel" target="_blank">https://lists.sourceforge.net/lists/listinfo/bluez-devel
</a><br><br></blockquote></div><br>

------=_Part_127204_33314560.1173087213853--


--===============1218608728==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1218608728==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1218608728==--
