Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <c49421c50612190525h197663fcu79da33f496526f45@mail.gmail.com>
Date: Tue, 19 Dec 2006 11:25:00 -0200
From: "Loreno Oliveira" <lorenooliveira@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Subject: [Bluez-users] notification of baseband conection establishment
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1862111048=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1862111048==
Content-Type: multipart/alternative;
	boundary="----=_Part_5962_7314701.1166534700485"

------=_Part_5962_7314701.1166534700485
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi there,

does anybody know some facility for a called device to detect the
establishment of a baseband connection? That is, say we have two devices, A
and B, and A attempts a paging to B. The idea is fire an event in B as soon
as the baseband connection is established.

I thought two ideas for this: first, when the synchronous call to
"hci_create_connection" returns, A then invokes, via SDP, a service
advertised on B, which fires the event on that device (it is reasonable in
my context to assume that B advertises a service such like that). Second,
some application in B runs a thread that constantly monitors the
availability of baseband connections through "hci_for_each_dev function".
Such an application would maintain a data structure for controling existent
conections. When a new conection is established, B updates the data
structure and fires the event.

Well, I was wondering if there is a better solution for this problem.

PS: I am developing over the BlueZ code itself, and not over the utilities
hcitools, hciconfig....

Regards and thanks for any hint...

Loreno

------=_Part_5962_7314701.1166534700485
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi there,<br><br>does anybody know some facility for a called device to detect the establishment of a baseband connection? That is, say we have two devices, A and B, and A attempts a paging to B. The idea is fire an event in B as soon as the baseband connection is established.
<br><br>I thought two ideas for this: first, when the <span>synchronous </span>call to &quot;hci_create_connection&quot; returns, A then invokes, via SDP, a service advertised on B, which fires the event on that device (it is reasonable in my context to assume that B advertises a service such like that). Second, some application in B runs a thread that constantly monitors the availability of baseband connections through &quot;hci_for_each_dev function&quot;. Such an application would maintain a data structure for controling existent conections. When a new conection is established, B updates the data structure and fires the event.
<br><br>Well, I was wondering if there is a better solution for this problem.<br><br>PS: I am developing over the BlueZ code itself, and not over the utilities hcitools, hciconfig....<br><br>Regards and thanks for any hint...
<br><br>Loreno<br>

------=_Part_5962_7314701.1166534700485--


--===============1862111048==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1862111048==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1862111048==--
