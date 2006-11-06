Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <7e36c64c0611060046j3d04ee1ibab63a54509a0532@mail.gmail.com>
Date: Mon, 6 Nov 2006 14:16:33 +0530
From: "shantibhushan sale" <shantibhushan.sale@gmail.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-devel] BT
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1355343382=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============1355343382==
Content-Type: multipart/alternative;
	boundary="----=_Part_47694_19589922.1162802793223"

------=_Part_47694_19589922.1162802793223
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Can i get any info how about Bluetooth On/OFF.I tried a program that doesnt
help out much for me.Does anyone help me here.
Here is this program which works as hciconfig hci0 up

int start_device(uint16_t dev_id)
{
    struct hci_dev *dev;
    struct hci_version ver;
    uint8_t features[8], inqmode;
    int dd;

    ASSERT_DEV_ID;

    dev = &devices[dev_id];

    if (dev->ignore)
        return 0;

    dd = hci_open_dev(dev_id);
    if (dd < 0) {
        error("Can't open device hci%d",
                    dev_id, strerror(errno), errno);
        return -errno;
    }

    if (hci_read_local_version(dd, &ver, 1000) < 0) {
        int err = errno;
        error("Can't read version info for hci%d: %s (%d)",
                    dev_id, strerror(errno), errno);
        hci_close_dev(dd);
        return -err;
    }

    dev->hci_rev = ver.hci_rev;
    dev->lmp_ver = ver.lmp_ver;
    dev->lmp_subver = ver.lmp_subver;
    dev->manufacturer = ver.manufacturer;

    if (hci_read_local_features(dd, features, 1000) < 0) {
        int err = errno;
        error("Can't read features for hci%d: %s (%d)",
                    dev_id, strerror(errno), errno);
        hci_close_dev(dd);
        return -err;
    }

    memcpy(dev->features, features, 8);

    inqmode = get_inquiry_mode(dev);
    if (inqmode < 1)
        goto done;

    if (hci_write_inquiry_mode(dd, inqmode, 1000) < 0) {
        int err = errno;
        error("Can't write inquiry mode for hci%d: %s (%d)",
                    dev_id, strerror(errno), errno);
        hci_close_dev(dd);
        return -err;
    }

done:
    hci_close_dev(dd);

    printf("Device hci%d has been activated", dev_id);

    return 0;
}

------=_Part_47694_19589922.1162802793223
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Can i get any info how about Bluetooth On/OFF.I tried a program that doesnt help out much for me.Does anyone help me here.<br>Here is this program which works as hciconfig hci0 up<br><br>int start_device(uint16_t dev_id)<br>
{<br>&nbsp;&nbsp;&nbsp; struct hci_dev *dev;<br>&nbsp;&nbsp;&nbsp; struct hci_version ver;<br>&nbsp;&nbsp;&nbsp; uint8_t features[8], inqmode;<br>&nbsp;&nbsp;&nbsp; int dd;<br><br>&nbsp;&nbsp;&nbsp; ASSERT_DEV_ID;<br><br>&nbsp;&nbsp;&nbsp; dev = &amp;devices[dev_id];<br><br>&nbsp;&nbsp;&nbsp; if (dev-&gt;ignore)<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; return 0;
<br><br>&nbsp;&nbsp;&nbsp; dd = hci_open_dev(dev_id);<br>&nbsp;&nbsp;&nbsp; if (dd &lt; 0) {<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; error(&quot;Can't open device hci%d&quot;,<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; dev_id, strerror(errno), errno);<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; return -errno;<br>&nbsp;&nbsp;&nbsp; }<br><br>&nbsp;&nbsp;&nbsp; if (hci_read_local_version(dd, &amp;ver, 1000) &lt; 0) {
<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; int err = errno;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; error(&quot;Can't read version info for hci%d: %s (%d)&quot;,<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; dev_id, strerror(errno), errno);<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; hci_close_dev(dd);<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; return -err;<br>&nbsp;&nbsp;&nbsp; }<br>
<br>&nbsp;&nbsp;&nbsp; dev-&gt;hci_rev = ver.hci_rev;<br>&nbsp;&nbsp;&nbsp; dev-&gt;lmp_ver = ver.lmp_ver;<br>&nbsp;&nbsp;&nbsp; dev-&gt;lmp_subver = ver.lmp_subver;<br>&nbsp;&nbsp;&nbsp; dev-&gt;manufacturer = ver.manufacturer;<br><br>&nbsp;&nbsp;&nbsp; if (hci_read_local_features(dd, features, 1000) &lt; 0) {
<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; int err = errno;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; error(&quot;Can't read features for hci%d: %s (%d)&quot;,<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; dev_id, strerror(errno), errno);<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; hci_close_dev(dd);<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; return -err;<br>&nbsp;&nbsp;&nbsp; }<br><br>
&nbsp;&nbsp;&nbsp; memcpy(dev-&gt;features, features, 8);<br><br>&nbsp;&nbsp;&nbsp; inqmode = get_inquiry_mode(dev);<br>&nbsp;&nbsp;&nbsp; if (inqmode &lt; 1)<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; goto done;<br><br>&nbsp;&nbsp;&nbsp; if (hci_write_inquiry_mode(dd, inqmode, 1000) &lt; 0) {<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; int err = errno;
<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; error(&quot;Can't write inquiry mode for hci%d: %s (%d)&quot;,<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; dev_id, strerror(errno), errno);<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; hci_close_dev(dd);<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; return -err;<br>&nbsp;&nbsp;&nbsp; }<br><br>done:<br>&nbsp;&nbsp;&nbsp; hci_close_dev(dd);
<br><br>&nbsp;&nbsp;&nbsp; printf(&quot;Device hci%d has been activated&quot;, dev_id);<br><br>&nbsp;&nbsp;&nbsp; return 0;<br>}<br><br>

------=_Part_47694_19589922.1162802793223--


--===============1355343382==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============1355343382==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1355343382==--
