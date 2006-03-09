Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Dave Mielke <dave@mielke.cc>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] PIN helper
Message-ID: <20060309055552.GB4516@beta.private.mielke.cc>
References: <20060308221925.17d20407.fotopiper@o2.pl> <20060308214031.GZ4516@beta.private.mielke.cc> <20060308230109.202dc5ff.fotopiper@o2.pl> <20060308221644.GA4516@beta.private.mielke.cc> <20060309064424.584539d2.fotopiper@o2.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060309064424.584539d2.fotopiper@o2.pl>
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 9 Mar 2006 00:55:52 -0500

[quoted lines by Radek Rurarz on 2006/03/09 at 06:44 +0100]

>if the permissions are wrong (the
>propper ones set in a config file, or in the script itself) the script
>should not use the file and either refuse the connection = ERR (and
>syslog the error) or fallback to other methods of geting the PIN (if
>allowed).

Done. I won't let the permissions be more than 600 (although I'll perhaps add
an option to override that). The logging is done too.

>> >2. an option to chose wheather a promp should be used even if there
>> >is no pin in the file, 

This one (-n for no prompt) has now been done.

>> >possibly to chose another pinhelper if there
>> >is no pin (for instance the one for X, if that fails to create a
>> >promp).

This one will take some thought. It could check to see if X is running, and
then run the X one if so and do the text-mode thing otherwise. If that's okay,
the option would be something like: -x /etc/bluetooth/xbluepin

>> >3. In the pins file another 'slot' for the name of the device
>> >(not nessesary the one advertised by it, rather to have an idea whot
>> >is it)

The script actually already did that, i.e. it ignores data after the PIN. Now
it's documented, though, and even with an example.

-- 
Dave Mielke           | 2213 Fox Crescent | I believe that the Bible is the
Phone: 1-613-726-0014 | Ottawa, Ontario   | Word of God. Please contact me
EMail: dave@mielke.cc | Canada  K2A 1H7   | if you're concerned about Hell.
http://FamilyRadio.com/                   | http://Mielke.cc/bible/


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
