Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <3F4F32E0.7050802@systinet.com>
From: Leos Literak <leos.literak@systinet.com>
MIME-Version: 1.0
To: Bluez-users@lists.sourceforge.net
Subject: [Bluez-users] phillips fisio 825
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Unsubscribe: 
	<https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: 
	<http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri, 29 Aug 2003 13:02:56 +0200
Content-Type: multipart/mixed; boundary="=-ZXnaOiK1HBcwbb8hQhG3"


--=-ZXnaOiK1HBcwbb8hQhG3
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; CHARSET=ISO-8859-1; FORMAT=flowed

Hi,

I have mandrake 9.1 with latest kernel 2.4.21 and latest bluez
utilities. I try to connect phone $SUBJECT to my PC using
USB BT card. After some experimantation I succeeded.
But there are still some errors. So treat this as bugreport :-)

sdptool browse - > segfaults

rfcomm bind - it depends on order, in which I start BT / Receive
on phone and invoke rfcomm bind. I have to run command on PC
and then immediatelly start BT/Receive on phone. Usually it
takes me many attempts, before I catch correct timing and these
two devices become connected.

I attach log, as I invoke commands command with hcidump.

Best regards

    Leos



--=-ZXnaOiK1HBcwbb8hQhG3
Content-Transfer-Encoding: base64
Content-Disposition: inline; filename="bt-phillips-fisio.txt.gz"
Content-Type: application/x-gzip; NAME=bt-phillips-fisio.txt.gz

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
vH/uxv4nWkrvp3Xu/1TkYQ6oXQAA

--=-ZXnaOiK1HBcwbb8hQhG3--
