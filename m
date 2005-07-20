Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb050720121520ed4b4a@mail.gmail.com>
From: Claudio Takahasi <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bluez-devel] Periodic Inquiry
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 20 Jul 2005 16:15:52 -0300

Hi folks,

What is the correct way to deal with periodic inquiry?

Currently I created a raw BT HCI socket integrated with my
application main loop. The following events is being captured:

int8_t hci_events[]  =3D { EVT_INQUIRY_RESULT, \
=09=09=09=09 EVT_INQUIRY_RESULT_WITH_RSSI, \
=09=09=09=09 EVT_INQUIRY_COMPLETE, \
=09=09=09=09 EVT_REMOTE_NAME_REQ_COMPLETE, \
=09=09=09=09 EVT_CMD_STATUS, \
=09=09=09=09 0 };

.....
The hci command is:
ret =3D hci_send_cmd(sock, OGF_LINK_CTL, OCF_PERIODIC_INQUIRY, \
=09=09=09PERIODIC_INQUIRY_CP_SIZE, &inq_param);


Is there another way to do this task? eg: Using ioctl.


Regards,
Claudio.


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
