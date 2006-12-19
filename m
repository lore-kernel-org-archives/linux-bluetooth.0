Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <c49421c50612190525h197663fcu79da33f496526f45@mail.gmail.com>
References: <c49421c50612190525h197663fcu79da33f496526f45@mail.gmail.com>
Date: Tue, 19 Dec 2006 14:28:54 +0100
Message-Id: <1166534934.7309.0.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-users] notification of baseband conection establishment
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

Hi Loreno,

> does anybody know some facility for a called device to detect the
> establishment of a baseband connection? That is, say we have two
> devices, A and B, and A attempts a paging to B. The idea is fire an
> event in B as soon as the baseband connection is established. 
> 
> I thought two ideas for this: first, when the synchronous call to
> "hci_create_connection" returns, A then invokes, via SDP, a service
> advertised on B, which fires the event on that device (it is
> reasonable in my context to assume that B advertises a service such
> like that). Second, some application in B runs a thread that
> constantly monitors the availability of baseband connections through
> "hci_for_each_dev function". Such an application would maintain a data
> structure for controling existent conections. When a new conection is
> established, B updates the data structure and fires the event. 

look at the D-Bus API for BlueZ. It sends you a signal once a device has
been connected or disconnected.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
