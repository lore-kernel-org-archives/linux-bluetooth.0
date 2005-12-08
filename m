Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Khaled" <khaled@ipbill.com>
To: <bluez-users@lists.sourceforge.net>
Subject: RE: [Bluez-users] Bluetooth Voice Setting
Message-ID: <HCEOIFALKKLBLJPENPNOGEGKCAAA.khaled@ipbill.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <43971307.8050205@xmission.com>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 8 Dec 2005 11:53:48 -0000

Hi Marcel, Steven, Brad

My next step now is to upgrade the kernel to one of the 2.6.14 kernel. But
before I do...

I have noticed that sometimes, when I start asterisk, after initialising a
bluetooth link to the phone, there is an incoming sco link...note that
usually, only an acl link is created at this point and an sco when a call is
initiated. But reoccuringly, usually the first time I run asterisk, an
incoming sco link is attempted to be created. This sco link lasts for about
2/3 seconds before it dies.

Please look at the following extract from asterisk atrtup (debug enabled)
and then the hcidump -X -V output for this event (unfortunately I couldn't
access all of the hcidump since I couldn't scroll up the terminal window far
enough!)

1. Asterisk -vvvvvvvvvvc:

Asterisk Ready.
*CLI> Dec  8 11:21:42 NOTICE[4515]:
/usr/src/chan_bluetooth/chan_bluetooth.c:2041 try_connect: Initial
ised bluetooth link to device Nokia6310i
 [AG] Nokia6310i < AT+BRSF=23
 [AG] Nokia6310i > ERROR
Dec  8 11:21:42 DEBUG[4515]: /usr/src/chan_bluetooth/chan_bluetooth.c:1658
ag_brsf_response: Bluetooth
 features: ERROR
 [AG] Nokia6310i < AT+CIND=?
Dec  8 11:21:42 DEBUG[4515]: /usr/src/chan_bluetooth/chan_bluetooth.c:1504
ag_unsol_cind: CIND: 1=call
Dec  8 11:21:42 DEBUG[4515]: /usr/src/chan_bluetooth/chan_bluetooth.c:1504
ag_unsol_cind: CIND: 2=serv
ice
Dec  8 11:21:42 DEBUG[4515]: /usr/src/chan_bluetooth/chan_bluetooth.c:1514
ag_unsol_cind: CIND: 3=call
_setup
 [AG] Nokia6310i > +CIND:
("call",(0,1)),("service",(0,1)),("call_setup",(0-3))
 [AG] Nokia6310i > OK
 [AG] Nokia6310i < AT+CIND?
Dec  8 11:21:42 DEBUG[4515]: /usr/src/chan_bluetooth/chan_bluetooth.c:386
set_cind: CIND 1 set to 0
Dec  8 11:21:42 DEBUG[4515]: /usr/src/chan_bluetooth/chan_bluetooth.c:386
set_cind: CIND 2 set to 1
Dec  8 11:21:42 NOTICE[4515]: /usr/src/chan_bluetooth/chan_bluetooth.c:417
set_cind: Audio Gateway Nok
ia6310i got signal
Dec  8 11:21:42 DEBUG[4515]: /usr/src/chan_bluetooth/chan_bluetooth.c:1539
ag_unsol_cind: CIND IND 3 s
et to 0 [0]
 [AG] Nokia6310i > +CIND: 0,1,0
 [AG] Nokia6310i > OK
 [AG] Nokia6310i < AT+CMER=3,0,0,1
Dec  8 11:21:42 DEBUG[4515]: /usr/src/chan_bluetooth/chan_bluetooth.c:2265
handle_incoming_sco: Incoming SCO socket
Dec  8 11:21:42 DEBUG[4515]: /usr/src/chan_bluetooth/chan_bluetooth.c:2295
handle_incoming_sco: SCO Connect from Nokia6310i
Dec  8 11:21:42 DEBUG[4516]: /usr/src/chan_bluetoot
h/chan_bluetooth.c:522 sco_thread: SCO thread started on fd 25, pid 4516
Dec  8 11:21:42 DEBUG[4515]: /usr/src/chan_bluetooth/chan_bluetooth.c:2315
handle_incoming_sco: SCO: 2
5, HCIHandle=43, MUT=64
 [AG] Nokia6310i > OK
 [AG] Nokia6310i < AT+CLIP=1
 [AG] Nokia6310i > OK
 [AG] Nokia6310i < AT+CGMI=?
 [AG] Nokia6310i > OK
 [AG] Nokia6310i < AT+CGMI
 [AG] Nokia6310i > Nokia
 [AG] Nokia6310i > OK

-----------------The Disconnect below (hcidump -X -V) happens here after 2/3
seconds---------------------------------------

Dec  8 11:21:47 ERROR[4516]: /usr/src/chan_bluetooth/chan_bluetooth.c:586
sco_thread: SCO connection error: Connection reset by peer
 (errno 104)
Dec  8 11:21:47 DEBUG[4516]: /usr/src/chan_bluetooth/chan_bluetooth.c:619
sco_thread: SCO thread stopped

2. hcidump -X -V when asterisk -vvvvvvvvvc is run:

00  ................
< SCO data: handle 43 dlen 48
    0000: 7f 7f 7f 7f 7f 7f 7f 7f  7f 7f 7f 7f 7f 7f 7f 7f  ................
    0010: 7f 7f 7f 7f 7f 7f 7f 7f  7f 7f 7f 7f 7f 7f 7f 7f  ................
    0020: 7f 7f 7f 7f 7f 7f 7f 7f  7f 7f 7f 7f 7f 7f 7f 7f  ................
< SCO data: handle 43 dlen 48
    0000: 7f 7f 7f 7f 7f 7f 7f 7f  7f 7f 7f 7f 7f 7f 7f 7f  ................
    0010: 7f 7f 7f 7f 7f 7f 7f 7f  7f 7f 7f 7f 7f 7f 7f 7f  ................
    0020: 7f 7f 7f 7f 7f 7f 7f 7f  7f 7f 7f 7f 7f 7f 7f 7f  ................
< SCO data: handle 43 dlen 48
    0000: 7f 7f 7f 7f 7f 7f 7f 7f  7f 7f 7f 7f 7f 7f 7f 7f  ................
    0010: 7f 7f 7f 7f 7f 7f 7f 7f  7f 7f 7f 7f 7f 7f 7f 7f  ................
    0020: 7f 7f 7f 7f 7f 7f 7f 7f  7f 7f 7f 7f 7f 7f 7f 7f  ................
< SCO data: handle 43 dlen 48
    0000: 7f 7f 7f 7f 7f 7f 7f 7f  7f 7f 7f 7f 7f 7f 7f 7f  ................
    0010: 7f 7f 7f 7f 7f 7f 7f 7f  7f 7f 7f 7f 7f 7f 7f 7f  ................
    0020: 7f 7f 7f 7f 7f 7f 7f 7f  7f 7f 7f 7f 7f 7f 7f 7f  ................
> SCO data: handle 43 dlen 48
    0000: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
    0010: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
    0020: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
> SCO data: handle 43 dlen 48
    0000: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
    0010: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
    0020: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
> SCO data: handle 43 dlen 48
    0000: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
    0010: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
    0020: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
.
.
.	This repeats untill:
.
.


< SCO data: handle 43 dlen 48
    0000: 7f 7f 7f 7f 7f 7f 7f 7f  7f 7f 7f 7f 7f 7f 7f 7f  ................
    0010: 7f 7f 7f 7f 7f 7f 7f 7f  7f 7f 7f 7f 7f 7f 7f 7f  ................
    0020: 7f 7f 7f 7f 7f 7f 7f 7f  7f 7f 7f 7f 7f 7f 7f 7f  ................
> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 43 reason 0x13
    Reason: Remote User Terminated Connection
> HCI Event: Max Slots Change (0x1b) plen 3
    handle 40 slots 5
> HCI Event: Mode Change (0x14) plen 6
    status 0x00 handle 40 mode 0x02 interval 800
    Mode: Sniff

Please remember this happens very very occassionally...most of the time
there is no incoming sco connection untill a call is made.
The disconnect is automatic and happens almost immediately. Any ideas on
this guys? Why would the phone try to create an sco link before a call once,
and thereafter only initiate an sco link at an active call, but then with no
hcidump trace of sco packets unlike here?

Should I continue with a kernel upgrade? Also, I cannot see sco_bt_snd
anywhere in the system...do I need this and for what?
Finally, does it matter whether I use OSS or alsa?

Kind Regards

Khaled



> -----Original Message-----
> From: bluez-users-admin@lists.sourceforge.net
> [mailto:bluez-users-admin@lists.sourceforge.net]On Behalf Of Brad
> Midgley
> Sent: 07 December 2005 16:51
> To: bluez-users@lists.sourceforge.net
> Subject: Re: [Bluez-users] Bluetooth Voice Setting
>
>
> Khaled
>
> > **[root@mdk10-voipgsm root]# uname -r
> > 2.6.3-7mdk (Mandrake 10)
>
> this could be a problem. If you can, use something newer like 2.6.14.
> You'll have to rebuild sco_bt_snd too.
>
> Brad
>
>
> -------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc. Do you grep
> through log files
> for problems?  Stop!  Download the new AJAX search engine that makes
> searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
> http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>
> ______________________________________________________________________
> This email has been scanned by the MessageLabs Email Security System.
> For more information please visit http://www.messagelabs.com/email
> ______________________________________________________________________
>



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
