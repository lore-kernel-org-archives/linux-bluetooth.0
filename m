Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <41F63277.9060907@prim-time.fr>
From: Xavier Garreau <x.garreau@prim-time.fr>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Bypass for L2CAP packets
References: <loom.20050125T121015-316@post.gmane.org>
In-Reply-To: <loom.20050125T121015-316@post.gmane.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Date: Tue, 25 Jan 2005 12:50:15 +0100

> sorry for a question to the same problem again...
> I have a (problem) with the L2CAP layer from BlueZ.
> I wrote a program that communicates with a mobile phone by using its ow=
n L2CAP=20
> layer (the program builds its own L2CAP packets for protocol testing).
> For example I send a valid "connection request" to that phone and the p=
hone=20
> answers with a valid "connection response".
> So far so good.=20
> But then the L2CAP layer from BlueZ sends a "command reject", because t=
his=20
> layer doesn=C2=B4t know about the "connection request" and cannot handl=
e=20
> the "connection response".
> Ok, i understand that.=20
> But has anybody an idea how i can communicate with my own L2CAP layer a=
nd the=20
> phone only without using the BlueZ L2CAP layer, because the Bluez layer=
 always=20
> prevents a further communication?
> Hmm... is in this case the L2CAP RAW socket the solution?
> I=C2=B4m stucked with that problem and i hope anybody as an idea.

You can unload the l2cap module.

BR,
Xavier Garreau
http://www.xgarreau.org/


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
