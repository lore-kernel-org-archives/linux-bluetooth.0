Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Hi all !
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1101469734.16162.10.camel@baroque.rococosoft.com>
References: <41A6046D.30800@xgarreau.org> <1101423126.6465.19.camel@pegasus>
	 <41A6F456.5040005@prim-time.fr>
	 <1101469734.16162.10.camel@baroque.rococosoft.com>
Content-Type: text/plain
Message-Id: <1101489712.6514.27.camel@pegasus>
Mime-Version: 1.0
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
Date: Fri, 26 Nov 2004 18:21:52 +0100

Hi Steve,

> > Does it means that sdp_record_register closes the sdp_session when it is 
> > successful ? That would mean we need to di sdp_connect foreach record we 
> > have to add (I know, we usually only have only one to do at a time, but 
> > that seems "strange" to me)
> 
> I think this is a bug. The session should always be explicitly closed.
> Send in a patch :-)

actually it is not a bug. If you close the session the record would be
unregistered. However this is still somekind of ugly programming :(

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
