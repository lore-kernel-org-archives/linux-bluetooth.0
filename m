Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Moritz Bunkus <moritz@bunkus.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] connection to Motorola V525 fails
Message-ID: <20040528214300.GH7737@bunkus.org>
References: <20040528154111.GD24083@bunkus.org> <1085766449.3321.50.camel@pegasus> <20040528180635.GA20450@bunkus.org> <1085770308.4516.3.camel@pegasus> <20040528201025.GA7737@bunkus.org> <1085776595.4516.24.camel@pegasus> <20040528204353.GB7737@bunkus.org> <1085777409.4516.32.camel@pegasus> <20040528205749.GE7737@bunkus.org> <1085778561.4516.34.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1085778561.4516.34.camel@pegasus>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri, 28 May 2004 23:43:00 +0200

Hi,

> this uses RFCOMM channel 8, which doesn't requests an authentication.
> Maybe you wanna try it ;)

Now I'm feeling really, really stupid. Yes, this does work nicely, in
both directions (with some app called 'opd', OBEX push demon, on the PC
side). All the time I've used the channel for the OBEX file transfer,
not for the push service...

Sorry for being dumb ;) and thanks for the solution.

Mosu

-- 
If Darl McBride was in charge, he'd probably make marriage
unconstitutional too, since clearly it de-emphasizes the commercial
nature of normal human interaction, and probably is a major impediment
to the commercial growth of prostitution. - Linus Torvalds


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
