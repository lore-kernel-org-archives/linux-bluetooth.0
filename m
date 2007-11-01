Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <307f591f0711011605r58de9dcdr5ad9224efa9060eb@mail.gmail.com>
Date: Thu, 1 Nov 2007 15:05:55 -0800
From: "Paul Huber" <paul2004x@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1193894455.32459.130.camel@violet>
MIME-Version: 1.0
References: <307f591f0710312056r5f3f62ak42bc3cd3b8f01942@mail.gmail.com>
	<1193894455.32459.130.camel@violet>
Subject: Re: [Bluez-devel] multi-frequency scanning & US $2,000 'bounty'
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1416381794=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============1416381794==
Content-Type: multipart/alternative;
	boundary="----=_Part_17911_18475710.1193958355921"

------=_Part_17911_18475710.1193958355921
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

>> all programs liking in libbluetooth must be made GPL

That's no problem.  We planned that already anyway.

>> Just a small piece of advise for everybody who is thinking about taking
this bounty...

Don't take this the wrong way.  I'm not trying to bribe anyone or anything.
It's just that I'm getting paid to provide a solution, and it doesn't seem
right for me to keep pestering the devs on the list with 'how do I?'
questions, and I could waste a lot of time.  I just figured it was better to
be generous and pass it along to anybody who has the know-how to do it right
and do it fast.

>> you have to get the Bluetooth logo on the box

The customer is buying a few hundred off-the-shelf cheap PC's, loading my
software, and then separately they're buying some USB Bluetooth dongles to
stick in the USB port.  They're not then re-selling it.  I wasn't expecting
any issues with Bluetooth licensing because if I go to the store and buy a
PC and separately buy a bluetooth dongle I don't need to put the logo on the
box.  Since my customer is just doing the same thing, I didn't think there
was an issue.  They're not selling it as a Bluetooth-enabled solution, and
they're not reselling the PC + dongle together.  To your knowledge this is
ok, right?

>> using an internal antenna

Previously I've done another unrelated application with mobile phones and a
normal usb bluetooth dongle and tried to demo it at a few trade shows, using
the 'piecemeal' discovery.  It worked fine in the office, but every time the
show got busy with hundreds of phones all around, the scanning slowed to a
crawl.  It took several minutes to detect a phone.  Running hcitool scan
would also lock up for several minutes.  It seems the generic bluetooth usb
dongle was picking up too many phones in a broad area or something.  I never
dug into the real reason, and just wrote this off as a problem with crowded
areas.  But for this application it will be used in crowded areas, so that's
why I wanted to focus the scan area tightly so there's only a few phones in
the scan area at once.  Unfortunately this is really tough to test unless I
get a few hundred phones.  So I was hoping that if I got an antenna where
the signal dropped off sharply outside the detection zone then it would
work.

>> D-Link DBT-120  worked well

Yes, that's what I used in the previous trade show application

>> The phones are gonna be in visible mode?

Yes

>> Scanning times can't be less than 4 secs, but that doesn't mean that the
phone has to be there for 4 secs, with one or two secs is more than enough,
but scanning will not return results in less than that time.

Can the phones be reported as soon as they're detected, so you don't have to
wait the full 4 seconds?  The ideal goal is that people can briskly walk
through this 6 meter area (yes, understand it's a circle not a square) and
be detected before the leave the area.

>> 2.4 is not lighter weight than 2.6

Okay.  We can use 2.6.  I know that around 2.6.15 usb and some other things
were badly broken, and after talking around to some devs on kernel org the
consensus was that 2.4 was more stable and simpler because the multi-tasking
architecture was simpler, and that mission-critical, robust appliances
usually used 2.4.  But, that was a while ago, and if bluetooth doesn't work
well in 2.4, then we'll just use 2.6.

>> Are you planning to use any embedded device running linux? Or just a pc?

It's just a PC in that's a basic X86 box.  But it will be a really cheap
one, like a 500Mhz AMD Geode, or maybe a Via C3.

------=_Part_17911_18475710.1193958355921
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

&gt;&gt; all programs liking in libbluetooth must be made GPL<br><br>That&#=
39;s no problem.&nbsp; We planned that already anyway.<br><br>&gt;&gt; Just=
 a small piece of advise for everybody who is thinking about taking this bo=
unty...
<br><br>Don&#39;t take this the wrong way.&nbsp; I&#39;m not trying to brib=
e anyone or anything.&nbsp; It&#39;s just that I&#39;m getting paid to prov=
ide a solution, and it doesn&#39;t seem right for me to keep pestering the =
devs on the list with &#39;how do I?&#39; questions, and I could waste a lo=
t of time.&nbsp; I just figured it was better to be generous and pass it al=
ong to anybody who has the know-how to do it right and do it fast.
<br><br>&gt;&gt; you have to get the Bluetooth logo on the box<br><br>The c=
ustomer is buying a few hundred off-the-shelf cheap PC&#39;s, loading my so=
ftware, and then separately they&#39;re buying some USB Bluetooth dongles t=
o stick in the USB port.&nbsp; They&#39;re not then re-selling it.&nbsp; I =
wasn&#39;t expecting any issues with Bluetooth licensing because if I go to=
 the store and buy a PC and separately buy a bluetooth dongle I don&#39;t n=
eed to put the logo on the box.&nbsp; Since my customer is just doing the s=
ame thing, I didn&#39;t think there was an issue.&nbsp; They&#39;re not sel=
ling it as a Bluetooth-enabled solution, and they&#39;re not reselling the =
PC + dongle together.&nbsp; To your knowledge this is ok, right?
<br><br>&gt;&gt; using an internal antenna<br><br>Previously I&#39;ve done =
another unrelated application with mobile phones and a normal usb bluetooth=
 dongle and tried to demo it at a few trade shows, using the &#39;piecemeal=
&#39; discovery.&nbsp; It worked fine in the office, but every time the sho=
w got busy with hundreds of phones all around, the scanning slowed to a cra=
wl.&nbsp; It took several minutes to detect a phone.&nbsp; Running hcitool =
scan would also lock up for several minutes.&nbsp; It seems the generic blu=
etooth usb dongle was picking up too many phones in a broad area or somethi=
ng.&nbsp; I never dug into the real reason, and just wrote this off as a pr=
oblem with crowded areas.&nbsp; But for this application it will be used in=
 crowded areas, so that&#39;s why I wanted to focus the scan area tightly s=
o there&#39;s only a few phones in the scan area at once.&nbsp; Unfortunate=
ly this is really tough to test unless I get a few hundred phones.&nbsp; So=
 I was hoping that if I got an antenna where the signal dropped off sharply=
 outside the detection zone then it would work.
<br><br>&gt;&gt; D-Link DBT-120&nbsp; worked well<br><br>Yes, that&#39;s wh=
at I used in the previous trade show application<br><br>&gt;&gt; The phones=
 are gonna be in visible mode?<br><br>Yes<br><br>&gt;&gt; Scanning times ca=
n&#39;t be less than 4 secs, but that doesn&#39;t mean that the phone has t=
o be there for 4 secs, with one or two secs is more than enough, but scanni=
ng will not return results in less than that time.
<br><br>Can the phones be reported as soon as they&#39;re detected, so you =
don&#39;t have to wait the full 4 seconds?&nbsp; The ideal goal is that peo=
ple can briskly walk through this 6 meter area (yes, understand it&#39;s a =
circle not a square) and be detected before the leave the area.
<br><br>&gt;&gt; 2.4 is not lighter weight than 2.6<br><br>Okay.&nbsp; We c=
an use 2.6.&nbsp; I know that around 2.6.15 usb and some other things were =
badly broken, and after talking around to some devs on kernel org the conse=
nsus was that=20
2.4 was more stable and simpler because the multi-tasking architecture was =
simpler, and that mission-critical, robust appliances usually used 2.4.&nbs=
p; But, that was a while ago, and if bluetooth doesn&#39;t work well in 2.4=
, then we&#39;ll just use=20
2.6.<br><br>&gt;&gt; Are you planning to use any embedded device running li=
nux? Or just a pc?<br><br>It&#39;s just a PC in that&#39;s a basic X86 box.=
&nbsp; But it will be a really cheap one, like a 500Mhz AMD Geode, or maybe=
 a Via C3.
<br><br><br>

------=_Part_17911_18475710.1193958355921--


--===============1416381794==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
--===============1416381794==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1416381794==--
