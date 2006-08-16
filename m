Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <20060816142750.29806.qmail@web51415.mail.yahoo.com>
Date: Wed, 16 Aug 2006 07:27:50 -0700 (PDT)
From: manojt ambe <mp_tambe@yahoo.com>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <20060816133901.GA2993@refinery.twat.com.ar>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-529700959-1155738470=:29236"
Subject: Re: [Bluez-users] Totally confused
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

--0-529700959-1155738470=:29236
Content-Type: multipart/alternative; boundary="0-332191997-1155738470=:29236"

--0-332191997-1155738470=:29236
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

  I modified /usr/local/etc/dbus-1/system.conf as below. After this the pin problem went away. I am using bluez 3.1 and dbus 0.62.  Pls find system.conf attached.
   
  <!-- This is included last so local configuration can override what's 
  in this standard file -->
  <include ignore_missing="yes">/etc/dbus-1/system.d/bluez-hcid.conf</include>
  
thanks,
  Manoj
  
redondos <redondos@gmail.com> wrote:
  On Wed, Aug 16 09:18, Rui Pedro Lopes wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> redondos wrote:
> > Have you tried following the Gentoo wiki? You're probably not using
> > Gentoo, but they are well-known for providing pretty good documentation
> > to the open source community.
> >
> > http://www.gentoo-wiki.com/HOWTO_use_a_bluetooth_headset
> Yap. Actually, I'm using debian...
> >
> > About the PIN code: have you configured a pin helper correctly in
> > hcid.conf? It's pretty simple, you can just write a shell script:
> >
> > #!/bin/sh
> > echo "PIN:1234
> >
> > Make it executable, then edit hcid.conf with the line:
> >
> > pin_helper /path/to/the/script
> Yes, I have tried that. Here is the syslog messages:
> 
> Aug 16 09:13:20 tash hcid[7714]: Bluetooth HCI daemon
> Aug 16 09:13:20 tash hcid[7714]: Unknown option 'pin_helper' line 27
> Aug 16 09:13:20 tash hcid[7714]: syntax error line 27
> Aug 16 09:13:20 tash sdpd[7716]: Bluetooth SDP daemon
> Aug 16 09:13:20 tash hidd[7718]: Bluetooth HID daemon
> Aug 16 09:13:20 tash hcid[7714]: Register path:/org/bluez fallback:1
> Aug 16 09:13:20 tash hcid[7714]: Device hci0 has been added
> Aug 16 09:13:21 tash hcid[7714]: Starting security manager 0
> Aug 16 09:13:21 tash hcid[7714]: Can't write inquiry mode for hci0:
> Input/output error (5)
> Aug 16 09:13:21 tash hcid[7714]: Register path:/org/bluez/hci0 fallback:0
> 
> 
> 
> Apparently, pin_helper is not available...

I forgot the ';' at the end of the line. Did you add that? Can we see
your hcid.conf at its full extent?

> Here is what the Debian maintainer added to the documentation:
> 
> 
> PIN (or passkey) management
> - ---------------------------
> since bluez 3.0 the old pin_helper script has been replaced by
> the dbus interface. To add a default passkey for every outgoing
> request (e.g. the old /etc/bluetooth/pin file) drop it into
> /etc/bluetooth/passkeys/default. (e.g. echo "1234" >
> /etc/bluetooth/passkeys/default )
> To add a passkey for a specific outgoing connection replace default
> with the device's address. ( /etc/default/passkeys/aa:bb:cc:dd:ee:ff
> will contain passkey for aa:bb:cc:dd:ee:ff ).
> After adding a passkey you should restart bluetooth with
> 
> /etc/init.d/bluetooth restart
> 
> and the new passkeys will be registered.
> 
> 
> I have also tried that and it is not working... do you think it is a
> Debian problem?

Oh, you're using 3.x. I don't know, haven't played with it yet, sorry. 

-- 
redondos
-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users


 		
---------------------------------
Get your email and more, right on the  new Yahoo.com 
--0-332191997-1155738470=:29236
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<FONT size=2>  <DIV>I modified /usr/local/etc/dbus-1/system.conf as below. After this the pin problem went away. I am using bluez 3.1 and dbus&nbsp;0.62.&nbsp;&nbsp;Pls find system.conf attached.</DIV>  <DIV>&nbsp;</DIV>  <DIV>&lt;!-- This is included last so local configuration can override what's </DIV>  <DIV>in this standard file --&gt;</DIV>  <DIV>&lt;include ignore_missing="yes"&gt;/etc/dbus-1/system.d/bluez-hcid.conf&lt;/include&gt;</DIV></FONT>  <DIV><BR>thanks,</DIV>  <DIV>Manoj</DIV>  <DIV><BR><B><I>redondos &lt;redondos@gmail.com&gt;</I></B> wrote:</DIV>  <BLOCKQUOTE class=replbq style="PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #1010ff 2px solid">On Wed, Aug 16 09:18, Rui Pedro Lopes wrote:<BR>&gt; -----BEGIN PGP SIGNED MESSAGE-----<BR>&gt; Hash: SHA1<BR>&gt; <BR>&gt; redondos wrote:<BR>&gt; &gt; Have you tried following the Gentoo wiki? You're probably not using<BR>&gt; &gt; Gentoo, but they are well-known for providing pretty good documentation<BR>&gt;
 &gt; to the open source community.<BR>&gt; &gt;<BR>&gt; &gt; http://www.gentoo-wiki.com/HOWTO_use_a_bluetooth_headset<BR>&gt; Yap. Actually, I'm using debian...<BR>&gt; &gt;<BR>&gt; &gt; About the PIN code: have you configured a pin helper correctly in<BR>&gt; &gt; hcid.conf? It's pretty simple, you can just write a shell script:<BR>&gt; &gt;<BR>&gt; &gt; #!/bin/sh<BR>&gt; &gt; echo "PIN:1234<BR>&gt; &gt;<BR>&gt; &gt; Make it executable, then edit hcid.conf with the line:<BR>&gt; &gt;<BR>&gt; &gt; pin_helper /path/to/the/script<BR>&gt; Yes, I have tried that. Here is the syslog messages:<BR>&gt; <BR>&gt; Aug 16 09:13:20 tash hcid[7714]: Bluetooth HCI daemon<BR>&gt; Aug 16 09:13:20 tash hcid[7714]: Unknown option 'pin_helper' line 27<BR>&gt; Aug 16 09:13:20 tash hcid[7714]: syntax error line 27<BR>&gt; Aug 16 09:13:20 tash sdpd[7716]: Bluetooth SDP daemon<BR>&gt; Aug 16 09:13:20 tash hidd[7718]: Bluetooth HID daemon<BR>&gt; Aug 16 09:13:20 tash hcid[7714]: Register
 path:/org/bluez fallback:1<BR>&gt; Aug 16 09:13:20 tash hcid[7714]: Device hci0 has been added<BR>&gt; Aug 16 09:13:21 tash hcid[7714]: Starting security manager 0<BR>&gt; Aug 16 09:13:21 tash hcid[7714]: Can't write inquiry mode for hci0:<BR>&gt; Input/output error (5)<BR>&gt; Aug 16 09:13:21 tash hcid[7714]: Register path:/org/bluez/hci0 fallback:0<BR>&gt; <BR>&gt; <BR>&gt; <BR>&gt; Apparently, pin_helper is not available...<BR><BR>I forgot the ';' at the end of the line. Did you add that? Can we see<BR>your hcid.conf at its full extent?<BR><BR>&gt; Here is what the Debian maintainer added to the documentation:<BR>&gt; <BR>&gt; <BR>&gt; PIN (or passkey) management<BR>&gt; - ---------------------------<BR>&gt; since bluez 3.0 the old pin_helper script has been replaced by<BR>&gt; the dbus interface. To add a default passkey for every outgoing<BR>&gt; request (e.g. the old /etc/bluetooth/pin file) drop it into<BR>&gt; /etc/bluetooth/passkeys/default. (e.g. echo "1234"
 &gt;<BR>&gt; /etc/bluetooth/passkeys/default )<BR>&gt; To add a passkey for a specific outgoing connection replace default<BR>&gt; with the device's address. ( /etc/default/passkeys/aa:bb:cc:dd:ee:ff<BR>&gt; will contain passkey for aa:bb:cc:dd:ee:ff ).<BR>&gt; After adding a passkey you should restart bluetooth with<BR>&gt; <BR>&gt; /etc/init.d/bluetooth restart<BR>&gt; <BR>&gt; and the new passkeys will be registered.<BR>&gt; <BR>&gt; <BR>&gt; I have also tried that and it is not working... do you think it is a<BR>&gt; Debian problem?<BR><BR>Oh, you're using 3.x. I don't know, haven't played with it yet, sorry. <BR><BR>-- <BR>redondos<BR>-------------------------------------------------------------------------<BR>Using Tomcat but need to do more? Need to support web services, security?<BR>Get stuff done quickly with pre-integrated technology to make your job easier<BR>Download IBM WebSphere Application Server v.1.0.1 based on Apache
 Geronimo<BR>http://sel.as-us.falkag.net/sel?cmd=lnk&amp;kid=120709&amp;bid=263057&amp;dat=121642_______________________________________________<BR>Bluez-users mailing list<BR>Bluez-users@lists.sourceforge.net<BR>https://lists.sourceforge.net/lists/listinfo/bluez-users<BR></BLOCKQUOTE><BR><p>&#32;
		<hr size=1>Get your email and more, right on the <a href="http://us.rd.yahoo.com/evt=42973/*http://www.yahoo.com/preview"> new Yahoo.com</a> 

--0-332191997-1155738470=:29236--

--0-529700959-1155738470=:29236
Content-Type: application/octet-stream; name="system.conf"
Content-Transfer-Encoding: base64
Content-Description: 3934571641-system.conf
Content-Disposition: attachment; filename="system.conf"

PCEtLSBUaGlzIGNvbmZpZ3VyYXRpb24gZmlsZSBjb250cm9scyB0aGUgc3lz
dGVtd2lkZSBtZXNzYWdlIGJ1cy4KICAgICBBZGQgYSBzeXN0ZW0tbG9jYWwu
Y29uZiBhbmQgZWRpdCB0aGF0IHJhdGhlciB0aGFuIGNoYW5naW5nIHRoaXMg
CiAgICAgZmlsZSBkaXJlY3RseS4gLS0+Cgo8IS0tIE5vdGUgdGhhdCB0aGVy
ZSBhcmUgYW55IG51bWJlciBvZiB3YXlzIHlvdSBjYW4gaG9zZSB5b3Vyc2Vs
ZgogICAgIHNlY3VyaXR5LXdpc2UgYnkgc2NyZXdpbmcgdXAgdGhpcyBmaWxl
OyBpbiBwYXJ0aWN1bGFyLCB5b3UKICAgICBwcm9iYWJseSBkb24ndCB3YW50
IHRvIGxpc3RlbiBvbiBhbnkgbW9yZSBhZGRyZXNzZXMsIGFkZCBhbnkgbW9y
ZQogICAgIGF1dGggbWVjaGFuaXNtcywgcnVuIGFzIGEgZGlmZmVyZW50IHVz
ZXIsIGV0Yy4gLS0+Cgo8IURPQ1RZUEUgYnVzY29uZmlnIFBVQkxJQyAiLS8v
ZnJlZWRlc2t0b3AvL0RURCBELUJVUyBCdXMgQ29uZmlndXJhdGlvbiAxLjAv
L0VOIgogImh0dHA6Ly93d3cuZnJlZWRlc2t0b3Aub3JnL3N0YW5kYXJkcy9k
YnVzLzEuMC9idXNjb25maWcuZHRkIj4KPGJ1c2NvbmZpZz4KCiAgPCEtLSBP
dXIgd2VsbC1rbm93biBidXMgdHlwZSwgZG8gbm90IGNoYW5nZSB0aGlzIC0t
PgogIDx0eXBlPnN5c3RlbTwvdHlwZT4KCiAgPCEtLSBSdW4gYXMgc3BlY2lh
bCB1c2VyIC0tPgogIDx1c2VyPm1lc3NhZ2VidXM8L3VzZXI+CgogIDwhLS0g
Rm9yayBpbnRvIGRhZW1vbiBtb2RlIC0tPgogIDxmb3JrLz4KCiAgPCEtLSBX
cml0ZSBhIHBpZCBmaWxlIC0tPgogIDxwaWRmaWxlPi91c3IvbG9jYWwvdmFy
L3J1bi9tZXNzYWdlYnVzLnBpZDwvcGlkZmlsZT4KCiAgPCEtLSBPbmx5IGFs
bG93IHNvY2tldC1jcmVkZW50aWFscy1iYXNlZCBhdXRoZW50aWNhdGlvbiAt
LT4KICA8YXV0aD5FWFRFUk5BTDwvYXV0aD4KCiAgPCEtLSBPbmx5IGxpc3Rl
biBvbiBhIGxvY2FsIHNvY2tldC4gKGFic3RyYWN0PS9wYXRoL3RvL3NvY2tl
dCAKICAgICAgIG1lYW5zIHVzZSBhYnN0cmFjdCBuYW1lc3BhY2UsIGRvbid0
IHJlYWxseSBjcmVhdGUgZmlsZXN5c3RlbSAKICAgICAgIGZpbGU7IG9ubHkg
TGludXggc3VwcG9ydHMgdGhpcy4gVXNlIHBhdGg9L3doYXRldmVyIG9uIG90
aGVyIAogICAgICAgc3lzdGVtcy4pIC0tPgogIDxsaXN0ZW4+dW5peDpwYXRo
PS91c3IvbG9jYWwvdmFyL3J1bi9kYnVzL3N5c3RlbV9idXNfc29ja2V0PC9s
aXN0ZW4+CgogIDxwb2xpY3kgY29udGV4dD0iZGVmYXVsdCI+CiAgICA8IS0t
IERlbnkgZXZlcnl0aGluZyB0aGVuIHB1bmNoIGhvbGVzIC0tPgogICAgPGRl
bnkgc2VuZF9pbnRlcmZhY2U9IioiLz4KICAgIDxkZW55IHJlY2VpdmVfaW50
ZXJmYWNlPSIqIi8+CiAgICA8ZGVueSBvd249IioiLz4KICAgIDwhLS0gQnV0
IGFsbG93IGFsbCB1c2VycyB0byBjb25uZWN0IC0tPgogICAgPGFsbG93IHVz
ZXI9IioiLz4KICAgIDwhLS0gQWxsb3cgYW55b25lIHRvIHRhbGsgdG8gdGhl
IG1lc3NhZ2UgYnVzIC0tPgogICAgPCEtLSBGSVhNRSBJIHRoaW5rIGN1cnJl
bnRseSB0aGVzZSBhbGxvdyBydWxlcyBhcmUgYWx3YXlzIGltcGxpY2l0IAog
ICAgICAgICBldmVuIGlmIHRoZXkgYXJlbid0IGluIGhlcmUgLS0+CiAgICA8
YWxsb3cgc2VuZF9kZXN0aW5hdGlvbj0ib3JnLmZyZWVkZXNrdG9wLkRCdXMi
Lz4KICAgIDxhbGxvdyByZWNlaXZlX3NlbmRlcj0ib3JnLmZyZWVkZXNrdG9w
LkRCdXMiLz4KICAgIDwhLS0gdmFsaWQgcmVwbGllcyBhcmUgYWx3YXlzIGFs
bG93ZWQgLS0+CiAgICA8YWxsb3cgc2VuZF9yZXF1ZXN0ZWRfcmVwbHk9InRy
dWUiLz4KICAgIDxhbGxvdyByZWNlaXZlX3JlcXVlc3RlZF9yZXBseT0idHJ1
ZSIvPgogIDwvcG9saWN5PgoKICA8IS0tIENvbmZpZyBmaWxlcyBhcmUgcGxh
Y2VkIGhlcmUgdGhhdCBhbW9uZyBvdGhlciB0aGluZ3MsIHB1bmNoIAogICAg
ICAgaG9sZXMgaW4gdGhlIGFib3ZlIHBvbGljeSBmb3Igc3BlY2lmaWMgc2Vy
dmljZXMuIC0tPgogIDxpbmNsdWRlZGlyPnN5c3RlbS5kPC9pbmNsdWRlZGly
PgoKICA8IS0tIFRoaXMgaXMgaW5jbHVkZWQgbGFzdCBzbyBsb2NhbCBjb25m
aWd1cmF0aW9uIGNhbiBvdmVycmlkZSB3aGF0J3MgCiAgICAgICBpbiB0aGlz
IHN0YW5kYXJkIGZpbGUgLS0+CiAgPGluY2x1ZGUgaWdub3JlX21pc3Npbmc9
InllcyI+L2V0Yy9kYnVzLTEvc3lzdGVtLmQvYmx1ZXotaGNpZC5jb25mPC9p
bmNsdWRlPgoKICA8aW5jbHVkZSBpZl9zZWxpbnV4X2VuYWJsZWQ9InllcyIg
c2VsaW51eF9yb290X3JlbGF0aXZlPSJ5ZXMiPmNvbnRleHRzL2RidXNfY29u
dGV4dHM8L2luY2x1ZGU+Cgo8L2J1c2NvbmZpZz4K

--0-529700959-1155738470=:29236
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--0-529700959-1155738470=:29236
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--0-529700959-1155738470=:29236--
