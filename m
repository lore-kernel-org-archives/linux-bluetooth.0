Return-Path: <cyrus@holtmann.org>
Message-Id: <3E374F75-1F23-4B9E-89EB-BF25C688822F@gmail.com>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <b535981e0802282142m3e132b08jb1437607cccbcdc6@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v919.2)
Date: Fri, 29 Feb 2008 09:40:18 +0200
References: <b535981e0802282142m3e132b08jb1437607cccbcdc6@mail.gmail.com>
Subject: Re: [Bluez-users] HFP Status?
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

Hi Jon,

On Feb 29, 2008, at 7:42, Jon wrote:
> I apologize if this is answered somewhere - I've tried finding the  
> information - but no dice.  My question is simple: Whats the status  
> of the Hands Free Protocol?


If your all you need is getting some audio going through then the  
audio service latest 3.27 should work fine (as long as HFP support  
isn't disabled through audio.conf). Since the list of features for HFP  
is rather long and quite tightly bound to whathever telephony  
subsystem you have, we've decided to create a plugin system for the  
audio service where each plugin will act as an adapter to some  
specific telephony subsystem. You'll probably see some basic support  
for this kind of plugins already in the next bluez-utils release.  
However, as I said if you don't need any of the more advance telephony  
related features of HFP you should be able to get at least basic audio  
going with the latest releases.

Johan

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
