Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <4152B58A.9080702@tut.fi>
From: =?ISO-8859-1?Q?Riikka_Jylh=E4?= <riikka.jylha@tut.fi>
Reply-To: riikka.jylha@tut.fi
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-users] How does hcidump work
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
Date: Thu, 23 Sep 2004 14:37:46 +0300

I'm using hcidump to analyse audio traffic. Samples are 8 bit long and 
voice setting is properly set. The link works just fine. The dump log 
shows that 24 byte long data packets are sent and received. Question is 
what does the hcidump actually measure. Does it really report the 
contents of SCO packets (HV1, HV2 and HV3) that are sent with BT radio 
or does it just sniff send and receive buffers? The 24 byte seems 
strange since the payload of packets is supposed to be 10, 20 or 30 
bytes. Is there something that I have not noticed?

-- 
Riikka Jylhä


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
