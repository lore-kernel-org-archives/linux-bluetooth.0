Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <BAY124-W447656DE4AA676C57F7C6CF0570@phx.gbl>
From: Robert Rawlins <robert_rawlins@hotmail.com>
To: <bluez-users@lists.sourceforge.net>
Date: Thu, 19 Apr 2007 17:04:16 +0000
MIME-Version: 1.0
Subject: Re: [Bluez-users] Obex Push Channel
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1847908156=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1847908156==
Content-Type: multipart/alternative;
	boundary="_35f838a9-7bfd-4bf4-935b-b153311ecd1b_"

--_35f838a9-7bfd-4bf4-935b-b153311ecd1b_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello Guys,
=20
I've been toying with this today and I'm still not making any real progress=
, In the mean time i tried to give the XML version a go as to be honest thi=
s is likely to be of more use to me anyway, But it doesn't appear to find t=
he XML function in the adapter object so i get the following error when try=
ing to run it.
=20
  File "./sdp.py", line 14, in ?    result2 =3D adapter.GetRemoteServiceRec=
ordAsXML('00:17:B0:A0:E7:09', result[0])  File "/var/lib/python-support/pyt=
hon2.4/dbus/proxies.py", line 169, in __call__    reply_message =3D self._c=
onnection.send_message_with_reply_and_block(message, timeout)dbus.DBusExcep=
tion: org.bluez.Error.UnknownMethod: Method "GetRemoteServiceRecordAsXML" w=
ith signature "su" on interface "org.bluez.Adapter" doesn't exist
The code I'm using looks like this.
=20
#!/usr/bin/python
import dbus
bus =3D dbus.SystemBus()
obj =3D bus.get_object('org.bluez', '/org/bluez')
obj =3D bus.get_object('org.bluez', '/org/bluez/hci0')
adapter =3D dbus.Interface(obj, 'org.bluez.Adapter')
# Search For Obex Push Protocol
print('Start Scan...')
result =3D adapter.GetRemoteServiceHandles('00:17:B0:A0:E7:09', 'opp')
result2 =3D adapter.GetRemoteServiceRecordAsXML('00:17:B0:A0:E7:09', result=
[0])
print result
print('Done Scanning.')
=20
Now as you can see from the code and the signature in the exception thrown =
by dbus I'm passing in the right types of arguments in the form of a string=
 address and a unit32 handle for the obex push record but it doesn't appear=
 to come to life, I've upgraded to bluez 3.9 and still no change.
=20
Thanks for any further help anyone can offer,
=20
Rob
_________________________________________________________________
Try Live.com - your fast, personalized homepage with all the things you car=
e about in one place.
http://www.live.com/getstarted=

--_35f838a9-7bfd-4bf4-935b-b153311ecd1b_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<style>
P
{
margin:0px;
padding:0px
}
body
{
FONT-SIZE: 10pt;
FONT-FAMILY:Tahoma
}
</style>
</head>
<body>Hello Guys,<BR>
&nbsp;<BR>
I've been toying with this today and I'm still not making any real progress=
, In the mean time i tried to give the XML version a go as to be honest thi=
s is likely to be of more use to me anyway, But it doesn't appear to find t=
he XML function in the adapter object so i get the following error when try=
ing to run it.<BR>
&nbsp;<BR>
&nbsp; File "./sdp.py", line 14, in ?<BR>&nbsp;&nbsp;&nbsp; result2 =3D ada=
pter.GetRemoteServiceRecordAsXML('00:17:B0:A0:E7:09', result[0])<BR>&nbsp; =
File "/var/lib/python-support/python2.4/dbus/proxies.py", line 169, in __ca=
ll__<BR>&nbsp;&nbsp;&nbsp; reply_message =3D self._connection.send_message_=
with_reply_and_block(message, timeout)<BR>dbus.DBusException: org.bluez.Err=
or.UnknownMethod: Method "GetRemoteServiceRecordAsXML" with signature "su" =
on interface "org.bluez.Adapter" doesn't exist<BR><BR>
The code I'm using looks like this.<BR>
&nbsp;<BR>
#!/usr/bin/python<BR>
import dbus<BR>
bus =3D dbus.SystemBus()<BR>
obj =3D bus.get_object('org.bluez', '/org/bluez')<BR>
obj =3D bus.get_object('org.bluez', '/org/bluez/hci<FONT face=3D"Courier Ne=
w">0</FONT><FONT face=3D"">')<BR>
adapter =3D dbus.Interface(obj, 'org.bluez.Adapter')<BR>
# Search For Obex Push Protocol<BR>
print('Start Scan...')<BR></FONT><FONT face=3D"Courier New">
result =3D adapter.GetRemoteServiceHandles('00:17:B0:A0:E7:09', 'opp')<BR>
result2 =3D adapter.GetRemoteServiceRecordAsXML('00:17:B0:A0:E7:09', result=
[0])<BR></FONT><FONT face=3D"Courier New">
p</FONT><FONT size=3D1><FONT face=3D"Times New Roman" size=3D2>rint result<=
/FONT><BR>
<FONT size=3D2>print('Done Scanning.')</FONT><BR>
<FONT size=3D2></FONT>&nbsp;<BR>
<FONT size=3D2>Now as you can see from the code and the signature in the ex=
ception thrown by dbus I'm passing in the right types of arguments in the f=
orm of a string address and a unit32 handle for the obex push record but it=
 doesn't appear to come to life, I've upgraded to <FONT face=3D"">bluez 3.9=
 and still no change.</FONT></FONT><BR>
<FONT size=3D2></FONT>&nbsp;<BR>
<FONT size=3D2>Thanks for any further help anyone can offer,</FONT><BR>
<FONT size=3D2></FONT>&nbsp;<BR>
<FONT size=3D2>Rob</FONT><BR></FONT><br /><hr />Express yourself instantly =
with Windows Live Messenger, the future of MSN Messenger! <a href=3D'http:/=
/imagine-msn.com/messenger/launch/en-GB/' target=3D'_new'>Windows Live Mess=
enger, the future of MSN Messenger!</a></body>
</html>=

--_35f838a9-7bfd-4bf4-935b-b153311ecd1b_--


--===============1847908156==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============1847908156==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1847908156==--
