Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Mon, 24 Sep 2007 19:21:49 -0400
From: Martin Stolle <mstoll@sus.mcgill.ca>
To: bluez-users@lists.sourceforge.net
Message-ID: <20070924232149.GA14346@sus.mcgill.ca>
References: <2759cf860709241213o33159203kad04d7a0fa2ecaf5@mail.gmail.com>
	<20070924192203.GA31266@sus.mcgill.ca>
	<2759cf860709241233w621bd23akf3882800ad48cc28@mail.gmail.com>
	<1190672090.5133.133.camel@aeonflux.holtmann.net>
	<20070924222152.GA13130@sus.mcgill.ca>
	<1190675554.5133.151.camel@aeonflux.holtmann.net>
MIME-Version: 1.0
In-Reply-To: <1190675554.5133.151.camel@aeonflux.holtmann.net>
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

On Tue, Sep 25, 2007 at 01:12:34AM +0200, Marcel Holtmann wrote:
> Hi Martin,
> 
> > > > Yea, I would think that would fix things, but I tried that (the hidd
> > > > --connect) and it doesn't seem to work to get connected...
> > > 
> > > use the new input service and don't use hidd. The input service will
> > > convert your configured devices automatically. There is no need to use
> > > hidd --search or hidd --connect more than once. Whoever tells you
> > > differently is wrong. Period.
> > 
> > Thanks, I didn't know that. how do you solve the problem at hand then?
> > What are the commands to use for the new input service?  Which man pages
> > should I look at?
> 
> checkout wiki.bluez.org. It has all the examples.
> 

Sorry, but I can't find any end-user examples on the wiki.  They are all
programming examples in C and python.  Are you saying that the simple
"hidd --search" tool call has been replaced by having to write a whole
python program?  That's seems like quite a regression.  Or maybe I am
not able to find the appropriate page?

Martin


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
