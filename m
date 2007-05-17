Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <d89ddf300705162042j1850b997wd069bae29e813d29@mail.gmail.com>
Date: Wed, 16 May 2007 21:42:04 -0600
From: "Brad Midgley" <bmidgley@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <200705170207.52710.bluez-devel@huitl.de>
MIME-Version: 1.0
References: <200705170207.52710.bluez-devel@huitl.de>
Subject: Re: [Bluez-devel] headsetd has problems serving two applications at
	a time
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1369352280=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============1369352280==
Content-Type: multipart/alternative;
	boundary="----=_Part_19235_17133216.1179373324836"

------=_Part_19235_17133216.1179373324836
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Robert

headsetd is written to allow a single application to use the headset at one
time. it doesn't multiplex the mic or mix to the speaker. one of the two
apps will fail to get exclusive access. it's basically a latency
optimization but there's room for something like dmix or a sound server like
pulse to make it more flexible.

if skype is written such that input and output are separate file descriptors
obtained through independent open() calls then it will also fail, even if
they're in the same thread. that may be how it's written, especially if they
let you choose one device for mic and another for speaker.

Brad

On 5/16/07, Robert Huitl <bluez-devel@huitl.de> wrote:
>
>
> So why is headsetd blocking the second application while the first one is
> running?

------=_Part_19235_17133216.1179373324836
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Robert<br><br>headsetd is written to allow a single application to use the headset at one time. it doesn&#39;t multiplex the mic or mix to the speaker. one of the two apps will fail to get exclusive access. it&#39;s basically a latency optimization but there&#39;s room for something like dmix or a sound server like pulse to make it more flexible.
<br><br>if skype is written such that input and output are separate file descriptors obtained through independent open() calls then it will also fail, even if they&#39;re in the same thread. that may be how it&#39;s written, especially if they let you choose one device for mic and another for speaker.
<br><br>Brad<br><br><div><span class="gmail_quote">On 5/16/07, <b class="gmail_sendername">Robert Huitl</b> &lt;<a href="mailto:bluez-devel@huitl.de">bluez-devel@huitl.de</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<br>So why is headsetd blocking the second application while the first one is<br>running?</blockquote></div><br>

------=_Part_19235_17133216.1179373324836--


--===============1369352280==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============1369352280==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1369352280==--
