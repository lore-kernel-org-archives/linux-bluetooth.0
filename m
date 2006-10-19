Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Thu, 19 Oct 2006 15:31:33 +0300
From: Johan Hedberg <johan.hedberg@nokia.com>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Message-ID: <20061019123133.GA18838@localhost.localdomain>
References: <20061019115608.GB31910@suse.de>
	<1161259469.27710.40.camel@localhost>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="J2SCkAp4GZ/dPZZf"
In-Reply-To: <1161259469.27710.40.camel@localhost>
Subject: Re: [Bluez-users] DiscoverDevices with apitest?
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 19, 2006, Marcel Holtmann wrote:
> You need to keep the calling application running, because otherwise hcid
> will stop the discovery. That is actually what you see in syslog.

You could also try the attached patch. After that the following command 
should do the trick:
./apitest -l DiscoverDevices

I think we may want to apply this to CVS. Marcel, what do you think?

Johan

--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="apitest.patch"

Index: apitest
===================================================================
RCS file: /cvsroot/bluez/utils/test/apitest,v
retrieving revision 1.1
diff -u -r1.1 apitest
--- apitest	28 Sep 2006 15:23:24 -0000	1.1
+++ apitest	19 Oct 2006 12:30:33 -0000
@@ -399,7 +399,8 @@
             self.dbus_mgr_sig_setup()
             self.dbus_dev_sig_setup()
             print 'Listening for events...'
-        elif self.cmd in mgr_cmds:
+
+        if self.cmd in mgr_cmds:
             try:
                 self.dbus_mgr_setup()
             except dbus.DBusException, e:
@@ -413,7 +414,7 @@
                 print 'Failed to setup device interface: %s' % e
                 sys.exit(1)
             self.call_dev_dbus_func()
-        else:
+        else if not self.listen:
             print 'Unknown command: %s' % self.cmd
             self.usage()
             sys.exit(1)

--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--J2SCkAp4GZ/dPZZf--
