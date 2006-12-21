Return-Path: <bluez-users-bounces@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: Neil MacLeod <gmane@nmacleod.com>
Date: Thu, 21 Dec 2006 21:53:48 +0000
Message-ID: <emevpc$fk7$1@sea.gmane.org>
References: <elvlcl$drg$1@sea.gmane.org>	<1166358880.6557.25.camel@aeonflux.holtmann.net>	<em3vo7$2cs$1@sea.gmane.org>
	<1166381765.6557.48.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
In-Reply-To: <1166381765.6557.48.camel@aeonflux.holtmann.net>
Subject: Re: [Bluez-users] Nokia 770 / Sony Ericsson UIQ3 pairing / DUN
	problems
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Marcel Holtmann wrote:
> Hi Neil,
> 
>>> my wild guess would be that this phone has a similar problem as my
>>> Motorola RAZR V3x. If you use service search attribute request then it
>>> can't handle it, because that is not mandatory in the qualification.
>>> However it is mandatory to respond, but I think the Bluetooth part of
>>> the phone simply crashes at this point and leaves and unmaintained ACL
>>> link behind. The reset action on the Nokia 770 will clean this link and
>>> give the phone the chance to be able to reset itself. No matter what
>>> this phone is broken and it is not on the Linux software side.
>>>

Hi Marcel

Seems like you were spot on!

Johan has provided a new build of sdp-query that performs separate Service Search and Service Attribute requests instead of a SSA request. The binary is an attachment in the previously mentioned bugzilla entry #865, and with the modified sdp-query the Nokia 770 connects without fail to the W950i.

I'm not sure what the next steps are now, it looks like the 770+W950i combination can work after applying a a fix to the BlueZ stack, but it's possible Johan has provided the fix merely to narrow down the problem. I guess the long term solution should be to fix the phone, but that may or may not be possible unless someone can contact the Symbian & Sony Ericsson developers (I wonder if they follow this newsgroup? :))

Thanks to you and Johan for your help!


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
