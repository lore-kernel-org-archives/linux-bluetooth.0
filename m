Return-Path: <cyrus@holtmann.org>
Message-ID: <592e5b110801100459w2ea5ec9lb894c912cad3c26@mail.gmail.com>
Date: Thu, 10 Jan 2008 04:59:58 -0800
From: "Ryan Nevell" <ryan.nevell@gmail.com>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <592e5b110801100453v1e62da89n991cfc126e96e568@mail.gmail.com>
MIME-Version: 1.0
References: <592e5b110801100453v1e62da89n991cfc126e96e568@mail.gmail.com>
Subject: [Bluez-users] Simultaneous scan and request
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1042895079=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1042895079==
Content-Type: multipart/alternative;
	boundary="----=_Part_21887_19402057.1199969998020"

------=_Part_21887_19402057.1199969998020
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I'm trying to scan for all available devices, and query them for their name
as soon as possible, without waiting for the scan to complete.

However, if I read a  EVT_INQUIRY_RESULT and then attempt to issue a
OCF_REMOTE_NAME_REQ on the same socket, it always returns with a 0x07 error
(out of memory?). The same thing happens if I use hci_read_remote_name. But
if I wait until EVT_INQUIRY_COMPLETE is received and then issue
hci_read_remote_name, everything works great.

I've also tried opening a 2nd socket with another call to hci_open_dev, but
it appears to be just a symbolic link to the same device. It has a different
fd number, but I receive the (same) data from both sockets, and it still
gives IO error.

So what is the trick to getting simultaneous commands like this working?

Thank you!


Some pseudo code:

/* this will be the socket accepting EVT_INQUIRY_RESULT */
scanner = hci_open_dev( 0 );

/* Set up a filter. If somebody could explain how this works? */
hci_filter_clear( &flt );
hci_filter_all_events( &flt );
hci_filter_set_ptype( HCI_EVENT_PKT, &flt );
setsockopt( sock, SOL_HCI, HCI_FILTER, &flt, sizeof(flt))

/* Send inquiry request - doesn't use ioctl like hid_inquiry does */
guint8 packet[5] = { 0x33, 0x8b, 0x9e, 0x08, 0xff }; (8 * 1.25 seconds
duration, 255 max response)
hci_send_cmd( sock, OGF_LINK_CTL, OCF_INQUIRY, sizeof(packet), packet)

while(1){
    select( [scanner FD_SET] ); // Wait for some response
    recv( scanner, resp, ..); // Read the response

    if (resp[0] == EVT_INQUIRY_RESULT){
        bacpy(bdaddr, resp + someoffset)
        hci_read_remote_name( scanner, bdaddr, ..., 0) // Fails
"Input/output" error

        // Note that this also fails:
        dd = hci_open_dev( 0 )
        hci_read_remote_name( dd, bdaddr, ..., 0) // Fails "Input/output"
error
        hci_close_close( dd )
    }

    if (resp[0] == EVT_INQUIRY_COMPLETE){
        hci_read_remote_name( scanner, bdaddr, ..., 0) // This one works!
        break;
    }
}

hci_close_dev( scanner );

------=_Part_21887_19402057.1199969998020
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I&#39;m trying to scan for all available devices, and query them for their name as soon as possible, without waiting for the scan to complete.<br><div class="gmail_quote"><br>However, if I read a&nbsp; EVT_INQUIRY_RESULT and then attempt to issue a OCF_REMOTE_NAME_REQ on the same socket, it always returns with a 0x07 error (out of memory?). The same thing happens if I use hci_read_remote_name. But if I wait until EVT_INQUIRY_COMPLETE is received and then issue hci_read_remote_name, everything works great.
<br><br>I&#39;ve also tried opening a 2nd socket with another call to hci_open_dev, but it appears to be just a symbolic link to the same device. It has a different fd number, but I receive the (same) data from both sockets, and it still gives IO error.
<br><br>So what is the trick to getting simultaneous commands like this working?<br><br>Thank you!<br><br><br>Some pseudo code:<br><br>/* this will be the socket accepting EVT_INQUIRY_RESULT */<br>scanner = hci_open_dev( 0 );
<br><br>/* Set up a filter. If somebody could explain how this works? */<br>hci_filter_clear( &amp;flt );<br>hci_filter_all_events( &amp;flt );<br>hci_filter_set_ptype( HCI_EVENT_PKT, &amp;flt );<br>setsockopt( sock, SOL_HCI, HCI_FILTER, &amp;flt, sizeof(flt))
<br><br>/* Send inquiry request - doesn&#39;t use ioctl like hid_inquiry does */<br>guint8 packet[5] = { 0x33, 0x8b, 0x9e, 0x08, 0xff }; (8 * 1.25 seconds duration, 255 max response)<br>hci_send_cmd( sock, OGF_LINK_CTL, OCF_INQUIRY, sizeof(packet), packet)
<br><br>while(1){<br>&nbsp;&nbsp;&nbsp; select( [scanner FD_SET] ); // Wait for some response<br>&nbsp;&nbsp;&nbsp; recv( scanner, resp, ..); // Read the response<br>&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp; if (resp[0] == EVT_INQUIRY_RESULT){<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bacpy(bdaddr, resp + someoffset)
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hci_read_remote_name( scanner, bdaddr, ..., 0) // Fails &quot;Input/output&quot; error<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // Note that this also fails:<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dd = hci_open_dev( 0 )<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hci_read_remote_name( dd, bdaddr, ..., 0) // Fails &quot;Input/output&quot; error
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hci_close_close( dd )<br>&nbsp;&nbsp;&nbsp; }<br><br>&nbsp;&nbsp;&nbsp; if (resp[0] == EVT_INQUIRY_COMPLETE){<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hci_read_remote_name( scanner, bdaddr, ..., 0) // This one works!<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>&nbsp;&nbsp;&nbsp; }<br>}<br><br>hci_close_dev( scanner );
<br>
</div><br>

------=_Part_21887_19402057.1199969998020--


--===============1042895079==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
--===============1042895079==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1042895079==--
