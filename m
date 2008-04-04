Return-Path: <cyrus@holtmann.org>
Message-ID: <70e62ac60804040358l79a3b3a0jcdaa6c3bb7d21d00@mail.gmail.com>
Date: Fri, 4 Apr 2008 12:58:55 +0200
From: "Davide Bertola" <dade@dadeb.it>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] Bluetooth Power Management question
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0104825223=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0104825223==
Content-Type: multipart/alternative;
	boundary="----=_Part_7212_23926673.1207306735507"

------=_Part_7212_23926673.1207306735507
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

---------- Forwarded message ----------
From: Davide Bertola <dade@dadeb.it>
Date: Thu, Apr 3, 2008 at 12:27 PM
Subject: bluetooth question
To: marcel@trifinite.org


Hi,
I'm Davide from Italy.
I'm a Ubuntu Linux user (Hardy). My hardware is a Macbook (1,1) first
generation.
I'm investigating why power battery life is so different usin osx (4.5/5
hours)
or using linux (3/3.5 hours) [times are tested, not acpi estimated].

So this is my question.

My macbook has bluetooth connected to usb 1-4 (uhci) and I see something
strange.
When bluetooth.ko is loaded and hci0 is UP powertop shows that usb 1-4 wakes
up
the cpu 100/140 times, and cpu is in c0 state for about 2% - 3% of the time.

If I type "sudo hciconfig hci0 down" all those wakeups due to usb 1-4
disappear,
and the cpu goes in c0 for only 0.4% of the time.

If I also boot without loading bluetooth at all, my bluetooth mouse WORKS
in
a sort of usb emulation. It's seen as standard usb mouse. This way I can use
the
bt mouse without generating all those wakeups and cpu load. This reduce
power
consumption from 0.5 to 1W.

So it seems to me that bluetooth module does a lot of work that is not
necessary.
Why all those wakeups and cpu load?

The bluetooth adapter is from Cambridge Silicon Radio, like the powerbook
ones.

------=_Part_7212_23926673.1207306735507
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><br><div class="gmail_quote">---------- Forwarded message ----------<br>From: <b class="gmail_sendername">Davide Bertola</b> &lt;<a href="mailto:dade@dadeb.it">dade@dadeb.it</a>&gt;<br>Date: Thu, Apr 3, 2008 at 12:27 PM<br>
Subject: bluetooth question<br>To: <a href="mailto:marcel@trifinite.org">marcel@trifinite.org</a><br><br><br><div>Hi,</div><div>I&#39;m Davide from Italy.</div><div>I&#39;m a Ubuntu Linux user (Hardy). My hardware is a Macbook (1,1) first generation.</div>
<div>I&#39;m investigating why power battery life is so different usin osx (4.5/5 hours)</div>
<div>or using linux (3/3.5 hours) [times are tested, not acpi estimated].</div><div><br></div><div>So this is my question.</div><div><br></div><div>My macbook has bluetooth connected to usb 1-4 (uhci) and I see something strange.</div>

<div>When bluetooth.ko is loaded and hci0 is UP powertop shows that usb 1-4 wakes up&nbsp;</div><div>the cpu 100/140 times, and cpu is in c0 state for about 2% - 3% of the time.</div><div><br></div><div>If I type &quot;sudo hciconfig hci0 down&quot; all those wakeups due to usb 1-4 disappear,</div>

<div>and the cpu goes in c0 for only 0.4% of the time.</div><div><br></div><div>If I also boot without loading bluetooth at all, my bluetooth mouse WORKS in&nbsp;</div><div>a sort of usb emulation. It&#39;s seen as standard usb mouse. This way I can use the&nbsp;</div>

<div>bt mouse without generating all those wakeups and cpu load. This reduce power&nbsp;</div><div>consumption from 0.5 to 1W.</div><div><br></div><div>So it seems to me that bluetooth module does a lot of work that is not necessary.</div>

<div>Why all those wakeups and cpu load?</div><div><br></div><div>The bluetooth adapter is from Cambridge Silicon Radio, like the powerbook ones.</div><br></div><br>

------=_Part_7212_23926673.1207306735507--


--===============0104825223==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
--===============0104825223==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0104825223==--
