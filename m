Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Pavel Ruzicka <pavouk@pavouk.org>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Help sending a file
Cc: m r <captain512@yahoo.com>
References: <20050125034251.95495.qmail@web54509.mail.yahoo.com>
In-Reply-To: <20050125034251.95495.qmail@web54509.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200501251129.30247.pavouk@pavouk.org>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue, 25 Jan 2005 11:29:30 +0100

Hello,

You can use PAN profile. This is something like "ethernet over bluetooth".
One side you must setup like a server.
On linux you must have running hcid, sdpd and pand --listen.
You must preconfigure interface bnep0 which is on some systems
at /etc/sysconfig/network-scripts/ifcfg-bnep0.
When client side tried to connect network to server, then pand activate
interface bnep0. You will see it in ifconfig.
You can try to ping between client and server.
When the connection is established, you can use standard applications,
like on metalic ethernet.
For example SMB (Samba server, windows client), FTP server - client,
SSH server - WinSCP klient or anything else...

Other informations you can find here: http://www.holtmann.org/linux/bluetooth/
Specially PAND howto. Some informations are outdated.
Maybe someone else knows better information sources.
You can try google...

Best regards,

Pavel Ruzicka


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
