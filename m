Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <a654bb710709210254x416bab8atcabebcadf8a6523@mail.gmail.com>
Date: Fri, 21 Sep 2007 12:54:05 +0300
From: "Lari Tuononen" <lari@tuononen.fi>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <1190272091.5525.149.camel@aeonflux.holtmann.net>
MIME-Version: 1.0
References: <a654bb710709191343o3472b21auddee76f608ff710@mail.gmail.com>
	<1190272091.5525.149.camel@aeonflux.holtmann.net>
Subject: Re: [Bluez-users] PS3 remote working?
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

On 20/09/2007, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Lari,
>
> > Has anyone gotten the playstation 3 BD remote working as a remote
> > controller? There has been some discussion about it earlier, anyone
> > gotten further in getting it working smoothly?
>
> the PS3 remote control is basically working. However we are still
> missing a nice integration into the input service.

I've noticed this now that I got my bluetooth dongle. The remote
connects well and registers as /dev/input/eventX but nothing comes
out...

Are there any plans to make the input service thing work better or how
 this is done? Would the code need only the mapping of the codes sent
by the remote to right uinput codes?

There are some python scripts that convert the PS3 keypresses with
uinput to /dev/input/eventX. But this is not very convenient
solution...

Best regards,

Lari Tuononen

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
