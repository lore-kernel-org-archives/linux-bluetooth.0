Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb050721070860bf3de1@mail.gmail.com>
From: Claudio Takahasi <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <e1effdeb050720121520ed4b4a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <e1effdeb050720121520ed4b4a@mail.gmail.com>
Subject: [Bluez-devel] Re: Periodic Inquiry
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
Date: Thu, 21 Jul 2005 11:08:26 -0300

Hi folks,

The inquiry periodic is not working properly. The minimum=20
amount of time specified between consecutive inquiries
is not working as I expect. The device is entering on
inquiry mode every +- 5seconds.

Is there a problem in the code below?

=09inq_param.num_rsp =3D 100;
=09inq_param.length  =3D 4; /* 5.12s */

=09inq_param.max_period =3D 49; /* 62.72s */
=09inq_param.min_period =3D 27;  /* 34.56s */


=09/* General/Unlimited Inquiry Access Code */
=09inq_param.lap[0] =3D 0x33;
=09inq_param.lap[1] =3D 0x8b;
=09inq_param.lap[2] =3D 0x9e;
=09ret =3D hci_send_cmd(sock, OGF_LINK_CTL, OCF_PERIODIC_INQUIRY,=20
=09=09=09PERIODIC_INQUIRY_CP_SIZE, &inq_param);



Regards,
Claudio.

On 7/20/05, Claudio Takahasi <cktakahasi@gmail.com> wrote:
> Hi folks,
>=20
> What is the correct way to deal with periodic inquiry?
>=20
> Currently I created a raw BT HCI socket integrated with my
> application main loop. The following events is being captured:
>=20
> int8_t hci_events[]  =3D { EVT_INQUIRY_RESULT, \
>                                  EVT_INQUIRY_RESULT_WITH_RSSI, \
>                                  EVT_INQUIRY_COMPLETE, \
>                                  EVT_REMOTE_NAME_REQ_COMPLETE, \
>                                  EVT_CMD_STATUS, \
>                                  0 };
>=20
> .....
> The hci command is:
> ret =3D hci_send_cmd(sock, OGF_LINK_CTL, OCF_PERIODIC_INQUIRY, \
>                         PERIODIC_INQUIRY_CP_SIZE, &inq_param);
>=20
>=20
> Is there another way to do this task? eg: Using ioctl.
>=20
>=20
> Regards,
> Claudio.
>


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
