Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] cvs software issues
From: Marcel Holtmann <marcel@holtmann.org>
To: Dariusz Swiderski <sfires@sfires.net>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <40675F3B.5090704@sfires.net>
References: <40675F3B.5090704@sfires.net>
Content-Type: text/plain
Message-Id: <1080557069.2281.224.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 29 Mar 2004 12:44:30 +0200

Hi Dariusz,

> i just did a cvs co of libs libs2 utils utils2 on a clean system
> and i have faced following problems:
> 
> libs2 subdir is missinf the ltmain.sh script which is required by the
> bootstrap script

it should create it if it is missing.

> next thing, making libs and libs2 coexistatent on the system, what is
> your point of view?

Use another prefix for the new utils. I prefer /opt/bluetooth.

> i use hcid and some gnome utils which require libs
> and on the other hand i use hcid and so on which require libs2

You mean bthid which requires libs2 and using a different prefix solves
this problem.

There is no planned coexisting of both version and if libs2 and utils2
are ready for rollout it will replace the old one.

> what are your perspectives and how may i help, i really can help, but
> i dont want to spend 48 hours writeing sth. that will not agree with
> your point of view and thus would be therown into a trash can ;>
> 
> i have some free programming resource (time for example ;)
> and i would like to help, just tell me in which direction ;)

Every program that uses the old library must rewritten to use the new
one. Especially sdptool, pand and dund. The other big project is writing
a new sdpd.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
