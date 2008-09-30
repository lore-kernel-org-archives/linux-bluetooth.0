Return-Path: <cyrus@holtmann.org>
Message-ID: <223378410809292230t1156773as3db2003c98f18b1a@mail.gmail.com>
Date: Tue, 30 Sep 2008 11:00:23 +0530
From: "rakesh agarwal" <zen.raj@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <d89ddf300809231532m20a9f9eex2e515732da4b7755@mail.gmail.com>
MIME-Version: 1.0
References: <48C43D87.2040705@stephan.co.uk>
	<d89ddf300809071430jb7d0303yea3173504c0894aa@mail.gmail.com>
	<48D95F28.4000708@stephan.co.uk>
	<d89ddf300809231532m20a9f9eex2e515732da4b7755@mail.gmail.com>
Subject: Re: [Bluez-devel] Motorola DC800
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============8310833838576169846=="
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============8310833838576169846==
Content-Type: multipart/alternative;
	boundary="----=_Part_49965_22440301.1222752623951"

------=_Part_49965_22440301.1222752623951
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

Can anyone tell how to share internet connection in my computer to the other
devices through bluetooth connection. Is there any software for this??
Please help me in this regard.

Thank You.
Rakesh

On Wed, Sep 24, 2008 at 4:02 AM, Brad Midgley <bmidgley@gmail.com> wrote:

> Stephan
>
> Sorry for the miscue. You should go to the bluez wiki and use the
> instructions there for sending a2dp audio to a headset from your pc.
> It's best if you're on a recent bluez.
>
> http://wiki.bluez.org/wiki/HOWTO/AudioDevices
>
> Brad
>
> On Tue, Sep 23, 2008 at 3:27 PM, Stephan de Georgio <sd@stephan.co.uk>
> wrote:
> > Brad,
> >
> >  >afaik, this is still only possible using "a2recv" in the old btsco
> > project.
> >
> > Is a2recv not for streaming audio from the DC800 to the PC?  I'm trying
> > to stream audio from the PC to the DC800.  I can't seem to find any
> > documentation on a2recv except the small snippet below from the
> > bluetooth-alsa build page.
> >
> >  >The A2DP sink code receives a stream from another device. Run it with:
> >  > hciconfig hci0 class 0x200404
> >  > sdptool add A2SNK
> >  > ./a2recv
> >
> >  >It will try to bind to the bluetooth adapter and send audio out to
> > /dev/dsp.
> >
> > I have installed the btsco package and tried running this and a2recv
> > just hangs with no output.  Is there something else I need to do before
> > running a2recv?
> >
> > I've also tried the command
> >
> > mpg123 --au - file.mp3 | ./a2play bdaddr
> >
> > where bdaddr is the address of the DC800, but this give no audio output
> > either.
> >
> > Any help would be very much appreciated.
> >
> > Regards,
> > Stephan
> >
> >
> > -------------------------------------------------------------------------
> > This SF.Net email is sponsored by the Moblin Your Move Developer's
> challenge
> > Build the coolest Linux based applications with Moblin SDK & win great
> prizes
> > Grand prize is a trip for two to an Open Source event anywhere in the
> world
> > http://moblin-contest.org/redirect.php?banner_id=100&url=/
> > _______________________________________________
> > Bluez-devel mailing list
> > Bluez-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/bluez-devel
> >
>
>
>
> --
> Brad
>
> -------------------------------------------------------------------------
> This SF.Net email is sponsored by the Moblin Your Move Developer's
> challenge
> Build the coolest Linux based applications with Moblin SDK & win great
> prizes
> Grand prize is a trip for two to an Open Source event anywhere in the world
> http://moblin-contest.org/redirect.php?banner_id=100&url=/
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>

------=_Part_49965_22440301.1222752623951
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div dir="ltr">Hi,<br><br>Can anyone tell how to share internet connection in my computer to the other devices through bluetooth connection. Is there any software for this??<br>Please help me in this regard.<br><br>Thank You.<br>
Rakesh<br><br><div class="gmail_quote">On Wed, Sep 24, 2008 at 4:02 AM, Brad Midgley <span dir="ltr">&lt;<a href="mailto:bmidgley@gmail.com">bmidgley@gmail.com</a>&gt;</span> wrote:<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Stephan<br>
<br>
Sorry for the miscue. You should go to the bluez wiki and use the<br>
instructions there for sending a2dp audio to a headset from your pc.<br>
It&#39;s best if you&#39;re on a recent bluez.<br>
<br>
<a href="http://wiki.bluez.org/wiki/HOWTO/AudioDevices" target="_blank">http://wiki.bluez.org/wiki/HOWTO/AudioDevices</a><br>
<br>
Brad<br>
<div><div></div><div class="Wj3C7c"><br>
On Tue, Sep 23, 2008 at 3:27 PM, Stephan de Georgio &lt;<a href="mailto:sd@stephan.co.uk">sd@stephan.co.uk</a>&gt; wrote:<br>
&gt; Brad,<br>
&gt;<br>
&gt; &nbsp;&gt;afaik, this is still only possible using &quot;a2recv&quot; in the old btsco<br>
&gt; project.<br>
&gt;<br>
&gt; Is a2recv not for streaming audio from the DC800 to the PC? &nbsp;I&#39;m trying<br>
&gt; to stream audio from the PC to the DC800. &nbsp;I can&#39;t seem to find any<br>
&gt; documentation on a2recv except the small snippet below from the<br>
&gt; bluetooth-alsa build page.<br>
&gt;<br>
&gt; &nbsp;&gt;The A2DP sink code receives a stream from another device. Run it with:<br>
&gt; &nbsp;&gt; hciconfig hci0 class 0x200404<br>
&gt; &nbsp;&gt; sdptool add A2SNK<br>
&gt; &nbsp;&gt; ./a2recv<br>
&gt;<br>
&gt; &nbsp;&gt;It will try to bind to the bluetooth adapter and send audio out to<br>
&gt; /dev/dsp.<br>
&gt;<br>
&gt; I have installed the btsco package and tried running this and a2recv<br>
&gt; just hangs with no output. &nbsp;Is there something else I need to do before<br>
&gt; running a2recv?<br>
&gt;<br>
&gt; I&#39;ve also tried the command<br>
&gt;<br>
&gt; mpg123 --au - file.mp3 | ./a2play bdaddr<br>
&gt;<br>
&gt; where bdaddr is the address of the DC800, but this give no audio output<br>
&gt; either.<br>
&gt;<br>
&gt; Any help would be very much appreciated.<br>
&gt;<br>
&gt; Regards,<br>
&gt; Stephan<br>
&gt;<br>
&gt;<br>
&gt; -------------------------------------------------------------------------<br>
&gt; This SF.Net email is sponsored by the Moblin Your Move Developer&#39;s challenge<br>
&gt; Build the coolest Linux based applications with Moblin SDK &amp; win great prizes<br>
&gt; Grand prize is a trip for two to an Open Source event anywhere in the world<br>
&gt; <a href="http://moblin-contest.org/redirect.php?banner_id=100&amp;url=/" target="_blank">http://moblin-contest.org/redirect.php?banner_id=100&amp;url=/</a><br>
&gt; _______________________________________________<br>
&gt; Bluez-devel mailing list<br>
&gt; <a href="mailto:Bluez-devel@lists.sourceforge.net">Bluez-devel@lists.sourceforge.net</a><br>
&gt; <a href="https://lists.sourceforge.net/lists/listinfo/bluez-devel" target="_blank">https://lists.sourceforge.net/lists/listinfo/bluez-devel</a><br>
&gt;<br>
<br>
<br>
<br>
</div></div>--<br>
<font color="#888888">Brad<br>
</font><div><div></div><div class="Wj3C7c"><br>
-------------------------------------------------------------------------<br>
This SF.Net email is sponsored by the Moblin Your Move Developer&#39;s challenge<br>
Build the coolest Linux based applications with Moblin SDK &amp; win great prizes<br>
Grand prize is a trip for two to an Open Source event anywhere in the world<br>
<a href="http://moblin-contest.org/redirect.php?banner_id=100&amp;url=/" target="_blank">http://moblin-contest.org/redirect.php?banner_id=100&amp;url=/</a><br>
_______________________________________________<br>
Bluez-devel mailing list<br>
<a href="mailto:Bluez-devel@lists.sourceforge.net">Bluez-devel@lists.sourceforge.net</a><br>
<a href="https://lists.sourceforge.net/lists/listinfo/bluez-devel" target="_blank">https://lists.sourceforge.net/lists/listinfo/bluez-devel</a><br>
</div></div></blockquote></div><br></div>

------=_Part_49965_22440301.1222752623951--


--===============8310833838576169846==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
--===============8310833838576169846==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============8310833838576169846==--
