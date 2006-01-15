Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <45bf5ff80601151440w47f2f38bs80a68fafc8e8fdf1@mail.gmail.com>
From: Artur Almeida <fidalgo.a@gmail.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_122025_13836310.1137364810301"
Subject: [Bluez-devel] Time Between Rfcomm Connections
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
Date: Sun, 15 Jan 2006 22:40:10 +0000

------=_Part_122025_13836310.1137364810301
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi

 Im testing a few dongles that i bought but none of them is able to achieve
7 simultaneous rfcomm connections in a piconet. Im a master in all
comunications and i initiate the connections with the mobile phones,
depending on the ship provider the max number of communications i managed t=
o
establish was 5, in a 1.2  broadcom bluetooth dongle, tipcally i can only
establish 4 in a silicon wave or Csr dongle (All 1.2). Also, the delay that
i have to force between rfcomm connections varies from 2 to 3 sec depending
on the ship provider, otherwise i get resource busy messages. Can someone
point me a bluetooth usb dongle that is able to establish 7 rfcomm
connections? I thought this was a mandatory request from the bluetooth spec
but i tested more then 15 diferent dongles and the best i got was 5.
Concerning the delay between rfcomm connections , is this something
controled by bluez or some limitation in the ship provider?

Thank You

Regards

Artur

------=_Part_122025_13836310.1137364810301
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi<br><br>&nbsp;Im testing a few dongles that i bought but none of them is =
able to achieve 7 simultaneous rfcomm connections in a piconet. Im a master=
 in all comunications and i initiate the connections with the mobile phones=
, depending on the ship provider the max number of communications i managed=
 to establish was 5, in a=20
1.2&nbsp; broadcom bluetooth dongle, tipcally i can only establish 4 in a s=
ilicon wave or Csr dongle (All 1.2). Also, the delay that i have to force b=
etween rfcomm connections varies from 2 to 3 sec depending on the ship prov=
ider, otherwise i get resource busy messages. Can someone point me a blueto=
oth usb dongle that is able to establish 7 rfcomm connections? I thought th=
is was a mandatory request from the bluetooth spec&nbsp; but i tested more =
then 15 diferent dongles and the best i got was 5. Concerning the delay bet=
ween rfcomm connections , is this something controled by bluez or some limi=
tation in the ship provider?=20
<br><br>Thank You<br><br>Regards<br><br>Artur<br>&nbsp;<br>

------=_Part_122025_13836310.1137364810301--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
