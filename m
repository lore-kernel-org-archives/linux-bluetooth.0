Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Chris Boyle <bluez-devel@cmb.is-a-geek.org>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] snd-bt-sco problem
Message-ID: <20041208102606.GB2258@zeus.galaxy.org.uk>
References: <20041206225609.GA1177@zeus.galaxy.org.uk> <41B670A9.4030804@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <41B670A9.4030804@xmission.com>
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 8 Dec 2004 10:26:06 +0000

On Tue, Dec 07, 2004 at 08:10:33PM -0700, Brad Midgley wrote:
> Did it start working when you clicked the 'connect' button on the 
> headset? Sebastian pointed out that this was something one might miss so 
> I highlighted it recently in the docs.

Almost, but not quite. btsco looked more successful, and with hcidump I
could see a lot of SCO data flowing, but still audio apps would hang. I
could however press the volume buttons on the headset and see the mixer
change, so there was definitely a connection.

-- 
Chris Boyle - http://cmb.is-a-geek.org/
GPG: B7D86E0F, MSN: shortcipher@hotmail.com, ICQ: 24151961,
AIM: kerneloops, Yahoo: kerneloops, IRC: cmb on irc.uwcs.co.uk


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
