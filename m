Return-Path: <bluez-devel-admin@lists.sourceforge.net>
To: bluez-devel@lists.sourceforge.net
From: Paul Ionescu <i_p_a_u_l@yahoo.com>
Message-ID: <pan.2005.01.18.21.13.28.823011@yahoo.com>
References: <200501181145.11573.da209@cam.ac.uk> <41ED32F0.8010502@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bluez-devel] Re: bluetooth headset
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
Date: Tue, 18 Jan 2005 23:13:31 +0200

Hi Brad,

The problem was not the detection itself.
Indeed sco was connecting to Jabra BT 110 to the headset channel.
But it worked better on handsfree channel.
The headset profile is pretty dumb, comparing to handsfree profile.
So I forced to connect to handsfree instead of headset.
Maybe we should check if the headset implements both profiles, and if so,
choose the handsfree profile which is better.

Best regards,
Paul

On Tue, 18 Jan 2005 09:01:52 -0700, Brad Midgley wrote:
> paul ionescu had a similar problem with the jabra bt 110...
> 




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
