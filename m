Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Malte Steiner <steiner@mobileart.org>
To: bluez-users@lists.sourceforge.net
Date: Sun, 24 Jun 2007 02:44:37 +0200
Message-Id: <1182645877.4614.18.camel@localhost>
Mime-Version: 1.0
Subject: [Bluez-users] passkey-agent says Invalid arguments for passkey
	Request method
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hello,

I try to get passkey-agent to run so phones which need authentication
when they got something Obex Pushed recieves a default pin.

When my phone send the pin to the Linuxcomputer, passkey-agent come up
with this error line

Invalid arguments for passkey Request method

which I couldnt find any information or in the source code of
passkey-agent.

The agent is running with

passkey-agent --default 1234

Thanks for any help,

Malte Steiner



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
