Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [PATCH] Check return code of pin helper.
From: David Woodhouse <dwmw2@infradead.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <1051440611.2850.138.camel@imladris.demon.co.uk>
References: <1051440611.2850.138.camel@imladris.demon.co.uk>
Content-Type: text/plain
Message-Id: <1051448314.2850.181.camel@imladris.demon.co.uk>
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
Date: Sun, 27 Apr 2003 13:58:34 +0100

On Sun, 2003-04-27 at 11:50, David Woodhouse wrote:
> On Red Hat 9, the python interpreter segfaults when running bluepin if
> hcid is started from the init script, but it all works fine if hcid was
> started from a command prompt. This confuses me,

This no longer confuses me. It's a fontconfig bug when there's no 'HOME'
in the environment. Fixing the segfault in libfontconfig leaves bluepin
still not working -- although setting $HOME to something bogus _does_
work. I've worked around it in bluepin in the bluez-utils-2.3-4 package
which should be in rawhide some time soon.

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
