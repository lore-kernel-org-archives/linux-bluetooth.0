Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Thu, 08 Jun 2006 13:17:33 +0200
From: =?windows-1252?Q?G=F6tz_Issel?= <g.issel@fh-wolfenbuettel.de>
To: bluez-devel@lists.sourceforge.net
Message-id: <15a4c8153a9b.153a9b15a4c8@fh-wolfenbuettel.de>
MIME-version: 1.0
Subject: [Bluez-devel] Sim Access Profile question (rfcomm,l2cap,messages)
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi,

I have read the SimAccessProfile Spec and am not 100% sure on the following:

1. Establish connection l2cap and rfcomm (on port given from sdp search)
to SAP-server (ie. a mobile that supports this profile) as stated in
section 4.1, 2nd paragraph of spec?
Is l2cap really needed seperately or is it included when connection via
rfcomm ? If needed, what for?

2. do the binding/pairing stuff

3. Then build messages specified for conection request and write them on
the rfcomm connection using write(socket,values, length) ? ...wait for
response etc. and continue.
I have place the appropriate hex values in a array of unsigned char and
then use that whole array to send.


The real question is here:
- Is the sending via rfcomm the correct way? I sent a dial command
"atd123456789" to the port using channel 0 and my mobile starts
dialing... so in general
the connection is there and the phone reacts.

- What is l2cap needed for? The spec does not help me. Maybe you can?

Happy to phone anyone who can help directly, in case you are not happy
writing all this.. just give me your phone number and a time and timezone.

Thanks ,
Goetz



_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
