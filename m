Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <de4879e80709261519s68ca904i19f54905ece3594f@mail.gmail.com>
Date: Wed, 26 Sep 2007 19:19:57 -0300
From: thiagoss <thiagossantos@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1190844611.6484.33.camel@aeonflux.holtmann.net>
MIME-Version: 1.0
References: <de4879e80709250718p592208cci7a9aef68408a22fb@mail.gmail.com>
	<1190844611.6484.33.camel@aeonflux.holtmann.net>
Subject: Re: [Bluez-devel] patches fixing gstreamer plugins
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1819984512=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============1819984512==
Content-Type: multipart/alternative;
	boundary="----=_Part_8838_23692367.1190845198067"

------=_Part_8838_23692367.1190845198067
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Marcel

I know, the thing is the capabilities negotiation wasn't properly
implemented, some functions should have been overrided, sbcdec and sbcenc
should be enough to decode/encode, but since sbcparse was missing the same
thing sbcenc was, I did the work too.

If a use:
filesrc ! audioconvert ! sbcenc ! fakesink

it works, but that doesn't mean the problem isn't there, it just hasn't
ocurred, (the reason is that fakesink accept any kind of buffers, thus
negotiation is "everything is ok"), when I put sbcparse (even if its not
useful, it's just for testing) the negotiation should succeed, both of them
work with sbc, and it isn't succeeding.

Both sbcenc and sbcparse had a problem, the example I gave was only a
demonstration of the problem.

Regards

Thiago

On 9/26/07, Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Thiago,
>
> > Patches for Bluez utils, modifying the sbcenc and sbcparse gstreamer
> > plugins on utils/audio
> >
> >
> > The problem:
> > The pipeline "filesrc ! audioconvert ! sbcenc ! sbcparse ! fakesink"
> > is not working
>
> actually the sbcparse is only there for annotating an SBC stream. For
> decoding the sbcdec should be used.
>
> Regards
>
> Marcel
>
>
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by: Microsoft
> Defy all challenges. Microsoft(R) Visual Studio 2005.
> http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>

------=_Part_8838_23692367.1190845198067
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Marcel<br><br>I know, the thing is the capabilities negotiation wasn&#39;t properly implemented, some functions should have been overrided, sbcdec and sbcenc should be enough to decode/encode, but since sbcparse was missing the same thing sbcenc was, I did the work too.
<br><br>If a use:<br>filesrc ! audioconvert ! sbcenc ! fakesink<br><br>it works, but that doesn&#39;t mean the problem isn&#39;t there, it just hasn&#39;t ocurred, (the reason is that fakesink accept any kind of buffers, thus negotiation is &quot;everything is ok&quot;), when I put sbcparse (even if its not useful, it&#39;s just for testing) the negotiation should succeed, both of them work with sbc, and it isn&#39;t succeeding.
<br><br>Both sbcenc and sbcparse had a problem, the example I gave was only a demonstration of the problem.<br><br>Regards<br><br>Thiago<br><br><div><span class="gmail_quote">On 9/26/07, <b class="gmail_sendername">Marcel Holtmann
</b> &lt;<a href="mailto:marcel@holtmann.org">marcel@holtmann.org</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Hi Thiago,
<br><br>&gt; Patches for Bluez utils, modifying the sbcenc and sbcparse gstreamer<br>&gt; plugins on utils/audio<br>&gt;<br>&gt;<br>&gt; The problem:<br>&gt; The pipeline &quot;filesrc ! audioconvert ! sbcenc ! sbcparse ! fakesink&quot;
<br>&gt; is not working<br><br>actually the sbcparse is only there for annotating an SBC stream. For<br>decoding the sbcdec should be used.<br><br>Regards<br><br>Marcel<br><br><br><br>-------------------------------------------------------------------------
<br>This SF.net email is sponsored by: Microsoft<br>Defy all challenges. Microsoft(R) Visual Studio 2005.<br><a href="http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/">http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
</a><br>_______________________________________________<br>Bluez-devel mailing list<br><a href="mailto:Bluez-devel@lists.sourceforge.net">Bluez-devel@lists.sourceforge.net</a><br><a href="https://lists.sourceforge.net/lists/listinfo/bluez-devel">
https://lists.sourceforge.net/lists/listinfo/bluez-devel</a><br></blockquote></div><br>

------=_Part_8838_23692367.1190845198067--


--===============1819984512==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============1819984512==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1819984512==--
