Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <40675F3B.5090704@sfires.net>
From: Dariusz Swiderski <sfires@sfires.net>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: [Bluez-devel] cvs software issues
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
Date: Mon, 29 Mar 2004 01:26:51 +0200

hey

i just did a cvs co of libs libs2 utils utils2 on a clean system
and i have faced following problems:

libs2 subdir is missinf the ltmain.sh script which is required by the
bootstrap script

next thing, making libs and libs2 coexistatent on the system, what is
your point of view?

i use hcid and some gnome utils which require libs
and on the other hand i use hcid and so on which require libs2

what are your perspectives and how may i help, i really can help, but
i dont want to spend 48 hours writeing sth. that will not agree with
your point of view and thus would be therown into a trash can ;>

i have some free programming resource (time for example ;)
and i would like to help, just tell me in which direction ;)

greets
-- 
Maciej 'sfires' Swiderski
---------------------------------------------------
SysAdm | SecOff  | DS14145-RIPE        | DS11-6BONE
193.178.161.0/24 | 3ffe:8010:7:2a::/64 | AS16288
---------------------------------------------------
A mouse is a device used to point at the xterm you want to type in.



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
