Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Moritz Bunkus <moritz@bunkus.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] connection to Motorola V525 fails
Message-ID: <20040528201025.GA7737@bunkus.org>
References: <20040528154111.GD24083@bunkus.org> <1085766449.3321.50.camel@pegasus> <20040528180635.GA20450@bunkus.org> <1085770308.4516.3.camel@pegasus>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="liOOAslEiF7prFVr"
In-Reply-To: <1085770308.4516.3.camel@pegasus>
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
Date: Fri, 28 May 2004 22:10:25 +0200


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Marcel,

> you must make sure the you don't have a previous dumpfile while using
> hcidump -w, because it will append the HCI commands and events.

I'll remember that.

> However I don't see any data communication on the RFCOMM channel and
> that indicates that something is going wrong here. Please checkout the
> CVS repository obex and try the btobex tool from there.

Ok, I've downloaded the CVS from openobex and bluez' obex module. At
first 'btobex push ...' did not work at all because it does not parse
the channel number and always uses 0. The mobile did turn off the
screensaver (so it did receive something), but the question 'receive
obex file transfer' did not appear.

After modifying main.c and changing the channel number for the push
request to 9 I've got the same behaviour as before with the obextool
app. I've attached the binary dump.

Mosu

-- 
If Darl McBride was in charge, he'd probably make marriage
unconstitutional too, since clearly it de-emphasizes the commercial
nature of normal human interaction, and probably is a major impediment
to the commercial growth of prostitution. - Linus Torvalds

--liOOAslEiF7prFVr
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="btobex-push-bin.dump"
Content-Transfer-Encoding: base64

EQAAAPKbt0DemAcAAQUEDZPBuygKABjMAgAAAAEHAAEA8pu3QGi0BwAEDwQAAQUEDgABAPWb
t0DhRA0ABAMLACkAk8G7KAoAAQARAAAA9Zu3QPZEDQACKSAMAAgAAQACAQQAAwBAAAgAAAD1
m7dA/EQNAAENCAQpAA8ACAABAPWbt0BTXA0ABBMFASkAAQAGAAEA9Zu3QHZ/DQAEGwMpAAUJ
AAEA9Zu3QEeHDQAEDgYBDQgAKQAVAAEA9Zu3QMDwDQACKSAQAAwAAQADAQgAQABAAAAAAAAV
AAAA9Zu3QM7wDQACKSAQAAwAAQAEAggAQAAAAAECAAQVAAEA9Zu3QKn0DQACKSAQAAwAAQAE
YggAQAAAAAEC4gUTAAAA9Zu3QLP0DQACKSAOAAoAAQAFYgYAQAAAAAAACAABAPWbt0C1Gw4A
BBMFASkAAQAIAAEA9Zu3QIEjDgAEEwUBKQABABcAAQD1m7dA02kOAAIpIBIADgABAAUCCgBA
AAAAAAABAgAEDQAAAPWbt0DpaQ4AAikgCAAEAEAAAz8BHAgAAQD1m7dAQoEOAAQTBQEpAAEA
DQABAPWbt0Bb+g4AAikgCAAEAEAAA3MB1xcAAAD1m7dAePoOAAIpIBIADgBAAAPvFYMREvAH
APsDAAdwCAABAPWbt0CWGQ8ABBMFASkAAQAXAAEA9pu3QBQ1AAACKSASAA4AQAAB7xWBERLg
BwD7AwAAqg0AAAD2m7dAIjUAAAIpIAgABABAAEs/ATIIAAEA9pu3QIJMAAAEEwUBKQABAAkA
AQD2m7dAhxsBAAQXBpPBuygKABoAAAD2m7dAHBwBAAELBBaTwbsoCgB/FfxojKGPqqtoZ59N
omyvDQABAPabt0AEWgEABA4KAQsEAJPBuygKAAcAAQD2m7dA898GAAQIBAApAAENAAAAEJy3
QNqMBwACKSAIAAQAQABLUwHTDQAAABCct0ABjQcAAikgCAAEAEAAA1MB/REAAAAQnLdACY0H
AAIpIAwACAABAAYDBABAAEAACAABABCct0BbpQcABBMFASkAAQAIAAEAEJy3QCytBwAEEwUB
KQABAAgAAQAQnLdA9LQHAAQTBQEpAAEAEQABABCct0CXQQgAAikgDAAIAAEABwMEAEAAQAAH
AAAAEpy3QN4/CAABBgQDKQATBwABABKct0BDWAgABA8EAAEGBAcAAQASnLdAx5YIAAQFBAAp
ABY=

--liOOAslEiF7prFVr--


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
