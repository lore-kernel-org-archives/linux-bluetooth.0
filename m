Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Cloudshang" <zhixiang_deng@yahoo.com.cn>
To: "bluez-users@lists.sourceforge.net" <bluez-users@lists.sourceforge.net>
Subject: Re: Re: [Bluez-users] hci problems
Mime-Version: 1.0
Content-Type: text/plain;
      charset="GB2312"
Message-ID: <E1DYwg6-0007LC-NP@sc8-sf-mx2.sourceforge.net>
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
Date: Fri, 20 May 2005 9:54:33 +0800

Hi , Marcel

Thank you for your quick reply.
>> Here , I want to do the following work : one bluetooth device=
 send the inquiry command (using the hci_inquiry function) and=
 the bluetooth devices who are inquiried of course will return=
 corresponding packets , but how can I know the event that the=
 device is inquiried upon the HCI layer ? Because I have to do=
 some work only if the device is inquired .
>
>this is not possible.
I have no idea to continue my work without such function ,could=
 you please kindly provide me some alternative methods ?

The first step of our work is to form a piconet. The master=
 device is chosen by decreasing a random number to zero. Those=
 bluetooth devices that have been inquiried by the master in the=
 piconet should do some work such as stopping the decreasing=
 process,etc.

Thank you very much for consuming your precious time. 
=3D =3D =3D =3D =3D =3D =3D =3D =3D =3D =3D =3D =3D =3D =3D =3D =3D =3D =3D =3D
Regards,
        =09=09 
Cloudshang
=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1zhixiang_deng@yahoo.com.cn
=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A12005-05-20







-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
