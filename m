Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [PATCH] Check return code of pin helper.
From: David Woodhouse <dwmw2@infradead.org>
To: Max Krasnyansky <maxk@qualcomm.com>
Cc: bluez-devel@lists.sourceforge.net
In-Reply-To: <5.1.0.14.2.20030428145348.106adde0@unixmail.qualcomm.com>
References: <1051440611.2850.138.camel@imladris.demon.co.uk>
	<1051440611.2850.138.camel@imladris.demon.co.uk>
	<5.1.0.14.2.20030428145348.106adde0@unixmail.qualcomm.com>
Content-Type: text/plain
Message-Id: <1051598832.2850.189.camel@imladris.demon.co.uk>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: 
	<https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: 
	<http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 29 Apr 2003 07:47:13 +0100

On Mon, 2003-04-28 at 22:55, Max Krasnyansky wrote:
> You said that bluepin still doesn't work even if you fix libfontconfig.
> Do you know why ?

Not really -- it's a fontconfig or pango bug. If $HOME is set to
"/somewhere/bogus" it works, if $HOME is NULL it doesn't. 

Sounds like a failure to get a filename for a user config file is having
a more fatal effect than getting a potential filename but not being able
to open it, or something like that.

> btw I want to replace Python bluepin script with a little gtk app in
> later versions of bluez-utils.

OK. 

-- 
dwmw2




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
