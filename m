Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [PATCH] More SDP UUIDs...
From: Marcel Holtmann <marcel@holtmann.org>
To: Jean Tourrilhes <jt@hpl.hp.com>
Cc: Stephen Crane <steve.crane@rococosoft.com>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20030917003609.GA27263@bougret.hpl.hp.com>
References: <20030915221624.GA17085@bougret.hpl.hp.com>
	<1063712005.22723.27.camel@pegasus>
	<20030916195333.GA25068@bougret.hpl.hp.com>
	<1063755753.29942.9.camel@pegasus>
	<20030917000637.GA26969@bougret.hpl.hp.com>
	<1063758501.29942.47.camel@pegasus>
	<20030917003609.GA27263@bougret.hpl.hp.com>
Content-Type: text/plain
Message-Id: <1063760338.29941.59.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: 17 Sep 2003 02:58:52 +0200

Hi Jean,

> > I forgot to mention that I started from scratch and the output you see
> > above is a textual presentation of the new internal data structure. The
> > core attributes id's and the UUID16's are decoded into strings, because
> > they are unique. All other meanings of some data elements depends on
> > others. I have to add some checks which makes sure that this is a valid
> > SDP record, before I can do this.
> 
> 	Well... What was wrong with the code I wrote in listattr.c ?
> It did all of that properly and simply, and it was trivial to add new
> UUIDs and attributes. I don't see what you have gained here...

there was nothing wrong with that code and I think my final code for
that part will look very similar. My problem is the current API itself,
because it is a mess and if you have to do more complicated things with
SDP you are simply lost.

Regards

Marcel




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
