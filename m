Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <1ab01fb50706040628x9d1ac47xac985b34d8f742e6@mail.gmail.com>
Date: Mon, 4 Jun 2007 18:58:06 +0530
From: "Vikas Sinha" <compuvikas@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20070601163447.0c678f57@localhost.localdomain>
MIME-Version: 1.0
References: <loom.20061226T054340-711@post.gmane.org>
	<20070601163447.0c678f57@localhost.localdomain>
Subject: Re: [Bluez-devel] hci inquiry error with name scan
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1666744605=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============1666744605==
Content-Type: multipart/alternative;
	boundary="----=_Part_2731_4695169.1180963686835"

------=_Part_2731_4695169.1180963686835
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Thanks Andreas,
I am waiting for ur patch. If there anything I can do please tell me. I took
other way to overcome this problem. I have allocated MAX space for array of
inquery structure (i.e. 256) and then doing inquiry and making it memset
zero after using its result.  I think ur right .



On 6/1/07, Andreas Gaufer <Andreas.Gaufer@bluecellnetworks.com> wrote:
>
> Hi Avaited,
>
> i believe this is a bug in hci.c in the bluez-libs package. It returns
> wrong names if multiple hci_read_remote_name calls are done in a short
> period of time.
>
> hci_send_req which is used by hci_read_remote_name returns data of the
> first EVT_REMOTE_NAME_REQ_COMPLETE that occurs on the device even if it
> does not match the bdaddres that was requested.
>
> This problem was also already noticed by Sjoerd Simons in June 2004 and
> sent to this list with the subject "btaddr <-> name bug ?" (1)
>
> I prepared a patch that should fix that problem. I will provide that
> patch on this list as soon as I'm finished with stress-testing it.
>
> Greetings
>
> Andy
>
>
> 1) http://thread.gmane.org/gmane.linux.bluez.devel/2489/focus=2491
>
>
> On Tue, 26 Dec 2006 04:47:47 +0000 (UTC)
> Avaited <compuvikas@gmail.com> wrote:
>
> > hi all
> >
> > I am facing a big problem with hci layer process. I have developed a
> platform
> > and http wraper for bluetooth services using bluez.  I am searching all
> device
> > present in vicinity by using hci.c function 'hci_scan()'. later for each
> > number(BDADDR) i am searching its name by hci_read_remote_name(). Most
> of the
> > time I am getting right name(i.e. what ever name i am giving to my
> devices ) But
> > some time name get swaped with some one. Lisk in my case my mobile name
> was
> > SHARK and my Machine name was VIKAS [0], VIKAS[1], my friends mobile was
> GOLD,
> > SILVER. but when I had done scan name it returned me my mobile,s name as
> > VIKAS[1]. I am surprise why this happened.
> >
> > Is there any problem with present bluez stack I am using
> > bluez-bluefw-1.0-6
> > bluez-pin-0.23-3
> > bluez-hcidump-1.11-1
> > bluez-libs-2.10-2
> > bluez-utils-2.10-2.1
> > on redhat 4.0 Enterprise Edition
> > with kernel 2.6.9-5.EL i386
> > int getScanName(bdaddr_t *device_bt,char * device_name,bdaddr_t
> *dongle_bt)
> > {
> >         if((s = GetScanSock(dongle_bt)) < 0)    // this will connect to
> local dongle
> >         {
> >                 ERR_LOG(ERR,"Unable to open socket");
> >                 return -s;
> >         }
> >         if(hci_read_remote_name(s,
> device_bt,sizeof(device_name),device_name,0) < 0)
> >         {
> >                 ERR_LOG(DBG,"No Name found");
> >                 close(s);
> >                 return -NOTFOUND;
> >         }
> >         ERR_LOG(DBG,"Name of Device hci scan  [%s] DeviceBT
> > [%s]",device_name,device_bt);
> >         close(s);
> >         return 0;
> > }
> > this function get called for each device found in scan.
> >
> >
> > I am in deep trouble to know what is problem with this.
> >
> > Please help
> >
> >
> >
> -------------------------------------------------------------------------
> > Take Surveys. Earn Cash. Influence the Future of IT
> > Join SourceForge.net's Techsay panel and you'll get the chance to share
> your
> > opinions on IT & business topics through brief surveys - and earn cash
> >
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> > _______________________________________________
> > Bluez-devel mailing list
> > Bluez-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/bluez-devel
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
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>



-- 
Impossible
itself contain
I M Possible

Vikas

------=_Part_2731_4695169.1180963686835
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Thanks <span class="gmail_quote"><span class="gmail_sendername">Andreas,<br>
I am waiting for ur patch. If there anything I can do please tell me. I
took other way to overcome this problem. I have allocated MAX space for
array of inquery structure (i.e. 256) and then doing inquiry and making
it memset zero after using its result.&nbsp; I think ur right . <br>
<br>
<br>
</span></span><br><div><span class="gmail_quote">On 6/1/07, <b class="gmail_sendername">Andreas Gaufer</b> &lt;<a href="mailto:Andreas.Gaufer@bluecellnetworks.com">Andreas.Gaufer@bluecellnetworks.com</a>&gt; wrote:</span>
<blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Hi Avaited,<br><br>i believe this is a bug in hci.c in the bluez-libs package. It returns<br>
wrong names if multiple hci_read_remote_name calls are done in a short<br>period of time.<br><br>hci_send_req which is used by hci_read_remote_name returns data of the<br>first EVT_REMOTE_NAME_REQ_COMPLETE that occurs on the device even if it
<br>does not match the bdaddres that was requested.<br><br>This problem was also already noticed by Sjoerd Simons in June 2004 and<br>sent to this list with the subject &quot;btaddr &lt;-&gt; name bug ?&quot; (1)<br><br>I prepared a patch that should fix that problem. I will provide that
<br>patch on this list as soon as I&#39;m finished with stress-testing it.<br><br>Greetings<br><br>Andy<br><br><br>1) <a href="http://thread.gmane.org/gmane.linux.bluez.devel/2489/focus=2491">http://thread.gmane.org/gmane.linux.bluez.devel/2489/focus=2491
</a><br><br><br>On Tue, 26 Dec 2006 04:47:47 +0000 (UTC)<br>Avaited &lt;<a href="mailto:compuvikas@gmail.com">compuvikas@gmail.com</a>&gt; wrote:<br><br>&gt; hi all<br>&gt;<br>&gt; I am facing a big problem with hci layer process. I have developed a platform
<br>&gt; and http wraper for bluetooth services using bluez.&nbsp;&nbsp;I am searching all device<br>&gt; present in vicinity by using hci.c function &#39;hci_scan()&#39;. later for each<br>&gt; number(BDADDR) i am searching its name by hci_read_remote_name(). Most of the
<br>&gt; time I am getting right name(i.e. what ever name i am giving to my devices ) But<br>&gt; some time name get swaped with some one. Lisk in my case my mobile name was<br>&gt; SHARK and my Machine name was VIKAS [0], VIKAS[1], my friends mobile was GOLD,
<br>&gt; SILVER. but when I had done scan name it returned me my mobile,s name as<br>&gt; VIKAS[1]. I am surprise why this happened.<br>&gt;<br>&gt; Is there any problem with present bluez stack I am using<br>&gt; bluez-bluefw-1.0-6
<br>&gt; bluez-pin-0.23-3<br>&gt; bluez-hcidump-1.11-1<br>&gt; bluez-libs-2.10-2<br>&gt; bluez-utils-2.10-2.1<br>&gt; on redhat 4.0 Enterprise Edition<br>&gt; with kernel 2.6.9-5.EL i386<br>&gt; int getScanName(bdaddr_t *device_bt,char * device_name,bdaddr_t *dongle_bt)
<br>&gt; {<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
if((s = GetScanSock(dongle_bt)) &lt; 0)&nbsp;&nbsp;&nbsp;&nbsp;// this
will connect to local dongle<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
ERR_LOG(ERR,&quot;Unable to open socket&quot;);<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -s;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if(hci_read_remote_name(s, device_bt,sizeof(device_name),device_name,0) &lt; 0)<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
ERR_LOG(DBG,&quot;No Name found&quot;);<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; close(s);<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -NOTFOUND;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ERR_LOG(DBG,&quot;Name of Device hci scan&nbsp;&nbsp;[%s] DeviceBT<br>&gt; [%s]&quot;,device_name,device_bt);
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; close(s);<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>&gt; }<br>&gt; this function get called for each device found in scan.<br>&gt;<br>&gt;<br>&gt; I am in deep trouble to know what is problem with this.<br>&gt;<br>&gt; Please help
<br>&gt;<br>&gt;<br>&gt; -------------------------------------------------------------------------<br>&gt; Take Surveys. Earn Cash. Influence the Future of IT<br>&gt; Join SourceForge.net&#39;s Techsay panel and you&#39;ll get the chance to share your
<br>&gt; opinions on IT &amp; business topics through brief surveys - and earn cash<br>&gt; <a href="http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV">http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV
</a><br>&gt; _______________________________________________<br>&gt; Bluez-devel mailing list<br>&gt; <a href="mailto:Bluez-devel@lists.sourceforge.net">Bluez-devel@lists.sourceforge.net</a><br>&gt; <a href="https://lists.sourceforge.net/lists/listinfo/bluez-devel">
https://lists.sourceforge.net/lists/listinfo/bluez-devel</a><br><br><br><br><br>-------------------------------------------------------------------------<br>This SF.net email is sponsored by DB2 Express<br>Download DB2 Express C - the FREE version of DB2 express and take
<br>control of your XML. No limits. Just data. Click to get it now.<br><a href="http://sourceforge.net/powerbar/db2/">http://sourceforge.net/powerbar/db2/</a><br>_______________________________________________<br>Bluez-devel mailing list
<br><a href="mailto:Bluez-devel@lists.sourceforge.net">Bluez-devel@lists.sourceforge.net</a><br><a href="https://lists.sourceforge.net/lists/listinfo/bluez-devel">https://lists.sourceforge.net/lists/listinfo/bluez-devel</a>
<br></blockquote></div><br><br clear="all"><br>-- <br>Impossible <br>itself contain <br>I M Possible<br><br>Vikas

------=_Part_2731_4695169.1180963686835--


--===============1666744605==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============1666744605==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1666744605==--
