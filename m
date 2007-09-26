Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Wed, 26 Sep 2007 18:18:21 -0400
From: Martin Stolle <mstoll@sus.mcgill.ca>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Message-ID: <20070926221821.GA24681@sus.mcgill.ca>
References: <1190672090.5133.133.camel@aeonflux.holtmann.net>
	<20070924222152.GA13130@sus.mcgill.ca>
	<1190675554.5133.151.camel@aeonflux.holtmann.net>
	<20070924232149.GA14346@sus.mcgill.ca>
	<2759cf860709250450yc36a945m846bd529d006b289@mail.gmail.com>
	<e1effdeb0709250524n16217623p194a891fa858810c@mail.gmail.com>
	<20070925123441.GA1032@sus.mcgill.ca>
	<20070926113035.GC8781@suse.de>
	<20070926140507.GA5913@sus.mcgill.ca>
	<1190844390.6484.30.camel@aeonflux.holtmann.net>
MIME-Version: 1.0
In-Reply-To: <1190844390.6484.30.camel@aeonflux.holtmann.net>
Subject: Re: [Bluez-users] help with Logitech Travel Mouse
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

On Thu, Sep 27, 2007 at 12:06:30AM +0200, Marcel Holtmann wrote:
> 
> For the hidd case we provide smooth transition. So once you connected
> via --search and --connect the new input service will pick up that HID
> device on next boot and make it work. However --search and --connect and
> are one-time commands only. No matter what you think or what you want or
> what you read somewhere else. If you use them in a wrong why, then that
> is your problem.
> 

Thank you very much.  I didn't realize that hidd were supposed to still
work.  I will look into writing a python tool that does what I want to
do.  However, I still don't quite understand why the hidd behavior has
changed and/or why it is incorrect to use them more then once.  In
particular, in the case where a device (keyboard/mouse) was once paired
with a computer, but then has been re-paired with another computer.  If
I want to reconnect the keyboard/mouse to the first computer, wouldn't I
have to re-issue a hidd --connect <MAC> ?  (or the equivalent D-Bus
calls?)

Thanks,
  Martin


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
