Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Achim Bohnet <ach@mpe.mpg.de>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] PF_BLUETOOTH AF_BLUETOOTH redefinitions
References: <200401221347.32481.ach@mpe.mpg.de> <1074776673.3071.4.camel@pegasus>
In-Reply-To: <1074776673.3071.4.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200401221434.10203.ach@mpe.mpg.de>
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 22 Jan 2004 14:34:10 +0100

On Thursday 22 January 2004 14:04, you wrote:
> Hi Achim,
> 
> > During compilation of some bluetooth apps I get lots of warings like this:
> > 
> > In file included from /usr/include/sys/socket.h:35,
> >                  from connectiondlg.h:31,
> >                  from connectiondlg.cpp:24:
> > /usr/include/bits/socket.h:91: warning: `PF_BLUETOOTH' redefined
> > /usr/include/bluetooth/bluetooth.h:43: warning: this is the location of the previous definition
> > /usr/include/bits/socket.h:123: warning: `AF_BLUETOOTH' redefined
> > /usr/include/bluetooth/bluetooth.h:42: warning: this is the location of the previous definition
> > In file included from connectiondlg.h:35,
> >                  from connectiondlg.cpp:24:
> > /usr/include/bluetooth/hci.h:482: warning: ANSI C++ forbids zero-size array `condition'
> > /usr/include/bluetooth/hci.h:909: warning: ANSI C++ forbids zero-size array `data'
> > /usr/include/bluetooth/hci.h:1046: warning: ANSI C++ forbids zero-size array `dev_req'
> > /usr/include/bluetooth/hci.h:1052: warning: ANSI C++ forbids zero-size array `conn_info'
> > /usr/include/bluetooth/hci.h:1058: warning: ANSI C++ forbids zero-size array `conn_info'
> > 
> > Would be nice if bluetooth.h would not override stuff already defined
> > 
> > sys/socket.h:123:#define AF_BLUETOOTH    PF_BLUETOOTH
> > 
> > I would suggest that bluetooth.h includes itself sys/socket.h before checking if AF_BLUETOOTH
> > is defined.   This removed the dependency on how headers are ordered in source files.
> > Works for me ;)
> > 
> > hci.h may be due to old g++2.94.4 used on debian.  No idea about a workaround :(
> 
> include "sys/socket.h" before you include "bluetooth/bluetooth.h".

Hi Marcel,

That one solution, but why isn't it done by bluetooth.h itself?  Makes it header order
independent, and fixes _once and forever_ annoying warnings like that.
(that was my last try to convience you, promised ;)

What about condition[0] etc in hci.h.  Should this be contition[] etc?

ach@allee(0) ~ $ fgrep '[0]' /usr/include/bluetooth/hci.h
        uint8_t         condition[0];
        uint8_t         data[0];
        struct hci_dev_req dev_req[0];  /* hci_dev_req structures */
        struct hci_conn_info conn_info[0];
        struct hci_conn_info conn_info[0];

Achim
> 
> Regards
> 
> Marcel
> 
> 
> 
> 

-- 
  To me vi is Zen.  To use vi is to practice zen. Every command is
  a koan. Profound to the user, unintelligible to the uninitiated.
  You discover truth everytime you use it.
                                      -- reddy@lion.austin.ibm.com



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
