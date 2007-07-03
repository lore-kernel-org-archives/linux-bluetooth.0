Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <d89ddf300707021858u2e5e8f80k35794595254736f6@mail.gmail.com>
Date: Mon, 2 Jul 2007 19:58:32 -0600
From: "Brad Midgley" <bmidgley@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <46896137.90202@gmail.com>
MIME-Version: 1.0
References: <46896137.90202@gmail.com>
Subject: Re: [Bluez-devel] A few questions about bluetooth-alsa project
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1588608833=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============1588608833==
Content-Type: multipart/alternative;
	boundary="----=_Part_82513_11352800.1183427912217"

------=_Part_82513_11352800.1183427912217
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

hey

So first up, I have built sample spec files that generate rpm files out
> of sbc and plugz. In case you are interested then I can share them with
> you all.


sure... I could put them in contrib/

Now, I have installed both plugz and sbc. I am trying to use sco for
> doing the two-way communication. I have copied over the
> plugz/alsa-plugins/asound.conf (as ~/.asoundrc) and changed the BT
> address to my headset's.
>
> I ran the headset daemon and I noticed that my gnome-volume applet looks
> different and shows a new control called PCM-2. But beyond this I am
> unable to do much.


most apps don't know about the plugin and you have to manually type in
"headset" for the alsa device. if the app doesn't let you type in the name,
you could make it the default device or hand-edit the config file.

I also noticed that the website states that I need kernel patches. Is
> this still true for kernels > 2.6.21 ??


I have not seen the flowcontrol patch land upstream.

I would really appreciate it if people could help me out with figuring
> out this headset integration.


 you know this is a sort of testbed for this stuff. Marcel is allowing the
parts of the design that aren't broken to be rewritten into the bluez utils
audio service.

brad

------=_Part_82513_11352800.1183427912217
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

hey<br><br><div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">So first up, I have built sample spec files that generate rpm files out<br>of sbc and plugz. In case you are interested then I can share them with
<br>you all.</blockquote><div><br>sure... I could put them in contrib/<br></div><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Now, I have installed both plugz and sbc. I am trying to use sco for
<br>doing the two-way communication. I have copied over the<br>plugz/alsa-plugins/asound.conf (as ~/.asoundrc) and changed the BT<br>address to my headset&#39;s.<br><br>I ran the headset daemon and I noticed that my gnome-volume applet looks
<br>different and shows a new control called PCM-2. But beyond this I am<br>unable to do much.</blockquote><div><br>most apps don&#39;t know about the plugin and you have to manually type in &quot;headset&quot; for the alsa device. if the app doesn&#39;t let you type in the name, you could make it the default device or hand-edit the config file.
<br></div><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">I also noticed that the website states that I need kernel patches. Is<br>this still true for kernels &gt; 
2.6.21 ??</blockquote><div><br>I have not seen the flowcontrol patch land upstream.<br></div><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
I would really appreciate it if people could help me out with figuring<br>out this headset integration.</blockquote><div><br>&nbsp;you know this is a sort of testbed for this stuff. Marcel is allowing the parts of the design that aren&#39;t broken to be rewritten into the bluez utils audio service.
<br><br>brad<br></div></div><br>

------=_Part_82513_11352800.1183427912217--


--===============1588608833==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============1588608833==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1588608833==--
