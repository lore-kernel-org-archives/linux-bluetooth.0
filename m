Return-Path: <cyrus@holtmann.org>
Message-ID: <3e9cdced0805170741i202cfe62kef18ca9a0c2e30c@mail.gmail.com>
Date: Sat, 17 May 2008 16:41:02 +0200
From: "Fritz Code" <codefritz@googlemail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] using bluez dbus interface exposed from hcid with
	plain c code
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0048900222=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0048900222==
Content-Type: multipart/alternative;
	boundary="----=_Part_3270_14366084.1211035262394"

------=_Part_3270_14366084.1211035262394
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

since I don't have resources for Glib or another abstraction layer on my
Embedded Linux I can only use plain C for communication with bluez through
dbus.
But so far I've only find howto's with GLib or Qt etc.
Are there any documents that describe my case (plain c communication) ?

For general understanding of the bluez architecture and tools, a statement
and a question:

hcid is the daemon which exposes different Interfaces through dbus, e.g. the
Interface "Adapter".
Another Application can access bluez functionalities through dbus by using
the Interfaces exposed from hcid. (hopefully also by using plain C).

E.g.: You want to develop an application "example-app" which should list
available local buetooth devices, remote devices and its services.
In this case it is enough to start hcid and use its Interface "Adapter" from
"example-app" ?

The other tools like, hcitool, hciconfig etc. are not necessary, they are
own applications, right.
In order to use bluez features from another application (through dbus) the
only tool/util needed is hcid?
And this is configured by hcid.conf?



Thanks...





-- 
Regards,
--Codefritz

------=_Part_3270_14366084.1211035262394
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,<br><br>since I don&#39;t have resources for Glib or another abstraction layer on my Embedded Linux I can only use plain C for communication with bluez through dbus.<br>But so far I&#39;ve only find howto&#39;s with GLib or Qt etc. <br>
Are there any documents that describe my case (plain c communication) ?<br><br>For general understanding of the bluez architecture and tools, a statement and a question:<br><br>hcid is the daemon which exposes different Interfaces through dbus, e.g. the Interface &quot;Adapter&quot;.<br>
Another Application can access bluez functionalities through dbus by using the Interfaces exposed from hcid. (hopefully also by using plain C).<br><br>E.g.: You want to develop an application &quot;example-app&quot; which should list available local buetooth devices, remote devices and its services.<br>
In this case it is enough to start hcid and use its Interface &quot;Adapter&quot; from &quot;example-app&quot; ?<br><br>The other tools like, hcitool, hciconfig etc. are not necessary, they are own applications, right.<br>
In order to use bluez features from another application (through dbus) the only tool/util needed is hcid?<br>And this is configured by hcid.conf?<br><br><br><br>Thanks... <br><br><br><br><br clear="all"><br>-- <br>Regards,<br>
--Codefritz<br><br><br><br>

------=_Part_3270_14366084.1211035262394--


--===============0048900222==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft 
Defy all challenges. Microsoft(R) Visual Studio 2008. 
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============0048900222==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0048900222==--
