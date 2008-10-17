Return-Path: <cyrus@holtmann.org>
Message-ID: <12941.83.160.35.87.1224273962.squirrel@webmail.xs4all.nl>
Date: Fri, 17 Oct 2008 22:06:02 +0200 (CEST)
From: "menno van der klein" <jongerenchaos@zonnet.nl>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Subject: Re: [Bluez-users] Bluez 4.XX pincode authorisation HOW can i use
 it??
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
Errors-To: bluez-users-bounces@lists.sourceforge.net

Great it works well!! Thank you very much for your help!


> Johan Hedberg wrote:
>> Hi,
>>
>> If you want to pair devices from the command line you can e.g. use the
>> simple-agent python script (in the test subdirectory of bluez):
>> ./simple-agent hci0 <remote address>
>> It will ask you for the pin on stdin.
>>
>> Johan
>
> Thank you Johan that helped a lot with one of my devices,
>
> python .simple-agent.py hci0 00:1A:80:AB:0A:B1
>
> the simple-agent script can be found at the bluez git in its testing
> directory: git://git.kernel.org/pub/scm/bluetooth/bluez.git
>
> Best regards,
>
> Jelle
>
>
>
> -------------------------------------------------------------------------
> This SF.Net email is sponsored by the Moblin Your Move Developer's
> challenge
> Build the coolest Linux based applications with Moblin SDK & win great
> prizes
> Grand prize is a trip for two to an Open Source event anywhere in the
> world
> http://moblin-contest.org/redirect.php?banner_id=100&url=/
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>


Met vriendelijke groet,
Menno van der Klein
CreditFUN Media
T: 020-8005157
M: 06-28927919
E: Menno@creditfun.nl

Disclaimer
De informatie verzonden in dit e-mail bericht is uitsluitend bestemd voor
de geadresseerde. Gebruik van deze informatie door anderen dan de
geadresseerde is verboden. Openbaarmaking, vermenigvuldiging, verspreiding
en/of verstrekking van deze informatie aan derden is niet toegestaan.
Hoewel bij de verzending van dit e-mail bericht de nodige zorgvuldigheid
wordt betracht, is een juiste en volledige overdracht van dit e-mail
bericht niet te garanderen. Aan dit e-mail bericht en/of meegezonden
bestanden kunnen geen rechten worden ontleend. Daarnaast kan CreditFUN
Media,of aan haar gelieerde ondernemingen, niet aansprakelijk gehouden
worden voor de gevolgen van eventuele fouten en/of onvolledigheid van de
in het e-mail bericht opgenomen gegevens.


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
