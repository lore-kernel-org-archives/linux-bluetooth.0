Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <3f5a9ba20609270407p4bcce4f6j99d073b626b916c@mail.gmail.com>
Date: Wed, 27 Sep 2006 19:07:12 +0800
From: "Mingfan.Lu" <lucharse@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1159347649.22162.24.camel@localhost>
MIME-Version: 1.0
References: <3f5a9ba20609252330p3d14854eu7b47acc600c28daf@mail.gmail.com>
	<1159347649.22162.24.camel@localhost>
Subject: Re: [Bluez-devel] Can I search two services at the same time?
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1456962310=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============1456962310==
Content-Type: multipart/alternative;
	boundary="----=_Part_25612_11300399.1159355232094"

------=_Part_25612_11300399.1159355232094
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Thank you for your nice help.
But I think OR LIST is better :)

2006/9/27, Marcel Holtmann <marcel@holtmann.org>:
>
> Hi,
>
> >
> >    I have seen that there is a function named sdp_service_search_req,
> >    So,I append two service uuid such as obexpush's uuid and another
> > service's uuid into the search list, I want to get the two services'
> > info only call search func once.
>
> I checked with the SDP specification and the UUID list for service
> search is not an OR list of UUIDs. It is an AND list of UUIDs. Which
> means you are looking for service records that contain the first and the
> second UUID. This is per service record and can't be used to find
> service records in the whole database that match either one of these.
> You have to request them sequentially.
>
> Regards
>
> Marcel
>
>
>
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share
> your
> opinions on IT & business topics through brief surveys -- and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>



-- 
With respects,
   Mingfan.Lu

------=_Part_25612_11300399.1159355232094
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>Thank you for your nice help.</div>
<div>But I think OR LIST is better :)</div>
<div>&nbsp;</div>
<div><span class="gmail_quote">2006/9/27, Marcel Holtmann &lt;<a href="mailto:marcel@holtmann.org">marcel@holtmann.org</a>&gt;:</span>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">Hi,<br><br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;I have seen that there is a function named sdp_service_search_req,<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;So,I append two service uuid such as obexpush's uuid and another
<br>&gt; service's uuid into the search list, I want to get the two services'<br>&gt; info only call search func once.<br><br>I checked with the SDP specification and the UUID list for service<br>search is not an OR list of UUIDs. It is an AND list of UUIDs. Which
<br>means you are looking for service records that contain the first and the<br>second UUID. This is per service record and can't be used to find<br>service records in the whole database that match either one of these.<br>
You have to request them sequentially.<br><br>Regards<br><br>Marcel<br><br><br><br>-------------------------------------------------------------------------<br>Take Surveys. Earn Cash. Influence the Future of IT<br>Join SourceForge.net
's Techsay panel and you'll get the chance to share your<br>opinions on IT &amp; business topics through brief surveys -- and earn cash<br><a href="http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV">
http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV</a><br>_______________________________________________<br>Bluez-devel mailing list<br><a href="mailto:Bluez-devel@lists.sourceforge.net">Bluez-devel@lists.sourceforge.net
</a><br><a href="https://lists.sourceforge.net/lists/listinfo/bluez-devel">https://lists.sourceforge.net/lists/listinfo/bluez-devel</a><br></blockquote></div><br><br clear="all"><br>-- <br>With respects,<br>&nbsp;&nbsp; Mingfan.Lu 

------=_Part_25612_11300399.1159355232094--


--===============1456962310==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1456962310==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1456962310==--
