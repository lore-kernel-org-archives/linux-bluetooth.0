Return-Path: <bluez-devel-admin@lists.sourceforge.net>
To: bluez-devel@lists.sourceforge.net
From: Matthias =?utf-8?b?QnJ1bsOp?= <matthiasbrune@gmx.de>
Message-ID: <loom.20050125T121015-316@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Subject: [Bluez-devel] Bypass for L2CAP packets
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 25 Jan 2005 11:11:43 +0000 (UTC)

Hi Folks,
sorry for a question to the same problem again...
I have a (problem) with the L2CAP layer from BlueZ.
I wrote a program that communicates with a mobile phone by using its own L2CAP 
layer (the program builds its own L2CAP packets for protocol testing).
For example I send a valid "connection request" to that phone and the phone 
answers with a valid "connection response".
So far so good. 
But then the L2CAP layer from BlueZ sends a "command reject", because this 
layer doesn´t know about the "connection request" and cannot handle 
the "connection response".
Ok, i understand that. 
But has anybody an idea how i can communicate with my own L2CAP layer and the 
phone only without using the BlueZ L2CAP layer, because the Bluez layer always 
prevents a further communication?
Hmm... is in this case the L2CAP RAW socket the solution?
I´m stucked with that problem and i hope anybody as an idea.

Many thanks.

Matthias



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
