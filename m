Return-Path: <cyrus@holtmann.org>
Message-ID: <cc1649d10804141954h1be91b0an8b7e5bc6bfe8660b@mail.gmail.com>
Date: Mon, 14 Apr 2008 22:54:15 -0400
From: "Vlad Skarzhevskyy" <skarzhevskyy@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <FFED2D1514034841A6270D98984E7D0C020C7159@pdsmsx415.ccr.corp.intel.com>
MIME-Version: 1.0
References: <FFED2D1514034841A6270D98984E7D0C020C7159@pdsmsx415.ccr.corp.intel.com>
Subject: Re: [Bluez-users] Unable to read data via RFCOMM socket from a
	JSR82 program running on phone
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

Hi Peter
  We at bluecove.org constantly testing connections from JSR-82 on top
of BlueZ on Linux to client on Mobile phone L2CAP or RFCOMM and back.
No problems detected in BlueZ.
  Make sure you are connecting to right service!

  Look at this application as test
http://snapshot.bluecove.org/bluecove-examples/bluecove-tester/  it
runs on Linux and the MIDLet version can be installed on the phone.

--
Vlad

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
