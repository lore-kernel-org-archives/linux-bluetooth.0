Return-Path: <cyrus@holtmann.org>
Message-ID: <359782e70801030510p5abedbe4m6d7e129d8a5b0692@mail.gmail.com>
Date: Thu, 3 Jan 2008 21:10:54 +0800
From: "bsd user" <oldmoonster@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <E21A90CDB9591542899EFC7FB4ED5CC90776A695@tfmail02.TFMAIL.COM>
MIME-Version: 1.0
References: <d89ddf300801021040o28e16943t2c51ac0190bd4e91@mail.gmail.com>
	<E21A90CDB9591542899EFC7FB4ED5CC90776A695@tfmail02.TFMAIL.COM>
Subject: Re: [Bluez-users] slave - slave talk in a piconet
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0340904779=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0340904779==
Content-Type: multipart/alternative;
	boundary="----=_Part_25025_20631526.1199365854256"

------=_Part_25025_20631526.1199365854256
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

So, B or C has no knowledge about each other when they are slaves of master
A, right? Then, can I say if B want to talk with C, they need higher level
protocol support, such as telnet, ftp. And, all data exchange will be
forwarded by Master A. right?

Thanks!

On Jan 3, 2008 9:07 AM, guoyun <guoyun@techfaith.cn> wrote:

> Hi, Brad
>
> > hey
> >
> > > If there is a piconet that has 2 slave B,C, the master is A. Does B
> > > know the existence of C? can B talk to C directly without
> > A(master)'s intervention?
> >
> > if they did talk to each other directly, one would have to be
> > master and you'd have a scatternet.
>
> one bluetooth could be in two or more piconet, but it just can play as
> slave _not_ master for the bluetooth clock.
>
> Please refer to Core SPEC. chapter 4.1. Piconet topology.
>
> BRs
> Yun
>
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by: Microsoft
> Defy all challenges. Microsoft(R) Visual Studio 2005.
> http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>
>

------=_Part_25025_20631526.1199365854256
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

So, B or C has no knowledge about each other when they are slaves of master A, right? Then, can I say if B want to talk with C, they need higher level protocol support, such as telnet, ftp. And, all data exchange will be forwarded by Master A. right? 
<br><br>Thanks!<br><br><div class="gmail_quote">On Jan 3, 2008 9:07 AM, guoyun &lt;<a href="mailto:guoyun@techfaith.cn">guoyun@techfaith.cn</a>&gt; wrote:<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Hi, Brad<br><div class="Ih2E3d"><br>&gt; hey<br>&gt;<br>&gt; &gt; If there is a piconet that has 2 slave B,C, the master is A. Does B<br>&gt; &gt; know the existence of C? can B talk to C directly without<br>&gt; A(master)&#39;s intervention?
<br>&gt;<br>&gt; if they did talk to each other directly, one would have to be<br>&gt; master and you&#39;d have a scatternet.<br><br></div>one bluetooth could be in two or more piconet, but it just can play as slave _not_ master for the bluetooth clock.
<br><br>Please refer to Core SPEC. chapter 4.1. Piconet topology.<br><br>BRs<br>Yun<br><br><br>-------------------------------------------------------------------------<br>This SF.net email is sponsored by: Microsoft<br>Defy all challenges. Microsoft(R) Visual Studio 2005.
<br><a href="http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/" target="_blank">http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/</a><br>_______________________________________________<br>Bluez-users mailing list
<br><a href="mailto:Bluez-users@lists.sourceforge.net">Bluez-users@lists.sourceforge.net</a><br><a href="https://lists.sourceforge.net/lists/listinfo/bluez-users" target="_blank">https://lists.sourceforge.net/lists/listinfo/bluez-users
</a><br><br></blockquote></div><br>

------=_Part_25025_20631526.1199365854256--


--===============0340904779==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============0340904779==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0340904779==--
