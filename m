Return-Path: <cyrus@holtmann.org>
From: Sumeet VERMA <sumeet.verma@st.com>
To: "'BlueZ users'" <bluez-users@lists.sourceforge.net>
Date: Fri, 14 Dec 2007 09:49:40 +0530
Message-ID: <022e01c83e08$8c613360$832fc70a@dlh.st.com>
MIME-Version: 1.0
In-Reply-To: <1197561739.5644.87.camel@aeonflux>
Cc: bluez-users@lists.sf.net
Subject: Re: [Bluez-users] eSCO over HCI
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

Hi Marcel
Yes I know that. I have the eSCO patch for 2.6.20 kernel but how do I test
eSCO over HCI. How do I configure the audio application to use HCI for eSCO
data. Has anyone tested it? Are there any test applications? Do I see the
logging in hcidump?


Regards,
Sumeet 
-----Original Message-----
From: bluez-users-bounces@lists.sourceforge.net
[mailto:bluez-users-bounces@lists.sourceforge.net] On Behalf Of Marcel
Holtmann
Sent: Thursday, December 13, 2007 9:32 PM
To: BlueZ users
Cc: bluez-users@lists.sf.net
Subject: Re: [Bluez-users] eSCO over HCI

Hi Sumeet,

> Is there any application to test eSCO over HCI? I am wondering how to
configure the audio service to use HCI path for eSCO traffic. Do I see the
logging in hcidump if I am able to establish an eSCO link? 

if you use scotest (or any other tool that needs a SCO link), it should
create an eSCO link (with a recent kernel) if both sides support it.

Regards

Marcel



-------------------------------------------------------------------------
SF.Net email is sponsored by:
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for just about anything Open
Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users


-------------------------------------------------------------------------
SF.Net email is sponsored by:
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services
for just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
