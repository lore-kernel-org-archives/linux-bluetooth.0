Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Mayank BATRA <mayank.batra@st.com>
To: "'Sergey Smirnov'" <svs1957@gmail.com>
Date: Wed, 11 Apr 2007 12:11:14 +0530
Message-ID: <004401c77c04$66bcef80$9d0cc70a@dlh.st.com>
MIME-Version: 1.0
In-Reply-To: <461C8164.8010705@gmail.com>
Cc: "'BlueZ development'" <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] btsco: Operation not supported
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

> Sorry for stupid question.
> Part of what you want to see?

Actually, I wanted to see Add SCO connection command on hcidump.
Not the source code! Just wanted to see what packet types are going
in the command.

[...]
> >> Here is some part of hcidump while sco connect:
> >>> HCI Event: Number of Completed Packets (0x13) plen 5
> >>     handle 1 packets 1
> >>> HCI Event: Command Status (0x0f) plen 4
> >>     Add SCO Connection (0x01|0x0007) status 0x11 ncmd 4
> >>     Error: Unsupported Feature or Parameter Value
> > 
> > Can you provide the part showing the Add SCO connection command?
> > You might have to try different packet types.

Best Regards,

Mayank


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
