Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Wed, 29 Nov 2006 02:50:56 -0800 (PST)
From: Sergey Krivov <krivov@yahoo.com>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1164791561.5071.5.camel@aeonflux.holtmann.net>
MIME-Version: 1.0
Message-ID: <600808.9254.qm@web31014.mail.mud.yahoo.com>
Subject: [Bluez-devel] two concurrent a2dp connections
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

i am trying to work with two a2dp streams at the same
time. if i do it in the following way it works.
first way (schematically,):

lacp=[] # list of ACP
stream1=connect(addr1)
lacp.append(stream1)
stream2=connect(addr2) 
lacp.append(stream)


if i do it in a different way it does not.
here i advertise a2dp just to get the address
of the units. if i have more than two units the sound
is destroyed completely.  

second way (schematically):
lacp=[]
while true:
    sock2,addr,port=advertise_a2dp()
    avdtp_discover_abort(sock2)  
    sock2.close()
    lacp.append(connect(addr))

using hcidump i found that in the first case the media
packets are send more or less synchronously:
grep of hcidump output gives:
    L2CAP(d): cid 0x0041 len 621 [psm 0]
    L2CAP(d): cid 0x0041 len 621 [psm 0]
    L2CAP(d): cid 0x006b len 621 [psm 0]
    L2CAP(d): cid 0x0041 len 621 [psm 0]
    L2CAP(d): cid 0x006b len 621 [psm 0]
    L2CAP(d): cid 0x0041 len 621 [psm 0]
    L2CAP(d): cid 0x0041 len 621 [psm 0]
    L2CAP(d): cid 0x006b len 621 [psm 0]
    L2CAP(d): cid 0x0041 len 621 [psm 0]
    L2CAP(d): cid 0x006b len 621 [psm 0]
    L2CAP(d): cid 0x0041 len 621 [psm 0]
    L2CAP(d): cid 0x0041 len 621 [psm 0]
    L2CAP(d): cid 0x006b len 621 [psm 0]
    L2CAP(d): cid 0x0041 len 621 [psm 0]
    L2CAP(d): cid 0x006b len 621 [psm 0]
    L2CAP(d): cid 0x0041 len 621 [psm 0]
    L2CAP(d): cid 0x0041 len 621 [psm 0]
    L2CAP(d): cid 0x006b len 621 [psm 0]
    L2CAP(d): cid 0x006b len 621 [psm 0]
    L2CAP(d): cid 0x0041 len 621 [psm 0]
    L2CAP(d): cid 0x006b len 621 [psm 0]

for the second case i get:
    L2CAP(d): cid 0x0042 len 621 [psm 0]
    L2CAP(d): cid 0x0042 len 621 [psm 0]
    L2CAP(d): cid 0x0042 len 621 [psm 0]
    L2CAP(d): cid 0x006b len 621 [psm 0]
    L2CAP(d): cid 0x0042 len 621 [psm 0]
    L2CAP(d): cid 0x0042 len 621 [psm 0]
    L2CAP(d): cid 0x006b len 621 [psm 0]
    L2CAP(d): cid 0x006b len 621 [psm 0]
    L2CAP(d): cid 0x0042 len 621 [psm 0]
    L2CAP(d): cid 0x006b len 621 [psm 0]
    L2CAP(d): cid 0x0042 len 621 [psm 0]
    L2CAP(d): cid 0x006b len 621 [psm 0]
    L2CAP(d): cid 0x0042 len 621 [psm 0]
    L2CAP(d): cid 0x0042 len 621 [psm 0]
    L2CAP(d): cid 0x006b len 621 [psm 0]
    L2CAP(d): cid 0x0042 len 621 [psm 0]
    L2CAP(d): cid 0x0042 len 621 [psm 0]
    L2CAP(d): cid 0x006b len 621 [psm 0]
    L2CAP(d): cid 0x006b len 621 [psm 0]
    L2CAP(d): cid 0x006b len 621 [psm 0]
    L2CAP(d): cid 0x006b len 621 [psm 0]
    L2CAP(d): cid 0x006b len 621 [psm 0]
    L2CAP(d): cid 0x006b len 621 [psm 0]
    L2CAP(d): cid 0x006b len 621 [psm 0]
    L2CAP(d): cid 0x006b len 621 [psm 0]
    L2CAP(d): cid 0x006b len 621 [psm 0]
    L2CAP(d): cid 0x006b len 621 [psm 0]
    L2CAP(d): cid 0x006b len 621 [psm 0]
    L2CAP(d): cid 0x006b len 621 [psm 0]
    L2CAP(d): cid 0x006b len 621 [psm 0]
    L2CAP(d): cid 0x006b len 621 [psm 0]
    L2CAP(d): cid 0x006b len 621 [psm 0]
    L2CAP(d): cid 0x006b len 621 [psm 0]
    L2CAP(d): cid 0x006b len 621 [psm 0]
    L2CAP(d): cid 0x0042 len 621 [psm 0]
    L2CAP(d): cid 0x006b len 621 [psm 0]
    L2CAP(d): cid 0x0042 len 621 [psm 0]
    L2CAP(d): cid 0x0042 len 621 [psm 0]
    L2CAP(d): cid 0x0042 len 621 [psm 0]

what might be the difference between the two cases.
Didnt i set up some socket options? 
Any help is appreciated!


 
____________________________________________________________________________________
Cheap talk?
Check out Yahoo! Messenger's low PC-to-Phone call rates.
http://voice.yahoo.com

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
