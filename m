Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Sumeet VERMA <sumeet.verma@st.com>
To: "'BlueZ development'" <bluez-devel@lists.sourceforge.net>
Date: Mon, 30 Apr 2007 10:39:37 +0530
Message-ID: <01fc01c78ae5$c0c5c980$8935c70a@dlh.st.com>
MIME-Version: 1.0
In-Reply-To: <1177597177.14980.71.camel@aeonflux.holtmann.net>
Subject: Re: [Bluez-devel] Low Power mode in bluez
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

Hi Marcel,

I meant deep sleep modes by low power modes. I think I would need some
support in bluetooth transport layer for that. 

Regards,
Sumeet 
-----Original Message-----
From: bluez-devel-bounces@lists.sourceforge.net
[mailto:bluez-devel-bounces@lists.sourceforge.net] On Behalf Of Marcel
Holtmann
Sent: Thursday, April 26, 2007 7:50 PM
To: BlueZ development
Subject: Re: [Bluez-devel] Low Power mode in bluez

Hi Sumeet,

> Is there any plan to implement low power modes in bluez? I am using a
device which using a USB to UART driver (prolific).
> 
> If no, then can you give me some pointers about the implementation? Where
should I start from and some links from where I can get some help.

the sniff mode support has been implemented. All other modes are useless.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express Download DB2 Express C - the
FREE version of DB2 express and take control of your XML. No limits. Just
data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
