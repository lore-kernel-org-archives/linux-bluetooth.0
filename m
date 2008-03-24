Return-Path: <cyrus@holtmann.org>
Message-ID: <1e9e22610803240814r3b0a9f05g603b485c8b1bb0ec@mail.gmail.com>
Date: Mon, 24 Mar 2008 12:14:19 -0300
From: "Addo Del Grossi" <addo.delgrossi@gmail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] hci_conn_info definition
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1863314536=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1863314536==
Content-Type: multipart/alternative;
	boundary="----=_Part_10607_26363585.1206371659867"

------=_Part_10607_26363585.1206371659867
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Guys,

    I am using the struct hci_conn_info.
    What is the definition the attributes handle and state?
    What are the possible values for the attribute state?

    struct hci_conn_info {
        __u16    handle;
        bdaddr_t bdaddr;
        __u8     type;
        __u8     out;
        __u16    state;
        __u32    link_mode;
    };


Att,
Addo

------=_Part_10607_26363585.1206371659867
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Guys, <br><br>&nbsp;&nbsp;&nbsp; I am using the struct hci_conn_info.<br>&nbsp;&nbsp;&nbsp; What is the definition the attributes handle and state?<br>&nbsp;&nbsp;&nbsp; What are the possible values for the attribute state?<br><br>&nbsp;&nbsp;&nbsp; struct hci_conn_info {<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; __u16&nbsp;&nbsp;&nbsp; handle;<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; bdaddr_t bdaddr;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; __u8&nbsp;&nbsp;&nbsp;&nbsp; type;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; __u8&nbsp;&nbsp;&nbsp;&nbsp; out;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; __u16&nbsp;&nbsp;&nbsp; state;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; __u32&nbsp;&nbsp;&nbsp; link_mode;<br>&nbsp;&nbsp;&nbsp; };<br><br><br>Att,<br>Addo<br>

------=_Part_10607_26363585.1206371659867--


--===============1863314536==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============1863314536==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1863314536==--
