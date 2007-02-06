Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <b5dccebe0702061428pebc5f05h3a698325da1363f2@mail.gmail.com>
Date: Tue, 6 Feb 2007 23:28:48 +0100
From: "Mikael Lindqvist" <li.mikael.spam@gmail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] remote device identification
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

Somewhat unstructured, any thoughts would be much appreciated...

I would like to identify the model of a remote bluetooth device and I
wonder if there are any reasonably reliable ways to do this.

Googling around there seems to be a lot of references to [1] which
involves computing a hash from the record handles and channels from a
service discovery. This seems to be mainly a proof of concept, has
someone done further testing to see how well this works?

It would be possible to imagine some variations on this theme as well,
such as computing the hash based on the record handle and service
class id list. I have seen the port for obex change on my phone from
time to time, but not the record handle. So this might be a more
reliable way. Any thoughts on this?

The paper also mentions other possible sources of information, such
and Link Manager commands when connecting to specific services and
Obex behaviour. Which services would be suitable for this? And what
behaviour of Obex should be taken into consideration?

Some LM and obex info that would be usable would be:

For LMP, the version (LMP version, manufacturer and subversion) and
remote supported features.

For OBEX, the negotiated MTU.

What else?

The reason why I would like to do this identification is to detemine
the capabilities of the phone (such as screen resolution, java
version, supported file formats, etc), in order to know what content
it can handle. So the best would be to have a database of devices and
be able to look them up in something like WURFL [2].

Are there any projects like this going on? Both open and commercial
are interesting...

If not, who would like to participate in building such a database?

As I said, some unstructured thoughts... Please give your feedback...

-- Mikael

References:

[1] http://trifinite.org/trifinite_stuff_blueprinting.html
[2] http://wurfl.sourceforge.net/

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
