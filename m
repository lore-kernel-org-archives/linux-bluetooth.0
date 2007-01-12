Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <45A7AB19.50605@pracucci.com>
Date: Fri, 12 Jan 2007 15:36:57 +0000
From: Marco Pracucci <development@pracucci.com>
MIME-Version: 1.0
To: Bluez Users ML <bluez-users@lists.sourceforge.net>
Subject: [Bluez-users] ACL link creation in userspace
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

Dear Marcel,

I would like to receive your opinion about ACL link created in
userspace. I know that you ever discourage the creation of an ACL link
inside an application, but I would like to better understand the reasons.

I have an application that needs to read remote features, remote version
and search for services (SDP). Bluez provides API to read remote
features and version, but the application should pass the ACL handle as
argument. So, I think there are just two solutions:
1) Get the ACL handle (ioctl), if there is already an ACL link
2) Create an ACL link (hci_create_connection), if no ACL link has been
established yet

I don't want to establish the ACL link more that 1 time for remote
device, so I think that I must create the ACL link in userspace if there
is no ACL already established. However, I get several errors that I
suppose are collateral effects of this solution. For example, an error
occours if there are 2 threads (in parallel) that:
- hci_create_connection()
- read remote features
- read remote version
- sdp_connect() error: Operation already in progress

Can you explain me why I should not create an ACL link in userspace?
Do you have any idea how to bypass this limitation?

Thanks,
Marco Pracucci


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
