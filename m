Return-Path: <cyrus@holtmann.org>
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <EB2E724A-6D73-4349-B937-7935A8C4BEFB@holtmann.org>
References: <1200566602.26259.89.camel@cookie.hadess.net>
	<1200663790.2676.3.camel@cookie.hadess.net>
	<1201871693.2389.326.camel@cookie.hadess.net>
	<1201882130.2389.334.camel@cookie.hadess.net>
	<1201882826.2389.337.camel@cookie.hadess.net>
	<1202300325.3491.21.camel@cookie.hadess.net>
	<1202303303.3491.30.camel@cookie.hadess.net>
	<1202345972.3491.42.camel@cookie.hadess.net>
	<1203730228.2754.105.camel@cookie.hadess.net>
	<1203877746.2754.134.camel@cookie.hadess.net>
	<EB2E724A-6D73-4349-B937-7935A8C4BEFB@holtmann.org>
Date: Mon, 25 Feb 2008 10:56:37 +0000
Message-Id: <1203936997.2754.198.camel@cookie.hadess.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] [PATCH] Updated sendto
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


On Mon, 2008-02-25 at 03:21 +0100, Marcel Holtmann wrote:
> Hi Bastien,
> 
> >>>
> >>> And one that works with obex-data-server 0.1
> >>
> >> Updated against current CVS, and fix a memleak when getting the  
> >> adapters
> >> list. New main.c file attached as well, for easier review.
> >
> > Updated against current CVS.
> 
> I've been through the main.c as whole and the actual patch. As you  
> saw, I took the dialogs out of it since that made sense and was a sane  
> way to do it. I mentioned that I want small patches and if they are  
> small and logical, I apply them most of the times immediately. Smaller  
> patches are easier to review. I am not taking a big chunk blindly.
> 
> So current patch is not acceptable. It is actually bad. So first  
> action must be to remove all these useless comments. An example is this:
> 
> +       /* Go into main loop */
>          gtk_main();
> 
> Put comments where the code is unclear and not were everybody knows  
> what it is doing. This is a perfect example of wrongly commenting code.

Done locally.

> Second of all, I am unhappy with all this usage of gtk_main_quit() in  
> various functions. Can we not just structure the code a lot more  
> cleaner to avoid multiple calls of it.

I don't understand what you mean there.

>  Besides the signal handling, I  
> would expect one extra call in case we automatically wanna close the  
> progress dialog.

Why? If there's no errors, why would you want to see it's finished? What
information would be in the dialogue that could be useful?




-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
