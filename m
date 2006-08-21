Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <004b01c6c518$d298e400$9d0cc70a@dlh.st.com>
References: <004b01c6c518$d298e400$9d0cc70a@dlh.st.com>
Date: Mon, 21 Aug 2006 16:50:57 +0200
Message-Id: <1156171857.3956.32.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Host Controller to Host Flow Control
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

Hi Mayank,

> > please use "hcidump -X -V" 
> 
> Here is the log with hcidump -X -V

I added the two missing decodings to hcidump now.

> > and if the HCI shows a wrong behavior with
> > any of the new commands, please fix it.
> 
> There is no wrong behaviour as such. Just that Host Number of completed
> packets is being sent as soon as we get ACL Data on any connection handle.
> 
> Do you think that the attached patch is decent enough for sending Host
> Number of completed packets to the raw queue? (or is there a better way than
> this?)

Need to check that. At least you also have to check for OGF. You have to
store the setting for host_fc in hci_dev, because it can be different
for separate controllers.

Regards

Marcel



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
