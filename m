Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Two simultanous connections
From: Marcel Holtmann <marcel@holtmann.org>
To: Pierre N <pierren@mac.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1080928843.9541.90.camel@localhost>
References: <1080928843.9541.90.camel@localhost>
Content-Type: text/plain
Message-Id: <1080929429.2836.101.camel@pegasus>
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
Date: Fri, 02 Apr 2004 20:10:29 +0200

Hi Pierre,

> I've been trying to setup ip net with 3 identical devices connected
> simultanously over bluetooth. It works after a long
> while of fiddling around. I had to go the hcitool route manually to set
> the initial connections and then I could use dund no problem. My
> question is: why can't I initiate a connection (hcitool cc) from a
> device which is already connected?

for some setups this depends on your Bluetooth chip. So what does
"hciconfig -a" show? But I am not sure about what kind of network you
are talking, because between two device there can be only _one_ ACL link
and this means you can only use "hcitool cc" once. Actually there is no
need for creating the ACL link manually with hcitool, because every
higher layer will create it on demand.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
