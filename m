Return-Path: <bluez-users-admin@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [Bluez-users] Dbus support
Message-ID: <06CCEA2EB1B80A4A937ED59005FA85518804CF@svits26.main.ad.rit.edu>
From: "Christopher E Piggott" <cepasp@rit.edu>
To: <bluez-users@lists.sourceforge.net>
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
Date: Thu, 2 Feb 2006 13:17:38 -0500

If it's in C it would be great if you are willing to post a sample.  I
am new to dbus so I am fumbling around a little with this.  Your message
helped me, though; it gave me an idea about the types of messages I can
expect to receive.


-----Original Message-----
From: bluez-users-admin@lists.sourceforge.net
[mailto:bluez-users-admin@lists.sourceforge.net] On Behalf Of Claudio
Takahasi
Sent: Thursday, February 02, 2006 12:21 PM
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Dbus support

Hi Chris,

Here you can find information about some BlueZ D-Bus services. It isn't
updated, but it is a good starting point.
http://www.cin.ufpe.br/~ckt/bluez/BlueZDBus/

I developed a gtk client that use all this services. If you want I can
make it available for download. If you want develop a python client,
check the dbus-test script(inside the hcid directory).

Run the command "$dbus-monitor --system" in order to see the signals.
It can be useful.

Regards,
Claudio.


On 2/2/06, Christopher E Piggott <cepasp@rit.edu> wrote:
>
> Where in the source code can I find the dbus/netlink support for
BlueZ?
> Specifically, I'd like to know what events are available to dbus=20
> listeners, and how I configure the groups when I listen for those=20
> events.  Are other things supported besides pin generation?  Can I get

> an event, for example, when something associates?
>
> --Chris
>
>
> -------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc. Do you grep through log

> files for problems?  Stop!  Download the new AJAX search engine that=20
> makes searching your log files as easy as surfing the  web.  DOWNLOAD
SPLUNK!
> http://sel.as-us.falkag.net/sel?cmdlnk&kid=103432&bid#0486&dat=121642
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>


--
---------------------------------------------------------
Claudio Takahasi
Instituto Nokia de Tecnologia - INdT


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log
files for problems?  Stop!  Download the new AJAX search engine that
makes searching your log files as easy as surfing the  web.  DOWNLOAD
SPLUNK!
http://sel.as-us.falkag.net/sel?cmdlnk&kid=103432&bid#0486&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
