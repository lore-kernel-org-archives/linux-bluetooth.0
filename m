Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Collin R. Mulliner" <collin@betaversion.net>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] apple wireless keyboard
Message-Id: <20040614143144.6a5ecfc8@coredump>
In-Reply-To: <40C9FD7B.6000004@gmx.net>
References: <40C9FD7B.6000004@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
Date: Mon, 14 Jun 2004 14:31:44 +0200

Hi Simone,

quick answer is: the apple wireless keyboard works 100% with bluez-hidd.

I had to active authentication (on the laptop side), then just wait
until you get the bluepin popup asking for a pin, type in the pin on the
laptop side and on the apple wireless keyboard (press enter after
entering the pin!).

hidd runs with the --server option


... Collin

-- 
Collin R. Mulliner <collin@betaversion.net>
BETAVERSiON Systems [www.betaversion.net]
info/pgp: finger collin@betaversion.net
RTFM: No just an acronym, it's the LAW!


-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the
one installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
