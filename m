Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <18a15270707060321m46f54792sb2e72d58fc2b0a3e@mail.gmail.com>
Date: Fri, 6 Jul 2007 11:21:44 +0100
From: "Ranulf Doswell" <ralf@ranulf.net>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1183701644.6351.111.camel@aeonflux.holtmann.net>
MIME-Version: 1.0
References: <200707041719.20662.wundram@beenic.net>
	<200707051108.32230.wundram@beenic.net>
	<Pine.LNX.4.63.0707051114450.25165@redbean.intranet.gw-instruments.de>
	<200707051135.23459.wundram@beenic.net>
	<18a15270707050404y72f7d4e1i6473089816749123@mail.gmail.com>
	<1183701644.6351.111.camel@aeonflux.holtmann.net>
Subject: Re: [Bluez-devel] Using BlueZ in commercial applications - Once
	again.
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1284697334=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============1284697334==
Content-Type: multipart/alternative;
	boundary="----=_Part_17972_3828900.1183717304539"

------=_Part_17972_3828900.1183717304539
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Marcel,

Having read further comments by the OP, it sounds like he needs more than
just a simple constant to describe how to bind a socket, but actually a
bunch of structures to define the API. In which case, I'd agree that the
only way to remain compliant is to make a GPL bridge to some other
interface, although the GPL also makes this process a massive legal quagmire
too (e.g. if the bridge is GPL, so is everything that uses it, if the bridge
relies on an external bridge in order to be built, that also must be GPL,
...)

I fully respect your decision to license with the GPL, and apologies in
advance for dragging this out further, but as a developer that finds that
GPL massively complicates other open-source development [basically if you
provide your software as binaries as well as source to make life easier for
end-users, you are suddenly obligated to mirror the source for all your
dependencies, which is frankly difficult for most OSS hobbyists], I find it
quite frustrating when people confer even more restrictions into the GPL
than actually exist in the terms of the licence. You neatly summed it up
with:

> You wanna use software from the community so you have to play with our
rules.

However, GPLv2 explicitly states in the preamble that does not cover how you
use the software, only you how you copy, distribute and modify it.

> You read GPL code and this would make it derived work.

The act of "reading GPL code" does not make anything a derived work. The act
of copying or inclusion of part or all of it is what makes something a
derived work.

I can legally state a fact about the software - e.g. "it uses 532 bytes of
kernel RAM", "it runs on port 80", "it provides socket family 42", etc
without violating any terms of the GPL. What I can't do is copy any part of
that software verbatim.

But more worrying, is this thinly veiled threat:

> > The number itself isn't covered by the GPL however. The constant name,
> > I'm less sure about, but I see no reason why you couldn't define your
> > own constant FAMILY_BLUETOOTH which happens to have the same value as
> > a publically known magic value.

> contact a lawyer before making such statements.

I agree that the OP would be well advised to involve a lawyer, but my
personal opinion was clearly labeled as such, and anyone making a commercial
decision based on a personal opinion from someone they  know know nothing
about only has themselves to blame, frankly. Just to make it clear, I am not
in a position to offer legal advice.

But, just to clarify... why do you say I need a lawyer? Because I said
something you didn't like, or because I was defamatory to the product, or
because the contract was under NDA?

In any case, this particular constant also happens to be defined in
<bits/socket.h> which is distributed as part of glibc and explicitly
licensed as LGPL, which allows the header file to be included in commercial
works as long as that doesn't cause any code to be inlined or linked. Or are
you saying that glibc is non-compliant with the GPL?

Cheers,
    Ralf.

------=_Part_17972_3828900.1183717304539
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div><div>Hi Marcel,<br><br>Having read further comments by the OP, it sounds like he needs more than just a simple constant to describe how to bind a socket, but actually a bunch of structures to define the API. In which case, I&#39;d agree that the only way to remain compliant is to make a GPL bridge to some other interface, although the GPL also makes this process a massive legal quagmire too (
e.g. if the bridge is GPL, so is everything that uses it, if the bridge relies on an external bridge in order to be built, that also must be GPL, ...)<br><br>I fully respect your decision to license with the GPL, and apologies in advance for dragging this out further, but as a developer that finds that GPL massively complicates other open-source development [basically if you provide your software as binaries as well as source to make life easier for end-users, you are suddenly obligated to mirror the source for all your dependencies, which is frankly difficult for most OSS hobbyists], I find it quite frustrating when people confer even more restrictions into the GPL than actually exist in the terms of the licence. You neatly summed it up with:
<br><br>
&gt; You wanna use software from the community so you have to play with our rules. <br>
<br>However, GPLv2 explicitly states in the preamble that does not cover how you use
the software, only you how you copy, distribute and modify it.<br>
<br>
&gt; You read GPL code and this would make it derived work.<br>
<br>
The act of &quot;reading GPL code&quot; does not make anything a derived work.
The act of copying or inclusion of part or all of it is what makes
something a derived work.<br>
<br>
I can legally state a fact about the software - e.g. &quot;it uses 532 bytes
of kernel RAM&quot;, &quot;it runs on port 80&quot;, &quot;it provides socket family 42&quot;,
etc without violating any terms of the GPL. What I can&#39;t do is copy any
part of that software verbatim.<br>
<br>But more worrying, is this thinly veiled threat:<br><br><span class="q">&gt; </span><span class="q">&gt; The number itself isn&#39;t covered by the GPL however. The constant name,<br></span><span class="q">&gt; </span>
<span class="q">&gt; I&#39;m less sure about, but I see no reason why you couldn&#39;t define your<br></span><span class="q">&gt; </span><span class="q">&gt; own constant FAMILY_BLUETOOTH which happens to have the same value as
<br></span><span class="q">&gt; </span><span class="q">&gt; a publically known magic value.</span><br><br>&gt; contact a lawyer before making such statements.<br><br>I agree that the OP would be well advised to involve a lawyer, but my personal opinion was clearly labeled as such, and anyone making a commercial decision based on a personal opinion from someone they&nbsp; know know nothing about only has themselves to blame, frankly. Just to make it clear, I am not in a position to offer legal advice.
<br><br>But, just to clarify... why do you say I need a lawyer? Because I said something you didn&#39;t like, or
because I was defamatory to the product, or because the contract was
under NDA? <br><br>

In any case, this particular constant also happens to be
defined in &lt;bits/socket.h&gt; which is distributed as part of glibc
and explicitly licensed as LGPL, which allows the header file to be
included in commercial works as long as that doesn&#39;t cause any code to
be inlined or linked. Or are you saying that glibc is non-compliant
with the GPL?<br>
</div></div><br>Cheers,<br>&nbsp;&nbsp;&nbsp; Ralf.<br>

------=_Part_17972_3828900.1183717304539--


--===============1284697334==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============1284697334==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1284697334==--
