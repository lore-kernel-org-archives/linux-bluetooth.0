Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Mayank BATRA <mayank.batra@st.com>
To: "'BlueZ development'" <bluez-devel@lists.sourceforge.net>
Date: Mon, 21 Aug 2006 18:35:32 +0530
Message-ID: <006101c6c522$7be5de60$9d0cc70a@dlh.st.com>
MIME-Version: 1.0
In-Reply-To: <1156171857.3956.32.camel@aeonflux.holtmann.net>
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

Hi Marcel,

> I added the two missing decodings to hcidump now.

I see the following five missing decodings in hcidump. Which ones did you
miss out?

(1)< HCI Command: Host Buffer Size (0x03|0x0033) plen 7
   0000: 00 04 ff 08 00 08 00                              .......

(2) > HCI Event: Command Complete (0x0e) plen 4
    Host Buffer Size (0x03|0x0033) ncmd 1
    0000: 00                                                .

(3) < HCI Command: Set Host Controller To Host Flow Control (0x03|0x0031)
plen 1
    0000: 01                                                .

(4) > HCI Event: Command Complete (0x0e) plen 4
    Set Host Controller To Host Flow Control (0x03|0x0031) ncmd 1
    0000: 00                                                .

(5) < HCI Command: Host Number of Completed Packets (0x03|0x0035) plen 5
  0000: 01 28 00 01 00                                    .(...

> Need to check that. At least you also have to check for OGF. 

That's true. No other choice.

> You have to
> store the setting for host_fc in hci_dev, because it can be different
> for separate controllers.

I agree. But how to provide the user with the facility to switch flow
control on/off? Like we modify security settings through hcid.conf.

Regards,
Mayank


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
