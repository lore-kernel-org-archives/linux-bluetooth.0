Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <57c68ddc0701020446y3a7e70edh74f6ea5e0b05d07f@mail.gmail.com>
Date: Tue, 2 Jan 2007 18:16:28 +0530
From: "siddhant tewari" <siddhant.tewari@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <20070102094414.f7b9cef1.ml133@netpole.com.br>
MIME-Version: 1.0
References: <57c68ddc0701012354u4137d1d3s93b28cafaa53f849@mail.gmail.com>
	<1167725398.30886.32.camel@violet>
	<57c68ddc0701020016y29fafa8duf77494bb50ac6d75@mail.gmail.com>
	<20070102081813.6a264b0e.ml133@netpole.com.br>
	<57c68ddc0701020229w6ddfaab3yf989a8e3999cbd1@mail.gmail.com>
	<20070102094414.f7b9cef1.ml133@netpole.com.br>
Subject: Re: [Bluez-users] problem in making multiple connections using
	single bluetooth adapter using bluez
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0629584562=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0629584562==
Content-Type: multipart/alternative;
	boundary="----=_Part_136940_3421117.1167741988114"

------=_Part_136940_3421117.1167741988114
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

hi Cris,

    With linux being one of the major players in embedded domain and bluez
being an official protocol of linux there is definitely a great need for
multi connection support. You have suggested that somebody with a thorough
understanding of bluetooth and its protocol should start to fork the full
development of bluetooth support in linux , but that somebody cannot be at
least me at this instance as i am just a starter and it took some effort
from my side to even get the idea of what u wrote ... i think it should be
someone like you who has such a clear picture of the problem or to be more
precise really understands the problem well , who can initiate such
development... all i can say is that i am ready to work if somebody  can
guide me ....

Please tell me what are the other options parallel to bluez and is it really
advisable to  use them .

I am stuck at this problem and i dont like leaving it as such.

regards
siddhant

On 1/2
 /07, Cris <ml133@netpole.com.br> wrote:
>
> On Tue, 2 Jan 2007 15:59:19 +0530
> "siddhant tewari" <siddhant.tewari@gmail.com> wrote:
>
> > hi cris,
> >            I tried similar thing using OBEX push client and the thing
> that
> > happened is exactly what u apprehended ...
> >     ->  One thread waited for the other to get completed .... sad blues
> > behavior.....this is exactly what is creating trouble in my application
> ...
>
> Obviously, BlueZ didn't learn to deal with more than one connection at
> the same time yet. They are still thinking that everybody has a
> desktop computer with KDE (or Windows, as dbus being a derivate from
> gtk, is specially designed to be platform independent) and just a
> single cellphone or PDA at home. Of course, large companies like Nokia
> are not really affected by these problems, as a cellphone is so small
> that it can't deal with much more than one thing at the same time
> anyway. But this may change in some future.
>
> So your only choice is to not use libbluetooth. Marcel is right when
> he says that this implies a lot of work, as you will have to implement
> each protocol layer yourself. But as these are quite badly designed in
> BlueZ, there is really no fix for it. If the BlueZ developers had a
> different way of dealing with users (just look at their answers) the
> many thousands of hours of work we are doing each one on his own could
> go into this project. So, we are alone here. Your choices like mine or
> anybody else's who is trying to serious work with bluetooth, is either
> to give up or to do the work.
>
> But be aware, that re-writing the protocol stack may not be
> enough. I've done so and am having bad troubles because BlueZ
> developers think that an exclusive usage over a socket can be
> implemented by the concept of a raw socket. This is not true. Even
> using raw sockets the kernel will interfere in your programming,
> meaning that it is quite possible that we will have to replace also
> the kernel modules, which would make 100% of BlueZ code unusable. Not
> regulating mutually interfering accesses to one and the same ressource
> is pure Windows philosophy, where each program, starting with
> kernel.dll thinks it owns the complete device. Raw sockets allow to do
> low leve things, but they don't guarantee that someone else wont undo
> what ever my program has done a second earlier. Even if this someone
> else is the kernel herself.
>
> I've suggested the use of an exclusive flag with the HCI sockets, when
> Marcel answered, that the kernel does NOT interfere when I open that
> socket in raw. This is just not true. Marcel (who should know as he
> wrote this monster) asked what exactly happens. Here it is:
>
> If your program is already active and you plug in an USB bluetooth
> dongle, the kernel issues several informational queries to the
> device. It needs to do so, as a raw socket doesn't imply that there
> couldn't be more than one processes accessing the same device (there
> is no exclusivity), while a second process might want to use a cooked
> socket. In my case, I know that there will be no other process,
> specially not hcid or dbus, but the kernel doesn't, and still issues
> these commands. Thus, I need to expect anything to happen, just for
> the USB dongle having been plugged in. This raises the level of
> complexity of my program by a power of magnitud. Also, Marcel himself
> said, that whenever a major version number is increased, we can not
> trust that the behaviour wont change incompatibly with the previous
> version (besides the use of dbus and apparently the inability to
> multitask). Did anybody see any reasoning why dbus is defended so
> stiff neckedly? Or why nobody cares to work on a design which actually
> matches what bluetooth specifications persue?
>
> Much worse is what happens if you create a connection. Until you get
> the connection complete event, everything is fine. But then, the
> kernel will issue several commands, ignoring any commands of yours
> until it's done. Among those is HCI_Write_Link_Policy_Settings. At
> this point it seems to be impossible to achieve for instance a role
> switch. Also, the kernel has no way to know what my program is trying
> to do, and thus can not know which is the link policy I need.
>
> You see, everybody doing things like you and me (and I've seen more
> than just a few more out there) is just out of luck. The best would be
> somebody starting to fork the full development of Bluetooth support in
> Linux, but this time with a well thought design based on a thorough
> understanding of bluetooth and it's protocols.
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

------=_Part_136940_3421117.1167741988114
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

hi Cris,<br><br>&nbsp;&nbsp;&nbsp; With linux being one of the major players in embedded domain and bluez being an official protocol of linux there is definitely a great need for multi connection support. You have suggested that somebody with a thorough understanding of bluetooth and its protocol should start to fork the full development of bluetooth support in linux , but that somebody cannot be at least me at this instance as i am just a starter and it took some effort from my side to even get the idea of what u wrote ... i think it should be someone like you who has such a clear picture of the problem or to be more precise really understands the problem well , who can initiate such development... all i can say is that i am ready to work if somebody&nbsp; can guide me .... 
<br><br>Please tell me what are the other options parallel to bluez and is it really advisable to&nbsp; use them .<br><br>I am stuck at this problem and i dont like leaving it as such.<br><br>regards<br>siddhant<br><br><div><span class="gmail_quote">
On 1/2<br>&nbsp;/07, <b class="gmail_sendername">Cris</b> &lt;<a href="mailto:ml133@netpole.com.br">ml133@netpole.com.br</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
On Tue, 2 Jan 2007 15:59:19 +0530<br>&quot;siddhant tewari&quot; &lt;<a href="mailto:siddhant.tewari@gmail.com">siddhant.tewari@gmail.com</a>&gt; wrote:<br><br>&gt; hi cris,<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;I tried similar thing using OBEX push client and the thing that
<br>&gt; happened is exactly what u apprehended ...<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; -&gt;&nbsp;&nbsp;One thread waited for the other to get completed .... sad blues<br>&gt; behavior.....this is exactly what is creating trouble in my application ...<br>
<br>Obviously, BlueZ didn&#39;t learn to deal with more than one connection at<br>the same time yet. They are still thinking that everybody has a<br>desktop computer with KDE (or Windows, as dbus being a derivate from<br>
gtk, is specially designed to be platform independent) and just a<br>single cellphone or PDA at home. Of course, large companies like Nokia<br>are not really affected by these problems, as a cellphone is so small<br>that it can&#39;t deal with much more than one thing at the same time
<br>anyway. But this may change in some future.<br><br>So your only choice is to not use libbluetooth. Marcel is right when<br>he says that this implies a lot of work, as you will have to implement<br>each protocol layer yourself. But as these are quite badly designed in
<br>BlueZ, there is really no fix for it. If the BlueZ developers had a<br>different way of dealing with users (just look at their answers) the<br>many thousands of hours of work we are doing each one on his own could<br>
go into this project. So, we are alone here. Your choices like mine or<br>anybody else&#39;s who is trying to serious work with bluetooth, is either<br>to give up or to do the work.<br><br>But be aware, that re-writing the protocol stack may not be
<br>enough. I&#39;ve done so and am having bad troubles because BlueZ<br>developers think that an exclusive usage over a socket can be<br>implemented by the concept of a raw socket. This is not true. Even<br>using raw sockets the kernel will interfere in your programming,
<br>meaning that it is quite possible that we will have to replace also<br>the kernel modules, which would make 100% of BlueZ code unusable. Not<br>regulating mutually interfering accesses to one and the same ressource<br>
is pure Windows philosophy, where each program, starting with<br>kernel.dll thinks it owns the complete device. Raw sockets allow to do<br>low leve things, but they don&#39;t guarantee that someone else wont undo<br>what ever my program has done a second earlier. Even if this someone
<br>else is the kernel herself.<br><br>I&#39;ve suggested the use of an exclusive flag with the HCI sockets, when<br>Marcel answered, that the kernel does NOT interfere when I open that<br>socket in raw. This is just not true. Marcel (who should know as he
<br>wrote this monster) asked what exactly happens. Here it is:<br><br>If your program is already active and you plug in an USB bluetooth<br>dongle, the kernel issues several informational queries to the<br>device. It needs to do so, as a raw socket doesn&#39;t imply that there
<br>couldn&#39;t be more than one processes accessing the same device (there<br>is no exclusivity), while a second process might want to use a cooked<br>socket. In my case, I know that there will be no other process,<br>specially not hcid or dbus, but the kernel doesn&#39;t, and still issues
<br>these commands. Thus, I need to expect anything to happen, just for<br>the USB dongle having been plugged in. This raises the level of<br>complexity of my program by a power of magnitud. Also, Marcel himself<br>said, that whenever a major version number is increased, we can not
<br>trust that the behaviour wont change incompatibly with the previous<br>version (besides the use of dbus and apparently the inability to<br>multitask). Did anybody see any reasoning why dbus is defended so<br>stiff neckedly? Or why nobody cares to work on a design which actually
<br>matches what bluetooth specifications persue?<br><br>Much worse is what happens if you create a connection. Until you get<br>the connection complete event, everything is fine. But then, the<br>kernel will issue several commands, ignoring any commands of yours
<br>until it&#39;s done. Among those is HCI_Write_Link_Policy_Settings. At<br>this point it seems to be impossible to achieve for instance a role<br>switch. Also, the kernel has no way to know what my program is trying<br>
to do, and thus can not know which is the link policy I need.<br><br>You see, everybody doing things like you and me (and I&#39;ve seen more<br>than just a few more out there) is just out of luck. The best would be<br>somebody starting to fork the full development of Bluetooth support in
<br>Linux, but this time with a well thought design based on a thorough<br>understanding of bluetooth and it&#39;s protocols.<br><br>-------------------------------------------------------------------------<br>Take Surveys. Earn Cash. Influence the Future of IT
<br>Join SourceForge.net&#39;s Techsay panel and you&#39;ll get the chance to share your<br>opinions on IT &amp; business topics through brief surveys - and earn cash<br><a href="http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV">
http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV</a><br>_______________________________________________<br>Bluez-users mailing list<br><a href="mailto:Bluez-users@lists.sourceforge.net">Bluez-users@lists.sourceforge.net
</a><br><a href="https://lists.sourceforge.net/lists/listinfo/bluez-users">https://lists.sourceforge.net/lists/listinfo/bluez-users</a><br></blockquote></div><br>

------=_Part_136940_3421117.1167741988114--


--===============0629584562==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0629584562==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0629584562==--
