Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <e1effdeb0611280457p51b5b9a4vdd003eb8e5f4efab@mail.gmail.com>
Date: Tue, 28 Nov 2006 09:57:40 -0300
From: "Claudio Takahasi" <cktakahasi@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
MIME-Version: 1.0
Subject: [Bluez-devel] [DBUS] Service Agent Security
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

Hi Marcel,

In the new service interface, hcid will work as a proxy routing
messages from/to clients to service agents. We added verifications
based on the message sender field in the hcid, but it is missing add
some security verification in the service agent side.  If someone
wants to send a message directly to the service agent it is possible!
eg:
dbus-send --system --dest=":1.5" --type=method_call --print-reply
/org/bluez/service_agent_12094 org.bluez.ServiceAgent.Start

I started the investigation how avoid clients send messages directly
to the Service Agents. I don't think it's possible add rules in the
/etc/dbus-1/system.d/bluetooth.conf file to block that. Do you know
how create this rule? It is possible? (As long as I can remember our
last discussion, service agents will not have D-Bus configuration
files.)

Another option is let the Service Agent check this, I mean extract the
sender and only accept message from the hcid. We have the same problem
with authorization and passkey agents.

Comments? Is it really necessary check this or we can leave it open?

BR,
Claudio.

-- 
---------------------------------------------------------
Claudio Takahasi
Instituto Nokia de Tecnologia - INdT

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
