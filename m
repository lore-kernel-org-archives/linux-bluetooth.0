Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: "franz keuner" <franz_keuner@gmx.net>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Message-ID: <1366.1078828940@www52.gmx.net>
Content-Type: text/plain; charset="iso-8859-1"
Subject: [Bluez-devel] rfcomm connection send data
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 9 Mar 2004 11:42:20 +0100 (MET)

hello,

i´m trying to develop an application using the bluezstack (usb dongle)  and
the sonyericsson p900.
i´m able to connect the two devices via rfcomm.

rfcomm connect 0 00:00:00:00:00:00  5
Connected /dev/rfcomm0 to 00:00:00:00:00:00  on channel 5
Press CTRL-C for hangup

now i want to send data(string) from one device to the other.
on the p900 i use MIDlets and the java bluetooth api. 

if i start listening and dump with ./rctest -d and trying to connect the
p900 the following message returns:
./rctest -d
rctest: Waiting for connection on channel 10 ...
rctest: Connect from 00:00:00:00:00:00 (p900 adress)
rctest: Receiving ...

an nothing happens...
i use in the MIDlet the command: connector client = (StreamConnection)
Connector.open(btspp://dongle adress and channel));

so the connection seems to work alright.

the data i want to send is a string saved in content:
output = client.openOutputStream();
byte[] data = content.getBytes();
output.write(data);

the p900 confirms it sended the data and rctest gives no error message or
anything.

i hope somebody can help me.

regards,

franzhello,

i´m trying to develop an application using the bluezstack (usb dongle)  and
the sonyericsson p900.
i´m able to connect the two devices via rfcomm.

rfcomm connect 0 00:00:00:00:00:00  5
Connected /dev/rfcomm0 to 00:00:00:00:00:00  on channel 5
Press CTRL-C for hangup

now i want to send data(string) from one device to the other.
on the p900 i use MIDlets and the java bluetooth api. 

if i start listening and dump with ./rctest -d and trying to connect the
p900 the following message returns:
./rctest -d
rctest: Waiting for connection on channel 10 ...
rctest: Connect from 00:00:00:00:00:00 (p900 adress)
rctest: Receiving ...

an nothing happens...
i use in the MIDlet the command: connector client = (StreamConnection)
Connector.open(btspp://dongle adress and channel));

so the connection seems to work alright.

the data i want to send is a string saved in content:
output = client.openOutputStream();
byte[] data = content.getBytes();
output.write(data);

the p900 confirms it sended the data and rctest gives no error message or
anything.

i hope somebody can help me.

regards,

franz

-- 
+++ NEU bei GMX und erstmalig in Deutschland: TÜV-geprüfter Virenschutz +++
100% Virenerkennung nach Wildlist. Infos: http://www.gmx.net/virenschutz



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
