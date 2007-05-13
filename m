Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <46465CE6.8090407@jlab.org>
Date: Sat, 12 May 2007 20:33:42 -0400
From: Chris Carlin <carlin@jlab.org>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] A2DP reconnections and scanning
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

I'm trying A2DP again with Motorola S805 headphone (gave up on the 
Creative CB2530 for the moment).

Everything seems to work as expected except that every four seconds A2DP 
gives the following error message, disconnects from the headphones, 
reconnects, and continues playing.

a2dp_transfer_raw: Wrote -1 not 613 bytes (sbc.len=100)


An earlier post at http://thread.gmane.org/gmane.linux.bluez.devel/10682 
seemed to describe this closely, and he solved it by turning off a 
program that routinely initiated scans. Before I post reams of output I 
wanted to ask: is there anything in Bluez 3.10 that initiates scans like 
this? I have no external programs attempting to scan AFAIK; does Bluez 
do it itself?

~Chris

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
