Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: wim delvaux <wim.delvaux@adaptiveplanet.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] what API to use to disconnect an rfcomm connection
References: <200412110213.37305.wim.delvaux@adaptiveplanet.com> <1102756108.19086.1.camel@pegasus>
In-Reply-To: <1102756108.19086.1.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200412111314.05010.wim.delvaux@adaptiveplanet.com>
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
Date: Sat, 11 Dec 2004 13:14:04 +0100

On Saturday 11 December 2004 10:08, Marcel Holtmann wrote:
> Hi Wim,
>
> > if you started
> >
> > rfcomm x XXXXXXXXXX y &
> > and the connection to XXXXXXXXXXX is running,
> >
> > How can other application terminate that connection  (much like pand -k
> > addr)
> >
> > What API (ioctl ?) should be used ? Code samples ?>
>
> the use of ACL connections is tracked with reference counting and as
> long as there is a upper layer connection using the ACL link it is not
> closed. If the last one is gone, the disconnect timer is started and
> after the timeout the ACL link is terminated.


 I want to create a 'hangup' button that should disconnect from
 a phone connection immediately.  This means that is
 should terminate say the ppp connection ontop of the serial  
 connection and also the serial connection to the phone.

 What you say is that if I close the ppp after a while the rfcomm
 connection would stop automatically.  That is nice but that is
 not what I want.

 So I am looking for an equivalent to pressing CTRL-C in the 
 controlling terminate of the running rfcomm daemon using a
 C-API call.

 Is that more clear ?

 Thanx

 W


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
