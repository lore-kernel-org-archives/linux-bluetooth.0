Return-Path: <cyrus@holtmann.org>
Message-ID: <d89ddf300802211758x4a8e9991t868cfe5081523803@mail.gmail.com>
Date: Thu, 21 Feb 2008 18:58:26 -0700
From: "Brad Midgley" <bmidgley@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <50282bd30802211429h419f6342qb6ab4ac62cd20a69@mail.gmail.com>
MIME-Version: 1.0
References: <50282bd30802211429h419f6342qb6ab4ac62cd20a69@mail.gmail.com>
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

How significant is the volume drop in 4 subbands? Should we just leave
the decoder at 64 bit mults so we don't needlessly suffer quality
issues on faster platforms?

Brad

On Thu, Feb 21, 2008 at 3:29 PM, Cidorvan Leite <cidorvan@gmail.com> wrote:
> Hi!
>
>  I replaced the 64bits multiplies by 32bits and fixed the volume, now
>  the encode and decode are >10% faster.
>  Unfortunately, I couldn't keep the same volume for decode with 4 subbands...
>
> -------------------------------------------------------------------------
>  This SF.net email is sponsored by: Microsoft
>  Defy all challenges. Microsoft(R) Visual Studio 2008.
>  http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
> _______________________________________________
>  Bluez-devel mailing list
>  Bluez-devel@lists.sourceforge.net
>  https://lists.sourceforge.net/lists/listinfo/bluez-devel
>
>



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
