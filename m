Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] disappointed with my MX900 battery life
From: Marcel Holtmann <marcel@holtmann.org>
To: Charles Bueche <charles@bueche.ch>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1073555620.5632.8.camel@bluez.bueche.ch>
References: <1073555620.5632.8.camel@bluez.bueche.ch>
Content-Type: text/plain
Message-Id: <1073583568.2563.29.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 08 Jan 2004 18:39:28 +0100

Hi Charles,

> I'm using the CVS version of libs2 and utils2, with my MX900. I have the
> impression that the MX900 batteries don't last very long between two
> charging cycles (2-3 days). Can other here confirm this ?
> 
> I must explain that I use my MX900 without the docking (with a laptop
> underway), so I only dock the mouse to load it when it blink red.
> 
> And being with empty batteries underway leaves me with the poor
> touchpad.
> 
> Any better experience under Window$ ? Is some optimization possible in
> the code to better use the "standby" modes of the MX900 ?

the HID specification is clear about that the HID device itself must
take care about its power consumption. What is your link policy? Maybe
the sniff mode is not enabled. On the other hand the Apple Bluetooth
mouse never uses sniff mode to save power. Run a hcidump and check what
your mouse is doing.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
