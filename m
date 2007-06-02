Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <d89ddf300706012143s1444d9c9l98f2a06c8a05171b@mail.gmail.com>
Date: Fri, 1 Jun 2007 22:43:31 -0600
From: "Brad Midgley" <bmidgley@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
MIME-Version: 1.0
Subject: [Bluez-devel] fleshing out audio daemon scenarios
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2050881289=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============2050881289==
Content-Type: multipart/alternative;
	boundary="----=_Part_9191_7635848.1180759411129"

------=_Part_9191_7635848.1180759411129
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hey

I spent some time digging through the alsa api and experimenting with the
daemons in plugz. I also looked over the traces as some alsa clients
including kphone and twinkle.

I came across two problems to the design we've discussed

* for combo headsets, we incorrectly assumed we'd get a device open that was
either write-only or read-write and use that to decide whether to use a2dp
or sco
* we didn't have any provisions for two headsets connecting independently
which we might as well get right (imagine a voip appliance)

So I think a solution is not that complicated, but it gets wordy in
explaining it all out. I did a writeup in the wiki

http://wiki.bluez.org/wiki/Audio#Requirementsoftheaudioservice-alsaplugininterface

Brad

------=_Part_9191_7635848.1180759411129
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hey<br><br>I spent some time digging through the alsa api and experimenting with the daemons in plugz. I also looked over the traces as some alsa clients including kphone and twinkle. <br><br>I came across two problems to the design we&#39;ve discussed
<br><br>* for combo headsets, we incorrectly assumed we&#39;d get a device open that was either write-only or read-write and use that to decide whether to use a2dp or sco<br>* we didn&#39;t have any provisions for two headsets connecting independently which we might as well get right (imagine a voip appliance)
<br><br>So I think a solution is not that complicated, but it gets wordy in explaining it all out. I did a writeup in the wiki<br><br><a href="http://wiki.bluez.org/wiki/Audio#Requirementsoftheaudioservice-alsaplugininterface">
http://wiki.bluez.org/wiki/Audio#Requirementsoftheaudioservice-alsaplugininterface</a><br><br>Brad<br><br>

------=_Part_9191_7635848.1180759411129--


--===============2050881289==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============2050881289==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============2050881289==--
