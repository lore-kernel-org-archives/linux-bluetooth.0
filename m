Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <41F0EB0A.1020302@webstuhl.net>
From: Ben Pezzei <ben@webstuhl.net>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: [Bluez-devel] Again: Problems with Dongle, Headset or btsco
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
Date: Fri, 21 Jan 2005 12:44:10 +0100

Hi

I still try to use my Anycom 240 USB Dongle with the Plantronics 2500
Headset.  As Marcel stated in a previous Thread, this dongle looks
like to have an RSSI inquiry bug.

to make it short: shall I buy another dongle? And which one is known
to work without problems?

Here is the List what I did:

compile 2.6.10 Kernel (without patch-2.6.10-mh1.gz). In
previous trys I used the bluez libs and tools (compiled
them outside the kernel).

compile the latest btsco csv

btsco <addr> connects to the headset and i can change
the volume via the headset-button.

So i guess the rfcomm Communication is ok

But aplay -D plughw:Headset soundfile doesnt work.
either arecord ...
(btw: Should aplay ... be executed while btsco is connected
to the HS?)

weird thing: when using the hstest prog in bluez-utils i am
able to record _something_ but it's more or less static
(although the noises appear to be the spoken text - with
wrong frequency/speed).

Any Hints?

friendly regards
ben





-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
