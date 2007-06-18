Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Fernando Unzu <fernando@bluexare.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Date: Mon, 18 Jun 2007 09:38:10 +0200
References: <200706151809.04115.fernando@bluexare.org>
	<1181978987.6846.50.camel@aeonflux.inter-touch.com>
In-Reply-To: <1181978987.6846.50.camel@aeonflux.inter-touch.com>
MIME-Version: 1.0
Message-Id: <200706180938.10993.fernando@bluexare.org>
Subject: Re: [Bluez-devel] Problems with my own inquiry
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Marcel,
Thanks for the answer, but I don't know how to do...

> the solution is to use the new D-Bus based API. It takes care of
> everything that you want.

When I install the new distribution, I update the bluetooth/bluez packages 
with "apt-get", so there may be the later version, doesn't do?
If it is not true, where I can update my version to one make my system works 
ok?


> The new hcid switches into the best inquiry mode and that means Inquiry
> with RSSI (which is different event) for a Bluetooth 1.2 dongle or
> later. You have to watch for that event, too. Or use the D-Bus API that
> does that for you and already takes care of Extended Inquiry of the
> Bluetooth 2.1 specification.

I thought I was watching for this event, in the program:

switch (buf[1]) {
	case EVT_CMD_STATUS:
		//some code
		break;
	case EVT_INQUIRY_RESULT:
	case EVT_INQUIRY_RESULT_WITH_RSSI:
		//some code
		break;
	case EVT_INQUIRY_COMPLETE:
		//some code
		break;
	default:
		//some code
		break;
}

I take the event EVT_INQUIRY_RESULT_WITH_RSSI, so I'm watching the event, 
doesn't do?
And in the case I have not watch properly the event, it must be executed the 
code within the case "default", and do not execute...

What I'm doing wrong?

Thank you very much,
Fernando

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
