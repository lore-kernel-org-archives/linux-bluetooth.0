Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <1ab01fb50703010636n76b93d4dre26a557f59f8f294@mail.gmail.com>
Date: Thu, 1 Mar 2007 20:06:22 +0530
From: "Vikas Sinha" <compuvikas@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <ddea76ce0703010629y4930307chdbd0a6e366ca5ad9@mail.gmail.com>
MIME-Version: 1.0
References: <ddea76ce0703010629y4930307chdbd0a6e366ca5ad9@mail.gmail.com>
Subject: Re: [Bluez-devel] Help: missing Bluetooth header file
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1077242530=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============1077242530==
Content-Type: multipart/alternative;
	boundary="----=_Part_27506_17136913.1172759782220"

------=_Part_27506_17136913.1172759782220
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Did you have bluez stack in your machine. What version of kernel you are
using.
you need to provide linking -lbluetooth during compilation.

On 3/1/07, Meenakshi Seeballack <meena2010@gmail.com> wrote:
>
> Hello,
> I am new to the linux world and I have installed Eclipse, with CDT.
> I am running the simplescan code off this website http://people.csail.mit.edu/albert/bluez-intro/c401.html
> and I am getting these errors:
> simplescan.c:6:33: error: bluetooth/bluetooth.h: No such file or directory
> simplescan.c :7:27: error: bluetooth/hci.h: No such file or directory
> simplescan.c:8:31: error: bluetooth/hci_lib.h: No such file or directory
> simplescan.c : In function 'main':
> simplescan.c:12: error: 'inquiry_info' undeclared (first use in this
> function)
> simplescan.c:12: error: (Each undeclared identifier is reported only once
> simplescan.c:12: error: for each function it appears in.)
> simplescan.c:12: error: 'ii' undeclared (first use in this function)
> simplescan.c:28: error: 'IREQ_CACHE_FLUSH' undeclared (first use in this
> function)
> simplescan.c:29: error: expected expression before ')' token
> simplescan.c:36: warning: incompatible implicit declaration of built-in
> function 'memset'
> simplescan.c:39: warning: incompatible implicit declaration of built-in
> function 'strcpy'
> simplescan.c:46:2: warning: no newline at end of file
>
> I can see these header files:
> /usr/src/kernels/2.6.19-1.2911.fc6-i686/include/net/bluetooth/bluetooth.h
> /usr/src/kernels/2.6.19-1.2911.fc6-i686/include/net/bluetooth/hci.h
> /usr/src/kernels/2.6.19-1.2911.fc6-i686 /include/net/bluetooth/hci_core.h
> /usr/src/kernels/2.6.19-1.2911.fc6-i686/include/net/bluetooth/l2cap.h
> /usr/src/kernels/2.6.19-1.2911.fc6-i686/include/net/bluetooth/rfcomm.h
> /usr/src/kernels/2.6.19-1.2911.fc6-i686 /include/net/bluetooth/sco.h
>
> Where is the hci_lib.h header file? Can anyone please assist me?
> Meena
>
>
>
>
>
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
>


-- 
Impossible
itself contain
I M Possible

Vikas

------=_Part_27506_17136913.1172759782220
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Did you have bluez stack in your machine. What version of kernel you are using.<br>
you need to provide linking -lbluetooth during compilation. <br><br><div><span class="gmail_quote">On 3/1/07, <b class="gmail_sendername">Meenakshi Seeballack</b> &lt;<a href="mailto:meena2010@gmail.com">meena2010@gmail.com
</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Hello,<br>I am new to the linux world and I have installed Eclipse, with CDT.
<br>I am running the simplescan code off this website <a href="http://people.csail.mit.edu/albert/bluez-intro/c401.html" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">http://people.csail.mit.edu/albert/bluez-intro/c401.html
</a> and I am getting these errors:<br><span style="font-weight: bold;">simplescan.c:6:33: error: bluetooth/bluetooth.h: No such file or directory</span><br style="font-weight: bold;"><span style="font-weight: bold;">simplescan.c

:7:27: error: bluetooth/hci.h: No such file or directory</span><br style="font-weight: bold;"><span style="font-weight: bold;">simplescan.c:8:31: error: bluetooth/hci_lib.h: No such file or directory</span><br>simplescan.c

: In function &#39;main&#39;:<br>simplescan.c:12: error: &#39;inquiry_info&#39; undeclared (first use in this function)<br>simplescan.c:12: error: (Each undeclared identifier is reported only once<br>simplescan.c:12: error: for each function it appears in.)
<br>simplescan.c:12: error: &#39;ii&#39; undeclared (first use in this function)<br>simplescan.c:28: error: &#39;IREQ_CACHE_FLUSH&#39; undeclared (first use in this function)<br>simplescan.c:29: error: expected expression before &#39;)&#39; token
<br>simplescan.c:36: warning: incompatible implicit declaration of built-in function &#39;memset&#39;<br>simplescan.c:39: warning: incompatible implicit declaration of built-in function &#39;strcpy&#39;<br>simplescan.c:46:2: warning: no newline at end of file
<br><br>I can see these header files:<br>/usr/src/kernels/2.6.19-1.2911.fc6-i686/include/net/bluetooth/bluetooth.h<br>/usr/src/kernels/2.6.19-1.2911.fc6-i686/include/net/bluetooth/hci.h<br>/usr/src/kernels/2.6.19-1.2911.fc6-i686

/include/net/bluetooth/hci_core.h<br>/usr/src/kernels/2.6.19-1.2911.fc6-i686/include/net/bluetooth/l2cap.h<br>/usr/src/kernels/2.6.19-1.2911.fc6-i686/include/net/bluetooth/rfcomm.h<br>/usr/src/kernels/2.6.19-1.2911.fc6-i686

/include/net/bluetooth/sco.h<br><br>Where is the hci_lib.h header file? Can anyone please assist me?<br>Meena<br><br><br><br><br><br><br><br>
<br>-------------------------------------------------------------------------<br>Take Surveys. Earn Cash. Influence the Future of IT<br>Join SourceForge.net&#39;s Techsay panel and you&#39;ll get the chance to share your
<br>opinions on IT &amp; business topics through brief surveys-and earn cash<br><a onclick="return top.js.OpenExtLink(window,event,this)" href="http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV" target="_blank">
http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV</a><br>_______________________________________________<br>Bluez-devel mailing list<br><a onclick="return top.js.OpenExtLink(window,event,this)" href="mailto:Bluez-devel@lists.sourceforge.net">
Bluez-devel@lists.sourceforge.net</a><br><a onclick="return top.js.OpenExtLink(window,event,this)" href="https://lists.sourceforge.net/lists/listinfo/bluez-devel" target="_blank">https://lists.sourceforge.net/lists/listinfo/bluez-devel
</a><br><br></blockquote></div><br><br clear="all"><br>-- <br>Impossible <br>itself contain <br>I M Possible<br><br>Vikas

------=_Part_27506_17136913.1172759782220--


--===============1077242530==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1077242530==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1077242530==--
