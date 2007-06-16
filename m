Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <fc3d922d0706122331u55151133x5b141ef3a1159146@mail.gmail.com>
References: <fc3d922d0706120106y3a7fd657l1cada74a63166010@mail.gmail.com>
	<1181703539.6872.95.camel@aeonflux.holtmann.net>
	<fc3d922d0706122331u55151133x5b141ef3a1159146@mail.gmail.com>
Date: Sat, 16 Jun 2007 09:45:21 +0200
Message-Id: <1181979921.6846.74.camel@aeonflux.inter-touch.com>
Mime-Version: 1.0
Subject: Re: [Bluez-users] hci_inquiry
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

Hi,

> I'm little new in bluetooth software, so I've got some more questions.
> Where can I find this D-BUS API (is it in new versions of bluez-libs,
> bluez-utils or in kernel).
> 
> Yesterday I generated this code:
> 
> hci_send_req(dev_id, &rq, 100)
> where
> rq is hci_request struct and i set
> rq.ogf = OGF_LINK_CTL;
> rq.ocf = OCF_INQUIRY_CANCEL;
> 
> If this code would be proper if I have new D-Bus API.

as I said, use the new D-Bus based API. The source code contains a
dbus-api.txt file with the full description.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
