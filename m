Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <685df2130710290924m65b5d4ccr2cb86c1570f063d8@mail.gmail.com>
Date: Mon, 29 Oct 2007 12:24:37 -0400
From: "Joshua Bryant" <josh@bryantweb.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Subject: Re: [Bluez-devel] Audio service with multiple adapters
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1486986545=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============1486986545==
Content-Type: multipart/alternative;
	boundary="----=_Part_4545_8632427.1193675077187"

------=_Part_4545_8632427.1193675077187
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I would like to call the 'CreateHeadset' method and associate the headset
with a non-default adapter.

I am able to bond a headset to a non-default adapter with by referencing
"/org/bluez/hci1" in the object path of the Adapter.CreateBonding method.

However the 'CreateHeadset' method does not reference an adapter. It seems
to associate the headset with the default adapter. I would like to associate
headset A with the default adapter and headset B with a non-default adapter.


Is there a way to associate a headset with a non-default adapter in a
'CreateHeadset' call?


Date: Fri, 26 Oct 2007 00:45:31 +0200
> From: Marcel Holtmann <marcel@holtmann.org>
> Subject: Re: [Bluez-devel] Audio service with multiple adapters
> To: BlueZ development < bluez-devel@lists.sourceforge.net>
> Message-ID: <1193352331.6184.284.camel@violet>
> Content-Type: text/plain
>
> Hi Joshua,
>
> > I am using BlueZ for a project and it is working well. I have a
> > question concerning multiple adapters.
> >
> > I am able to connect my headset to the default adapter through the
> > audio service. However I cannot connect a headset to a second adapter
> > (hci1) through the audio service. I can bond my headset to the second
> > adapter, but I cannot create a sco connection.
> >
> > Is it possible to start the audio service on the non-default adapter
> > (hci1)?
> > Is it possible to run the audio service for both adapters? I would
> > like to have 2 adapters each supporting a separate headset.
>
> the audio service can used with any attached adapter. It is designed to
> deal with them. However having two SCO channels open at the same time
> might be limited by your hardware.
>
> Regards
>
> Marcel
>

------=_Part_4545_8632427.1193675077187
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I would like to call the &#39;CreateHeadset&#39; method and associate the headset with a non-default adapter.<br><br>I am able to bond a headset to a non-default adapter with by referencing &quot;/org/bluez/hci1&quot; in the object path of the 
Adapter.CreateBonding method. <br><br>However
the &#39;CreateHeadset&#39; method does not reference an adapter. It seems
to associate the headset with the default adapter. I would like to
associate headset A with the default adapter and headset B with a
non-default adapter.
<br><br>Is there a way to associate a headset with a non-default adapter in a &#39;CreateHeadset&#39; call?<br><br><div><span class="gmail_quote"><br></span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">

Date: Fri, 26 Oct 2007 00:45:31 +0200<br>From: Marcel Holtmann &lt;<a href="mailto:marcel@holtmann.org" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">marcel@holtmann.org</a>&gt;<br>Subject: Re: [Bluez-devel] Audio service with multiple adapters
<br>To: BlueZ development &lt;
<a href="mailto:bluez-devel@lists.sourceforge.net" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">bluez-devel@lists.sourceforge.net</a>&gt;<br>Message-ID: &lt;1193352331.6184.284.camel@violet&gt;<br>
Content-Type: text/plain<br><br>Hi Joshua,<br><br>&gt; I am using BlueZ for a project and it is working well. I have a
<br>&gt; question concerning multiple adapters.<br>&gt;<br>&gt; I am able to connect my headset to the default adapter through the<br>&gt; audio service. However I cannot connect a headset to a second adapter<br>&gt; (hci1) through the audio service. I can bond my headset to the second
<br>&gt; adapter, but I cannot create a sco connection.<br>&gt;<br>&gt; Is it possible to start the audio service on the non-default adapter<br>&gt; (hci1)?<br>&gt; Is it possible to run the audio service for both adapters? I would
<br>&gt; like to have 2 adapters each supporting a separate headset.<br><br>the audio service can used with any attached adapter. It is designed to<br>deal with them. However having two SCO channels open at the same time
<br>
might be limited by your hardware.<br><br>Regards<br><br>Marcel<br></blockquote></div><br>

------=_Part_4545_8632427.1193675077187--


--===============1486986545==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
--===============1486986545==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1486986545==--
