Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <463245A8.1020804@jlab.org>
Date: Fri, 27 Apr 2007 14:49:12 -0400
From: Chris Carlin <carlin@jlab.org>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <463151D2.1040805@jlab.org>	<4631762B.9060704@xmission.com>	<CE5216C10C83944D9FD37B65CD33F3970CF4CD@mplex01.mpl.access-company.com>	<46320AC6.9080200@jlab.org>
	<46321D59.5050503@access-company.com>
In-Reply-To: <46321D59.5050503@access-company.com>
Subject: Re: [Bluez-devel] RE :  Plugz, a2dpd, and a2dpd2 strangeness
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Well there are things that make me think it almost works. For example, 
a2play under btsco basically worked, and if I force the chirps to occur 
quickly enough (by pausing and unpausing the player's process... each 
cycle causes a chirp) they merge into music. To my uninformed mind this 
suggests that plugz might work with the headphones if it would just send 
the data.

So perhaps just to satisfy my own curiosity, why is a2dp not sending any 
data over bluetooth, as shown through hcidump? Is it waiting for some 
sort of acknowledgment from the headset?

And what's the status of a2dpd versus a2dpd2?

~Chris

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
