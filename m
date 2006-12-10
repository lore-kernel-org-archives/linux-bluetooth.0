Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <e4f1f0110612100442v43b4c6e0s2c5a6eb3034d3a04@mail.gmail.com>
Date: Sun, 10 Dec 2006 12:42:22 +0000
From: "jonny Linux" <jonnylinux@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <1165753814.22251.2.camel@aeonflux.holtmann.net>
MIME-Version: 1.0
References: <e4f1f0110612091109r3a89fa38t96afa23c7167e9d4@mail.gmail.com>
	<20061210053749.GA11996@163.com>
	<1165753814.22251.2.camel@aeonflux.holtmann.net>
Subject: Re: [Bluez-users] Has my passkey agent registered?
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1859146535=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1859146535==
Content-Type: multipart/alternative;
	boundary="----=_Part_84887_17850597.1165754542015"

------=_Part_84887_17850597.1165754542015
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

>
> > It seems that your computer have paired with the device before and
> > stored the link key. So there is no need to call the passkey-agent to
> > get a new PIN code from the user. You can use
> >       hcitool key device_addr
> > to change the link key, and this will ask you for a new PIN code.
>
> actually that is wrong. There will be no request for a new PIN code.
> Once a link key has been created, this link key can be used to create a
> new link key. However to use this key, you need a successful established
> and authenticated connection. This is not the case here.
>
>
I managed to fix it by removing the entry in
/var/bluetooth/[address]/linkkeys.

Thanks to both of you,

Jonny

------=_Part_84887_17850597.1165754542015
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">&gt; It seems that your computer have paired with the device before and<br>&gt; stored the link key. So there is no need to call the passkey-agent to
<br>&gt; get a new PIN code from the user. You can use<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hcitool key device_addr<br>&gt; to change the link key, and this will ask you for a new PIN code.<br><br>actually that is wrong. There will be no request for a new PIN code.
<br>Once a link key has been created, this link key can be used to create a<br>new link key. However to use this key, you need a successful established<br>and authenticated connection. This is not the case here.<br><br></blockquote>
</div><br>I managed to fix it by removing the entry in /var/bluetooth/[address]/linkkeys.<br><br>Thanks to both of you,<br><br>Jonny<br>

------=_Part_84887_17850597.1165754542015--


--===============1859146535==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1859146535==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1859146535==--
