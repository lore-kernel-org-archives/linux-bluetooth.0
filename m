Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] patch for d-bus support in hcid
From: David Woodhouse <dwmw2@infradead.org>
To: Philip Blundell <pb@nexus.co.uk>
Cc: bluez-devel@lists.sourceforge.net
In-Reply-To: <1056040950.3518.18.camel@mill.nexus.co.uk>
References: <1056040950.3518.18.camel@mill.nexus.co.uk>
Message-Id: <1062710287.32473.12.camel@hades.cambridge.redhat.com>
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
Date: Thu, 04 Sep 2003 22:18:08 +0100
Content-Type: text/plain

On Thu, 2003-06-19 at 17:42 +0100, Philip Blundell wrote:
> This patch adds support to hcid for PIN requests using D-BUS.  (See
> http://www.freedesktop.org/software/dbus/ if you don't know what D-BUS
> is about.)

 -  | K_PINHELP  PATH    {
 +  | K_PINHELP  WORD    {

It also removes support for actually configuring a pin helper as before.
Reverting the above removes support for the magic '*dbus' value. 

+       if (hcid_dbus_init () == FALSE) {
+               syslog (LOG_ERR, "Unable to get on D-BUS");
+               exit (1);

... and then it disables support for running hcid on any system on which
dbus isn't actually active, even if not configured to _use_ dbus. :)

I suspect we should just be using a script wrapper around 
dbus-send, or a simple external program, rather than putting support for
dbus directly into hcid.

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
