Return-Path: <cyrus@holtmann.org>
Message-ID: <de4879e80805141048w108a1e94n2486c92cab3d5692@mail.gmail.com>
Date: Wed, 14 May 2008 14:48:28 -0300
From: thiagoss <thiagossantos@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <F60A3CE9E807BE49B5F56BD80B894D20016883B2@sc-exch03.marvell.com>
MIME-Version: 1.0
References: <F60A3CE9E807BE49B5F56BD80B894D20016883A4@sc-exch03.marvell.com>
	<F60A3CE9E807BE49B5F56BD80B894D20016883A5@sc-exch03.marvell.com>
	<F60A3CE9E807BE49B5F56BD80B894D20016883B2@sc-exch03.marvell.com>
Subject: Re: [Bluez-devel] A2dpsink with bluez 3.31
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1548945090=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============1548945090==
Content-Type: multipart/alternative;
	boundary="----=_Part_372_18693524.1210787308754"

------=_Part_372_18693524.1210787308754
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Could you, please, show us with the pipeline you were using?

On Wed, May 14, 2008 at 1:40 PM, Angus Ainslie <aainslie@marvell.com> wrote:

> It seems the a2dpsink for 3.31 has different audio format requirements.
>
> Adding audioconvert to the pipeline fixed my problem.
>
>
> >
> > Looking closer it's the filter child that transitions
> > properly. The fakesink and a2dpsink always stay READY.
> >
> > Angus
> >
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by: Microsoft
> Defy all challenges. Microsoft(R) Visual Studio 2008.
> http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>

------=_Part_372_18693524.1210787308754
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Could you, please, show us with the pipeline you were using?<br><br><div class="gmail_quote">On Wed, May 14, 2008 at 1:40 PM, Angus Ainslie &lt;<a href="mailto:aainslie@marvell.com">aainslie@marvell.com</a>&gt; wrote:<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
It seems the a2dpsink for 3.31 has different audio format requirements.<br>
<br>
Adding audioconvert to the pipeline fixed my problem.<br>
<div><div></div><div class="Wj3C7c"><br>
<br>
&gt;<br>
&gt; Looking closer it&#39;s the filter child that transitions<br>
&gt; properly. The fakesink and a2dpsink always stay READY.<br>
&gt;<br>
&gt; Angus<br>
&gt;<br>
<br>
-------------------------------------------------------------------------<br>
This SF.net email is sponsored by: Microsoft<br>
Defy all challenges. Microsoft(R) Visual Studio 2008.<br>
<a href="http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/" target="_blank">http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/</a><br>
_______________________________________________<br>
Bluez-devel mailing list<br>
<a href="mailto:Bluez-devel@lists.sourceforge.net">Bluez-devel@lists.sourceforge.net</a><br>
<a href="https://lists.sourceforge.net/lists/listinfo/bluez-devel" target="_blank">https://lists.sourceforge.net/lists/listinfo/bluez-devel</a><br>
</div></div></blockquote></div><br>

------=_Part_372_18693524.1210787308754--


--===============1548945090==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft 
Defy all challenges. Microsoft(R) Visual Studio 2008. 
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============1548945090==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1548945090==--
