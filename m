Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <ef9938ec0611212212w67e3da16rc03a961965676f9f@mail.gmail.com>
Date: Wed, 22 Nov 2006 01:12:16 -0500
From: "Albert Huang" <albert@csail.mit.edu>
To: "Rupesh Gujare" <rupesh_gujare@rediffmail.com>,
        "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20061122044600.14932.qmail@webmail58.rediffmail.com>
MIME-Version: 1.0
References: <20061122044600.14932.qmail@webmail58.rediffmail.com>
Subject: Re: [Bluez-devel] need help....range of device??
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0422932042=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============0422932042==
Content-Type: multipart/alternative;
	boundary="----=_Part_40676_28515180.1164175936488"

------=_Part_40676_28515180.1164175936488
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

10 meters and 100 meters are marketing numbers.  The actual ranges you will
experience depend highly on the environment and the specific radios used.
It's not uncommon for a class 2 device to have a much larger effective range
(e.g. 30 meters) in some circumstances.

-albert

On 22 Nov 2006 04:46:00 -0000, Rupesh Gujare <rupesh_gujare@rediffmail.com>
wrote:
>
> Hello all,
>   currently i am little bit confused regarding range of bluetooth devices.
>
> I am having 2 devices.
> first device is class 2 device (Nokia 6600 mobile phone).
> and second device is class 1 Billionton dongle.
>
> now as per specification range of class 2 device is 10 meters.
>   and range of class 1 device is 100 meters.
>
>
> So when i do a inquiry from class 2 device, it should report me back all
> devices that fall within its range (ie. 10 mts). (Am I correct???) But
> surprisingly i am also able to detect calss 1 device(billionton dongle),
> which is out of range of class 2 device(mobile phone).
>
> So how is it happening? whats mistake i am making?
> Is it so that out of two bluetooth devices, the defualt range for both of
> these devices is maximum range of these two??
>   any corrections and help are highly appreciated.
> Thanks in advance
> Rupesh..
>
>
>
>
> <http://adworks.rediff.com/cgi-bin/AdWorks/sigclick.cgi/www.rediff.com/signature-home.htm/1507191490@Middle5?PARTNER=3>
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share
> your
> opinions on IT & business topics through brief surveys - and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
>
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>
>
>

------=_Part_40676_28515180.1164175936488
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

10 meters and 100 meters are marketing numbers.&nbsp; The actual ranges you will experience depend highly on the environment and the specific radios used.&nbsp; It's not uncommon for a class 2 device to have a much larger effective range (
e.g. 30 meters) in some circumstances.<br><br>-albert<br><br><div><span class="gmail_quote">On 22 Nov 2006 04:46:00 -0000, <b class="gmail_sendername">Rupesh Gujare</b> &lt;<a href="mailto:rupesh_gujare@rediffmail.com">rupesh_gujare@rediffmail.com
</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><p>
Hello all,<br>
&nbsp; currently i am little bit confused regarding range of bluetooth devices.<br>
<br>
 I am having 2 devices. <br>
 first device is class 2 device (Nokia 6600 mobile phone).<br>
 and second device is class 1 Billionton dongle.<br>
 <br>
 now as per specification range of class 2 device is 10 meters.<br>
&nbsp; and range of class 1 device is 100 meters.<br>
<br>
<br>
So when i do a inquiry from class 2 device, it should report me back all devices that fall within its range (ie. 10 mts). (Am I correct???) But&nbsp; surprisingly i am also able to detect calss 1 device(billionton dongle), which is out of range of class 2 device(mobile phone).
<br>
<br>
 So how is it happening? whats mistake i am making?<br>
 Is it so that out of two bluetooth devices, the defualt range for both of these devices is maximum range of these two??<br>
&nbsp; any corrections and help are highly appreciated.<br>
 Thanks in advance<br>
 Rupesh..<br>
<br>
&nbsp; <br>

</p>
<br><br>
<a href="http://adworks.rediff.com/cgi-bin/AdWorks/sigclick.cgi/www.rediff.com/signature-home.htm/1507191490@Middle5?PARTNER=3" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)"><img border="0" hspace="0" vspace="0">
</a>

<br>-------------------------------------------------------------------------<br>Take Surveys. Earn Cash. Influence the Future of IT<br>Join SourceForge.net's Techsay panel and you'll get the chance to share your<br>opinions on IT &amp; business topics through brief surveys - and earn cash
<br><a onclick="return top.js.OpenExtLink(window,event,this)" href="http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV" target="_blank">http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV
</a><br><br>_______________________________________________<br>Bluez-devel mailing list<br><a onclick="return top.js.OpenExtLink(window,event,this)" href="mailto:Bluez-devel@lists.sourceforge.net">Bluez-devel@lists.sourceforge.net
</a><br><a onclick="return top.js.OpenExtLink(window,event,this)" href="https://lists.sourceforge.net/lists/listinfo/bluez-devel" target="_blank">https://lists.sourceforge.net/lists/listinfo/bluez-devel</a><br><br><br></blockquote>
</div><br>

------=_Part_40676_28515180.1164175936488--


--===============0422932042==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0422932042==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0422932042==--
