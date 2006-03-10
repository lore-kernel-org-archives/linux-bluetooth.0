Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Geoff Shang <geoff@hitsandpieces.net>
To: bluez-users@lists.sourceforge.net
Message-ID: <Pine.LNX.4.64.0603102152370.10698@data.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Subject: [Bluez-users] pand: Connection failed. File exists(17)
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri, 10 Mar 2006 22:18:57 +1000 (EST)

Hi everyone,

I'm trying to set up a network connection via bluetooth using pand and I've 
hit a problem that I can't find any references to.

I start pand on the NAP side with no problems, using the following comand:

pand --listen --role NAP

When I try to connect from the panu, I get the following:

Mar 10 18:35:46 data pand[16077]: Connection failed. File exists(17)

I get the same sort of thing on the other end.  Here's an example from when 
I tried reversing roles:

Mar 10 18:59:34 data pand[16186]: Bluetooth PAN daemon version 2.25
Mar 10 18:59:34 data pand[16186]: Connecting to 00:02:72:B2:A0:6E
Mar 10 18:59:34 data pand[16186]: Connect to 00:02:72:B2:A0:6E failed. File 
exists(17)

I've searched the web, read all relevant docs I could find, even took a 
look at the pand source.  I got as far as looking at bnep_accept_connection 
but then my brain began to ache (I'm not a C programmer).

I'm using bluez libs and utils v2.25 on both ends.  They were compiled with 
./configure --enable-all though some of the supporting components like obex 
weren't available.  One end is running on a freshly installed Debian 3.1 
system, the other is on a Debian 2.2 system with various upgrades; however 
all bluez items were compiled from source.

If anyone knows what this is, or even simply has suggestions as to what 
file it is that pand is complaining about, I'd be extremely greatful.

Geoff.


-- 
Geoff Shang <geoff@hitsandpieces.net>
Phone: +61-418-96-5590
MSN: geoff@acbradio.org

Make sure your E-mail can be read by everyone!
http://www.betips.net/etc/evilmail.html

Please avoid sending me Word or PowerPoint attachments.
See http://www.gnu.org/philosophy/no-word-attachments.html


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
