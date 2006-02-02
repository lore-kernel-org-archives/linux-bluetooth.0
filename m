Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <e1effdeb0602020920i240838a0jd1e6e1b6ee76f27e@mail.gmail.com>
From: Claudio Takahasi <cktakahasi@gmail.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Dbus support
In-Reply-To: <06CCEA2EB1B80A4A937ED59005FA85518804B0@svits26.main.ad.rit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <06CCEA2EB1B80A4A937ED59005FA85518804B0@svits26.main.ad.rit.edu>
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
Date: Thu, 2 Feb 2006 15:20:43 -0200

Hi Chris,

Here you can find information about some BlueZ D-Bus services. It
isn't updated, but it is a good starting point.
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
> Where in the source code can I find the dbus/netlink support for BlueZ?
> Specifically, I'd like to know what events are available to dbus
> listeners, and how I configure the groups when I listen for those
> events.  Are other things supported besides pin generation?  Can I get
> an event, for example, when something associates?
>
> --Chris
>
>
> -------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc. Do you grep through log fi=
les
> for problems?  Stop!  Download the new AJAX search engine that makes
> searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
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
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
