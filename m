Return-Path: <cyrus@holtmann.org>
Message-ID: <50282bd30802220600m73114ba8ya7bdb415d4d6057f@mail.gmail.com>
Date: Fri, 22 Feb 2008 11:00:50 -0300
From: "Cidorvan Leite" <cidorvan@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <d89ddf300802211758x4a8e9991t868cfe5081523803@mail.gmail.com>
MIME-Version: 1.0
References: <50282bd30802211429h419f6342qb6ab4ac62cd20a69@mail.gmail.com>
	<d89ddf300802211758x4a8e9991t868cfe5081523803@mail.gmail.com>
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

Hi Brad!

The volume drop is not significant.
Comparing the versions, I didn't see any change in quality with my
headphone, so I think that we can change to 32bits.
By the way, I am not sure if last version of decode with 4 subbands is
correct about overflows.

On Thu, Feb 21, 2008 at 10:58 PM, Brad Midgley <bmidgley@gmail.com> wrote:
> Cidorvan
>
>  How significant is the volume drop in 4 subbands? Should we just leave
>  the decoder at 64 bit mults so we don't needlessly suffer quality
>  issues on faster platforms?
>
>  Brad
>
>
>
>  On Thu, Feb 21, 2008 at 3:29 PM, Cidorvan Leite <cidorvan@gmail.com> wrote:
>  > Hi!
>  >
>  >  I replaced the 64bits multiplies by 32bits and fixed the volume, now
>  >  the encode and decode are >10% faster.
>  >  Unfortunately, I couldn't keep the same volume for decode with 4 subbands...
>  >
>  > -------------------------------------------------------------------------
>  >  This SF.net email is sponsored by: Microsoft
>  >  Defy all challenges. Microsoft(R) Visual Studio 2008.
>  >  http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
>  > _______________________________________________
>  >  Bluez-devel mailing list
>  >  Bluez-devel@lists.sourceforge.net
>  >  https://lists.sourceforge.net/lists/listinfo/bluez-devel
>  >
>  >
>
>
>
>  --
>  Brad
>
>  -------------------------------------------------------------------------
>  This SF.net email is sponsored by: Microsoft
>  Defy all challenges. Microsoft(R) Visual Studio 2008.
>  http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
>  _______________________________________________
>  Bluez-devel mailing list
>  Bluez-devel@lists.sourceforge.net
>  https://lists.sourceforge.net/lists/listinfo/bluez-devel
>

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
