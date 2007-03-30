Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <c49421c50703292018r4a1fb72fpc47f1339fa1f2939@mail.gmail.com>
Date: Fri, 30 Mar 2007 00:18:01 -0300
From: "Loreno Oliveira" <lorenooliveira@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Subject: [Bluez-users] problem reading rssi
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1302257194=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1302257194==
Content-Type: multipart/alternative;
	boundary="----=_Part_66621_15986824.1175224681626"

------=_Part_66621_15986824.1175224681626
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

I am having some headache for reading the rssi of a remote device. The code
bellow insists in returning 0 to the "rssi" variable when I try to read the
rssi of a connected Nokia 770. If I run the same code for a connected
desktop, then a non zero value is returned. For complicating even more, if I
run "hcitool clkoff <addr>" when connected to the 770, then a non zero value
is also returned.

    struct hci_conn_info_req* cr;
    bdaddr_t bdaddr;
    int8_t rssi;

    char* addr = device->client->getClientAddressAsString();
    int sockId = device->dongle->getSocketId();

    str2ba( addr, &bdaddr );

    cr = (hci_conn_info_req*)malloc(sizeof(*cr) + sizeof(struct
hci_conn_info));
    if( !cr ) {
        perror( "Can't allocate memory" );
        exit( 1 );
    }

    bacpy(&cr->bdaddr, &bdaddr);
    cr->type = ACL_LINK;
    if( ioctl( sockId, HCIGETCONNINFO, (unsigned long) cr ) < 0 ) {
        perror("Get connection info failed");
        exit(1);
    }

    if( hci_read_rssi(sockId, htobs(cr->conn_info->handle), &rssi, 1000) < 0
) {
        perror("Read RSSI failed");
        exit(1);
    }

    printf("RSSI return value: %d\n", rssi);

    free(cr);
    return (int)rssi;

Does anyone have some idea about what is going wrong here?

Loreno

------=_Part_66621_15986824.1175224681626
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,<br><br>I am having some headache for reading the rssi of a remote device. The code bellow insists in returning 0 to the &quot;rssi&quot; variable when I try to read the rssi of a connected Nokia 770. If I run the same code for a connected desktop, then a non zero value is returned. For complicating even more, if I run &quot;hcitool clkoff &lt;addr&gt;&quot; when connected to the 770, then a non zero value is also returned.
<br><br>&nbsp;&nbsp;&nbsp; struct hci_conn_info_req* cr;<br>&nbsp;&nbsp;&nbsp; bdaddr_t bdaddr;<br>&nbsp;&nbsp;&nbsp; int8_t rssi;<br>&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp; char* addr = device-&gt;client-&gt;getClientAddressAsString();<br>&nbsp;&nbsp;&nbsp; int sockId = device-&gt;dongle-&gt;getSocketId();<br>
<br>&nbsp;&nbsp;&nbsp; str2ba( addr, &amp;bdaddr );<br><br>&nbsp;&nbsp;&nbsp; cr = (hci_conn_info_req*)malloc(sizeof(*cr) + sizeof(struct hci_conn_info));<br>&nbsp;&nbsp;&nbsp; if( !cr ) {<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; perror( &quot;Can&#39;t allocate memory&quot; );<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; exit( 1 );
<br>&nbsp;&nbsp;&nbsp; }<br><br>&nbsp;&nbsp;&nbsp; bacpy(&amp;cr-&gt;bdaddr, &amp;bdaddr);<br>&nbsp;&nbsp;&nbsp; cr-&gt;type = ACL_LINK;<br>&nbsp;&nbsp;&nbsp; if( ioctl( sockId, HCIGETCONNINFO, (unsigned long) cr ) &lt; 0 ) {<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; perror(&quot;Get connection info failed&quot;);
<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; exit(1);<br>&nbsp;&nbsp;&nbsp; }<br><br>&nbsp;&nbsp;&nbsp; if( hci_read_rssi(sockId, htobs(cr-&gt;conn_info-&gt;handle), &amp;rssi, 1000) &lt; 0 ) {<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; perror(&quot;Read RSSI failed&quot;);<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; exit(1);<br>&nbsp;&nbsp;&nbsp; }<br><br>&nbsp;&nbsp;&nbsp; printf(&quot;RSSI return value: %d\n&quot;, rssi);
<br><br>&nbsp;&nbsp;&nbsp; free(cr);<br>&nbsp;&nbsp;&nbsp; return (int)rssi;<br><br>Does anyone have some idea about what is going wrong here?<br><br>Loreno<br>

------=_Part_66621_15986824.1175224681626--


--===============1302257194==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1302257194==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1302257194==--
