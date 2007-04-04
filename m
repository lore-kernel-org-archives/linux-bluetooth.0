Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-Id: <1175691610.5768.1182988863@webmail.messagingengine.com>
From: "Kenneth Liew Jau Tze" <kenliew@kenliew.org>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Date: Wed, 04 Apr 2007 21:00:10 +0800
Subject: [Bluez-users] A couple of question regarding bluez
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi,

  I am a newbie, and I have look thru the FAQ, could not find a
suitable answer.  I am using Ubuntu 6.10, using the bluez.  I 
am trying to send a photo from my Sony Ericsson phone to the 
server via bluetooth without any passkey or pin.  This mean,
on the Sony K610i phone, you select the picture, and select
Sent To Bluetooth.  I was wondering if it is possible to
set it in such a way that, I can select the PC running bluez
without providing any pin (i.e. 1234).  Is it possible?  or
the bluetooth protocol simply wont allow this.  I have set 
the hcid.conf to have autoinit yes, security none, and 
pairing none, BUT still, it does not work, and my Sony
ask me to enter the 4 digit pin.


  Second question is: when I run bluez, how many handphone
can sent pictures to me at the same time?  can bluez actually
listen to multiple requests and allow the upload from multiple
handphone at the same time?  (I meant, can the obexserver 
does this?)

  Third question is:  can I plug multiple bluetooth dongle
into the same PC?  In such case, how do I configure so that
each dongle has a different name.

  Forth question is:  if I place 2 or 3 dongle, in such case,
can I receive pictures from multiple hand phone at the same 
time?  Do I need to run multiple copies of obexserver?

  Fifth question:  I run the obexserver, but somehow, when
I sent the picture over from my sony phone, it stop at 
half ways, and it just hang there, and I check the /tmp
directory, there are no picture files, am I missing something?

  sixth question:  my friend told me about affix, I now I 
should not ask the question here, but what is the bad 
thing to run affix.  I remember I saw a bluetooth programming
presentation, in there there is a diagram showing many ppl
are using bluez vs affix.  

  seventh question:  some how, I read the FAQ, I read the 
tips, and I run thru many doc, I could not find a good
obexserver.  Is there one that is good that can accept
multiple connections, and really does the job accept the
whole file and write it to the /tmp?  

  eight question:  if multiple uploads are possible, how
the obexserver handle conflict filename/same file name
uploads, etc?  

  Sorry for the long questions list, and I am new to
ubuntu as well as this bluez thingy.  What I want is
I want to have a picture depository server so that 
every one can upload the picture and dump on the 
server.  

  Thanks in advanced.

--ken

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
