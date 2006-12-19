Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <be976db60612191226p7c4660a7q45d173717c81d634@mail.gmail.com>
Date: Tue, 19 Dec 2006 12:26:32 -0800
From: "Mark S. Townsley" <mstownsley@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <E34033EC-19D4-4112-A964-C656CA724290@gmail.com>
MIME-Version: 1.0
References: <be976db60612191123s62dfa67egc3c937e63ae2031@mail.gmail.com>
	<E34033EC-19D4-4112-A964-C656CA724290@gmail.com>
Subject: Re: [Bluez-users] minicom over /dev/rfcomm0
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0468272747=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0468272747==
Content-Type: multipart/alternative;
	boundary="----=_Part_15159_2925361.1166559992313"

------=_Part_15159_2925361.1166559992313
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Bas:  thanks for your reply.

So are you implying that if I do not go through RFCOMM and all the sockets
stuff, I can
actually open /dev/rfcomm0 and get back a file descriptor just like any
other serial port?

Thanks

Mark


On 12/19/06, Bas Schulte <basschulte@gmail.com> wrote:
>
> Hi,
>
> On 19-dec-2006, at 20:23, Mark S. Townsley wrote:
>
> > In many examples that I found online where people are trying to
> > make their cellphone surf web or somehow talk to their cellphone
> > from Bluez, I notice that they can often do minicom over /dev/
> > rfcomm0 in the setup.
> >
> > If I want to access the serial port service like that, but from my
> > C program, do I just treat /dev/rfcomm0 as a serial device and use
> > standard Unix serial programming libraries from my C program to do so?
> > Just curious.  Thanks in advanced for any tip.
>
> You sure can.
>
> You can of course use the code provided by Manuel too but then your
> code won't work without rfcomm/bluetooth. The nice thing is that if
> you keep it generic you can test your application using any old
> serial connection. Or use a pipe in the filesystem etc..
>
> Caveat: I can't get mgetty to work by feeding it /dev/rfcommX though :
> ( It should work, must be one of those things ;)
>
>
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share
> your
> opinions on IT & business topics through brief surveys - and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>

------=_Part_15159_2925361.1166559992313
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Bas:&nbsp; thanks for your reply.<br><br>So are you implying that if I do not go through RFCOMM and all the sockets stuff, I can<br>actually open /dev/rfcomm0 and get back a file descriptor just like any other serial port?<br>
<br>Thanks<br><br>Mark<br><br><br><div><span class="gmail_quote">On 12/19/06, <b class="gmail_sendername">Bas Schulte</b> &lt;<a href="mailto:basschulte@gmail.com">basschulte@gmail.com</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Hi,<br><br>On 19-dec-2006, at 20:23, Mark S. Townsley wrote:<br><br>&gt; In many examples that I found online where people are trying to<br>&gt; make their cellphone surf web or somehow talk to their cellphone<br>&gt; from Bluez, I notice that they can often do minicom over /dev/
<br>&gt; rfcomm0 in the setup.<br>&gt;<br>&gt; If I want to access the serial port service like that, but from my<br>&gt; C program, do I just treat /dev/rfcomm0 as a serial device and use<br>&gt; standard Unix serial programming libraries from my C program to do so?
<br>&gt; Just curious.&nbsp;&nbsp;Thanks in advanced for any tip.<br><br>You sure can.<br><br>You can of course use the code provided by Manuel too but then your<br>code won&#39;t work without rfcomm/bluetooth. The nice thing is that if
<br>you keep it generic you can test your application using any old<br>serial connection. Or use a pipe in the filesystem etc..<br><br>Caveat: I can&#39;t get mgetty to work by feeding it /dev/rfcommX though :<br>( It should work, must be one of those things ;)
<br><br><br>-------------------------------------------------------------------------<br>Take Surveys. Earn Cash. Influence the Future of IT<br>Join SourceForge.net&#39;s Techsay panel and you&#39;ll get the chance to share your
<br>opinions on IT &amp; business topics through brief surveys - and earn cash<br><a href="http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV">http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV
</a><br>_______________________________________________<br>Bluez-users mailing list<br><a href="mailto:Bluez-users@lists.sourceforge.net">Bluez-users@lists.sourceforge.net</a><br><a href="https://lists.sourceforge.net/lists/listinfo/bluez-users">
https://lists.sourceforge.net/lists/listinfo/bluez-users</a><br></blockquote></div><br>

------=_Part_15159_2925361.1166559992313--


--===============0468272747==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0468272747==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0468272747==--
