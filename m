Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <45A7AB19.50605@pracucci.com>
References: <45A7AB19.50605@pracucci.com>
Date: Fri, 12 Jan 2007 17:12:05 +0100
Message-Id: <1168618325.14933.16.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-users] ACL link creation in userspace
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

Hi Marco,

> I would like to receive your opinion about ACL link created in
> userspace. I know that you ever discourage the creation of an ACL link
> inside an application, but I would like to better understand the reasons.
> 
> I have an application that needs to read remote features, remote version
> and search for services (SDP). Bluez provides API to read remote
> features and version, but the application should pass the ACL handle as
> argument. So, I think there are just two solutions:
> 1) Get the ACL handle (ioctl), if there is already an ACL link
> 2) Create an ACL link (hci_create_connection), if no ACL link has been
> established yet
> 
> I don't want to establish the ACL link more that 1 time for remote
> device, so I think that I must create the ACL link in userspace if there
> is no ACL already established. However, I get several errors that I
> suppose are collateral effects of this solution. For example, an error
> occours if there are 2 threads (in parallel) that:
> - hci_create_connection()
> - read remote features
> - read remote version
> - sdp_connect() error: Operation already in progress
> 
> Can you explain me why I should not create an ACL link in userspace?
> Do you have any idea how to bypass this limitation?

every ACL and SCO connection needs its representation inside the kernel
and the driver model. The upper layers like L2CAP rely on this being
handled by the kernel. This is important for establishing a L2CAP and
for terminating them. In the case no ACL link exists the kernel has to
create one and if the last L2CAP terminates the kernel has to start the
disconnect timer and if no other user comes along terminate the ACL link
to not waste power on unused piconets. This is essential and must simply
work. The only instance that can have full control over these things is
the kernel itself. And as you already realized you have to avoid
parallel use. The kernel is exactly doing this. The latest kernel
releases even do more. In case the L2CAP create will be canceled before
the ACL link establishment succeeds, the kernel automatically cancels
this process. This then free the Bluetooth chip for other tasks which is
really important since the chip can only to one page or inquiry
operation at a time. Secondly the kernel automatically retries the
connection establishment if the Bluetooth chip indicates it was busy.
This involves watching out for inquiry and remote name events. This all
together makes it wrong to establish any ACL link via raw HCI commands
from the userspace. Even in the case of hcid we moved away from doing
this at all. It is not suitable for the userspace to keep track. Instead
we use the L2CAP raw socket to establish the ACL link. And if hcid is
not doing it then certainly you shouldn't do it either.

So if you wanna do a SDP search anyway, then it is totally stupid to
create the ACL link first. The kernel will do it for you anyway and you
shouldn't mess it. And btw. the so needed ACL handle can be retrieved
via socket options on the L2CAP socket that is used by SDP.

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
