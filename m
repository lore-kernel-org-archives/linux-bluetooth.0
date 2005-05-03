Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Pavel Ruzicka <pavouk@pavouk.org>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Compatability
References: <000001c54f76$46987920$2c95c988@riverrun>
In-Reply-To: <000001c54f76$46987920$2c95c988@riverrun>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <200505031001.32513.pavouk@pavouk.org>
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
Date: Tue, 3 May 2005 10:01:32 +0200

>   Can anyone tell me if Socket CF Bluetooth with PCMCIA Adaptor, sold
> for example at eXpansys runs well under bluez?

There are more versions of card. I have revision F, which is old Nokia
based and works with dtl1 kernel module under kernel 2.4 or 2.6.

New revision G is CSR based and uses hci_uart and serial.cs.
There is problem with kernel 2.6. You must use patch for serial.cs which
solve problem. These problems was discussed in this list before few weeks.
Some discussions about SOCKET G card and patch is here:
http://www.summet.com/x31/socket.html

Best regards,

Pavel Ruzicka


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
