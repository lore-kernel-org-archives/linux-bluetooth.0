Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <473CFED1.7050806@szift.org>
Date: Fri, 16 Nov 2007 03:22:09 +0100
From: =?ISO-8859-2?Q?=A3ukasz_Hejnak?= <szift@szift.org>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <473BF56D.8010301@szift.org>
In-Reply-To: <473BF56D.8010301@szift.org>
Subject: Re: [Bluez-users] LAN over bluetooth connection hangs [SOLVED]
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-2"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi
[for the impatient, scroll half way down for the solution - look for a =

'whoa']

Thought I'll update this thread with some info I gathered today.
First off, I'm using bluez version 3.22
I read the http://bluez.sourceforge.net/contrib/HOWTO-PAN and redone my =

configuration according to the second example, the effect is exactly the =

same: the connection get's established, I can send ICMP packets as well =

as small portions of information (like establishing an ssh session) and =

this works well. I left the ping working for an hour and everything =

worked ok.
BUT the minute I try to send/receive a bigger chunk of data (like load a =

webpage or do `dmesg` on my ssh terminal) the connection freezes.
Everything seems to be in order, `pand -l` shows the connection, =

`hcitool scan` shows the other interface, `hcidump -i hci0` shows no =

disruption at all. The packets are still flying back and forth, but icmp =

packets stop arriving, and everything else freezes as well.
`ifconfig bnep0` shows no errors/dropped/overruns/collisions etc.
MTU is set to 1500...

*whoa* here we go, just tried to set the mtu to something smaller like =

1000 and there it went.. for a moment longer - I managed to load up a =

page in lynx.. it worked for a while and then froze again
then I reduced the mtu on both sides to 500 and it works now
Just added `ifconfig bnep0 mtu 500` to both bnep0 init scripts (-u pand =

option) and it's done.
Strange though, none of the docs/how-to's I came across mention anything =

about changing the bnep0 interfaces mtu, but I'd shoot it's because of =

the damned cheap bluetooth dongles.
Anyway it works great & fast now. We'll see for how long.

-- =

Best Wishes
=A3ukasz 'Szift' Hejnak
jid: Szift@jabster.pl
email: Lukasz@Hejnak.pl

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
