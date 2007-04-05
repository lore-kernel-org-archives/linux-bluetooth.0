Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <80236d750704050226m1563a49dw74214b6e847c495e@mail.gmail.com>
Date: Thu, 5 Apr 2007 11:26:46 +0200
From: "Emanuele Novelli" <ema.novelli@gmail.com>
To: Bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] reading RSSI value with D-Bus Api
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1412828425=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1412828425==
Content-Type: multipart/alternative;
	boundary="----=_Part_41029_16356545.1175765206242"

------=_Part_41029_16356545.1175765206242
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,
reading another post here, I saw Marcel hinted to use the inquiry from D-Bus
API to sort the devices by their RSSI so I tried a simple test

this is the part of code I'm using
...

 if (dbus_message_is_signal(msg, "org.bluez.Adapter",
"RemoteDeviceFound")) {
          printf ("Remote Device Found Signal Received\n");

             while (dbus_message_iter_get_arg_type(&iter)  !=
DBUS_TYPE_INVALID)  {
                 switch (dbus_message_iter_get_arg_type(&item)) {
                     case DBUS_TYPE_STRING:  /* first pameter bdaddress */
                      .....

                     break;
                     case DBUS_TYPE_UINT32: /* second parameter class of
device */
                     ........
                    break;

                     case DBUS_TYPE_INT16: /* rssi */
                         dbus_message_iter_get_basic(&args, &rssi);
                         printf("rssi: %d\n", rssi);
                         break;

......



Now the problem is: I can read the bdaddress and the device class good, but
the RSSI values I get from variuous devices are negatives (the are in range
-40 -90 usually). I read somewhere RSSI should range from 0 to 255 so maybe
I'm doing something wrong ? api says the type RSSI is int16 not uint16 so I
used a signed variable.

------=_Part_41029_16356545.1175765206242
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,<br>reading another post here, I saw Marcel hinted to use the inquiry from D-Bus API to sort the devices by their RSSI so I tried a simple test<br><br>this is the part of code I&#39;m using<br>...<br><br>&nbsp;if (dbus_message_is_signal(msg, &quot;
org.bluez.Adapter&quot;,&nbsp;&nbsp;&nbsp; &quot;RemoteDeviceFound&quot;)) {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printf (&quot;Remote Device Found Signal Received\n&quot;);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; while (dbus_message_iter_get_arg_type(&amp;iter)&nbsp; !=&nbsp; DBUS_TYPE_INVALID)&nbsp; {
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; switch (dbus_message_iter_get_arg_type(&amp;item)) {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; case DBUS_TYPE_STRING:&nbsp; /* first pameter bdaddress */<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; ..... &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;  
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; break;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; case DBUS_TYPE_UINT32: /* second parameter class of device */<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; ........ <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;&nbsp;  <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; case DBUS_TYPE_INT16: /* rssi */
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; dbus_message_iter_get_basic(&amp;args, &amp;rssi);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; printf(&quot;rssi: %d\n&quot;, rssi);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; break;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; <br>......<br><br>
<br><br>Now the problem is: I can read the bdaddress and the device class good, but the RSSI values I get from variuous devices are negatives (the are in range -40 -90 usually). I read somewhere RSSI should range from 0 to 255 so maybe I&#39;m doing something wrong ? api says the type RSSI is int16 not uint16 so I used a signed variable.
<br><br><br>

------=_Part_41029_16356545.1175765206242--


--===============1412828425==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1412828425==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1412828425==--
