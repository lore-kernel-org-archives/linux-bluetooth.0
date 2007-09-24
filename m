Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Mon, 24 Sep 2007 15:22:03 -0400
From: Martin Stolle <mstoll@sus.mcgill.ca>
To: bluez-users@lists.sourceforge.net
Message-ID: <20070924192203.GA31266@sus.mcgill.ca>
References: <2759cf860709241213o33159203kad04d7a0fa2ecaf5@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <2759cf860709241213o33159203kad04d7a0fa2ecaf5@mail.gmail.com>
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

I've had similar experience with a bluetooth keyboard (which I am
switching between computers, hence the need to re-establish connection).
Before, a sudo hidd --search would re-establish the connectino.  Now, I
have to try that a couple of times before it spits out the MAC address.
Armed with the MAC address, I can now do sudo hidd --connect <MAC address>

It's definitely a regression from before (but might be more intended
behavior?  The weird part is that often, my keybaord will think the
connection is re-established after the hidd --search, but the computer
doesn't think so.  So I have to hit the reset/connect button on the
keyboard between all the --search and one last time before the
--connect.

Martin


On Mon, Sep 24, 2007 at 03:13:47PM -0400, Jared Greenwald wrote:
> I've had this setup for a year or so.  A nice bluetooth mouse and
> Kubuntu.  Currently, I'm running kubuntu 7.10 with the 2.6.22-12
> kernel and blueZ 3.19-0ubuntu1.
> 
> Every time I upgrade my kernel, I've had to re-establish my mouse's
> bluetooth connection by power-cycling it or hitting the reset button
> while running hiddev --search.  This time, when I upgraded, I cannot
> get the mouse to re-establish a connection.  I'm able to get hiddev to
> "see" the mac of my mouse, but it times out on getting any actual
> information that would make it usable as an input device.
> 
> Any thoughts or suggestions that people can think of, would be great.
> 
> Thanks in advance...
> -Jared
> 
> -------------------------------------------------------------------------
> This SF.net email is sponsored by: Microsoft
> Defy all challenges. Microsoft(R) Visual Studio 2005.
> http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
