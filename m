Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Edouard Lafargue <ELafargue@montrouge.sns.slb.com>
To: bluez-devel@lists.sourceforge.net
Message-id: <1080053029.7507.40.camel@gryffindor>
MIME-version: 1.0
Content-type: multipart/alternative;
 boundary="Boundary_(ID_tB5BMMwAx8dNP5Ozgy0hZQ)"
Subject: [Bluez-devel] Documentation for hcid.conf ?
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 23 Mar 2004 15:43:49 +0100


--Boundary_(ID_tB5BMMwAx8dNP5Ozgy0hZQ)
Content-type: text/plain
Content-transfer-encoding: 7BIT

   Hello,

   I am currently writing a (not so) short document on how to set up a
generic Bluetooth access point under Linux. The goal is to describe a
working setup that enables both DUN and PAN connectivity to a network
through a Linux server, for several clients at the same time. The idea
is to reproduce the basic functionality of a standard Bluetooth access
point.

   While configuring the system, I have discovered that the detection of
my computer as a "Network Access Point" largely depends on the "class"
setting of hcid.conf. A standard "0x100" is not good enough if you want
your Linux box to be automatically detected by a Windows machine, for
example.

    Below is my effort at describing the role/effect of the "class"
option, please feel free to include this in the "hcid.conf" man page
-does it exist ? It's really needed!-. I would appreciate if someone who
is more knowledgeable than me in this field could look at this and
correct what I'm saying there.

    Another useful thing to do would be to describe a few more "class"
options, such as "0x020100" which enables a computer to be detected as a
NAP, etc.

Edouard

--------------------------------------
   - Device Class: "class"

        The default is 0x100 which simply stands for "Computer". The
meaning of the Bluetooth Device Class is described in the Bluetooth
Specification section 1.2 ("Assigned Numbers - Bluetooth Baseband").

        Basically the Bluetooth device class is a high-level description
of the type of device ("Device Class"), such as "Printer", "Computer",
etc, and also the type of high-level services offered by this device
("Networking", "OBEX Object push", etc) . This information is often used
by clients who are looking for a certain type of service around them.

        Where it becomes tricky is that another type of mechanism for
service discovery exists: "SDP", as in "Service Discovery Protocol". SDP
settings are usually taken care of by service-providing applications
(dund or pand for example), but the "class" of the bluetooth device is
usually never updated.

        This is a problem, because in reality, most Bluetooth clients
scan in two steps: they first look for all bluetooth devices around them
and find out their "Device Class" and "Service Class" (both are
contained in the "class" parameter). Then, they use SDP in order to
check if a device in a given class offers the type of service they want.
This means that the hcid.conf "class" parameter needs to be set up
properly in order to be detected in the way you want : in general a
device looking for a service such as "Network Access Point" will only
scan for this service on devices containing "Network" in their service
class. Another example is that Nokia Mobile phones will generally only
send business cards to computers that show "OBEX Object Push" in their
"class" setting.

--------------------


--Boundary_(ID_tB5BMMwAx8dNP5Ozgy0hZQ)
Content-type: text/html; charset=utf-8
Content-transfer-encoding: 7BIT

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.0.9">
</HEAD>
<BODY>
&nbsp;&nbsp; Hello,<BR>
<BR>
&nbsp;&nbsp; I am currently writing a (not so) short document on how to set up a generic Bluetooth access point under Linux. The goal is to describe a working setup that enables both DUN and PAN connectivity to a network through a Linux server, for several clients at the same time. The idea is to reproduce the basic functionality of a standard Bluetooth access point.<BR>
<BR>
&nbsp;&nbsp; While configuring the system, I have discovered that the detection of my computer as a &quot;Network Access Point&quot; largely depends on the &quot;class&quot; setting of hcid.conf. A standard &quot;0x100&quot; is not good enough if you want your Linux box to be automatically detected by a Windows machine, for example.<BR>
<BR>
&nbsp;&nbsp;&nbsp; Below is my effort at describing the role/effect of the &quot;class&quot; option, please feel free to include this in the &quot;hcid.conf&quot; man page -does it exist ? It's really needed!-. I would appreciate if someone who is more knowledgeable than me in this field could look at this and correct what I'm saying there.<BR>
<BR>
&nbsp;&nbsp;&nbsp; Another useful thing to do would be to describe a few more &quot;class&quot; options, such as &quot;0x020100&quot; which enables a computer to be detected as a NAP, etc.<BR>
<BR>
Edouard<BR>
<BR>
--------------------------------------<BR>
&nbsp;&nbsp; - Device Class: &quot;class&quot;<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; The default is 0x100 which simply stands for &quot;Computer&quot;. The meaning of the Bluetooth Device Class is described in the Bluetooth Specification section 1.2 (&quot;Assigned Numbers - Bluetooth Baseband&quot;).<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Basically the Bluetooth device class is a high-level description of the type of device (&quot;Device Class&quot;), such as &quot;Printer&quot;, &quot;Computer&quot;, etc, and also the type of high-level services offered by this device (&quot;Networking&quot;, &quot;OBEX Object push&quot;, etc) . This information is often used by clients who are looking for a certain type of service around them.<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Where it becomes tricky is that another type of mechanism for service discovery exists: &quot;SDP&quot;, as in &quot;Service Discovery Protocol&quot;. SDP settings are usually taken care of by service-providing applications (dund or pand for example), but the &quot;class&quot; of the bluetooth device is usually never updated.<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; This is a problem, because in reality, most Bluetooth clients scan in two steps: they first look for all bluetooth devices around them and find out their &quot;Device Class&quot; and &quot;Service Class&quot; (both are contained in the &quot;class&quot; parameter). Then, they use SDP in order to check if a device in a given class offers the type of service they want. This means that the hcid.conf &quot;class&quot; parameter needs to be set up properly in order to be detected in the way you want : in general a device looking for a service such as &quot;Network Access Point&quot; will only scan for this service on devices containing &quot;Network&quot; in their service class. Another example is that Nokia Mobile phones will generally only send business cards to computers that show &quot;OBEX Object Push&quot; in their &quot;class&quot; setting.<BR>
<BR>
--------------------<BR>
<BR>
</BODY>
</HTML>

--Boundary_(ID_tB5BMMwAx8dNP5Ozgy0hZQ)--


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
