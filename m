Return-Path: <cyrus@holtmann.org>
Message-ID: <2d5a2c100803041359h5d726e9fv5c144fcfc8fd17ae@mail.gmail.com>
Date: Tue, 4 Mar 2008 18:59:13 -0300
From: "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <47CC3EEB.6060105@access-company.com>
MIME-Version: 1.0
References: <47CC3DF5.8070303@access-company.com>
	<47CC3EEB.6060105@access-company.com>
Subject: Re: [Bluez-devel] [patch] alsa plugin disconnection
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Committed, even though rhythmbox (alsasink) seems to not handle the
disconnect properly.

On Mon, Mar 3, 2008 at 3:09 PM, Fr=E9d=E9ric Dalleau
<frederic.dalleau@access-company.com> wrote:
>
>  updated patch.
>
>
>
>  Fr=E9d=E9ric Dalleau wrote:
>  > Hi,
>  >
>  > This patch will allow alsa plugin to detect disconnection of devices a=
nd
>  > return error to applications.
>  > Not all applications will handle this error, but at least it is availa=
ble.
>  >
>  > Comments are welcome.
>  >
>  > Frederic
>  >
>  >
>  > ----------------------------------------------------------------------=
---
>  > This SF.net email is sponsored by: Microsoft
>  > Defy all challenges. Microsoft(R) Visual Studio 2008.
>  > http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
>  > _______________________________________________
>  > Bluez-devel mailing list
>  > Bluez-devel@lists.sourceforge.net
>  > https://lists.sourceforge.net/lists/listinfo/bluez-devel
>  >
>
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



-- =

Luiz Augusto von Dentz
Engenheiro de Computa=E7=E3o

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
