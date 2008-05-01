Return-Path: <cyrus@holtmann.org>
Message-ID: <46f855150805010641q1e164d86h46d2bc8352d6ed37@mail.gmail.com>
Date: Thu, 1 May 2008 09:41:19 -0400
From: "Chris Carlin" <volkris@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <4818E1B3.6000900@powercraft.nl>
MIME-Version: 1.0
References: <48171A58.8060200@powercraft.nl> <4817DAE3.6050406@gmail.com>
	<d89ddf300804291959m6589b95fse31e8227c37c8f1f@mail.gmail.com>
	<4818E1B3.6000900@powercraft.nl>
Subject: Re: [Bluez-users] step by step - how to get your bluetooth stereo
	headset fully working with the bluez software stack under linux
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1576961370=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1576961370==
Content-Type: multipart/alternative;
	boundary="----=_Part_6423_20824433.1209649280161"

------=_Part_6423_20824433.1209649280161
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I use Motorola S805 headphones as well. a2dp is so much better now than it
was a year or so ago that I've been somewhat happily living with it.

On Wed, Apr 30, 2008 at 5:16 PM, Jelle de Jong <jelledejong@powercraft.nl>
wrote:

> I got some kind of bandwidth issue with bluez. When I use my bluetooth
> headset and mouse at the same time, the audio gets interrupted. Both
> devices are master connections, if the headset is connected as slave,
> the connection is totally unusable, every other bluetooth event will
> make the audio stop in this case.
> - So how can we fix the bandwidth priority/distribution system with bluez?


To add my experiences, audio only drops out when using other bluetooth
devices connected to the same computer. That is, I can use bluetooth in the
vicinity without interference, so it doesn't seem to be an over-the-air
thing. Also, I see the problem with my bt keyboard: even pressing a single
key can cause a drop while moving the mouse normally takes a couple of
seconds to mess up the audio. I suspect this has something to do with
changing connection state, but I don't actually know.

Also, the problem is far, far worse with high quality music than, say, a
poor quality book on tape. I almost never have a problem listening to voice
but always when listening to symphonic music. Perhaps it's compressibility?

I use both audacious and mplayer with identical results.
My system is very different from Jelle's: I have a low latency kernel with
upped jiffies and all that... it's gentoo-sources. Maybe observations on the
very different system will provide some clues.

~Chris

------=_Part_6423_20824433.1209649280161
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I use Motorola S805 headphones as well. a2dp is so much better now than it was a year or so ago that I&#39;ve been somewhat happily living with it.<br><br><div class="gmail_quote">On Wed, Apr 30, 2008 at 5:16 PM, Jelle de Jong &lt;<a href="mailto:jelledejong@powercraft.nl">jelledejong@powercraft.nl</a>&gt; wrote:<br>
<blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">I got some kind of bandwidth issue with bluez. When I use my bluetooth<br>
headset and mouse at the same time, the audio gets interrupted. Both<br>
devices are master connections, if the headset is connected as slave,<br>
the connection is totally unusable, every other bluetooth event will<br>
make the audio stop in this case.<br>
- So how can we fix the bandwidth priority/distribution system with bluez?</blockquote><div><br>To add my experiences, audio only drops out when using other bluetooth devices connected to the same computer. That is, I can use bluetooth in the vicinity without interference, so it doesn&#39;t seem to be an over-the-air thing. Also, I see the problem with my bt keyboard: even pressing a single key can cause a drop while moving the mouse normally takes a couple of seconds to mess up the audio. I suspect this has something to do with changing connection state, but I don&#39;t actually know.<br>
<br>Also, the problem is far, far worse with high quality music than, say, a poor quality book on tape. I almost never have a problem listening to voice but always when listening to symphonic music. Perhaps it&#39;s compressibility?<br>
<br>I use both audacious and mplayer with identical results.<br>My system is very different from Jelle&#39;s: I have a low latency kernel with upped jiffies and all that... it&#39;s gentoo-sources. Maybe observations on the very different system will provide some clues.<br>
<br>~Chris</div></div>

------=_Part_6423_20824433.1209649280161--


--===============1576961370==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
--===============1576961370==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1576961370==--
