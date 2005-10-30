Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <4364D689.4010305@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Bluetooth-Alsa: cannot pair the headset
References: <435B72B0.5050309@libero.it> <43649779.3000803@libero.it>
In-Reply-To: <43649779.3000803@libero.it>
Content-Type: text/plain; charset=ISO-8859-15
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
Date: Sun, 30 Oct 2005 07:19:53 -0700

jimmi

i put a note in the docs about this.

which distro defaults to auth and encrypt on? (or did you install from
source?)

brad

>> I searched  for the "SDP  server" error but  I could not  get suitable
>> informations. Has anybody an hint about?
> 
> I fixed it with:
>         auth disable;
>                 encrypt disable;
> in /etc/bluetooth/hcid.config. It seems they are enable by default :)
> -- 
>    ---         _   o       |     Sembra di sentirlo ancora dire al     |
>    / immi   ---  _/\_>     | mercante di liquori: tu che lo vendi cosa |
> (_/          -  O,> / O    |        ti compri di migliore? FdA         |
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by the JBoss Inc.
> Get Certified Today * Register for a JBoss Training Course
> Free Certification Exam for All Training Attendees Through End of 2005
> Visit http://www.jboss.com/services/certification for more information
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users



-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
