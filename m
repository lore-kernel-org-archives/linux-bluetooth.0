Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Christoph Simon <ml133@netpole.com.br>
To: bluez-users@lists.sourceforge.net
Cc: ashuang@gmail.com
Subject: Re: [Bluez-users] Anonymous service setup
Message-Id: <20060409174634.2ed036df.ml133@netpole.com.br>
In-Reply-To: <ef9938ec0604021017q786d33e5r32692f7fb33fad91@mail.gmail.com>
References: <20060401131949.fdb6d992.ml133@netpole.com.br>
	<ef9938ec0604021017q786d33e5r32692f7fb33fad91@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sun, 9 Apr 2006 17:46:34 -0300

On Sun, 2 Apr 2006 13:17:55 -0400
"Albert Huang" <ashuang@gmail.com> wrote:

> Many phones do not require authentication for OBEX Push.  You might try to
> use that instead of OBEX File Transfer to avoid the PIN issue.  take a look
> at ussp-push.
> 
> -albert

Thanks, Albert, and sorry for taking so long to check it
out. Unfortunately, ussp-push also requires a PIN. This is exactly
what I tried. First:

	obexftp -b 00:15:A8:F3:B5:DF -l
	Browsing 00:15:A8:E3:A5:DF ...
	Channel: 9
	No custom transport

Here the phone askes if I want to connect and I say Yes. Then it asks
me for a PIN which I type in (the same which is in /etc/bluetooth/pin)
and the phone tells me that the PIN is invalid. I can try the same or
any other...

	Connecting...failed: connect
	Still trying to connect
	Connecting...failed: connect
	Still trying to connect
	Connecting...failed: connect
	Still trying to connect

until, eventually, they give up. Then, with ussp-push:

	ussp-push --dev hci:0 00:15:A8:F3:B5:DF@1 test.jpg test.jpg
	pushing file test.jpg
	name=test.jpg, size=1377
	Registered transport

	set user data

	created new objext
	Local device 00:10:60:AA:BA:53
	Remote device 00:15:A8:E3:B5:DF (1)

Here I'm asked by the phone to type in the PIN.

	connect: Connection refused
	Link broken!

	started a new request
	Error while doing OBEX_HandleInput()
	Connection return code: -1, id: 0
	Local device 00:10:60:AA:BA:53
	Remote device 00:15:A8:C3:A5:DF (1)
	connect: Connection refused
	Link broken!
	Error while doing OBEX_HandleInput()unable to connect to the
	server error

ObexFTP is version 0.10.8, ussp-push is version v0.5.

What else could I try?

Thanks,

-- 
Cris


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
