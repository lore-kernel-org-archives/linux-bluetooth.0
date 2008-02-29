Return-Path: <cyrus@holtmann.org>
Message-Id: <C3910953-F3FF-4854-971C-9B47AC8C852B@gmail.com>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <b535981e0802290028s22a771bcubbbc9a9fb993d1a7@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v919.2)
Date: Fri, 29 Feb 2008 10:51:51 +0200
References: <b535981e0802282142m3e132b08jb1437607cccbcdc6@mail.gmail.com>
	<3E374F75-1F23-4B9E-89EB-BF25C688822F@gmail.com>
	<b535981e0802290028s22a771bcubbbc9a9fb993d1a7@mail.gmail.com>
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


On Feb 29, 2008, at 10:28, Jon wrote:
> The end goal of my project is to get some amount of bluetooth  
> handsfree calling built into a carputer (a topic that I'm sure has  
> come up before).  It will be a legal requirement (Shortly) in my  
> state to use hands free while driving.  Really all I need is to be  
> able to answer & end the call - and of course be able to hear/speak  
> to the party.  I'm not sure what would be classified as an  
> "Advanced" feature, but I think I get the gist of it.

Just so we get this clear, do you need the Audio Gateway (AG) or the  
Handsfree (HF) role of HFP? Because what is currently implemented in  
BlueZ is only the AG side (which is the most useful out of the two for  
a PC type device). There are placeholders  for the HF role in the code  
but nothing has been implemented yet (simply because it hasn't been a  
high priority for the developers compared to other Bluetooth audio  
features).

Johan

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
