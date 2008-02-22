Return-Path: <cyrus@holtmann.org>
Message-ID: <d89ddf300802220746l72e55ba9lfa3b5b3aff2227b0@mail.gmail.com>
Date: Fri, 22 Feb 2008 08:46:29 -0700
From: "Brad Midgley" <bmidgley@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <50282bd30802220619v2eb77bafx86973131b65c3d19@mail.gmail.com>
MIME-Version: 1.0
References: <50282bd30802211429h419f6342qb6ab4ac62cd20a69@mail.gmail.com>
	<d89ddf300802211758x4a8e9991t868cfe5081523803@mail.gmail.com>
	<50282bd30802220600m73114ba8ya7bdb415d4d6057f@mail.gmail.com>
	<50282bd30802220619v2eb77bafx86973131b65c3d19@mail.gmail.com>
Subject: Re: [Bluez-devel] SBC optimizations
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Cidorvan

>  "I am not sure if last version(64bits) of decode with 4 subbands is
>  correct about overflows."

Some volume reduction is ok, especially if it means we avoid another overflow.

Anyway, it looks like the commit is in.

Thanks again.

-- 
Brad

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
