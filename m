Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <464194a50703151011j666c93e2s1ffbe017361279f5@mail.gmail.com>
Date: Thu, 15 Mar 2007 19:11:01 +0200
From: "Zmej Gorianin" <mortagon.iyi@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1173970416.7461.7.camel@aeonflux.holtmann.net>
MIME-Version: 1.0
References: <464194a50703150639u7d4869b7h76f5185fef01f2da@mail.gmail.com>
	<1173970416.7461.7.camel@aeonflux.holtmann.net>
Subject: Re: [Bluez-devel] Is LMP implemented in BlueZ?
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0191099230=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============0191099230==
Content-Type: multipart/alternative;
	boundary="----=_Part_12321_5380813.1173978661382"

------=_Part_12321_5380813.1173978661382
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

2007/3/15, Marcel Holtmann <marcel@holtmann.org>:
>
> Hi,
>
> > I am currently doing my bachelor's dissertation about creating an
> > alternative Bluetooth authentication and key exchange scheme, using
> > public key crypto, and would like to know whether I should build on
> > top of the Bluetooth protocol stack or I can actually add code inside
> > the LMP.  I have looked thorough the code in the BlueZ kernel module
> > and  In bluez -libs package and I'm left with the impression that the
> > link manager and the LMP are part of the Bluetooth device's firmware,
> > while the HCI asks it to initiate specific LMP transactions. So my
> > question is whether LMP is a software component implemented by BlueZ
> > on a computer or it's a firmware component on the Bluetooth receiver
> > connected to the computer. I'd be thankful if somebody can clarify
> > that for me.
>
> the LMP implementation is part of the firmware inside the Bluetooth
> chip.
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
> opinions on IT & business topics through brief surveys-and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>

Thank you very much. Can you tell me then, if I can tamper with the
semi-permanent keys or are they stored within the device also. I need to
know whether I can overwrite them in some way or I have to work without
augmenting the existing authentication and key exchange scheme at all.
Thanks in advance.

Regards,
Dragomir

------=_Part_12321_5380813.1173978661382
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><br><div><span class="gmail_quote">2007/3/15, Marcel Holtmann &lt;<a href="mailto:marcel@holtmann.org">marcel@holtmann.org</a>&gt;:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Hi,<br><br>&gt; I am currently doing my bachelor&#39;s dissertation about creating an<br>&gt; alternative Bluetooth authentication and key exchange scheme, using<br>&gt; public key crypto, and would like to know whether I should build on
<br>&gt; top of the Bluetooth protocol stack or I can actually add code inside<br>&gt; the LMP.&nbsp;&nbsp;I have looked thorough the code in the BlueZ kernel module<br>&gt; and&nbsp;&nbsp;In bluez -libs package and I&#39;m left with the impression that the
<br>&gt; link manager and the LMP are part of the Bluetooth device&#39;s firmware,<br>&gt; while the HCI asks it to initiate specific LMP transactions. So my<br>&gt; question is whether LMP is a software component implemented by BlueZ
<br>&gt; on a computer or it&#39;s a firmware component on the Bluetooth receiver<br>&gt; connected to the computer. I&#39;d be thankful if somebody can clarify<br>&gt; that for me.<br><br>the LMP implementation is part of the firmware inside the Bluetooth
<br>chip.<br><br>Regards<br><br>Marcel<br><br><br><br>-------------------------------------------------------------------------<br>Take Surveys. Earn Cash. Influence the Future of IT<br>Join SourceForge.net&#39;s Techsay panel and you&#39;ll get the chance to share your
<br>opinions on IT &amp; business topics through brief surveys-and earn cash<br><a href="http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV">http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV
</a><br>_______________________________________________<br>Bluez-devel mailing list<br><a href="mailto:Bluez-devel@lists.sourceforge.net">Bluez-devel@lists.sourceforge.net</a><br><a href="https://lists.sourceforge.net/lists/listinfo/bluez-devel">
https://lists.sourceforge.net/lists/listinfo/bluez-devel</a><br></blockquote></div><br>Thank you very much. Can you tell me then, if I can tamper with the semi-permanent keys or are they stored within the device also. I need to know whether I can overwrite them in some way or I have to work without augmenting the existing authentication and key exchange scheme at all. Thanks in advance.
<br><br>Regards,<br>Dragomir<br>

------=_Part_12321_5380813.1173978661382--


--===============0191099230==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0191099230==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0191099230==--
