Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [PATCH] More SDP UUIDs...
From: Marcel Holtmann <marcel@holtmann.org>
To: Jean Tourrilhes <jt@hpl.hp.com>
Cc: Stephen Crane <steve.crane@rococosoft.com>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20030915221624.GA17085@bougret.hpl.hp.com>
References: <20030915221624.GA17085@bougret.hpl.hp.com>
Content-Type: text/plain
Message-Id: <1063712005.22723.27.camel@pegasus>
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
Date: 16 Sep 2003 13:33:20 +0200

Hi Jean,

> 	I've just realised that you didn't keep the UUID and attribute
> list of sdptool in sync. The patch below correct this.

I have applied your patch, thanks.

> 	Also : I believe that having in the sdp library all the
> functions xxx2str() (uuid2str, sdp_proto_uuid2strn...) and their
> associated data (struct tupla ServiceClass...) is not
> necessary.
> 	Realistically, only sdptool or a graphical equivalent would
> use those functions, the vast majority of users of the library would
> be like 'pand' and only create or search SDP records.
> 	Moving this functionality to sdptool would allow to reduce
> further the size of the SDP library.

I like to keep this functions in the library, because they are a good
for debugging and they can be shared between any graphical and terminal
SDP tools. Anyway it seems to me like a good idea to have a compile
switch to disable the string arrays and let the functions return NULL
instead. People which care about the library size can use it.

My work on the 4th (or maybe 5th) generation of a SDP library is making
good progress and I hope that I will have clean code for publishing very
soon.

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
