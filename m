Return-Path: <cyrus@holtmann.org>
Message-ID: <8a8adccc0802100831k107d6d0akc0cfe388b61b7810@mail.gmail.com>
Date: Sun, 10 Feb 2008 17:31:43 +0100
From: "Jaap A. Haitsma" <jaap@haitsma.org>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1202659315.7664.88.camel@violet>
MIME-Version: 1.0
References: <8a8adccc0802100701y384d23f6oeb12c7a8d0fe4f83@mail.gmail.com>
	<1202659315.7664.88.camel@violet>
Subject: Re: [Bluez-devel] [PATCH] Use new tango icon for bluez gnome
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

On Feb 10, 2008 5:01 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Jaap,
>
> > Andreas Nilson has made new tango icons for bluez-gnome. (The
> > stock_bluetooth icon will be removed from gnome-icon-theme, because
> > it's deprecated)
>
> do icons really should belong in the package itself. I was under the
> impression that it is better to have them in a common package and the
> applications are going to reference them only. I am happy to follow the
> GNOME policy here, but someone has to tell me what is the current way to
> go for these.

The GNOME policy is that only the icons of the icon naming
specification [1] will be in gnome icon theme. Apps have to ship there
own icons.


> If we are re-working the icon anyway, then I like to request a grayed
> out icon (for disabled or inactive adapters) and one that indicates an
> active state. For example with yellow instead of white for the bind
> rune.
>
Shall we start with applying this patch? It makes bluez-gnome blend in
better with current desktops and we don't depend on gnome-icon-theme
anymore. There is already a request to remove the stock_bluetooth icon
[2]

I'll ask Andreas if he can cook up bluetooth-enabled and
bluetooth-disabled icons

Jaap

[1] http://standards.freedesktop.org/icon-naming-spec/icon-naming-spec-latest.html
[2] http://bugzilla.gnome.org/show_bug.cgi?id=505116

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
