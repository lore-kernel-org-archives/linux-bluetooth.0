Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Jan Sobek <honza@sis.vutbr.cz>
To: bluez-users@lists.sourceforge.net
Message-ID: <20040702105653.GF13439@sis.vutbr.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-users] bluetooth - 6310i - iBook
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
Date: Fri, 2 Jul 2004 12:56:53 +0200

Hello,

I'm trying to connect ibook and nokia 6310 using bluetooth adapter by
microcom.

same configuration works for me on my desktop, but on ibook works
only.
	hcitool scan
	hcitool info xx.xx.xx.xx.xx.xx

gnokii --monitor
GNOKII 0.6.1
Couldn't open PHONET device: No such file or directory
Telephone interface init failed: Command failed.
Quitting

rfcomm connect rfcomm0 xx.xx.xx.xx.xx.xx
Can't connect RFCOMM socket: Connection refused

On phone is pin request.


can you help me?

thank you

-- 
Honza


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
