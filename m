Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Re: [Bluez-users] How do I obtain a free PSM
	automatically?
From: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
To: Max Krasnyansky <maxk@qualcomm.com>
Cc: Alexandros Karypidis <karypid@inf.uth.gr>, bluez-devel@lists.sourceforge.net
In-Reply-To: <5.1.0.14.2.20030210125138.04183f58@mail1.qualcomm.com>
References: <200302081740.48000.karypid@inf.uth.gr>
	<200302071951.35073.karypid@inf.uth.gr>
	<1044653775.32672.14.camel@pegasus.local>
	<200302081740.48000.karypid@inf.uth.gr>
	<5.1.0.14.2.20030210125138.04183f58@mail1.qualcomm.com>
Content-Type: text/plain
Message-Id: <1044964883.19214.46.camel@linux>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: 
	<https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: 
	<http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: 11 Feb 2003 13:01:21 +0100

Hi,

> Now if people really want dynamic PSMs. We could introduce something like
> bind(psm == 0xffff).

I think this is not a good idea, because 0xffff is a valid PSM according
to the spec.

But what about bind it with PSM 0 and the listen call assign a dynamic
PSM if it is bind with PSM 0 ?

What about a l2cap daemon like inetd ?

Regards

Marcel




-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
