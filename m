Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Alain Volmat <avolmat@src.ricoh.co.jp>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] rfcomm question 3
Message-ID: <20050203052237.GE9259@snoopy.src.ricoh.co.jp>
References: <1107322449.9276.13.camel@pegasus> <20050203034226.82077.qmail@web60903.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050203034226.82077.qmail@web60903.mail.yahoo.com>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 3 Feb 2005 14:22:37 +0900

Hi Michael,

> a)Just include "rctest.c" by creating "rctest.h" in bluez-utils-2.14/test directory, and put the function prototypes related to listening on a RFCOMM channel and include the header files bluetooth.h and rfcomm.h in my main program

Are you kidding ?

> b)put the functions related to listening on a RFCOMM channel in my main program, and include the header files  bluetooth.h and rfcomm.h in the beginning.

Seems much better than the first idea. basically only do_listen and recv_mode
should be important in your case.

> So, which approach is more appropriate?

The second one.

> And for each approach, what variables need I to declare in the beginning of my main program?

Are you kidding ? (once more) .. this is not a bluetooth/socket API question
anymore but just C programming you are asking about. Are we here for that ?

> 2.My wish is to let the program to accept all mobiles that wish to connect to PC. Then how can I write the syntax so that if one mobile wish to connect to PC, the PC can accept it?

Take a look at the function do_listen ... the bind call.

        loc_addr.rc_family = AF_BLUETOOTH;
        loc_addr.rc_bdaddr = BDADDR_ANY;
        loc_addr.rc_channel = channel;
        if( bind(s, (struct sockaddr *) &loc_addr, sizeof(loc_addr)) < 0 ) {

should let you get connection from any device ....

> And how can I do to count and check the number of mobile terminals connecting with PC?
> 3.What online reference is good for me to get familiar with the matter that I asked in the previous two questions?

Some googleing with keyword like "socket programming" should be a good start.

Regards,

Alain


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
