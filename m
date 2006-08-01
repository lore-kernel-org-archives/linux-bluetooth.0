Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Mon, 31 Jul 2006 17:12:07 -0700
From: John Gruenenfelder <johng@as.arizona.edu>
To: bluez-users@lists.sourceforge.net
Message-ID: <20060801001207.GA5092@as.arizona.edu>
MIME-Version: 1.0
Subject: [Bluez-users] Pairing problem with Plantronics headset
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

I am attempting to use btsco with my Plantronics M2500 headset.  I am using
the most recent Debian bluez-utils packages (3.1-3).

The headset's passkey/pin is "0000" which I have set in both
/etc/bluetooth/hcid.conf as:
  passkey "0000";

and in /etc/bluetooth/passkeys/default as just "0000".

When I turn on the headset, put it in pairing mode, and then attempt to run
btsco, I get the following from btsco:

-----
./btsco 00:03:89:6E:C9:11
Error: Failed to connect to SDP server: Permission denied
Assuming channel 2

Can't connect RFCOMM channel: Permission denied
-----

In the system logs the only new entries generated are:

Jul 31 19:32:52 Redtail hcid[5743]: pin_code_request (sba=00:16:41:89:98:00, dba=00:03:89:6E:C9:11)
Jul 31 19:32:52 Redtail hcid[5743]: Calling PasskeyAgent.Request: name=:1.5, path=/org/bluez/passkey_agent_5755
Jul 31 19:32:56 Redtail hcid[5743]: pin_code_request (sba=00:16:41:89:98:00, dba=00:03:89:6E:C9:11)
Jul 31 19:32:56 Redtail hcid[5743]: Calling PasskeyAgent.Request: name=:1.5, path=/org/bluez/passkey_agent_5755

To me, these seem to indicate that the PIN is being requested, but perhaps not
being returned properly?  I also tried creating a passkey explicitly for this
device as:
  /etc/bluetooth/passkeys/00:03:89:6E:C9:11

But the log messages were the same for this instance.  What am I doing wrong?
Thanks in advance.


-- 
--John Gruenenfelder    Research Assistant, UMass Amherst student
                        Systems Manager, MKS Imaging Technology, LLC.
Try Weasel Reader for PalmOS  --  http://gutenpalm.sf.net
"This is the most fun I've had without being drenched in the blood
of my enemies!"
        --Sam of Sam & Max

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
